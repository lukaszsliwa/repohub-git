class Blob
  include ActiveModel::Model


  attr_accessor :name, :path, :size, :content, :mode, :id, :commit_id

  class << self
    def find(repository, sha, path = nil)
      object = repository.rugged.lookup(sha)
      root_tree = object.type == :tree ? object : object.tree

      blob_entry = find_entry_by_path(repository, root_tree.oid, path)

      return nil unless blob_entry

      if blob_entry[:type] == :commit
        submodule_blob(blob_entry, path, sha)
      else
        blob = repository.rugged.lookup(blob_entry[:oid])

        if blob
          Blob.new(
              id: blob.oid,
              name: blob_entry[:name],
              size: blob.size,
              content: blob.content,
              mode: blob_entry[:filemode].to_s(8),
              path: path,
              commit_id: sha,
          )
        end
      end
    end

    def raw(repository, sha)
      blob = repository.rugged.lookup(sha)

      Blob.new(
          id: blob.oid,
          size: blob.size,
          content: blob.content,
      )
    end

    def find_entry_by_path(repository, root_id, path)
      root_tree = repository.rugged.lookup(root_id)
      path_arr = path.split('/')

      entry = root_tree.find do |entry|
        entry[:name] == path_arr[0]
      end

      return nil unless entry

      if path_arr.size > 1
        return nil unless entry[:type] == :tree
        path_arr.shift
        find_entry_by_path(repository, entry[:oid], path_arr.join('/'))
      else
        [:blob, :commit].include?(entry[:type]) ? entry : nil
      end
    end

    def submodule_blob(blob_entry, path, sha)
      Blob.new(
          id: blob_entry[:oid],
          name: blob_entry[:name],
          content: '',
          path: path,
          commit_id: sha,
      )
    end
  end

  def total_number_of_lines
    content.lines.size
  end

  def empty?
    !content || content == ''
  end
end