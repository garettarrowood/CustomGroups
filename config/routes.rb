Rails.application.routes.draw do
  
  devise_for :users

  authenticated :user do
    root to: "groups#index"
  end

  unauthenticated do
    root to: 'application#main', as: :unauth_root
  end

  authenticate :user do
    get '/groups/class_edit', to: "groups#class_edit", as: 'class_edit'
    resources :groups do
      resources :separations, only: [:create, :destroy]
      get 'students/roster_edit', to: "students#roster_edit", as: "edit_roster"
      resources :students, except: [:index, :show, :edit]
    end
    get '/groups/:id/small_groups', to: "groups#small_groups", as: "small_groups"
    put '/groups/:id/gender_setter', to: "groups#gender_setter"
    get '/groups/:id/class_settings', to: "groups#class_settings", as: "class_settings"
    post '/groups/:id/grouping', to: "groups#grouping"
  end

end
