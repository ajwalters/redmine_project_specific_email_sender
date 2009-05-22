require_dependency 'project'

module ProjectPatch
  
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      has_one :project_email
    end
  end
  
  module InstanceMethods
    def email
      project_email ? project_email.email : Setting.mail_from
    end
    
    def email=(email_address)
      project_email ? (project_email.email = email_address) : build_project_email(:email => email_address)
    end
  end
    
end