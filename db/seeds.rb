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
  email: "tomeng728@gmail.com",
  password: "password",
  full_name: "Thomas Eng",
  administrator: false
  )

puts "creating essays"
Essay.create(
  student_name: "Jack Johnson",
  email: "jjohnson@gmail.com",
  applicant_type: "Undergraduate",
  country_applying: "US",
  university_applying: "University of California",
  program_applying: "Economics",
  prompt: "What would you say is your greatest talent or skill? How have you developed and demonstrated that talent over time?",
  word_count: 350,
  assigned: true,
  user: User.first
  )
Essay.create(
  student_name: "Beyonce Knowles",
  email: "bey@gmail.com",
  applicant_type: "Undergraduate",
  country_applying: "US",
  university_applying: "",
  program_applying: "Business",
  prompt: "Personal Statement - open essay prompt",
  word_count: 650,
  assigned: true,
  user: User.last
  )
Essay.create(
  student_name: "Calvin Harris",
  email: "calvinharristhebest@gmail.com",
  applicant_type: "Graduate",
  country_applying: "UK",
  university_applying: "London Business School",
  program_applying: "MBA",
  prompt: "Why LBS?",
  word_count: 450,
  assigned: true,
  reviewed: true,
  user: User.find(User.first.id + 1)
  )
Essay.create(
  student_name: "Miley Cyrus",
  email: "hannahm@gmail.com",
  applicant_type: "Graduate",
  country_applying: "US",
  university_applying: "Harvard Business School",
  program_applying: "MBA",
  prompt: "Why Harvard?",
  word_count: 300,
  assigned: true,
  user: User.find(User.first.id + 1)
  )
Essay.create!(
  student_name: "Dua Lipa",
  email: "2lipa@gmail.com",
  applicant_type: "Undergraduate",
  country_applying: "UK",
  university_applying: "",
  program_applying: "Chemical Engineering",
  prompt: "UK Personal Statement",
  word_count: 500
  ) ## fix dua lipa - cannot save without assigned user
