# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

name  = "testuser"
email = "example-1@railstutorial.org"
password = "password"
User.create!( name: name,
              email: email,
              password: password,
              password_confirmation: password,
              created_at: Time.parse("2021/08/20"))


Book.create!(
  title: "test_created_yesterday",
  body: "body_text",
  user_id: 1,
  created_at: 1.day.ago
)
Book.create!(
  title: "test_created_yesterday_2",
  body: "body_text",
  user_id: 1,
  created_at: 1.day.ago
)
Book.create!(
  title: "test_created_two_days_ago",
  body: "body_text",
  user_id: 1,
  created_at: 2.day.ago
)

Book.create!(
  title: "test_created_lastweek",
  body: "body_text",
  user_id: 1,
  created_at: 8.day.ago
)