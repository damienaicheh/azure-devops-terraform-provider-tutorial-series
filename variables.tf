variable "project_name" {
  description = "The project name to create"
  type        = string
}

variable "repositories" {
  type = list(object({
    application    = string
    type           = string
    domain         = string
    default_branch = string
  }))
  default = []
}
