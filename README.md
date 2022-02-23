# pt_streams

Stream data from Twitter Decahose.

```sh
npm start
```

There are two main endpoints:

```
GET {{HOST}}/stream
```

This endpoint starts the streaming connection to the Decahose API. Each tweet will be published in a separate message to the given Pubsub topic.

```
GET {{HOST}}/poll/:frequency/:delay
```

This endpoint pulls up to MAX messages (configured in config.js) from the given pull subscription. The tweets they contain are then pushed to the configured BQ dataset/table.

This operation happens FREQUENCY times over DELAY milliseconds. You will need to poll this endpoint to regularly drain the queue and import data into bigquery. This is where a cron job is required.

# Schematics

## Real-time trends - Architecture Blueprint #
![alt text](https://github.com/prasannacs/pt_streams/blob/main/resources/pt-blueprint.jpeg "PowerTrack - Consumer Architecture Blueprint")
## Real-time trends - Gaming trends sample #
![alt text](https://github.com/prasannacs/pt_streams/blob/main/resources/gaming-trends.png "Gaming trends - sample report")
## Real-time trends - NBA trends sample #
![alt text](https://github.com/prasannacs/pt_streams/blob/main/resources/nba-trends.png "NBA trends - sample report")
## Real-time trends - Crypto trends sample #
![alt text](https://github.com/prasannacs/pt_streams/blob/main/resources/crypto-trends.png "Crypto trends - sample report")
