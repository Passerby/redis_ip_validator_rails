require 'redis'
require 'active_support/core_ext/module/attribute_accessors.rb'

class Redis
  module IpValidator
    mattr_accessor :redis, :max_count

    def self.valid?(ip)
      result = redis_client.get(ip.to_s).to_i < max_count.to_i
      counter(ip)
      result
    end

    def self.clean(ip)
      redis_client.del(ip.to_s)
    end

    def self.counter(ip, increasement = 1)
      if redis_client.exists ip.to_s
        redis_client.incrby ip.to_s, increasement
      else
        redis_client.set ip, increasement
        redis_client.expire ip.to_s, 3600
        redis_client.get(ip)
      end
    end

    def self.setup
      yield self
      Redis.current = Redis.new(redis)
    end

    private

    def self.redis_client
      Redis.current
    end
  end
end
