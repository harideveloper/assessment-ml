## Storage Bucket : Retention Policy & Life cycle
# Rule 1 : Bucket Object can not be deleted/modified for a minimum 2 days
# Rule 2 : Minimum Object Age = 1 day

resource "random_id" "project_suffix" {
  byte_length = 3
}

resource "google_storage_bucket" "assessment_bucket" {
  name                        = "${var.bucket_name}-${random_id.project_suffix.hex}"
  project                     = var.project_name
  location                    = var.bucket_location
  storage_class               = var.bucket-storage-class
  force_destroy               = var.destroy_enabled
  uniform_bucket_level_access = var.uniform_bucket_access_enabled

  ## REQUIREMENT 2A : PRIVATE BUCKET
  public_access_prevention    = "enforced" 


  ## REQUIREMENT 2B : RETENTION POLICY
  retention_policy {
    retention_period = "172800" ### ==> 2 days
  }

  lifecycle_rule {
    condition {
      age = "1"
    }
    action {
      type = "Delete"
    }
  }
  depends_on = [random_id.project_suffix]
}
