desc "Reset demo user daily"
task :reset_demo_user => :environment do
  p "Resetting demo user..."
  demo_user = User.create_or_find_by!(email: "demo@example.com", password: "password") # TODO(reece) Don't hardcode this password
  demo_user.organisations.each do |org|
    # Loop through each to ensure servers etc are also destroyed
    org.destroy
  end
  OrganisationsUser.where(user_id: demo_user.id).destroy_all
  org = demo_user.organisations.create(name: "Demo organisation")
  server = org.servers.create(name: "Example server", hostname: "google.com", protocol: "https://")
  SendHeartbeatJob.perform_later(server)
  app_url = ENV.fetch("APP_URL") { "localhost:3000" }
  protocol = Rails.env.production? ? "https://" : "http://"
  server = org.servers.create(name: "Server that will fail", hostname: app_url + "/failingserver", protocol: protocol)
  SendHeartbeatJob.perform_later(server)
  p "Done"
end
