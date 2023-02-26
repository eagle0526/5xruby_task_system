Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :tasks
  resource :user, as: "users" do
    collection do
      get :login
    end
  end

  resource :session, only: [:create, :destroy]

  root 'tasks#index'
end
