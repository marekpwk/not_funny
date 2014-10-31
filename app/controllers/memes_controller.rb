class MemesController < ApplicationController
  def index
    @templates =  Template.all
  end

  def new
    @template = Template.find(params[:template_id])
    @meme = Meme.new
  end

  def create
    @meme = Meme.new(meme_params)
    @meme.image_data=(params[:meme][:image].split("base64,")[1])
    if @meme.save
      redirect_to demots_path, notice: "Your meme has been created"
    else
      render 'new'
    end
  end

  def destroy
    @meme = Meme.find(params[:id])
    @meme.destroy
    redirect_to memes_path, notice: "Meme has been deleted"
  end

  def meme_params
    params.require(:meme).permit(:image)
  end
end
