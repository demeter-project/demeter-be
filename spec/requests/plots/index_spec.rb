require 'rails_helper'

RSpec.describe 'plots#index' do
  describe 'GET api/v1/gardens/:garden_id/plots' do
    it 'returns a json response with information about all plots in the garden' do
      garden = create :garden
      plots = create_list(:plot, 5, garden: garden)
      get "/api/v1/gardens/#{garden.id}/plots"
      expect(response).to be_successful
      expect(response).to have_http_status(200)

      result = JSON.parse(response.body)
      expect(result).to have_key(:data)

      data = result[:data]
      expect(data.count).to eq(5)

      expected_plot = data.first
      actual_plot = plots.first
      require 'pry'; binding.pry
      expect(expected_plot[:name])
    end
  end
end