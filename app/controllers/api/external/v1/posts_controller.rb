module Api
	class External::V1::PostsController < Api::PostsController

		# def index
		# 	render json: Post.available, status: 200
		# end
		def available_posts
			Post.available
		end
	end
end