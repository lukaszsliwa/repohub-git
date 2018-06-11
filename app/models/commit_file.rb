class CommitFile
  include ActiveModel::Model

  attr_accessor :id, :path, :status, :hunks, :additions, :deletions, :commit

  def changed_lines_of_code
    [additions, deletions].max
  end

  def total_number_of_lines_before
    number_of_lines = 0
    if (parent_sha = commit.parents.first).present?
      number_of_lines = (Blob.find commit.repository, parent_sha, path).try(:total_number_of_lines) || 0
    end
    number_of_lines
  end

  def total_number_of_lines_after
    (Blob.find commit.repository, commit.sha, path).try(:total_number_of_lines) || 0
  end
end