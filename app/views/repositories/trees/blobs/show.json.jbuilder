json.id @blob.id
json.name @blob.name
json.path @blob.path
json.mode @blob.mode
json.size @blob.size
json.total_number_of_lines @blob.total_number_of_lines
json.content @blob.content
json.commit_id @blob.commit_id
if @blob.commit.present?
  json.commit do
    json.id @blob.commit_id
    json.sha @blob.commit.sha
    json.author_email @blob.commit.author_email
    json.author_name @blob.commit.author_name
    json.committer_email @blob.commit.committer_email
    json.committer_name @blob.commit.committer_name
    json.message @blob.commit.message
    json.created_at @blob.commit.created_at
  end
end