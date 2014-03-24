json.array!(@battles) do |battle|
  json.extract! battle, :id, :name, :state
  json.url battle_url(battle, format: :json)
end
