json.extract! request, :id, :status_code, :request_time, :created_at, :updated_at
json.url request_url(request, format: :json)
