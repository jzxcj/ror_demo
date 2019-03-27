require 'rails_helper'

RSpec.describe UpdateRating do
  let!(:post) { create(:post_with_rating, ratings_count: 5) }
  let(:rate)  { 5 }

  subject { described_class.(post, rate) }

  describe '.call' do
    let!(:expected_avg_rating) { post.ratings.average(:rate) }

    it 'succeeds' do
      is_expected.to be_success
    end

    it 'creates new rating for the post' do
      expect { subject }.to change(Rating, :count).by(1)
    end

    it 'returns correct average rating of the post' do
      expect(post).to receive(:update_avg_rating)

      subject
    end
  end
end
