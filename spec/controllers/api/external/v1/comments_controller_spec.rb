describe Api::External::V1::CommentsController, type: :controller do
  describe 'methods' do
    before do
      Comment.destroy_all
      @post = create :post, draft: false
      comments_count = rand(1..5)
      (1..comments_count).map { create :comment, post_id: @post.id }
      @without_comments_post = create :post, draft: false
      @non_existing_post = build :post, draft: false
      @draft = create :post
      (1..comments_count).map { create :comment, post_id: @draft.id }
    end

    context '#index' do
      it 'expect to return all comments for post' do
        get :index, params: { post_id: @post.id }, format: :json
        expect(response).to be_successful
        commments = JSON.parse(response.body)['comments']
        expect(commments.count).to be == (@post.comments.count)
      end
      it 'expect not to return comments for draft' do
        get :index, params: { post_id: @draft.id }, format: :json
        expect(response).not_to be_successful
      end
      it 'expect to return nothing for post without comments' do
        get :index, params: { post_id: @without_comments_post.id }, format: :json
        expect(response).to be_successful
        commments = JSON.parse(response.body)['comments']
        expect(commments).to be_empty
      end
      it 'expect to show errors for non-existing post' do
        expect do
          get :index, params: { post_id: @non_existing_post.id }, format: :json
        end.to raise_error
      end
    end

    context '#show' do
      it 'expect to show comment for post' do
        comment = @post.comments.first
        get :show, params: { post_id: @post.id, id: comment.id }, format: :json
        expect(response).to be_successful
        found = JSON.parse(response.body)['comment']
        expect(found['id']).to be == (@post.comments.first.id)
      end
      it 'expect not to show comment for draft' do
        comment = @draft.comments.first
        get :show, params: { post_id: @draft.id, id: comment.id }, format: :json
        expect(response).not_to be_successful
      end
    end

    context '#new' do
      it 'expect to build new comment for post' do
        post = create :post, draft: false
        get :new, params: { post_id: post.id },  format: :json
        expect(response).to be_successful
      end
      it 'expect not to build new comment for draft' do
        post = create :post
        get :new, params: { post_id: post.id }, format: :json
        expect(response).not_to be_successful
      end
    end

    # we don't need these items now
    # context '#create' do
    #   it 'expect to create new comment' do
    #     existing_post = create :post
    #     a_new = attributes_for :comment
  #       expect do
  #         post :create, post_id: existing_post.id, comment: a_new, format: :json
  #       end.to change(Comment, :count).by(1)

  #       expect(response).to be_successful
    #   end
    # end

    # context '#update' do
    #   it 'expect to update post' do
    #     existing_post = create :post
  #       existing = create :comment, post_id: existing_post.id
  #       an_update = attributes_for :comment
  #       put :update, post_id: existing_post.id, id: existing.id, comment: an_update, format: :json

  #       expect(response).to be_successful
    #   end
    # end

    # context '#destroy' do
    #   it 'expect to remove post and comments' do
    #     existing = create :post

    #     count = rand(1..5)
    #     comments = (1..count).map { create :comment, post_id: existing.id }
    #     to_destroy = comments.first
    #     expect do
    #       delete :destroy, post_id: existing.id, id: to_destroy.id
    #     end.to change(Comment, :count).by(-1)
    #   end
    # end
  end
end

