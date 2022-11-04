Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :gardens, only: %i(index show create destroy) do
        resources :plots, only: %i(index show create update destroy) do
          resources :plot_plants, only: %i(index destroy)
        end
      end
      resources :plants, only: %i[index show]  
    end
  end
end
