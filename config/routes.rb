Rails.application.routes.draw do

	resources :topics do
		resources :bookmarks, only: [:edit, :show, :new]
	end

  devise_for :users
  get 'about' => 'welcome#about'

  root to: 'welcome#index'

  post :incoming, to: 'incoming#create'

end
