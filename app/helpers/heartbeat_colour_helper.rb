module HeartbeatColourHelper
  def heartbeat_colour(heartbeat)
    if Server::ERRORS.include?(heartbeat.status_code)
      return "bg-red-200"
    else
      return "bg-green-200"
    end
  end
end
