json.array! @startups do |startup|
  json.extract! startup, :id, :name, :description, :rating
end
