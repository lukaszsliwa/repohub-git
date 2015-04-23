class Content
  include ActiveModel::Model

  attr_accessor :name, :path, :id, :type, :updated_at, :message, :commit_id
end