# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#
#
Organisation.insert_all([{name: "org1"}, {name: "org2"}])
server = Organisation.first.servers.create(hostname: "localhost:3000")

id_1 = server.id

Heartbeat.insert_all([{server_id: id_1, status_code: 200, request_time: Time.now}, {server_id: id_1, status_code: 200, request_time: Time.now}])
