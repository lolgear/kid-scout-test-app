class Api::External::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :body
end