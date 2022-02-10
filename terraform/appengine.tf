
data "archive_file" "function_dist" {
  type        = "zip"
  source_dir  = ".."
  output_path = "dist/${local.ARCHIVE_NAME}.zip"
}

resource "google_storage_bucket_object" "archive" {
  name   = "${var.ARCHIVE_PATH}/${local.ARCHIVE_NAME}.${data.archive_file.function_dist.output_base64sha256}.zip"
  bucket = var.CODE_STORAGE_NAME
  source = data.archive_file.function_dist.output_path
}

resource "google_app_engine_standard_app_version" "default" {
  version_id     = replace(var.VERSION, ".", "-")
  service        = local.SERVICE_NAME
  runtime        = "nodejs14"
  instance_class = "F4_1G"

  deployment {
    zip {
      source_url = google_storage_bucket_object.archive.name
    }
  }

  entrypoint {
    shell = "node index.js"
  }

  automatic_scaling {
    max_idle_instances = 1
  }
  #   noop_on_destroy = true
}
