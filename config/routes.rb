Rails.application.routes.draw do
  
  root 'groups#index'

  resources :groups do
    resources :people
  end

end
