Rails.application.routes.draw do
  resource  :session
  resources :messages

  root 'welcome#index'

  mount ActionCable.server => '/cable'
end
