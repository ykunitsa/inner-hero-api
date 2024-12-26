require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users
  mount Sidekiq::Web => "/sidekiq"
  # authenticate :user, lambda { |u| u.admin? } do
  #   mount Sidekiq::Web => "/sidekiq"
  # end

  get "up" => "rails/health#show", as: :rails_health_check

  post "signup", to: "auth#signup"
  post "login", to: "auth#login"
end
