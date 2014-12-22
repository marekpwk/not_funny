require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header

  skip_before_action :verify_authenticity_token

  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', :voice => 'alice'
      r.Play 'http://linode.rabasa.com/cantina.mp3'
    end

    render_twiml response
  end

  def inbound
    # binding.pry
    user= User.first(10).last
    demot = Demot.new(title: "From cell", user: user )
    demot.remote_image_url = params[:MediaUrl0]
    binding.pry
    if demot.save
      response = Twilio::TwiML::Response.new do |r|
        r.SMS "Recieved"
      end
    else

      response = Twilio::TwiML::Response.new do |r|
        r.SMS "Something went wrong"
      end
    end
  end

  def status
    render_twiml Twilio::TwiML::Response.new
  end
end
