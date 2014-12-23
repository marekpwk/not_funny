# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name: "Dr Who", email: "admin@example.com", password: 'password1', password_confirmation: 'password1', admin: true)
users = []
100.times do |i|
  name = Faker::Name.name
  email = "fake_user_#{i}@example.com"
  password = "123456"
  users << User.create(name: name, email: email, password: password, password_confirmation: password)
end

themes = %w{sports city food nature cats technics}
puts "Starting to seed images"
200.times do |i|
  puts "image #{i}"
  url = "http://lorempixel.com/650/800/"
  title = Faker::Company.catch_phrase
  user = users.sample
  demot = Demot.new(title: title, user: user)
  image_url = url << themes.sample
  demot.remote_image_url = image_url
  demot.save
end
