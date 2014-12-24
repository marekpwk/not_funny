# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#jjkj
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name: "Dr Who", email: "admin@example.com", password: 'password1', password_confirmation: 'password1', admin: true)
users = []
puts "Starting to seed users..."
100.times do |i|
  name = Faker::Name.name
  email = "fake_user_#{i}@example.com"
  password = "123456"
  users << User.create(name: name, email: email, password: password, password_confirmation: password)
end

themes = %w{sports city food nature cats technics transport business}
puts "Starting to seed images..."
demots = []
images_height = %w{300 400 500 600 800}
100.times do |i|
  url = "http://lorempixel.com/650/"
  url << images_height.sample << "/"
  title = Faker::Company.catch_phrase
  user = users.sample
  demot = Demot.new(title: title, user: user)
  image_url = url << themes.sample
  demot.remote_image_url = image_url
  demots << demot
  demot.save
end
puts "Done with images, populating votes now..."
500.times do |i|
  vote = Vote.new(demot_id: demots[0..6].sample.id, user_id: users.sample.id)
  vote.save
end
1000.times do |i|
 vote = Vote.new(demot_id: demots.sample.id, user_id: users.sample.id)
 vote.save
end 
puts "Done!!"
