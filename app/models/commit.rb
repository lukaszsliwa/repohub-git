class Commit
  include ActiveModel::Model

  attr_accessor :repository, :sha, :message, :author_email, :author_name, :committer_email, :committer_name,
                :additions, :deletions, :files, :created_at, :rugged_commit, :parents

  class << self
    def all(repository)
      raise 'Repository is required' if repository.nil?

      repository.logs.map { |rugged_commit| build_from_rugged_commit(repository, rugged_commit) }
    end

    def build_from_rugged_commit(repository, rugged_commit, options = {})
      commit = Commit.new(repository: repository, sha: rugged_commit.oid, message: rugged_commit.message.try(:strip),
                 author_email: rugged_commit.author[:email], author_name: rugged_commit.author[:name],
                 committer_email: rugged_commit.committer[:email], committer_name: rugged_commit.committer[:name],
                 created_at: rugged_commit.time, rugged_commit: rugged_commit, parents: rugged_commit.parents.map(&:oid))
      commit.initialize_attributes options
      commit
    end

    def find(repository, sha)
      commit_rugged = repository.rugged.lookup sha
      build_from_rugged_commit repository, commit_rugged, {files: true, patches: true}
    rescue Rugged::ReferenceError, Rugged::InvalidError, Rugged::ObjectError
      nil
    end
  end

  def initialize_attributes(options = {})
    if rugged_commit.parents.empty?
      rugged_diff = repository.rugged.diff nil, rugged_commit
    else
      rugged_diff = rugged_commit.parents[0].diff(rugged_commit)
    end

    initialize_statistics rugged_diff
    initialize_files      rugged_diff if options[:files]
  end

  def initialize_statistics(rugged_diff)
    self.additions, self.deletions = 0, 0
    rugged_diff.each_patch do |patch|
      self.additions += patch.stat[0]
      self.deletions += patch.stat[1]
    end
  end

  def initialize_files(rugged_diff)
    self.files = []
    rugged_diff.deltas.each do |delta|
      self.files << CommitFile.new(path: delta.new_file[:path], status: delta.status, id: delta.object_id, commit: self)
    end
    rugged_diff.patches.each_with_index do |rugged_patch, index|
      self.files[index].lines, self.files[index].additions, self.files[index].deletions = [], 0, 0
      rugged_patch.hunks.each do |rugged_hunk|
        self.files[index].lines << CommitFileLine.new(hunk_id: rugged_hunk.object_id, content: rugged_hunk.header, status: 'header')
        rugged_hunk.lines.each do |rugged_line|
          number = rugged_line.new_lineno < 0 ? rugged_line.old_lineno : rugged_line.new_lineno
          self.files[index].lines << CommitFileLine.new(hunk_id: rugged_hunk.object_id, number: number, content: rugged_line.content, status: rugged_line.line_origin)
          self.files[index].additions += 1 if rugged_line.addition?
          self.files[index].deletions += 1 if rugged_line.deletion?
        end
      end
    end
  end
end
