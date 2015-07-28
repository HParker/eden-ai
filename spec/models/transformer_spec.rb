require 'rails_helper'

RSpec.describe Transformer, type: :model do
  describe '#new' do
    it 'takes a board' do
      Transformer.new(build(:board))
    end
  end

  describe "#move" do
    before { create(:simple_map) }
    let(:transformer) { Transformer.new(Map.first.to_board) }
    it 'takes an entity and direction' do
      transformer.move("agent", :forward)
    end

    it 'turns right' do
      transformer.move("agent", :forward)
    end
    it 'must be a direction transformer knows' do
      expect { transformer.move("agent", :foo) }.to raise_error
    end

    it 'must contain the entity on the board' do
      expect { transformer.move("bar", :forward) }.to raise_error
    end

    it 'must not move the agent off the board' do
      transformer.move("agent", :forward)
      transformer.move("agent", :forward)
    end
  end
end
