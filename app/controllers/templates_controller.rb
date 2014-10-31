class TemplatesController < ApplicationController

  def index
    @templates = Template.all
  end

  def new
    @template = Template.new
  end

  def create
    @template = Template.new(template_params)
    if @template.save
      redirect_to templates_path, notice: "Your template has been created"
    else
      render 'new'
    end
  end

  def destroy
    @template = Template.find(params[:id])
    @template.destroy
    redirect_to templates_path, notice: "Template has been deleted"
  end

  private
  def template_params
    params.require(:template).permit(:title, :image)
  end
end
