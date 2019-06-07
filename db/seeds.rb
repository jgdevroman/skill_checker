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

eat_tag = SkillTag.create!(name: "Eat")
sleep_tag = SkillTag.create!(name: "Sleep")
ct = SkillTag.create!(name: "Code")
rt = SkillTag.create!(name: "Repeat")
User.first.user_skills.create!(name: "Eat", skill_tag_id: eat_tag.id)
User.first.user_skills.create!(name: "Sleep", skill_tag_id: sleep_tag.id)
User.first.user_skills.create!(name: "Code", skill_tag_id: ct.id)
User.first.user_skills.create!(name: "Repeat", skill_tag_id: rt.id)

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

users = User.order(:id).take(50)
50.times do |n|
    name = "Cool Skill #{n+1}"
    tag = SkillTag.create!(name: name)
    users.each do |user| 
        if user.id == 1
            next
        end
        user.user_skills.create!(name: name, skill_tag_id: tag.id)
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
other_endorsers.each {|e| e.endorse(user.user_skills[3])}
endorsers.each {|e| e.endorse(second_user.user_skills.first)}
other_endorsers.each {|e| e.endorse(user.user_skills.all[6])}
