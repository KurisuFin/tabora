json.array!(@operators) do |operator|
  json.extract! operator, :id, :user_id, :event_id
  json.url operator_url(operator, format: :json)
end
