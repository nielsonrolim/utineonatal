json.array!(@indicator_categories) do |indicator_category|
  json.extract! indicator_category, :id, :name
  json.url indicator_category_url(indicator_category, format: :json)
end
