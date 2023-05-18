# resource "google_project" "assessment_project" {
#   name                = var.project_name
#   project_id          = "hariprasad-sundaresan-${random_id.project_suffix.hex}"
#   auto_create_network = true
#   billing_account     = var.billing_id
#   skip_delete         = false
# }

# resource "google_project_service" "apis" {
#   for_each                   = toset(var.apis)
#   service                    = each.key
#   project                    = google_project.assessment_project.project_id
#   disable_dependent_services = true
#   depends_on                 = [google_project.assessment_project]

# }

# resource "google_project_iam_member" "project_roles" {
#   for_each = length(var.project_roles) == 0 ? [] : toset(var.project_roles)
#   project  = google_project.assessment_project.project_id
#   member   = "user:hari.gcp.study@gmail.com"
#   role     = each.value
#   depends_on = [
#     google_project.assessment_project
#   ]
# } 
