class Tag < Reference
  include ActiveModel::Model

  attr_accessor :name, :sha, :repository

  class << self
    def all(repository)
      repository.rugged.tags.map do |rugged_tag|
        Branch.new(name: rugged_tag.name, sha: rugged_tag.target.try(:oid), repository: repository)
      end
    end

    def find(repository, name)
      if (rugged_tag = repository.rugged.tags[name]).present?
        Tag.new(name: name, sha: rugged_tag.target.try(:oid), repository: repository)
      end
    end
  end

  def commits(options = {})
    target_id = repository.rugged.tags[name].target_id
    repository.logs({sha: target_id}.merge(options)).map do |rugged_commit|
      Commit.build_from_rugged_commit repository, rugged_commit
    end
  end
end