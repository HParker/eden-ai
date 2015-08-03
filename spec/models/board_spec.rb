require 'rails_helper'

RSpec.describe Board, type: :model do
  let(:board) { create(:board)}

  context '#to_array' do
    it 'returns the board as an array' do
      expected_board = Array.new(6) { Array.new(6) { [] } }
      expect(board.to_array).to eq(expected_board)
    end
  end

  context '#to_json' do
    it 'turns the array into json' do
      expected_board = {board: Array.new(6) { Array.new(6) { [] } } }.to_json
      expect(board.to_json).to eq(expected_board)
    end
  end

  context "#to_ascii" do
    it 'returns a string representing the board' do
      expected_board = "# # # # # # # #\n" +
                       "#             #\n" +
                       "#             #\n" +
                       "#             #\n" +
                       "#             #\n" +
                       "#             #\n" +
                       "#             #\n" +
                       "# # # # # # # #\n"
      expect(board.to_ascii).to eq(expected_board)
    end
  end

  context '#move_agent' do
    let(:simple_map) { create(:simple_map) }
    let(:simple_board) { Board.new(map: simple_map) }

    it 'can move the agent forward' do
      expected_before = "# # # # # # # #\n" +
                       "#             #\n" +
                       "#     c       #\n" +
                       "#             #\n" +
                       "#             #\n" +
                       "#     a       #\n" +
                       "#             #\n" +
                        "# # # # # # # #\n"

      expected_after = "# # # # # # # #\n" +
                       "#             #\n" +
                       "#     c       #\n" +
                       "#             #\n" +
                       "#             #\n" +
                       "#             #\n" +
                       "#     a       #\n" +
                       "# # # # # # # #\n"

      expect(simple_board.to_ascii).to eq(expected_before)
      simple_board.move_agent(:forward)
      expect(simple_board.to_ascii).to eq(expected_after)
    end
  end

  describe '#entities' do
    let(:simple_board) { create(:simple_map).to_board }

    it 'returns each entities and the x, y, z' do
      simple_board # must call for the entities to exist
      expected_entities = [
        [{'id' => 1, 'direction'=>"north", 'name'=>"cheese", 'char'=>"c"}, 1, 2, 0],
        [{'id' => 2, 'direction'=>"south", 'name'=>"agent", 'char'=>"a"}, 4, 2, 0]
      ]
      expect(simple_board.entities).to eq(expected_entities)
    end
  end

  describe '#deep_copy' do
    let(:simple_board) { create(:simple_map).to_board }

    it 'returns a deep copy version of the board' do
      expect(simple_board.deep_copy).to_not equal(simple_board.board)
    end
  end
end
