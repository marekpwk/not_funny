class MemesController < ApplicationController
  
  def demot_params
   params.require(:demot).permit(:image)
  end
end
