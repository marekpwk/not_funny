class Admin::TemplatesController < ApplicationController
  include ApplicationHelper
  before_filter :signed_in_user
  before_filter :admin_user 

  def index
    @templates = Template.paginate(:page => params[:page])
  end

  def new
    @template = Template.new
  end

  def create
    @template = Template.new(template_params)
    if @template.save
      redirect_to admin_templates_path, notice: "Your template has been created"
    else
      render 'new'
    end
  end

  def destroy
    @template = Template.find(params[:id])
    @template.destroy
    respond_to do |format|
      format.js
      format.html{ redirect_to admin_templates_path, notice: "Template has been deleted" }
    end
  end

  private
  def template_params
    params.require(:template).permit(:title, :image, :user_id)
  end
end
