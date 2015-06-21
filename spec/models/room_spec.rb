require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '.new' do
    let(:room) { create(:room) }

    before { create(:map) }

    it 'finds existing rooms if already created' do
      redis = Redis.new
      room.redis = redis
      room.save!
      expect(room.current_board.board).to eq(Room.new(id: 1, redis: redis).current_board.board)
    end
  end

  describe '#current_board' do
    before { create(:map) }

    it 'returns the currrent board state' do
      expected_board = Array.new(6) { Array.new(6) { {} }}
      expect(Room.new(id: 1, map_id: 1, redis: MockRedis.new).current_board.board).to eq(expected_board)
    end
  end

  describe ".with_generated_id" do
    it 'generateds a random url safe string' do
      room = Room.with_generated_id
      expect(room.id).not_to be_empty
    end
  end

  describe '#save!' do
    let(:room) { Room.new(id: 1, map_id: 1) }
    before { create(:map) }
    it 'creates a new room in redis with 2 hour expiration' do
      expect(room.send(:redis)).to receive(:set) { true }
      expect(room.send(:redis)).to receive(:expire).with(1, 72_000) { true }
      room.save!
    end
  end
end
