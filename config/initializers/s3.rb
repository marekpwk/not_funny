CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  else
    config.fog_credentials = {
      :provider => 'AWS',
      :aws_access_key_id => ENV['S3_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET'],
      # :region
    }
    config.fog_directory = ENV['S3_BUCKET_NAME']
  end
end
