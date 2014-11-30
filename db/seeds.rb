# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
100.times do |i|
  name = Faker::Name.name
  email = "fake_user_#{i}@example.com"
  password = "123456"
  User.create(name: name, email: email, password: password, password_confirmation: password)
end
