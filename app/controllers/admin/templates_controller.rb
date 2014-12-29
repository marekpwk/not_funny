class Admin::TemplatesController < ApplicationController
  include ApplicationHelper
  helper_method :sort_column, :sort_direction
  before_filter :signed_in_user
  before_filter :admin_user

  def index
    if params[:search]
      @templates = Template.search(params[:search]).order(sort_column + "  " +  sort_direction).paginate(:page => params[:page], :per_page => 10)
    else
      @templates = Template.order(sort_column + "  " +  sort_direction).paginate(:page => params[:page], :per_page => 10)
    end
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
