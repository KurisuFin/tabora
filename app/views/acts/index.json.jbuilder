json.array!(@acts) do |act|
  json.extract! act, :id, :user_id, :battle_id
  json.url act_url(act, format: :json)
end
