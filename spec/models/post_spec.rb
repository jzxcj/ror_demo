require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:rate) { 5 }

  subject { create(:post_with_rating) }

  describe '#update_avg_rating' do
    let(:new_rating) { subject.ratings.average(:rate) }

    it 'updates average rating of the post' do
      subject.ratings.create(rate: rate)
      subject.update_avg_rating

      expect(subject.avg_rating).to be_within(0.01).of(new_rating)
    end
  end
end
