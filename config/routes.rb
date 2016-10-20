Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :github_webhooks, only: :create, defaults: { formats: :json }
end
