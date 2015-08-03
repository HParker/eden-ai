# Entity describes a 'thing' that without any reference to location on a bouard.
class Entity < ActiveRecord::Base
  has_many :entity_locations
end
