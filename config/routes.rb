Rails.application.routes.draw do
  #devise_for :users,controllers: {registrations: 'api/v1/users/registrations',sessions: 'api/v1/users/sessions',passwords: 'api/v1/users/passwords'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # scope '/api/v1' do
  #   devise_for :users, :controllers => { :passwords => 'api/v1/users/passwords' }
  # end
  scope module: :api,defaults:{format: :json} do
  	scope module: :v1 do
  		scope module: :users do
  			post "users/sign_in" => "sessions#create"
        put "users/update" => "sessions#update"
  			post "users/sign_up" => "registrations#create"
  			delete "users/sign_out" => "sessions#destroy"
  			post "users/password" => "passwords#create"
  			get "users/password/edit" => "passwords#edit"
  			put "users/password/update" => "passwords#update"
  		end

			scope module: :tags do
				resources :tags
			end

			scope module: :events do
				resources :events
			end
  	end
  end
end
