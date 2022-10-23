resource "azuredevops_build_definition" "build_definitions" {
  count      = length(var.repositories)
  project_id = azuredevops_project.this.id
  name       = "${var.repositories[count.index].domain}_${var.repositories[count.index].type}_${var.repositories[count.index].application}"

  repository {
    repo_type   = "TfsGit"
    branch_name = "refs/heads/develop"
    repo_id     = azuredevops_git_repository.this[count.index].id
    yml_path    = "azure_pipeline.yml"
  }

  ci_trigger {
    use_yaml = true
  }
}
