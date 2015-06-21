require 'rails_helper'

RSpec.describe Map, type: :model do
  context 'existance' do
    it 'exists' do
      map = create(:map)
      expect(map.name).to eq('first map')
    end
  end

  context 'with a simple map' do
    before do
      @simple_map = create(:simple_map)
    end

    it 'has entity_locations' do
      expect(@simple_map.entity_locations.size).to eq(2)
    end

    context '#to_board' do
      it 'will wrap its output in a board object' do
        expect(@simple_map.to_board.to_array).to eq(Board.new(map: @simple_map).to_array)
      end
    end

    context '#to_ascii' do
      it 'can represent itself as ascii' do
        expected_board = <<EOF
# # # # # # # #
#             #
#     c       #
#             #
#             #
#     a       #
#             #
# # # # # # # #
EOF
        expect(@simple_map.to_ascii).to eq(expected_board)
      end
    end
  end
end
