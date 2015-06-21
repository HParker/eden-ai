require 'rails_helper'

RSpec.describe EntityLocation, type: :model do
  context 'existance' do
    it 'exists' do
      create(:entity_location)
    end
  end
end
