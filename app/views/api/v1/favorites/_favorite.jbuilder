json.extract! favorite, :id
json.startup do
  json.extract! favorite.startup, :id, :name, :description, :rating
end
