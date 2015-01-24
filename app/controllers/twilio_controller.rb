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
    binding.pry
    user= User.find(ENV['MMS_USER'])
    title = params[:Body].empty? ? "Sent from cell" : params[:Body]
    demot = Demot.new(title: title, user: user )
    demot.remote_image_url = params[:MediaUrl0]
    demot.mms = true
    if demot.save
      response = Twilio::TwiML::Response.new do |r|
        r.SMS "Your message has been recieved."
      end
    else

      response = Twilio::TwiML::Response.new do |r|
        r.SMS "Something went wrong, try one more time."
      end
    end
    render_twiml response
  end

  def status
    render_twiml Twilio::TwiML::Response.new
  end

end
