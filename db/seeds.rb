# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Usuario.create!(nombre:  "Administrator",
             apellido: "smts",
             email: "admin@smts.com",
             password:              "qazplm123",
             password_confirmation: "qazplm123",
             admin: true)

99.times do |n|
  nombre  = Faker::Name.first_name
  apellido = Faker::Name.last_name
  email = "usuario-#{n+1}@smts.com"
  password = "password"
  Usuario.create!(nombre:  nombre,
               apellido: apellido,
               email: email,
               password:              password,
               password_confirmation: password)
end
