require 'rails_helper'

RSpec.describe Board, type: :model do
  let(:board) { create(:board)}

  context '#to_array' do
    it 'returns the board as an array' do
      expected_board = Array.new(6) { Array.new(6) { {} }}
      expect(board.to_array).to eq(expected_board)
    end
  end

  context '#to_json' do
    it 'turns the array into json' do
      expected_board = {board: Array.new(6) { Array.new(6) { {} }}}.to_json
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
end
