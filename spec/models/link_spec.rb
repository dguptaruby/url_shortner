require 'rails_helper'

RSpec.describe Link, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:url) }
    it { should validate_uniqueness_of(:slug) }
  end

  describe '#short' do
    subject { build(:link) }
    Rails.application.routes.default_url_options = { host: 'localhost:3000', protocol: 'http' }
    it { expect(subject.short).to include(subject.slug) }
  end

  describe '#generate_link' do
    context 'when URL is empty returns link with error' do
      let(:link) { Link.generate_link('') }
      it { expect(link).to be_instance_of(Link) }
      it { expect(link).to_not be_valid }
      it { expect(link.errors.messages[:url]).to eq ['can\'t be blank'] }
    end

    context 'when URL is present returns a valid link with slug' do
      let(:link) { Link.generate_link('www.google.com') }
      it { expect(link).to be_instance_of(Link) }
      it { expect(link).to be_valid }
      it { expect(link.slug).to_not be_nil }
    end
  end
end
