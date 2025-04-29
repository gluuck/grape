class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
  belongs_to :user, serializer: UserSerializer
end
