FactoryGirl.define do
  factory :entity do
    factory :agent, class: Entity do
      name 'agent'
      sprite 'agent.png'
      char 'a'
    end

    factory :stone, class: Entity do
      name 'stone'
      sprite 'stone.png'
      collision true
      char '#'
    end

    factory :cheese, class: Entity do
      name 'cheese'
      sprite 'cheese.png'
      char 'c'
    end
  end
end
