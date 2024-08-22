# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'bluelry.com', 'www.bluelry.com', 'https://bluelry.com', 'https://www.bluelry.com', '127.0.0.1'

    resource '*',
      headers: :any,
      expose: ['Authorization'],  # This line exposes the Authorization header
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end
