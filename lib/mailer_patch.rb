require_dependency 'mailer'

module MailerPatch
  
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :issue_add, :project_specific_email
      alias_method_chain :issue_edit, :project_specific_email
      alias_method_chain :document_added, :project_specific_email
      alias_method_chain :attachments_added, :project_specific_email
      alias_method_chain :news_added, :project_specific_email
      alias_method_chain :message_posted, :project_specific_email
    end
  end
  
  module InstanceMethods
    def issue_add_with_project_specific_email(issue)
      set_project_from_address(issue.project)
      issue_add_without_project_specific_email(issue)
    end
    
    def issue_edit_with_project_specific_email(journal)
      set_project_from_address(journal.project)
      issue_edit_without_project_specific_email(journal)
    end
    
    def document_added_with_project_specific_email(document)
      set_project_from_address(document.project)
      document_added_without_project_specific_email(document)
    end
    
    def attachments_added_with_project_specific_email(attachments)
      container = attachments.first.container
      set_project_from_address(container.project)
      attachments_added_without_project_specific_email(attachments)
    end
    
    def news_added_with_project_specific_email(news)
      set_project_from_address(news.project)
      news_added_without_project_specific_email(news)
    end
    
    def message_posted_with_project_specific_email(message, recipients)
      set_project_from_address(message.board.project)
      message_posted_without_project_specific_email(message, recipients)
    end
    
    private 
    
    def set_project_from_address(project)
      from project.email if project
    end
  end
  
end
