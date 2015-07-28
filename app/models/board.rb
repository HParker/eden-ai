require 'json'

# the board class manages state of the board,
# but not persistance. Persistance is managed in rooms.
class Board
  attr_accessor :board # TODO: hide my privates

  def initialize(map: nil, board: nil)
    fail "must supply map or board: #{map}, #{board}" unless map || board
    if map
      @board = boardify(map)
    else
      @board = from_json(board)
    end
  end

  def to_array
    @board
  end

  def to_ascii
    [boarder, rows, boarder].join("\n") + "\n"
  end

  def move_agent(direction)
    transformer = Transformer.new(self)
    @board = transformer.move('agent', direction)
  end

  def entities
    entities = []
    @board.each_with_index do |row, y|
      row.each_with_index do |spot, x|
        spot.each_with_index do |zone, z|
          entities << [zone, y, x, z] unless spot.empty?
        end
      end
    end
    entities
  end

  private

  def from_json(board_json)
    JSON.parse(board_json)['board']
  end

  def boardify(map)
    board = Array.new(map.height) { Array.new(map.width) { [] } }
    map.entity_locations.each do |entity_location|
      y = entity_location.location_y
      x = entity_location.location_x
      board[y][x] << entity_location.cache
    end
    board
  end

  def rows
    @board.map { |row|
      "# " + row.map { |entity| asciify(entity) }.join(' ') + " #"
    }.join("\n")
  end

  def asciify(entity)
    if entity.last
      entity.last['char']
    else
      ' '
    end
  end

  def boarder
    a = Array.new(@board.size + 2) { '#' }
    a.join(' ')
  end
end
