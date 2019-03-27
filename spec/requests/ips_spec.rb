require 'rails_helper'

RSpec.describe 'Ips', type: :request do
  describe 'GET /ips' do
    let(:users)  { create_list(:user, 10) }
    let(:ips)    { Array.new(5) { Faker::Internet.ip_v4_address } }

    before do
      20.times { create(:post, user: users.sample, ip: ips.sample) }
    end

    it 'returns ips with user list as json' do
      get ips_path

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq 'application/json'
    end
  end
end
