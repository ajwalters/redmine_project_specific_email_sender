class ProjectEmailsController < ApplicationController
  unloadable
  
  before_filter :load_project, :authorize
  
  def update
    @project.email = params[:email]
    respond_to do |format|
      format.html{
        if @project.project_email.save
          flash[:notice] = "Email successfully updated"
        else
          flash[:notice] = "Email format invalid"
        end
        redirect_to :controller => "projects", :action => "settings"
      }
      format.js{
        if @project.project_email.save
          render :text => "success"
        else
          render :text => "failure"
        end
      }
    end
  end
  
  def restore_default
    @project.project_email.destroy if @project.project_email
    @project.reload
    respond_to do |format|
      format.html{
        flash[:notice] = "Email restored to system default"
        redirect_to :controller => "projects", :action => "settings"
      }
      format.js{
        render :text => @project.email
      }
    end
  end
  
  private
  def load_project
    @project = Project.find(params[:id])
  end
end
