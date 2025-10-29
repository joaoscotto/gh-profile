# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'validations' do
    context 'when there is no name' do
      subject { build(:profile, name: nil) }
      it { is_expected.not_to be_valid }
    end

    context 'when there is no url' do
      subject { build(:profile, url: nil) }
      it { is_expected.not_to be_valid }
    end
  end

  describe 'fulltext search' do
    context 'when query matches profiles' do
      let(:profile_matz) { create(:profile, name: 'Yukihiro Matsumoto', username: 'matz') }

      before { profile_matz.send(:update_fts_index) }

      context 'When finding by name' do
        subject { Profile.fulltext_search('Yukihiro') }
        it { is_expected.to include(profile_matz) }
      end

      context 'When finding by username' do
        subject { Profile.fulltext_search('matz') }
        it { is_expected.to include(profile_matz) }
      end
    end

    context 'when query does not match' do
      subject { Profile.fulltext_search('nonexistent') }
      it { is_expected.to be_empty }
    end

    context 'when query is blank' do
      subject { Profile.fulltext_search('') }
      it { is_expected.to be_none }
    end

    context 'when query is nil' do
      subject { Profile.fulltext_search(nil) }
      it { is_expected.to be_none }
    end
  end

  describe 'search index updates' do
    let(:profile) { build(:profile) }

    context 'when creating a profile' do
      it 'updates search index' do
        expect(profile).to receive(:update_fts_index)
        profile.save!
      end
    end

    context 'when updating a profile' do
      it 'updates search index' do
        expect(profile).to receive(:update_fts_index)
        profile.update!(name: 'New Name')
      end
    end

    context 'when destroying a profile' do
      let(:profile) { create(:profile) }

      it 'removes from search index' do
        expect(profile).to receive(:remove_from_fts_index)
        profile.destroy!
      end
    end
  end
end
