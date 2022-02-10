# https://www.terraform.io/docs/providers/google/r/google_service_account.html
resource "google_service_account" "default" {
  account_id = "ae-${var.ENV_CODE}-${var.SERVICE_NAME}"
}

# https://www.terraform.io/docs/providers/google/r/google_service_account_iam.html
# https://cloud.google.com/iam/docs/permissions-reference
resource "google_project_iam_member" "default" {
  count  = length(local.ROLES)
  role   = local.ROLES[count.index]
  member = "serviceAccount:${google_service_account.default.email}"
}
