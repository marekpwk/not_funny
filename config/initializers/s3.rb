CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
    if Rails.env.test?
      CarrierWave.configure do |config|
        config.enable_processing =  false
      end

      ImageUploader
      #     # use different dirs when testing
      CarrierWave::Uploader::Base.descendants.each do |klass|
        next if klass.anonymous?
        klass.class_eval do
          def cache_dir
            "#{Rails.root}/spec/support/uploads/tmp"
          end

          def store_dir
            "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
          end
        end
      end
    end

  elsif Rails.env.production?
    config.asset_host = ENV['CARRIER_ASSET_HOST']
    config.storage :fog
    config.fog_credentials = {
      :provider => 'AWS',
      :aws_access_key_id => ENV['S3_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET'],
      # :region
    }
    config.fog_directory = ENV['S3_BUCKET_NAME']
    config.cache_dir        = "#{Rails.root}/tmp/uploads"
  end
end
