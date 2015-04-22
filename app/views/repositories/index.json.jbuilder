json.array! @repositories do |repository|
  json.id repository.id
  json.name repository.name
  json.path repository.path
  json.size repository.size
end