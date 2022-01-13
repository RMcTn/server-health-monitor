class SendHeartbeatJob < ApplicationJob
  require 'uri'
  require 'Net/http'
  queue_as :default
  after_perform do |job|
    self.class.set(wait: 10.seconds).perform_later(job.arguments.first)
  end

  def perform(server)
    # TODO: need a queue backend for this for persistence
    uri = URI.parse(server.hostname)
    request_time = Time.now
    # TODO: Handle case where server no longer exists
    # TODO: Will need a timeout to stop getting hung
    begin
      res = Net::HTTP.get_response(uri)
      heartbeat = server.heartbeats.create(status_code: res.code, request_time: request_time)
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError, Errno::ECONNREFUSED,
      Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
      # TODO: Handle this better (different http lib?)
      heartbeat = server.heartbeats.create(status_code: 0, request_time: request_time)
    end
  end
end
