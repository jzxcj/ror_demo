require 'rails_helper'

RSpec.describe FetchTopRatedPosts do
  let(:size) { 5 }
  let!(:posts) { create_list(:post_with_rating, 20) }
  let(:expected_posts) do
    Post.select('posts.id, posts.title, posts.body, posts.avg_rating, avg(ratings.rate) as rate').joins(:ratings).group('posts.id').order('rate DESC, posts.created_at DESC')
        .limit(size)
  end

  subject { described_class.(size) }

  describe '.call' do
    it 'succeeds' do
      is_expected.to be_success
    end

    it 'returns correct post in correct order' do
      subject

      expect(subject.result.as_json).to contain_exactly(*expected_posts.as_json(except: [:rate]))
    end
  end
end
