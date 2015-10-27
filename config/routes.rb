Rails.application.routes.draw do
  
  root 'groups#index'

  resources :groups do
    resources :students
  end

end
