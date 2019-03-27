require 'rails_helper'

RSpec.describe IpWithUserListDecorator do
  let(:visit) { create(:visit) }

  subject { IpWithUserListDecorator.new(visit) }

  describe '#ip' do
    it 'returns ip address as string' do
      expect(subject.ip).to eq(visit.ip.to_string)
    end
  end

  describe '#as_json' do
    let(:expected_hash) do
      {
        ip:     visit.ip.to_string,
        logins: visit.logins
      }
    end

    it 'returns the record as correct hash' do
      expect(subject.as_json).to eq(expected_hash)
    end
  end
end
