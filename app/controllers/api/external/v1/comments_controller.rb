module Api
	class External::V1::CommentsController < Api::CommentsController
		def associated_post
			post_id = params[:post_id]
			Post.available.find post_id
		end
	end
end