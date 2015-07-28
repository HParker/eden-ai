# join record between entity and location
# also stores information that is specific
# to the pieces orientation on the board.
class EntityLocation < ActiveRecord::Base
  enum direction: %w(north east south west)
  belongs_to :entity
  belongs_to :map

  def cache
    {'direction' => direction, 'name' => entity.name, 'char' => entity.char }
  end
end
