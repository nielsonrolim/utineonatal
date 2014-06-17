json.array!(@patients) do |patient|
  json.extract! patient, :id, :name, :birthdate, :sex
  json.url patient_url(patient, format: :json)
end
