Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:5010"
    resource "*", headers: :any, methods: %i[get post put patch delete options head], expose: [ :Authorization ], credentials: true
  end
end
