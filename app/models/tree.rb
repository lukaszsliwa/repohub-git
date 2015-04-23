class Tree
  include ActiveModel::Model

  attr_accessor :repository, :sha, :path, :contents

  class << self
    def find(repository, sha_or_name, path = nil)
      path = nil if path == '' || path == '/'

      sha = sha_or_name

      unless ((object = repository.rugged.lookup(sha)) rescue nil).present?
        raise NotFoundException, "Object `#{sha_or_name}` not found"
      end

      root_tree = if object.type == :tree
        object
      elsif object.type == :commit
        object.tree
      else
        raise NotFoundException, "Object `#{sha_or_name}` not found"
      end

      tree = if path
        if (id = Tree.find_id_by_path(repository, root_tree.oid, path)).present?
          repository.rugged.lookup id
        else
          []
        end
      else
        root_tree
      end

      contents = tree.map do |entry|
        content_path = path.present? ? "#{path}/#{entry[:name]}" : entry[:name]
        output = `cd #{repository.path} && git log -1 --format="%s%n%cd%n%H" #{sha} -- #{content_path}`.split("\n")
        message, updated_at, commit_id = output[0], (DateTime.parse(output[1]) rescue nil), output[2]
        Content.new(
            name: entry[:name],
            path: content_path,
            id: entry[:oid],
            sha: entry[:oid],
            type: entry[:type],
            updated_at: updated_at,
            message: message,
            commit_id: commit_id
        )
      end
      Tree.new(repository: repository, sha: sha, path: path, contents: contents)
    end

    def find_id_by_path(repository, root_id, path)
      root_tree = repository.rugged.lookup(root_id)
      path_arr = path.split('/')

      entry = root_tree.find do |entry|
        entry[:name] == path_arr[0] && entry[:type] == :tree
      end

      return nil unless entry

      if path_arr.size > 1
        path_arr.shift
        find_id_by_path(repository, entry[:oid], path_arr.join('/'))
      else
        entry[:oid]
      end
    end
  end
end