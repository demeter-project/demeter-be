require 'rails_helper'

RSpec.describe 'gardens#index' do
  describe 'happy path' do
    let!(:gardens) { create_list(:garden, 5, user_id: 1, zip_code: "05408") }

    it 'returns a json response with information about all users gardens' do
      get "/api/v1/gardens?user_id=1"

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      result = JSON.parse(response.body, symbolize_names: true)
      expect(result).to have_key(:data)
      
      data = result[:data]
      expect(data.count).to eq(gardens.count)

      first_garden = data.first
      expect(first_garden).to have_key(:id)
      expect(first_garden).to have_key(:type)
      expect(first_garden).to have_key(:attributes)

      attributes = first_garden[:attributes]
      expect(attributes).to have_key(:name)
      expect(attributes).to have_key(:zip_code)
      expect(attributes).to have_key(:state_code)
      expect(attributes).to have_key(:user_id)
    end
  end

  describe 'sad path user has no gardens' do
    it 'returns an empty json and 200 code' do
      get "/api/v1/gardens?user_id=2"
      expect(response).to be_successful
      expect(response).to have_http_status(200)

      result = JSON.parse(response.body, symbolize_names: true)
      expect(result).to have_key(:data)
      expect(result[:data]).to be_empty
    end
  end
end