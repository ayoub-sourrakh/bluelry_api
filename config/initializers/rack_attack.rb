# config/initializers/rack_attack.rb
class Rack::Attack
  throttle('req/ip', limit: 60, period: 1.minute) do |req|
    req.ip
  end
end
