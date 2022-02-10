resource "google_cloud_scheduler_job" "job" {

  name             = "cron-${local.SERVICE_NAME}-poll"
  schedule         = "* * * * *"
  description      = "PT Streams Polling"
  time_zone        = "Europe/London"
  attempt_deadline = "320s"

  retry_config {
    min_backoff_duration = "1s"
    max_retry_duration   = "10s"
    max_doublings        = 2
    retry_count          = 3
  }

  app_engine_http_target {
    http_method = "POST"

    app_engine_routing {
      service = "pt-streams"
      version = var.VERSION
    }

    relative_uri = "/poll/6/60000"
  }
}
