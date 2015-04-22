class Tag < Reference
  include ActiveModel::Model

  attr_accessor :name, :last_commit_id

  def self.all(repository)
    repository.rugged.tags.each do |rugged_tag|
      Branch.new(name: rugged_tag.name, last_commit_id: rugged_tag.target.try(:oid))
    end
  end
end