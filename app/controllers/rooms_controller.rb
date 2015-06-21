class RoomsController < ApplicationController
  def new; end
  def create
    room = Room.new(params[:room]).save!
    redirect_to action: 'show', id: room.id
  end
  def show
    @room = Room.new(id: params[:id])
  end
end
