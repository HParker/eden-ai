require 'json'

class Board
  attr_reader :board

  def initialize(map: nil, board: nil)
    raise "must supply map or board: #{map}, #{board}" if !(map || board)
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

  private

  def from_json(board_json)
    JSON.parse(board_json)["board"]
  end

  def boardify(map)
    board = Array.new(map.height) { Array.new(map.width) { {} } }
    map.entity_locations.each do |entity_location|
      y, x = entity_location.location_y, entity_location.location_x
      entity = entity_location.entity
      board[y][x] = { 'name'      => entity.name,
                      'sprite'    => entity.sprite,
                      'char'      => entity.char,
                      'sprite'    => entity.sprite,
                      'direction' => entity_location.direction
                    }
    end
    board
  end

  def rows
    @board.map { |row|
      "# " + row.map { |entity| asciify(entity) }.join(' ') + " #"
    }.join("\n")
  end

  def asciify(entity)
    entity['char'] || ' '
  end

  def boarder
    a = Array.new(@board.size + 2) { '#' }
    a.join(' ')
  end
end
