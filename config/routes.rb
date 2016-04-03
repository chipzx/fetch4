Rails.application.routes.draw do

  # use the customized registrations controller
  devise_for :users, controllers: { registrations: "users/registrations" }

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  resources :welcome, only: [:index, :show]
  resources :animals, only: [:index, :show]
  resources :animal_galleries
  resources :intake_heatmaps, only: [:index, :show]
  resources :outcome_heatmaps, only: [:index, :show]
  resources :animal_services311_heatmaps, only: [:index, :show]
  resources :adoption_metrics, only: [:index, :show]
  resources :intake_metrics, only: [:index, :show]
  resources :outcome_metrics, only: [:index, :show]
  resources :service_request_metrics, only: [:index, :show]
  resources :population_metrics, only: [:index, :show]
  resources :imports, only: [:index, :show]
  resources :dashboards, only: [:index, :show]

  Rails.application.routes.draw do
    resources :intake_heatmaps do
      collection do
        get :detail
      end
    end
    resources :outcome_heatmaps do
      collection do
        get :detail
      end
    end
    resources :animal_services311_heatmaps do
      collection do
        get :detail
      end
    end
    resources :imports do
      collection do
        get :import
      end
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
