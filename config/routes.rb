Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, path:'/' do
    namespace :internal do
      namespace :v1 do
        resources :posts do
          resources :comments
        end
      end
    end
    # for others
    namespace :external do
      namespace :v1 do
        with_options except: [:create, :update, :destroy] do
          |options|
          options.resources :posts do
            options.resources :comments
          end
        end
      end
    end
  end

  # match '/404', to: 'errors#file_not_found', via: :all
  # match '/422', to: 'errors#unprocessable', via: :all
  # match '/500', to: 'errors#internal_server_error', via: :all
  match '*path', to: 'application#page_not_found', via: :all
end
