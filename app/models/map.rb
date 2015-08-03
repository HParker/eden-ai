# Map is a specific arangement of pieces on a board with a name.
# Note: a map only represents the initial state.
# all transformations while the board is being solved is stored in redis.
class Map < ActiveRecord::Base
  has_many :entity_locations
  def to_board
    Board.new(map: self)
  end

  def to_ascii
    to_board.to_ascii
  end
end
