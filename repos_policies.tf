resource "azuredevops_branch_policy_min_reviewers" "this" {
  count      = length(var.repositories)
  project_id = azuredevops_project.this.id

  enabled  = true
  blocking = true

  settings {
    reviewer_count                         = 1
    submitter_can_vote                     = false
    last_pusher_cannot_approve             = true
    allow_completion_with_rejects_or_waits = false
    on_push_reset_approved_votes           = false
    on_last_iteration_require_vote         = false

    scope {
      repository_id  = azuredevops_git_repository.this[count.index].id
      repository_ref = azuredevops_git_repository.this[count.index].default_branch
      match_type     = "Exact"
    }
  }

  depends_on = [
    azuredevops_git_repository_file.default_pipeline,
    azuredevops_git_repository_file.default_gitignore,
  ]
}

resource "azuredevops_branch_policy_work_item_linking" "this" {
  count      = length(var.repositories)
  project_id = azuredevops_project.this.id

  enabled  = true
  blocking = true

  settings {

    scope {
      repository_id  = azuredevops_git_repository.this[count.index].id
      repository_ref = azuredevops_git_repository.this[count.index].default_branch
      match_type     = "Exact"
    }
  }

  depends_on = [
    azuredevops_git_repository_file.default_pipeline,
    azuredevops_git_repository_file.default_gitignore,
  ]
}

resource "azuredevops_branch_policy_comment_resolution" "this" {
  count      = length(var.repositories)
  project_id = azuredevops_project.this.id

  enabled  = true
  blocking = true

  settings {

    scope {
      repository_id  = azuredevops_git_repository.this[count.index].id
      repository_ref = azuredevops_git_repository.this[count.index].default_branch
      match_type     = "Exact"
    }
  }

  depends_on = [
    azuredevops_git_repository_file.default_pipeline,
    azuredevops_git_repository_file.default_gitignore,
  ]
}

resource "azuredevops_branch_policy_merge_types" "this" {
  count      = length(var.repositories)
  project_id = azuredevops_project.this.id

  enabled  = true
  blocking = true

  settings {
    allow_squash                  = true
    allow_rebase_and_fast_forward = false
    allow_basic_no_fast_forward   = true
    allow_rebase_with_merge       = false

    scope {
      repository_id  = azuredevops_git_repository.this[count.index].id
      repository_ref = azuredevops_git_repository.this[count.index].default_branch
      match_type     = "Exact"
    }
  }

  depends_on = [
    azuredevops_git_repository_file.default_pipeline,
    azuredevops_git_repository_file.default_gitignore,
  ]
}

resource "azuredevops_branch_policy_build_validation" "this" {
  count      = length(var.repositories)
  project_id = azuredevops_project.this.id

  enabled  = true
  blocking = true

  settings {
    display_name        = "Pull Request Check"
    build_definition_id = azuredevops_build_definition.build_definitions[count.index].id
    valid_duration      = 720 # minutes => 12 hours

    scope {
      repository_id  = azuredevops_git_repository.this[count.index].id
      repository_ref = azuredevops_git_repository.this[count.index].default_branch
      match_type     = "Exact"
    }
  }

  depends_on = [
    azuredevops_git_repository_file.default_pipeline,
    azuredevops_git_repository_file.default_gitignore,
  ]
}
