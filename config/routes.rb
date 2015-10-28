Rails.application.routes.draw do
  
  devise_for :users
  root 'application#main'

  authenticate :user do
    resources :groups do
      resources :students
    end
  end

end
