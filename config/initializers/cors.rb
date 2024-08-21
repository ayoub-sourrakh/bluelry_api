# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'bluelry.com', 'www.bluelry.com', 'https://bluelry.com', 'https://www.bluelry.com'
  
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        credentials: true  # Set to true if you need cookies to be sent with requests
    end
  end
  