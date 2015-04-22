json.sha @commit.sha
json.message @commit.message
json.committer_name @commit.committer_name
json.committer_email @commit.committer_email
json.author_name @commit.author_name
json.author_email @commit.author_email
json.additions @commit.additions
json.deletions @commit.deletions
json.parents @commit.parents
json.files @commit.files do |file|
  json.id file.id
  json.path file.path
  json.status file.status
  json.additions file.additions
  json.deletions file.deletions
  json.lines file.lines do |line|
    json.hunk_id line.hunk_id
    json.status line.status
    json.number line.number
    json.content line.content
  end
end
json.created_at @commit.created_at