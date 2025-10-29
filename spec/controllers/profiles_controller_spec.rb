# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe 'GET #index' do
    it 'returns success' do
      get :index
      expect(response).to be_successful
    end

    context 'When finding by username' do
      subject { get :index, params: { q: 'matz' } }
      it { is_expected.to be_successful }
    end
  end

  describe 'POST #create' do
    subject { post :create, params: { profile: { name: 'Test', url: 'https://test.com' } } }
    let(:profile) { create(:profile, name: 'Test User') }

    before do
      allow(Interactors::Profiles::SaveProfile).to(
        receive(:call).and_return(double(success?: true, profile: profile))
      )
    end

    it 'returns success' do
      subject
      expect(response).to redirect_to(profiles_path(q: 'Test User'))
      expect(flash[:notice]).to eq('Profile saved successfully.')
    end
  end

  describe 'PUT #update' do
    subject { put :update, params: { id: profile.id, profile: { name: 'Updated' } } }
    let(:profile) { create(:profile, name: 'Test User') }

    before do
      allow(Interactors::Profiles::SaveProfile).to(
        receive(:call).and_return(double(success?: true, profile: profile))
      )
    end

    it 'returns success' do
      subject
      expect(response).to redirect_to(profiles_path(q: 'Test User'))
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: profile.id } }
    let(:profile) { create(:profile) }

    it 'returns success' do
      subject
      expect(response).to redirect_to(profiles_path)
      expect(flash[:notice]).to eq('Profile deleted.')
    end
  end
end
