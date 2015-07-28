class Transformer
  ALLOWED_DIRECTIONS = %i(forward left right)
  BLANK_SPOT = []

  def initialize(board)
    @board = board
  end

  def move(entity_name, direction)
    fail "unknown direction" unless direction.in?(ALLOWED_DIRECTIONS)
    dir, y, x, _z = find(entity_name)
    send(direction, dir, y, x)
    @board.board
  end

  def forward(direction, y, x)
    after_y, after_x = move_to(direction, y, x)
    if forward_valid?(after_y, after_x)
      swap(y, x, after_y, after_x)
    end
  end

  def left(direction, y, x)
    new_heading = (EntityLocation.directions[direction] - 1) % EntityLocation.directions.size
    new_direction = EntityLocation.directions.key(new_heading)
    set_direction(new_direction, y, x)
  end

  def right(direction, y, x)
    new_heading = (EntityLocation.directions[direction] + 1) % EntityLocation.directions.size
    new_direction = EntityLocation.directions.key(new_heading)
    set_direction(new_direction, y, x)
  end

  private

  def set_direction(new_direction, y, x)
    @board.board[y][x].last['direction'] = new_direction
  end

  def forward_valid?(y, x)
    in_bounds?(y, x) && !collision?(y, x)
  end

  def in_bounds?(y, x)
    @board.board.size > y && @board.board.first.size > x
  end

  def collision?(y, x)
    false
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
    @board.entities.each do |spot, y, x, z|
      return [spot['direction'], y, x, z] if spot['name'] == entity_name
    end
    fail "entity not found"
  end

  # for now we only swap the last element at a location z == (x,y).max
  def swap(before_y, before_x, after_y, after_x)
    @board.board[after_y][after_x] << @board.board[before_y][before_x].pop
  end
end
