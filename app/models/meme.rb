class Meme < Demot

  def image_data=(data)
    io = CarrierIO.new(Base64.decode64(data))
    puts io``
    self.image = io
  end
end
