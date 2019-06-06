# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
    name: "Roman Shirasaki",
    email: "jgdevromank@gmail.com",
    password: "123456",
    password_confirmation: "123456",
    admin: 1)

User.first.user_skills.create!(name: "Eat")
User.first.user_skills.create!(name: "Sleep")
User.first.user_skills.create!(name: "Code")
User.first.user_skills.create!(name: "Repeat")

99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(
        name: name,
        email: email,
        password: password,
        password_confirmation: password)
end

users = User.order(:id).take(7)
50.times do |n|
    name = "Cool Skill #{n+1}"
    users.each do |user| 
        if user.id == 1
            next
        end
        user.user_skills.create!(name: name)
    end
end

users = User.all
user = User.first
second_user = User.second
endorsing = users[2..50]
endorsers = users[1..70]
other_endorsers = users[30..60]
endorsing.each {|e| user.endorse(e.user_skills.first)}
endorsers.each {|e| e.endorse(user.user_skills.first)}
endorsers.each {|e| e.endorse(second_user.user_skills.first)}
other_endorsers.each {|e| e.endorse(user.user_skills.all[6])}
