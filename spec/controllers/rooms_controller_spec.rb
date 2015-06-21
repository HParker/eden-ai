require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  describe "#new" do
    it 'does not really do anything yet' do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    before { create(:map) }

    it 'creates a new room' do
      get :create, { room: {id: 1, map_id: Map.first.id}}
      expect(response).to redirect_to(room_path(id: 1))
    end
  end

  describe '#show' do
    it 'does not really do anything yet' do
      get :show, id: 1
      expect(assigns(:room)).to be_a(Room)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end
end
