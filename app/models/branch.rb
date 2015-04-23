class Branch
  include ActiveModel::Model

  attr_accessor :name, :sha, :repository

  class << self
    def all(repository)
      repository.rugged.branches.map do |rugged_branch|
        Branch.new(name: rugged_branch.name, sha: rugged_branch.target.try(:oid), repository: repository)
      end
    end

    def find(repository, name)
      if (rugged_branch = repository.rugged.branches[name]).present?
        Branch.new(name: name, sha: rugged_branch.target.try(:oid), repository: repository)
      end
    end
  end

  def commits
    target_id = repository.rugged.branches[name].target_id
    repository.logs(sha: target_id).map do |rugged_commit|
      Commit.build_from_rugged_commit repository, rugged_commit
    end
  end
end