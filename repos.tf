resource "azuredevops_git_repository" "this" {
  count          = length(var.repositories)
  project_id     = azuredevops_project.this.id
  name           = "${var.repositories[count.index].domain}_${var.repositories[count.index].type}_${var.repositories[count.index].application}"
  default_branch = var.repositories[count.index].default_branch == "" ? "refs/heads/develop" : var.repositories[count.index].default_branch
  initialization {
    init_type = "Clean"
  }
  lifecycle {
    ignore_changes = [
      initialization,
    ]
  }
}
