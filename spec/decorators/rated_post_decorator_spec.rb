require 'rails_helper'

RSpec.describe RatedPostDecorator do
  let(:post) { create(:post) }

  subject { RatedPostDecorator.new(post) }

  describe '#ip' do
    it 'returns ip address as string' do
      expect(subject.ip).to eq(post.ip.to_string)
    end
  end

  describe '#as_json' do
    let(:expected_hash) do
      { id:             post.id,
        title:          post.title,
        body:           post.body,
        average_rating: post.avg_rating.round(3) }
    end

    it 'returns the post as correct hash' do
      expect(subject.as_json).to eq(expected_hash)
    end
  end
end
