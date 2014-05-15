json.array!(@indicators) do |indicator|
  json.extract! indicator, :id, :name, :obs_description, :has_obs, :indicator_category_id
  json.url indicator_url(indicator, format: :json)
end
