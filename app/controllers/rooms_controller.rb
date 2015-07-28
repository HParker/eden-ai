# Rooms controller manages interactions with the rooms containing boards.
class RoomsController < ApplicationController
  def new; end

  def create
    room = Room.new(params[:room]).save!
    redirect_to action: 'show', id: room.id
  end

  def show
    @room = Room.new(id: params[:id])
  end

  def reload_board
    board = Room.new(id: params[:room_id]).current_board
    render partial: 'shared/board', locals: { board: board }
  end
end
