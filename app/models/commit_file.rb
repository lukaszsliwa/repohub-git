class CommitFile
  include ActiveModel::Model

  attr_accessor :id, :path, :status, :lines, :additions, :deletions
end