json.array! @branches do |branch|
  json.name branch.name
  json.last_commit_id branch.last_commit_id
end