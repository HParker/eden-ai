FactoryGirl.define do
  factory :map do
    name "first map"
    height 6
    width 6

    factory :simple_map do
      # # # # # # # #
      #             #
      #     c       #
      #             #
      #             #
      #     a       #
      #             #
      # # # # # # # #

      after(:create) do |map, _evaluator|
        create(:cheese_location, location_y: 1, location_x: 2, map: map, direction: "north")
        create(:agent_location, location_y: 4, location_x: 2, map: map)
      end
    end
  end
end
