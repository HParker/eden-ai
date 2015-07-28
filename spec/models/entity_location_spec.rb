require 'rails_helper'

RSpec.describe EntityLocation, type: :model do
  describe 'existance' do
    it 'exists' do
      create(:entity_location)
    end
  end

  describe '#cache' do
    let(:entity_location) { create(:stone_location) }
    it 'dumpes a cached copy of the entity and entity location' do
      expected_cache = {
        'char' => '#',
        'direction' => 'south',
        'name' => 'stone'
      }
      expect(entity_location.cache).to eq(expected_cache)
    end
  end
end
