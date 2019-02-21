require 'spec_helper'
RSpec.describe Post, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  # I want validate integraty of models?
  subject(:post) { build :post }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }
  its(:draft) { is_expected.to be true }
  describe 'associations' do
    context 'as comments' do
      it 'are expected to be ok and have many comments' do
        post = create :post
        # generate several comments
        count = rand(1..10)
        comments = (1..count).map { create :comment }
        post.comments << comments
        expect(post.comments.count).to be == count
        expect(comments.map(&:post_id)).to all be == post.id
      end

      it 'are expected to destroy comments with post' do
        post = create :post
        count = rand(1..10)
        comments = (1..count).map { create  :comment }
        post.comments << comments
        post.destroy
        expect(post.comments).to be_empty
      end
    end
  end

  describe 'scopes' do
    context 'for mobile applications' do
      before do
        Post.destroy_all
      end
      it 'are expected to be ok and show only real posts, not drafts' do
        drafts_count = rand(1..10)
        real_posts_count = rand(1..10)

        posts = (1..drafts_count).map { create :post }

        posts += (1..real_posts_count).map { create :post, draft: false }
        expect(Post.available.count).to be == real_posts_count
      end
    end
  end
end