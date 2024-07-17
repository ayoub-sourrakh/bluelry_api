# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://www.bluelry.com/', 'https://bluelry.com/'  # The origin for your React app
  
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        credentials: true  # Set to true if you need cookies to be sent with requests
    end
  end
  