class Api::CommentSerializer < ActiveModel::Serializer
	attributes :id, :body
end