TWEET_FIELDS=context_annotations
EXPANSIONS=author_id
APP_ACCESS_TOKEN=AAAAAAAAAAAAAAAAAAAAABb0VQEAAAAAOXnx7PnN5inZF2YYLeVZreNjCFM%3DMJC9GGDBGDPJkCljSGBwso86UpNyPR3zTroK6zuRjKUzdNHsI0

1pct:
	curl -X GET \
	"https://api.twitter.com/2/tweets/sample/stream?tweet.fields=$(TWEET_FIELDS)&expansions=$(EXPANSIONS)" \
	-H "Authorization: Bearer $(APP_ACCESS_TOKEN)" | tee 1pct.jsonl
