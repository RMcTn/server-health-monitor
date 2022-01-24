class SendHeartbeatJob < ApplicationJob
  require 'uri'
  require 'net/http'
  queue_as :default
  after_perform do |job|
    self.class.set(wait: 10.seconds).perform_later(job.arguments.first)
  end

  rescue_from ActiveJob::DeserializationError do 
    # Means server was deleted, can just ignore
    true
  end

  def perform(server)
    uri = URI.parse(server.protocol + server.hostname)
    request_time = Time.now
    # TODO: Will need a timeout to stop getting hung
    begin
      res = Net::HTTP.get_response(uri)
      response_time = Time.now
      heartbeat = server.heartbeats.create(status_code: res.code, status_message: res.message, request_time: request_time, response_time: response_time)
    rescue Errno::ECONNREFUSED, SocketError  => e
      heartbeat = server.heartbeats.create(status_code: 0, request_time: request_time, status_message: e.message)
    end
  end
end
