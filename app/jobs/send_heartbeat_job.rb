class SendHeartbeatJob < ApplicationJob
  require 'uri'
  require 'net/http'
  queue_as :default
  after_perform do |job|
    self.class.set(wait: 10.seconds).perform_later(job.arguments.first)
  end

  def perform(server)
    # TODO: need a queue backend for this for persistence
    uri = URI.parse(server.protocol + server.hostname)
    request_time = Time.now
    # TODO: Will need a timeout to stop getting hung
    begin
      res = Net::HTTP.get_response(uri)
      response_time = Time.now
      heartbeat = server.heartbeats.create(status_code: res.code, status_message: res.message, request_time: request_time, response_time: response_time)
    rescue Exception => e
      # TODO: Check if different HTTP lib will handle things like google.com instead of http://www.google.com
      heartbeat = server.heartbeats.create(status_code: 0, request_time: request_time, status_message: e.message)
    end
  end
end
