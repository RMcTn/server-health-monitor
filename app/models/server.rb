class Server < ApplicationRecord
  validates :hostname, presence: true , format: { with: /https?:\/\/.*/, message: "Hostname must start with http:// or https://"}
  has_many :heartbeats, dependent: :destroy
  belongs_to :organisation

  ERRORS = [
    "500",
    "0"
  ]


  def recent_failure?
    @heartbeats_check_amount = 5
    # TODO: Should use a scope here for order?
    heartbeats.order(id: :desc).limit(@heartbeats_check_amount).any? do |heartbeat|
      ERRORS.include?(heartbeat.status_code)
    end
  end

  def last_request_failed?
    return false if heartbeats.last == nil
    ERRORS.include?(heartbeats.last.status_code)
  end
end
