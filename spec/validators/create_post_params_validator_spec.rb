require 'rails_helper'

RSpec.describe CreatePostParamsValidator, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:login) }
  it { should validate_presence_of(:ip) }

  let(:params) { { title: 'test', body: 'test', login: 'test', ip: '127.0.0.1' } }

  subject { described_class.new(params) }

  describe 'ip validation' do
    context 'when ip is valid' do
      specify 'valid' do
        expect(subject.valid?).to be true
      end
    end

    context 'when ip is invalid' do
      let(:params) { { title: 'test', body: 'test', login: 'test', ip: 'a127.0.0.1' } }

      specify 'invalid' do
        expect(subject.valid?).to be false
        expect(subject.errors[:ip]).to include('Invalid ip address')
      end
    end
  end
end
