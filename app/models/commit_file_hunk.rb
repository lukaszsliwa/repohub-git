class CommitFileHunk
  include ActiveModel::Model

  attr_accessor :id, :lines, :header
end