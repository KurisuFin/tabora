json.array!(@participations) do |participation|
  json.extract! participation, :id, :user_id, :tournament_id
  json.url participation_url(participation, format: :json)
end
