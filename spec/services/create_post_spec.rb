require 'rails_helper'

RSpec.describe CreatePost do
  let(:attributes) do
    {
      title: 'test title',
      body:  'test body',
      login: 'test login',
      ip:    '127.0.0.1'
    }
  end

  let(:validator_class) { double(:validator_class, new: nil) }
  let(:validator) { double(:validator, valid?: true, errors: nil) }

  subject { described_class.(attributes) }

  before do
    described_class.validator_class = validator_class

    allow(validator_class).to receive(:new).with(attributes).and_return(validator)
  end

  describe '.call' do
    context 'when params are valid' do
      it 'succeeds' do
        is_expected.to be_success
      end

      it 'validates params' do
        expect(validator).to receive(:valid?)

        subject
      end

      it 'creates the post' do
        expect { subject }.to change(Post, :count).by(1)
      end

      it 'returns the correct post' do
        post = subject.result

        expect(post.title).to eq(attributes[:title])
        expect(post.body).to  eq(attributes[:body])
        expect(post.login).to eq(attributes[:login])
        expect(post.ip).to    eq(attributes[:ip])
      end
    end

    context 'when params are invalid' do
      let(:validator) { double(:validator, valid?: false, errors: errors) }
      let(:errors)    { double(:errors, messages: expected_errors_messages) }

      let(:expected_errors_messages) { { test_field: ['test errors message'] } }

      it 'fails' do
        is_expected.to be_failure
      end

      it 'returns errors' do
        expect(subject.errors).to include expected_errors_messages
      end
    end
  end
end
