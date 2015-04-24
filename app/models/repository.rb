require 'find'

class Repository
  include ActiveModel::Model

  attr_accessor :id, :name

  class << self
    def all
      Dir['/home/git/*.git'].map do |path|
        id = File.basename path, '.git'
        Repository.new(id: id, name: id)
      end
    end

    def find(id)
      @repository = Repository.new(id: id, name: id)
      unless @repository.exists?
        raise NotFoundException, "Repository #{id} not found"
      end
      @repository
    end
  end

  def commits
    Commit.all self
  end

  def branches
    Branch.all self
  end

  def tags
    Tag.all self
  end

  def find_commit(sha)
    Commit.find self, sha
  end

  def find_branch(name)
    Branch.find self, name
  end

  def find_tag(name)
    Tag.find self, name
  end

  def find_blob(sha, path)
    Blob.find(self, sha, path)
  end

  def logs(options = {})
    walker = Rugged::Walker.new rugged
    if (sha = options[:sha] || options[:to] || 'HEAD').present?
      walker.push sha
    end

    walker.hide options[:from] if options[:from]

    commits = []

    walker.sorting(Rugged::SORT_DATE)
    walker.each do |rugged_commit|
      commits.push rugged_commit
    end

    walker.reset

    commits
  rescue Rugged::OdbError, Rugged::InvalidError, Rugged::ReferenceError
    []
  end

  def path
    @path ||= "/home/git/#{id}.git"
  end

  def exists?
    File.exists? path
  end

  def size
    `du -sb #{path}`.split(' ')[0].to_i
  end

  def rugged
    @rugged ||= Rugged::Repository.new path
  end
end