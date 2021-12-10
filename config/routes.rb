Rails.application.routes.draw do
  resources :lists, except: [:destroy, :update, :edit]  do
    resources :bookmarks, only: [:new, :create, :delete]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
