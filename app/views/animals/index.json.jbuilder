json.array!(@animals) do |animal|
  json.extract! animal, :id
  json.url animal_url(animal, format: :json)
end
