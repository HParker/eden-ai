class EntityLocation < ActiveRecord::Base
  enum direction: %w(north east south west)
  belongs_to :entity
  belongs_to :map
end
