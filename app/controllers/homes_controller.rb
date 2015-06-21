class HomesController < ApplicationController
  def index
    @board = Map.first.to_board
  end
end
