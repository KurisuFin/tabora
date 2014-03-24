json.array!(@setups) do |setup|
  json.extract! setup, :id, :code, :data
  json.url setup_url(setup, format: :json)
end
