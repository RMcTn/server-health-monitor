class SendHeartbeatJob < ApplicationJob
  require 'uri'
  require 'Net/http'
  queue_as :default
  after_perform do |job|
    self.class.set(wait: 10.seconds).perform_later(job.arguments.first)
  end

  def perform(*servers)
    # TODO: need a queue backend for this for persistence
    server = servers[0]
    p "Server is " + server.to_s
    p "Server hostname is " + server.hostname
    uri = URI.parse(server.hostname)
    p uri
    p "Sending request to " + uri.to_s
    request_time = Time.now
    # TODO: Will need a timeout to stop getting hung
    begin
      res = Net::HTTP.get_response(uri)
      p "SUCCESS" if res.is_a?(Net::HTTPSuccess)
      heartbeat = server.heartbeats.create(status_code: res.code, request_time: request_time)
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError, Errno::ECONNREFUSED,
      Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
      # TODO: Handle this better (different http lib?)
      heartbeat = server.heartbeats.create(status_code: 0, request_time: request_time)
    end
 
    # TODO: This possibly won't trigger turbo streams (manually trigger here?)
  end
end
