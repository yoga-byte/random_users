# frozen_string_literal: true

class RedisHelper
  def self.add_male_count(count)
    redis.incrby(redis_key('male'), count)
  end

  def self.add_female_count(count)
    redis.incrby(redis_key('female'), count)
  end

  def self.get_count(gender)
    redis.get(redis_key(gender))
  end

  def self.redis
    @redis ||= Redis.new
  end

  def self.redis_key(gender)
    gender.to_s
  end

  def self.reset_count
    redis.set(redis_key('male'), 0)
    redis.set(redis_key('female'), 0)
  end
end
