require 'rails_helper'

RSpec.describe 'gardens#create' do
  describe 'happy paths' do
    describe 'when a post request is made to api/v1/gardens' do
      describe 'all params are present and correct' do
        it 'returns a json response with status 201 and the garden' do
          post "/api/v1/gardens", params: { garden: { user_id: 1, zip_code: "05408", state_code: "VT", name: "Arnold's Whimsical Carrot Grotto" } }

          expect(response).to be_successful
          expect(response).to have_http_status(201)

          result = JSON.parse(response.body, symbolize_names: true)
          expect(result).to have_key(:data)

          data = result[:data]
          expect(data).to have_key(:id)
          expect(data).to have_key(:type)
          expect(data).to have_key(:attributes)
          expect(data).to have_key(:relationships)
          
          attributes = data[:attributes]
          relationships = data[:relationships]

          expect(attributes).to have_key(:name)
          expect(attributes[:name]).to be_a String
          expect(attributes).to have_key(:zip_code)
          expect(attributes[:zip_code]).to be_a String
          expect(attributes).to have_key(:state_code)
          expect(attributes[:state_code]).to be_a String
          expect(attributes).to have_key(:user_id)
          expect(attributes[:user_id]).to be_an Integer
          expect(attributes).to have_key(:weather_forecast)
          expect(attributes[:weather_forcast]).to be nil
        end
      end
    end
  end

  describe 'sad paths' do
    it 'returns an error when values are missing' do
      post "/api/v1/gardens", params: { garden: { user_id: 1, name: "Arnold's Whimsical Carrot Grotto" } }

      expect(response).not_to be_successful
      expect(response).to have_http_status(400)

      result = JSON.parse(response.body, symbolize_names: true)
      expect(result).to have_key(:errors)
      expect(result[:errors]).to be_an Array
      expect(result[:errors].first).to have_key(:title)
      expect(result[:errors].first).to have_key(:detail)
    end
  end
end