require 'rails_helper'

RSpec.describe 'plots#index' do
  describe 'GET api/v1/gardens/:garden_id/plots' do
    it 'returns a json response with information about all plots in the garden' do
      get '/api/v1/gardens/:garden_id/plots'
      garden = create :garden
      plots = create_list(:plot, 5, garden: garden)

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      result = JSON.parse(response.body)
      expect(result).to have_key(:data)

      plots = result[:data]
      end
    end
  end
end