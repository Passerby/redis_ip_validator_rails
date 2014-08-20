require 'test_helper'

MAX_COUNT = 7
HOST = '127.0.0.1'
PORT = '6379'
DB = 5
TARGET_IP = '8.8.8.8'

redis = Redis.new(host: HOST, port: PORT, db: DB)

describe 'Redis::IpValidator setup' do
  def message_setup_helper(str)
    "should equal redis #{ str }, please check option."
  end

  before do
    Redis::IpValidator.setup do |iv|
      iv.max_count = MAX_COUNT
      iv.redis = {
        host: HOST,
        port: PORT,
        db: DB
      }
    end
  end

  it 'setup initialize variable' do
    assert_equal(MAX_COUNT, Redis::IpValidator.max_count, 'should equal Redis::IpValidator max_count.')
    assert_equal(HOST, Redis::IpValidator.redis_client.client.options[:host], message_setup_helper(HOST))
    assert_equal(PORT.to_i, Redis::IpValidator.redis_client.client.options[:port], message_setup_helper(PORT))
    assert_equal(DB.to_i, Redis::IpValidator.redis_client.client.options[:db], message_setup_helper(DB))
  end
end

describe 'Redis::IpValidator counte ip' do
  it 'counter' do
    ip_count = redis.get(TARGET_IP)
    random_count = rand(1..100)
    assert_equal(ip_count.to_i + random_count, Redis::IpValidator.counter(TARGET_IP, random_count).to_i,
                 'increase ip count fail.')
  end

  it 'clean' do
    Redis::IpValidator.counter(TARGET_IP)
    Redis::IpValidator.clean(TARGET_IP)
    assert_nil(redis.get(TARGET_IP), "should delete #{ TARGET_IP } redis's key.")
  end
end
