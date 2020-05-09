# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "destroying all seeds..."
Essay.destroy_all
User.destroy_all
Lead.destroy_all

puts "creating users"
User.create(
  email: "amanda@origoedu.com",
  password: "password",
  full_name: "Amanda Ng",
  administrator: true
  )
User.create(
  email: "sharon@origoedu.com",
  password: "password",
  full_name: "Sharon Koharjo",
  administrator: true
  )
User.create(
  email: "jessica@origoedu.com",
  password: "password",
  full_name: "Jessica Vitriana",
  administrator: true
  )
User.create(
  email: "thomas@gmail.com",
  password: "password",
  full_name: "Thomas Eng",
  administrator: false
  )
