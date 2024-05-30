Rails.application.routes.draw do
  root to: 'questions#index'
 
  get '/admins/page', to: 'admins#page', as: 'admins_page'
  resources :questions
  resource :session, only: %i[new create destroy]
  resources :users do
    member do
      put 'admin_update_role'
    end
  end
  resource :profile, only: [:edit, :update, :show]
end
