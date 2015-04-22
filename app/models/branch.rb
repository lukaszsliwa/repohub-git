class Branch
  include ActiveModel::Model

  attr_accessor :name, :last_commit_id

  def self.all(repository)
    repository.rugged.branches.map do |rugged_branch|
      Branch.new(name: rugged_branch.name, last_commit_id: rugged_branch.target.try(:oid))
    end
  end
end