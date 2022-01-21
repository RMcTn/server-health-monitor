module HeartbeatsHelper
  def heartbeat_colour(heartbeat)
    return "bg-red-200" if heartbeat.is_500_error? || heartbeat.status_code == "0"
    return "bg-orange-200" if heartbeat.is_400_error? 
    return "bg-green-200" 
  end
end
