
resource "google_app_engine_standard_app_version" "default" {
  version_id = replace(var.VERSION, ".", "-")
  service    = var.SERVICE_NAME
  runtime    = "nodejs14"

  entrypoint {
    instance_class = "F4_1G"
    shell          = "node index.js"
  }

  automatic_scaling {
    maxmax_idle_instances = 1
    cpu_utilization {
      target_utilization = 0.8
    }
  }
  #   noop_on_destroy = true
}
