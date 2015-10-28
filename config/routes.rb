Rails.application.routes.draw do
  
  devise_for :users
  root 'groups#index'

  authenticate :user do
    resources :groups do
      resources :students
    end
  end

end
