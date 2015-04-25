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
  json.total_number_of_lines_before file.total_number_of_lines_before
  json.total_number_of_lines_after file.total_number_of_lines_after
  json.hunks file.hunks do |hunk|
    json.id hunk.id
    json.header hunk.header
    json.lines hunk.lines do |line|
      json.id line.id
      json.status line.status
      json.number line.number
      json.content line.content
    end
  end
end
json.created_at @commit.created_at
