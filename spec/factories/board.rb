FactoryGirl.define do
  factory :board do
    skip_create
    map
    initialize_with { new(map: map) }
  end
end
