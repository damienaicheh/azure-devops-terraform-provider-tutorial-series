resource "azuredevops_git_repository_file" "default_pipeline" {
  count               = length(azuredevops_git_repository.this)
  repository_id       = azuredevops_git_repository.this[count.index].id
  file                = "azure-pipelines.yml"
  content             = file("${path.module}/assets/azure-pipelines.yml")
  branch              = "refs/heads/develop"
  commit_message      = "Add azure-pipelines.yml"
  overwrite_on_create = false

  lifecycle {
    ignore_changes = [
      file,
      content,
      commit_message
    ]
  }
}

resource "azuredevops_git_repository_file" "default_gitignore" {
  count               = length(azuredevops_git_repository.this)
  repository_id       = azuredevops_git_repository.this[count.index].id
  file                = ".gitignore"
  content             = file("${path.module}/assets/.gitignore")
  branch              = "refs/heads/develop"
  commit_message      = "Add .gitignore"
  overwrite_on_create = false

  lifecycle {
    ignore_changes = [
      file,
      content,
      commit_message
    ]
  }
}
