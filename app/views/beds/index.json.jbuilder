json.array!(@beds) do |bed|
  json.extract! bed, :id, :number
  json.url bed_url(bed, format: :json)
end
