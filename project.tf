resource "azuredevops_project" "this" {
  name            = var.project_name
  visibility      = "private"
  version_control = "Git"
  features = {
    "boards"       = "enabled"
    "repositories" = "enabled"
    "pipelines"    = "enabled"
    "testplans"    = "disabled"
    "artifacts"    = "disabled"
  }
}
