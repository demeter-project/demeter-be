Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :gardens, only: %i(index show create) do
        resources :plots, only: %i(index show create destroy)
      end
      resources :plants, only: %i[index show]  
    end
  end
end
