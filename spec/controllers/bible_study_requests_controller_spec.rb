# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BibleStudyRequestsController, type: :controller do
  describe '#index' do
    xit 'is only accessible via http basic auth' do
      ENV['HTTP_BASIC_AUTH'] = 'foo:bar'

      authorization = ActionController::HttpAuthentication::Basic.encode_credentials(
        'foo',
        'bar'
      )

      request.env['HTTP_AUTHORIZATION'] = authorization

      get :index

      expect(response).to be_successful
    end

    it 'responds with 401' do
      get :index

      expect(response.status).to eq 401
    end
  end

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

    it 'renders :new' do
      get :new, params: { cid: 'the-cid' }

      expect(controller).to have_rendered(:new)
    end
  end

  describe 'POST #create' do
    let(:new_visitor_params) do
      {
        uuid: 'the-uuid',
        email: 'the-email',
        name: 'the-name',
        phone: 'the-phone',
        cid: 'the-cid',
        message: 'the-message'
      }
    end

    context 'with valid params' do
      it 'creates a visitor' do
        expect do
          post :create, params: { visitor: new_visitor_params }
        end.to change(Visitor, :count).by(1)

        visitor = Visitor.last
        visitor_attributes = visitor.attributes
          .symbolize_keys
          .slice(*new_visitor_params.keys)
        expect(visitor_attributes).to eq(new_visitor_params)
      end

      it 'redirects to new action' do
        post :create, params: { visitor: new_visitor_params }

        expect(response).to redirect_to(new_bible_study_request_path(requested: true))
      end
    end

    context 'with invalid params' do
      it 're-renders :new' do
        post :create, params: { visitor: new_visitor_params.except(:name) }

        expect(controller).to render_template(:new)
      end
    end
  end
end
