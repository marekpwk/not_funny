FactoryGirl.define do
  factory :demot do
    title "Ruby"
    image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/features/images/ruby.jpg')))
  end
end
