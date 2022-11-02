Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :gardens, only: %i(index) do
        resources :plots, only: %i(index)
      end
      resources :plants, only: %i[index]  
    end
  end
end
