Rails.application.routes.draw do
  
  devise_for :users
  root 'application#main'

  authenticate :user do
    resources :groups do
      get 'students/roster_edit', to: "students#roster_edit"
      resources :students
    end
    get '/groups/:id/small_groups', to: "groups#small_groups", as: "small_groups"
    get '/groups/:id/class_settings', to: "groups#class_settings", as: "class_settings"
  end

end
