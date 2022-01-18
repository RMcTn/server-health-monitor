class Server < ApplicationRecord
  validates :hostname, presence: true
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
    return false if !defined?(heartbeats.last)
    ERRORS.include?(heartbeats.last.status_code)
  end
end
