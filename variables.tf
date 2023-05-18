variable "project_name" {
  type    = string
  default = "hariprasad-sundaresan-0202"
}

variable "region" {
  type    = string
  default = "europe-west2"
}

variable "zone" {
  type    = string
  default = "europe-west2-b"
}


## PROJECT SETUP
variable "apis" {
  type        = list(string)
  description = ""
  default = ["iam.googleapis.com",
    "cloudapis.googleapis.com",
    "serviceusage.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iamcredentials.googleapis.com",
    "cloudbilling.googleapis.com"]
}

variable "project_roles" {
  type        = list(string)
  description = ""
  default = ["roles/serviceusage.serviceUsageViewer",
    "roles/actions.Admin",
    "roles/notebooks.admin",
    "roles/iam.serviceAccountAdmin"]
}


## NOTEBOOKS
variable "notebook_name" {
  type    = string
  default = "user-notebook"
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}

variable "image_project" {
  type    = string
  default = "deeplearning-platform-release"
}

variable "image_family" {
  type    = string
  default = "tf-ent-2-9-cu113-notebooks"
}

## STORAGE BUCKETS
variable "bucket_name" {
  type    = string
  default = "assessment_bucket"
}

variable "bucket_location" {
  type    = string
  default = "EU"
}

variable "bucket-storage-class" {
  type        = string
  description = "storage class of the storage bucket"
  default     = "STANDARD"
}


variable "destroy_enabled" {
  type    = bool
  default = true
}

variable "uniform_bucket_access_enabled" {
  type    = bool
  default = true
}

variable "public_access_prevention" {
  type    = string
  default = "enforced"
}

## BIGQUERY
variable "dataset_id" {
  type    = string
  default = "assessment"
}

variable "friendly_name" {
  type    = string
  default = "assessment-dataset"
}


variable "dataset_description" {
  type    = string
  default = "sample data for assessment"
}

variable "dataset_location" {
  type    = string
  default = "EU"
}

variable "default_table_expiration_ms" {
  type    = string
  default = "3600000"
}










