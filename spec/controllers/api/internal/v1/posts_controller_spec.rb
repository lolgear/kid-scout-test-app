describe Api::Internal::V1::PostsController, type: :controller do
	describe 'methods' do
		before do
			Post.destroy_all
			drafts_count = rand(1..5)
			@drafts = (1..drafts_count).map { create :post, draft: true }
			posts_count = rand(1..5)
			@posts = (1..posts_count).map { create :post, draft: false }
			@all_posts = (@drafts + @posts)
		end

		context '#index' do
			it 'expect to return all posts' do
				get :index, format: :json
				expect(response).to be_success
				posts = JSON.parse(response.body)['posts']
				expect(posts.count).to be == @all_posts.count
				expect(posts.first.keys).to include('comments')
			end
		end

		context '#show' do
			it 'expect to return post by id' do
				post = create :post
				get :show, id: post.id, format: :json
				expect(response).to be_success
				found = JSON.parse(response.body)['post']
				expect(found['id']).to be == post.id
			end
		end

		context '#new' do
			it 'expect to return new post' do
				get :new, format: :json
				expect(response).to be_success
			end
		end

		context '#create' do
			it 'expect to create new post' do
				a_new = attributes_for :post
        expect do
          post :create, post: a_new, format: :json
        end.to change(Post, :count).by(1)

        expect(response).to be_success
        expect(assigns(:post)).not_to be_new_record
			end
		end

		context '#update' do
			it 'expect to update post' do
        existing = create :post
        an_update = attributes_for :post
        put :update, id: existing.id, post: an_update, format: :json

        expect(response).to be_success
        expect(assigns(:post).title).to be == an_update[:title]
			end
		end

		context '#destroy' do
			it 'expect to remove post and comments' do
				existing = create :post

				count = rand(1..5)
				(1..count).map { create :comment, post_id: existing.id }

				expect do
					delete :destroy, id: existing.id
				end.to change(Post, :count).by(-1)

				expect(existing.comments).to be_empty
			end
		end
	end
end

