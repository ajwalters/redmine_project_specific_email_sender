require 'redmine'
require 'dispatcher'
require_dependency 'project_patch'
require_dependency 'mailer_patch'
require_dependency 'projects_helper_patch'

Redmine::Plugin.register :redmine_project_specific_email_sender do
  name 'Redmine Project Specific Email Sender plugin'
  author 'Adam Walters'
  description "This is a plugin for Redmine which allows each project to have it's own sender email address for project related, outbound emails"
  version '1.0.0'
  
  permission :edit_project_email, :project_emails => [:restore_default, :update]
end

# This was required for plugin to be included in development environment
Dispatcher.to_prepare do
  Project.send(:include, ProjectPatch)
  Mailer.send(:include, MailerPatch)
  ProjectsHelper.send(:include, ProjectsHelperPatch)
end