json.array!(@interventions) do |intervention|
  json.extract! intervention, :id, :name
  json.url intervention_url(intervention, format: :json)
end
