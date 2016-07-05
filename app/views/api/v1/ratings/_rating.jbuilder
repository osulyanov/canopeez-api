json.extract! rating, :id, :value, :created_at
json.startup do
  json.extract! rating.startup, :id, :name
end
