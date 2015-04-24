json.array! @contents do |content|
  json.id content.sha
  json.sha content.sha
  json.type content.type
  json.name content.name
  json.path content.path
  json.commit_id content.commit_id
  json.message content.message
  json.updated_at content.updated_at
end