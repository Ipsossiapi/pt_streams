const config = {

    app_name: "pt-streams",
    gcp_projectId: process.env.PROJECT_ID,
    gcp_topicName: process.env.TOPIC_NAME,
    gcp_subscriptionName: process.env.SUBSCRIPTION_NAME,

    messageCount: 1000,  // how many max messages to pull at a time on poll
    reconnectCounter: 100,  // regenerate connection after X messages read

    pt_stream_host: process.env.TWITTER_API_HOST,
    pt_stream_path: process.env.TWITTER_API_PATH,
    gnip_username: process.env.GNIP_USERNAME,
    gnip_password: process.env.GNIP_PASSWORD,

    // bigquery
    pt_datasetId: process.env.BIGQUERY_DATASET,
    pt_table: process.env.BIGQUERY_TABLE,

};

module.exports = config;
