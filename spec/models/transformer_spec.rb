require 'rails_helper'

RSpec.describe Transformer, type: :model do
  describe '#new' do
    it 'takes a board' do
      Transformer.new(build(:board))
    end
  end

  describe '#move' do
    describe 'direcitonal movements' do
      before { create(:simple_map) }
      let(:transformer) { Transformer.new(Map.first.to_board) }

      it 'takes an entity and direction' do
        transformer.move('agent', :forward)
      end

      it 'turns right' do
        transformer.move('agent', :forward)
      end
      it 'must be a direction transformer knows' do
        expect { transformer.move('agent', :foo) }.to raise_error
      end

      it 'must contain the entity on the board' do
        expect { transformer.move('bar', :forward) }.to raise_error
      end

      it 'must not move the agent off the board' do
        first_board  = transformer.move('agent', :forward)
        second_board = transformer.move('agent', :forward)

        expect(first_board).to eq(second_board)
      end
    end

    describe 'collisions' do
      before { create(:obstical_map) }
      let(:transformer) { Transformer.new(Map.first.to_board) }

      it 'cannot move through stone' do
        first_board  = Board.new(map: Map.first).board
        second_board = transformer.move('agent', :forward)

        expect(first_board).to eq(second_board)
      end

      it 'can walk through non-collision objects' do
        first_board  = Board.new(map: Map.first).board
        transformer.move('agent', :right)
        second_board = transformer.move('agent', :forward)
        # byebug
        expect(first_board).to_not eq(second_board)
      end
    end
  end
end
