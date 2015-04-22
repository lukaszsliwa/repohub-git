json.array! @tags do |tag|
  json.name tag.name
  json.last_commit_id tag.last_commit_id
end