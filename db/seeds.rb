# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#
#
Organisation.insert_all([{ name: "org1" }, { name: "org2" }])
org = Organisation.first
server = org.servers.create(name: "Seed server", hostname: "localhost:3000")

id_1 = server.id
Heartbeat.insert_all([{ server_id: id_1, status_code: 200, request_time: Time.now }, { server_id: id_1, status_code: 200, request_time: Time.now }])

user = User.create(email: "a@example.com", password: "password", password_confirmation: "password")
org.users << user

User.create(email: "b@example.com", password: "password", password_confirmation: "password")
User.create(email: "c@example.com", password: "password", password_confirmation: "password")
User.create(email: "d@example.com", password: "password", password_confirmation: "password")
User.create(email: "e@example.com", password: "password", password_confirmation: "password")
