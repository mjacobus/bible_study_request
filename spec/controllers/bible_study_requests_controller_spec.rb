# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BibleStudyRequestsController, type: :controller do
  describe 'GET #new' do
    it 'assigns cid' do
      get :new, params: { cid: 'the-cid' }

      expect(cookies[:cid]).to eq('the-cid')
    end

    it 'does not change cid when it has been assigned' do
      cookies[:cid] = 'the-cid'

      get :new, params: { cid: 'other-cid' }

      expect(cookies[:cid]).to eq('the-cid')
    end

    it 'assigns a visitor' do
      get :new, params: { cid: 'the-cid' }

      expect(assigns(:visitor).cid).to eq('the-cid')
      expect(assigns(:visitor).uuid.length).to eq(36)
    end
  end

  describe 'POST #create' do
    let(:new_visitor_params) do
      {
        uuid: 'the-uuid',
        email: 'the-email',
        name: 'the-name',
        phone: 'the-phone',
        cid: 'the-cid'
      }
    end

    it 'creates a visitor' do
      expect do
        post :create, params: { visitor: new_visitor_params }
      end.to change(Visitor, :count).by(1)
    end
  end
end
