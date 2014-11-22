class MemesController < ApplicationController
  def index
    @templates =  Template.all
  end

  def new
    @template = Template.find(params[:template_id])
    @meme = Meme.new
  end

  def create
    binding.pry
    pic = params[:meme][:image].split("base64")[1]
    tempfile = Tempfile.new("fileuploud")
    tempfile.binmode
    tempfile.write(Base64.decode64(pic))
    # uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename=> "test.jpeg" , :original_filename=> "original_name")
    uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile,
    :head => "Content-Disposition: form-data; name=\"demot[image]\"; filename=\"think.jpg\"\r\nContent-Type: image/jpeg\r\n",
     :type =>"image/jpeg",
     :filename =>"something.jpeg"      )
    # decoded_pic = CarrierIO.new(Base64.decode64(pic))
    # params[:meme][:image] = decoded_pic
    params[:meme][:image] = uploaded_file 
    @meme = Meme.new(meme_params)
    # @meme.image_data=(params[:meme][:image].split("base64,")[1])
    if @meme.save
      redirect_to demots_path, notice: "Your meme has been created"
    else
      render 'new', notice: "Upload onetime"
    end
  end

  def destroy
    @meme = Meme.find(params[:id])
    @meme.destroy
    redirect_to memes_path, notice: "Meme has been deleted"
  end

  def meme_params
    params.require(:meme).permit(:title, :image, :user_id)
  end
end
