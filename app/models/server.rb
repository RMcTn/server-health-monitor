class Server < ApplicationRecord
  validates :hostname, presence: true, format: { with: /\A(?!https?:\/\/).*/, message: "Hostname cannot start with http:// or https://"}
  validates :protocol, inclusion: { in: %w(http:// https://)}
  has_many :heartbeats, dependent: :destroy
  belongs_to :organisation

  ERRORS = [
    "500",
    "0"
  ]

  PROTOCOLS = [
    "http://",
    "https://"
  ]

  @@heartbeats_check_amount = 5

  
  def recent_failure?
    # TODO: Should use a scope here for order?
    arr = heartbeats.order(id: :desc).limit(@@heartbeats_check_amount)
    return false if arr.first == nil
    return false if ERRORS.include?(arr[0].status_code) 
    arr.any? do |heartbeat|
      ERRORS.include?(heartbeat.status_code)
    end
  end

  def last_request_failed?
    return false if heartbeats.first == nil
    ERRORS.include?(heartbeats.first.status_code)
  end

  def all_good?
    !last_request_failed? && !recent_failure?
  end

  def just_became_healthy?
    arr = heartbeats.order(id: :desc).limit(@@heartbeats_check_amount + 1)
    return false if arr.first == nil
    return false if arr.length < @@heartbeats_check_amount 

    if ERRORS.include?(arr.last.status_code)
      arr.slice(0, arr.length - 1).each do |heartbeat|
        if ERRORS.include?(heartbeat.status_code)
          return false
        end
      end
      return true
    end 

    return false
  end

end
