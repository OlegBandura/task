Rails.application.routes.draw do
  root to: 'messages#index'

  resources :messages, only: %i[index show new create] do
    member { post :read }
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
