require 'rails_helper'

RSpec.describe 'plots#show' do
  describe 'GET api/v1/gardens/:garden_id/plots/:plot_id' do
    it 'returns a json response with information about the requested plot' do
      garden = create :garden
      plot = create(:plot, garden: garden)
      plot.plants = create_list(:plant, 10)

      get "/api/v1/gardens/#{garden.id}/plots/#{plot.id}"

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      result = JSON.parse(response.body, symbolize_names: true)
      expect(result).to have_key(:data)

      data = result[:data]
      expect(data).to have_key(:id)
      expect(data).to have_key(:type)
      expect(data).to have_key(:attributes)
      expect(data).to have_key(:relationships)

      expect(data[:attributes]).to have_key(:name)
      expect(data[:relationships]).to have_key(:plants)

      plants = data[:relationships][:plants]
      expect(plants).to have_key(:data)
    end
  end
end