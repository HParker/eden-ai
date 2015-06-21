require 'rails_helper'

RSpec.describe AgentsController, type: :controller do

  describe "GET #senses" do
    it "returns http success" do
      get :senses, room_id: 1
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #board" do
    it "returns http success" do
      get :board, room_id: 1
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #action" do
    it "returns http success" do
      get :action, room_id: 1
      expect(response).to have_http_status(:success)
    end
  end

end
