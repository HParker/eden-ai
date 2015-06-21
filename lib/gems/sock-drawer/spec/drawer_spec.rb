require 'spec_helper'

RSpec.describe Sock::Drawer do
  it "takes a name on initialize" do
    Sock::Drawer.new
    Sock::Drawer.new('sock-me')
  end

  it "subscribes to events from redis with that name" do

  end
end
