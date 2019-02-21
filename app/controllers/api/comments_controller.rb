module Api
  class CommentsController < ApiController
    def index
      post = associated_post
      if post
        render json: post.comments, status: 200
      else
        render json: {}, status: 404
      end
    end

    def show
      post = associated_post
      unless post
        render json: {}, status: 404
        return
      end
      comment = post.comments.find(params[:id])
      if comment
        render json: comment, status: 200
      else
        render json: {}, status: 404
      end
    end

    def edit
      render :show
    end

    def new
      post = associated_post
      unless post
        render json: {}, status: 404
        return
      end
      render json: Comment.new, status: 200
    end

    def create
      post = associated_post
      unless post
        render json: {}, status: 404
        return
      end
      comment = Comment.new(comment_params)
      comment.post_id = post.id
      if comment.save
        render json: comment, status: 201
      else
        render json: comment.errors, status: 422
      end

    end

    def update
      post = associated_post
      unless post
        render json: {}, status: 404
        return
      end
      comment = post.comments.find(params[:id])
      unless comment
        render json: {}, status: 404
      end
      if comment.update_attributes comment_params
        render json: comment, status: 200
      else
        render json: comment.errors, status: 400
      end
    end

    def destroy
      post = associated_post
      unless post
        render json: {}, status: 404
        return
      end
      comment = post.comments.find(params[:id])
      unless comment
        render json: {}, status: 404
      end
      if comment.destroy
        render json: {}, status: 204
      else
        render json: comment.errors, status: 422
      end
    end

    private
    def comment_params
      params.require(:comment).permit(:body, :post_id)
    end

    protected
    def associated_post
      post_id = params[:post_id]
      Post.find post_id
    end
  end
end