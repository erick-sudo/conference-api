# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins [ "http://localhost:5173", "http://localhost:3000", "http://ec2-18-208-140-121.compute-1.amazonaws.com:80", "http://ec2-18-208-140-121.compute-1.amazonaws.com:4000", "https://deploy-preview-17--confrence-tracking.netlify.app", "https://conference-front.vercel.app" ]

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true, # Add this line to enable credentials

    # Add response headers
    expose: ['Access-Control-Allow-Origin', 'Access-Control-Allow-Methods', 'Access-Control-Allow-Headers', 'Access-Control-Allow-Credentials']
  end
end
