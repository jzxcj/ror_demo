require 'rails_helper'

RSpec.describe Visit, type: :model do
  subject { create(:visit) }

  describe '#add_login' do
    context 'when login is not in the user list' do
      let(:new_login) { "new #{subject.logins.first}" }

      it 'updates user list' do
        expect do
          subject.add_login(new_login)
        end.to change { subject.logins.size }.by(1)

        expect(subject.logins).to include(new_login)
      end
    end

    context 'when login not in the user list' do
      let(:new_login) { subject.logins.first }

      it 'updates user list' do
        expect do
          subject.add_login(new_login)
        end.not_to change { subject.logins.size }
      end
    end
  end
end
