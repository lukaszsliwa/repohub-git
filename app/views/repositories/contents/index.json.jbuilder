json.sha @tree.sha
json.path @tree.path
json.contents @tree.contents do |content|
  json.id content.id
  json.type content.type
  json.name content.name
  json.path content.path
  json.commit_id content.commit_id
  json.message content.message
  json.updated_at content.updated_at
end