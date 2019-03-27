require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'POST /posts' do
    let(:valid_attributes) do
      {
        title: 'test title',
        body:  'test body',
        login: 'test login',
        ip:    '127.0.0.1'
      }
    end

    let(:invalid_attributes) do
      {
        title: nil,
        body:  nil,
        login: nil,
        ip:    nil
      }
    end

    context 'when attributes are valid' do
      it 'creates new post' do
        expect do
          post '/posts', params: { post: valid_attributes }
        end.to change(Post, :count).by(1)

        expect(response).to have_http_status(:ok)
      end

      it 'returns the created post as json' do
        post '/posts', params: { post: valid_attributes }

        expect(response.content_type).to eq 'application/json'
        expect(response.body).to include_json(valid_attributes)
      end
    end

    context 'when attributes are invalid' do
      let(:expected_errors) do
        {
          title: ["can't be blank"],
          body:  ["can't be blank"],
          login: ["can't be blank"],
          ip:    ["can't be blank"]
        }
      end

      it 'returns unprocessable entity status' do
        post '/posts', params: { post: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns validation errors as json' do
        post '/posts', params: { post: invalid_attributes }

        expect(response.content_type).to eq 'application/json'
        expect(response.body).to include_json(errors: expected_errors)
      end
    end
  end

  describe 'PATCH /posts/:id/rate' do
    let(:post) { create(:post_with_rating, ratings_count: 5) }
    let!(:old_rating) { post.avg_rating }
    let(:rate) { 5 }
    let(:new_rating) { post.ratings.average(:rate).to_f }

    it 'rates the post' do
      patch rate_post_path(post.id), params: { rate: rate }

      expect(post.reload.avg_rating).to be_within(0.01).of(new_rating)
    end

    it 'returns new avarage post rating as json' do
      patch rate_post_path(post.id), params: { rate: rate }

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq 'application/json'
      expect(JSON.parse(response.body)['average_rating']).to be_within(0.01).of(new_rating)
    end
  end

  describe 'GET /posts/rating/:size' do
    let(:size)   { 5 }
    let!(:posts) { create_list(:post_with_rating, 20) }
    let(:expected_posts) do
      Post.select('posts.id, posts.title, posts.body, avg(ratings.rate) as average_rating').joins(:ratings)
          .group('posts.id')
          .order('average_rating DESC, posts.created_at DESC')
          .limit(size)
    end

    it 'returns N top rated posts as json in correct order' do
      get top_rated_posts_path(size)

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq 'application/json'
      expect(JSON.parse(response.body)).to contain_exactly(*expected_posts.as_json)
    end
  end
end
