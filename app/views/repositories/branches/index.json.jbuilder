json.array! @branches do |branch|
  json.id branch.name
  json.name branch.name
  json.sha branch.sha
end