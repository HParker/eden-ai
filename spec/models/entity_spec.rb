require 'rails_helper'

RSpec.describe Entity, type: :model do
  context 'existance' do
    it 'exists' do
      create(:entity)
    end
  end
end
