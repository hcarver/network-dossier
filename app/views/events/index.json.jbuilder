json.array!(@events) do |event|
  json.extract! event, :id, :index, :show
  json.url event_url(event, format: :json)
end
