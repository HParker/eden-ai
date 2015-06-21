require 'rails_helper'

RSpec.describe 'homes/index.html.erb', type: :view do
  before do
    assign(:board, create(:board))
    render
  end

  describe 'copy' do
    it 'contains eden ai at the top of the page' do
      expect(rendered).to match("Eden AI")
    end
  end

  describe 'game board' do
    it 'contains a game board' do
      expect(response).to render_template(partial: '_board')
    end
  end

  describe 'start game' do
    it 'has a link to try solving a map' do
      expect(rendered).to match(/Start Testing/)
    end
  end
end
