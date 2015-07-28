require 'securerandom'
require 'redis'

class Room
  EXPIRATION = 72_000

  include ActiveModel::Model
  attr_accessor :id, :map_id, :redis, :curret_board

  def self.with_generated_id
    new(id: SecureRandom.urlsafe_base64)
  end

  def save!
    redis.set(id, current_board.to_json)
    redis.expire(id, EXPIRATION)
    sock.pub(current_board.to_json, postfix: id)
    self
  end

  def current_board
    if map_id
      @current_board ||= Map.find(map_id).to_board
    else
      @current_board ||= Board.new(board: redis.get(id))
    end
  end

  private

  def redis
    @redis ||= Redis.new
  end

  def sock
    @sock ||= Sock::Client.new(logger: Rails.logger, redis: redis)
  end
end
