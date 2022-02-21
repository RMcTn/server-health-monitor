class Server < ApplicationRecord
  before_validation :strip_hostname
  validates :hostname, presence: true, format: { with: /\A(?!https?:\/\/).*/, message: "cannot start with http:// or https://"}
  validates :protocol, inclusion: { in: %w(http:// https://)}
  validates :name, presence: true
  has_many :heartbeats, dependent: :destroy
  belongs_to :organisation

  ERRORS = [
    "500",
    "501",
    "502",
    "503",
    "504",
    "505",
    "506",
    "507",
    "508",
    "509",
    "510",
    "511",
    "0"
  ]

  CLIENT_ERRORS = [
  ]

  PROTOCOLS = [
    "http://",
    "https://"
  ]

  @@heartbeats_check_amount = 5

  after_create_commit {
    broadcast_prepend_to self.organisation, target: "healthy_servers", partial: "servers/healthy_server", locals: { server: self, organisation: self.organisation }
  }

  after_destroy_commit {
    broadcast_remove_to self.organisation
  }

  after_update_commit {
    # TODO: healthy server partial + problem server partial could just be merged into one server partial
    server_header_dom_id = "server_" + self.id.to_s + "-server-header"
    broadcast_replace_to(self.organisation, target: server_header_dom_id, partial: 'servers/server_header', locals: {server: self, organisation: self.organisation})
  }

  
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

  def strip_hostname
    self.hostname = self.hostname.strip
  end

end
