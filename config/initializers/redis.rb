# Redis::Namespace messes with Fakeredis
if Rails.env.test?
  Redis.current = Redis.new
else
  Redis.current = Redis::Namespace.new(
    "mongo-salesdemo", redis: Redis.new(url: ENV[ENV.fetch("REDIS_PROVIDER", "REDIS_URL")], driver: :hiredis)
  )
end
