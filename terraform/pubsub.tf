
resource "google_pubsub_topic" "default" {
  name = "PT-STREAMS"
}

resource "google_service_account" "subscriber" {
  account_id = "pss-${local.SERVICE_NAME}"
}

resource "google_iap_web_type_app_engine_iam_member" "member" {
  project = google_app_engine_application.default.project
  app_id  = google_app_engine_application.default.app_id
  role    = "roles/iap.httpsResourceAccessor" # == iap web app user
  member  = "serviceAccount:${google_service_account.subscriber.email}"
}

resource "google_pubsub_subscription" "default" {

  name  = "pss-pt-streams"
  topic = google_pubsub_topic.default.name

  #   message_retention_duration = "600s"
  #   ack_deadline_seconds       = 600

  expiration_policy {
    ttl = ""
  }

  #   dead_letter_policy {
  #     dead_letter_topic     = google_pubsub_topic.default_dead_letter.id
  #     max_delivery_attempts = 5
  #   }

}

resource "google_project_iam_member" "defaultPubSubRequires" {
  role   = "roles/iam.serviceAccountTokenCreator"
  member = "serviceAccount:service-${data.google_project.default.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}
