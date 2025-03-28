require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  # authenticate :user, lambda { |u| u.admin? } do
  #   mount Sidekiq::Web => "/sidekiq"
  # end

  devise_for :users, defaults: { format: :json }, path: "api/users", path_names: {
    sign_in: "login",
    sign_out: "logout",
    registration: "signup"
  },
  controllers: {
    sessions: "api/users/sessions",
    registrations: "api/users/registrations"
  }

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    resources :situations, only: [ :index, :show, :create, :update, :destroy ]
    resources :exposures, only: [ :index, :show, :create, :update, :destroy ] do
      resources :exposure_steps, only: %i[index show create update destroy], module: :exposures
    end
    namespace :users do
      resource :me, only: :show, controller: "me"
      devise_scope :user do
        post "refresh_token", to: "sessions#refresh_token"
      end
    end
  end
end
