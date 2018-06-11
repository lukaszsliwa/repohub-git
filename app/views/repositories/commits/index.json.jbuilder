json.array! @commits do |commit|
  json.id commit.sha
  json.sha commit.sha
  json.message commit.message
  json.committer_name commit.committer_name
  json.committer_email commit.committer_email
  json.author_name commit.author_name
  json.author_email commit.author_email
  json.additions commit.additions
  json.deletions commit.deletions
  json.parents commit.parents
  json.created_at commit.created_at
end