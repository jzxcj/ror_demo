require 'rails_helper'

RSpec.describe FetchIpsWithMultiplyUsers do
  let(:users)  { create_list(:user, 10) }
  let(:ips)    { Array.new(5) { Faker::Internet.ip_v4_address } }

  before { 20.times { create(:post, user: users.sample, ip: ips.sample) } }

  subject { described_class.() }

  describe '.call' do
    let!(:expected_avg_rating) do
      Visit.where('array_length(logins, 1) > 1').order('id DESC')
    end

    it 'succeeds' do
      is_expected.to be_success
    end

    it 'returns correct ips with user lists' do
      expect(subject.result.as_json).to contain_exactly(*expected_avg_rating.as_json)
    end
  end
end
