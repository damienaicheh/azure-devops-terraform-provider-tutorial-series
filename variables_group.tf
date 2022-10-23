resource "azuredevops_variable_group" "this" {
  count        = length(var.repositories)
  project_id   = azuredevops_project.this.id
  name         = "${var.repositories[count.index].domain}.${var.repositories[count.index].application}.shared"
  description  = "The Variable Group for ${title(var.repositories[count.index].domain)} ${title(var.repositories[count.index].application)}"
  allow_access = true

  variable {
    name  = "Domain"
    value = var.repositories[count.index].domain
  }

  variable {
    name  = "Application"
    value = var.repositories[count.index].application
  }
}
