class Map < ActiveRecord::Base
  has_many :entity_locations

  def to_board
    Board.new(map: self)
  end

  def to_ascii
    to_board.to_ascii
  end
end
