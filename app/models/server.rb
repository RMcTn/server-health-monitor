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


  def recent_failure?
    @heartbeats_check_amount = 5
    # TODO: Should use a scope here for order?
    heartbeats.order(id: :desc).limit(@heartbeats_check_amount).any? do |heartbeat|
      ERRORS.include?(heartbeat.status_code)
    end
  end

  def last_request_failed?
    return false if heartbeats.first == nil
    ERRORS.include?(heartbeats.first.status_code)
  end
end
