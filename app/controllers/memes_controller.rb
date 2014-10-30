class MemesController < ApplicationController
  def index
    @templates =  Template.all
  end

  def new
    @template = Template.find(params[:template_id])
    @demot = Demot.new
  end

  def demot_params
    params.require(:demot).permit(:image)
  end
end
