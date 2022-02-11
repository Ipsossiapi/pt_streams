const express = require("express");
const fs = require('fs');
const url = require('url');
const { pipeline } = require('stream');
const axios = require("axios").default;
const axiosRetry = require("axios-retry");
const pub_sub_svcs = require('.././services/pub-sub.js');
const utils = require('.././services/utils.js');

const config = require('../config.js');
const https = require('https');

const router = express.Router();

axiosRetry(axios, {
  retries: 3,
  retryDelay: axiosRetry.exponentialDelay,
  shouldResetTimeout: true,
  retryCondition: (axiosError) => {
    return true;
  },
});

router.get("/", function (req, res) {
  streamTweetsHttp();
  res.send("Now streaming tweets ..");
});

router.get("/alive", function (req, res) {
  //console.log('staying alive ..');
  res.send('Alive');
});

router.get("/poll/:frequency/:delay", function (req, res) {
  console.log('polling Tweets from PubSub ', req.params.frequency);
  for (var i = 0; i < req.params.frequency; i++) {
    setTimeout(() => {
      pub_sub_svcs.synchronousPull(config.gcp_projectId, config.gcp_subscriptionName, config.messageCount).then((messenger) => {

        if (messenger === 'disconnect') {
          console.log('Stream reconnecting => ', messenger);
          streamTweetsHttp();
        }
      })

    }, req.params.delay);
  }
  res.send('polling Tweets from PubSub');
});

async function streamTweetsHttp() {

  var options = {
    host: config.pt_stream_host,
    // baseUrl: 'https://' + config.pt_stream_host,
    port: 443,
    path: url.parse(url.format({
      pathname: config.pt_stream_path,
      query: {
        ['tweet.fields']: 'context_annotations',
        expansions: 'author_id'
      },
    })).path,
    // url: config.pt_stream_path,
    // keepAlive: true,
    headers: {
      // 'Authorization': 'Basic ' + new Buffer(config.gnip_username + ':' + config.gnip_password).toString('base64')
      'Authorization': `Bearer ${process.env.TWITTER_API_BEARER_TOKEN}`
    }
  };
  // const url = `${options.baseUrl}${options.url}`
  console.log(options);
  request = https.get(options, function (res) {
    console.log('streaming with HTTP .. ', config.app_name);
    var body = '';
    res.on('data', function (data) {
      var tweet_json = JSON.parse(data.toString());
      console.log(Object.keys(tweet_json.data));
      // pub_sub_svcs.publishMessage(JSON.stringify(tweet_json));
    });
    res.on('end', function () {
      //here we have the full response, html or json object
      console.log(body);
    })
    res.on('error', function (e) {
      console.log("Got error: " + e.message);
      streamTweetsHttp();
    });
  });
}

module.exports = router
module.exports.streamTweetsHttp = streamTweetsHttp;
