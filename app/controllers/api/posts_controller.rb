module Api
	class PostsController < ApiController
		# load_and_authorize_resource except: :index
		def index
			render json: available_posts, status: 200
		end

		def show
			render json: available_posts.find(params[:id]), status: 200
		end

		def edit
			render :show
		end

		def new
			render json: Post.new, status: 200
		end

		def create
			@post = Post.new(post_params)
			if @post.save
				render json: @post, status: 201
			else
				render json: @post.errors, status: 422
			end
		end

		def update
			@post = available_posts.find(params[:id])

			unless @post
				render json: {}, status: 404
			end
			an_update = post_params
			if @post.update_attributes an_update
				render json: @post, status: 200
			else
				render json: @post.errors, status: 400
			end

		end

		def destroy
			@post = available_posts.find(params[:id])

			unless @post
				render json: {}, status: 404
			end

			if @post.destroy
				render json: {}, status: 204
			else
				render json: @post.errors, status: 422
			end
		end

		private
		def post_params
			params.require(:post).permit(:title, :body, :draft)
		end
		protected
		def available_posts
			Post.all
		end
	end
end