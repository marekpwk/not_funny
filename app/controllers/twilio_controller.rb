require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header

  skip_before_action :verify_authenticity_token

  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say "Hey, don't call this number, just send us a picture message", :voice => 'alice'
      r.Play 'http://linode.rabasa.com/cantina.mp3'
    end

    render_twiml response
  end

  def inbound
    user= User.first(10).last
    demot = Demot.new(title: "From cell", user: user )
    demot.remote_image_url = params[:MediaUrl0]
    if demot.save
      response = Twilio::TwiML::Response.new do |r|
        r.SMS "Your message has been recieved."
      end
    else

      response = Twilio::TwiML::Response.new do |r|
        r.SMS "Something went wrong, try onemore time."
      end
    end
    render_twiml response
  end

  def status
    render_twiml Twilio::TwiML::Response.new
  end
end
