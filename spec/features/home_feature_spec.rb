require 'capybara/rspec'

describe 'the homepage', type: :feature do
  before do
    create(:board)
  end

  it 'exists' do
    visit '/'

  end
end
