Rails.application.routes.draw do
  
  devise_for :users
  root 'application#main'

  authenticate :user do
    resources :groups do
      get 'students/roster_edit', to: "students#roster_edit"
      resources :students
    end
  end

end
