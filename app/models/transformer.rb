# Transformer is responsible for taking a board
# and returning a transformed version of it.
class Transformer
  ALLOWED_DIRECTIONS = %i(forward left right)

  def initialize(board)
    @board_object = board
    @board = board.deep_copy
  end

  def move(entity_name, direction)
    fail 'unknown direction' unless direction.in?(ALLOWED_DIRECTIONS)
    dir, y, x, _z = find(entity_name)
    send(direction, dir, y, x)
    @board
  end

  private

  def forward(direction, y, x)
    after_y, after_x = move_to(direction, y, x)
    swap(y, x, after_y, after_x) if forward_valid?(after_y, after_x)
  end

  def left(direction, y, x)
    new_heading = change_heading(direction, 1)
    new_direction = EntityLocation.directions.key(new_heading)
    set_direction(new_direction, y, x)
  end

  def right(direction, y, x)
    new_heading = change_heading(direction, 1)
    new_direction = EntityLocation.directions.key(new_heading)
    set_direction(new_direction, y, x)
  end

  def change_heading(direction, increment)
    (EntityLocation.directions[direction] + increment) %
      EntityLocation.directions.size
  end

  def set_direction(new_direction, y, x)
    @board[y][x].last['direction'] = new_direction
  end

  def forward_valid?(y, x)
    in_bounds?(y, x) && !collision?(y, x)
  end

  def in_bounds?(y, x)
    @board.size > y && @board.first.size > x
  end

  def collision?(y, x)
    @board[y][x].map { |effective_square|
      effective_square ? Entity.find(effective_square['id']).collision : false
    }.select { |s| s == true }.size > 0
  end

  def move_to(direction, before_y, before_x)
    case direction
    when 'north'
      [before_y - 1, before_x]
    when 'east'
      [before_y, before_x + 1]
    when 'south'
      [before_y + 1, before_x]
    when 'west'
      [before_y, before_x - 1]
    end
  end

  def find(entity_name)
    @board_object.entities.each do |spot, y, x, z|
      return [spot['direction'], y, x, z] if spot['name'] == entity_name
    end
    fail 'entity not found'
  end

  # for now we only swap the last element at a location z == (x,y).max
  def swap(before_y, before_x, after_y, after_x)
    @board[after_y][after_x] << @board[before_y][before_x].pop
  end
end
