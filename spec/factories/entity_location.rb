FactoryGirl.define do
  factory :entity_location do
    map
    location_x 0
    location_y 0
    direction 'south'

    factory :cheese_location do
      association :entity, factory: :cheese
    end

    factory :stone_location do
      association :entity, factory: :stone
    end

    factory :agent_location do
      association :entity, factory: :agent
    end
  end
end
