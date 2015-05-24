class Api::Internal::V1::CommentSerializer < ActiveModel::Serializer
	attributes :id, :body
end