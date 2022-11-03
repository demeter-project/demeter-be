require 'rails_helper'

RSpec.describe 'plot creation' do
  describe 'when a POST request is sent to /gardens/:garden_id/plots' do
    let!(:garden) { create :garden }
    
    describe 'happy path' do
      let!(:http_body) { { "name": "Colorado Wildflowers" } }
      
      it 'returns a response with status 201 and data from the newly created Plot' do
        post "/api/v1/gardens/#{garden.id}/plots?name=Colorado Wildflowers"

        expect(response).to be_successful
        expect(response).to have_http_status(201)

        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to have_key(:data)

        data = result[:data]
        expect(data).to have_key(:id)
        expect(data[:id]).to eq(Plot.last.id.to_s)
        expect(data).to have_key(:type)
        expect(data).to have_key(:attributes)

        attributes = data[:attributes]
        expect(attributes).to have_key(:name)
        expect(attributes[:name]).to eq("Colorado Wildflowers")
      end
    end

    describe 'sad path' do
      describe 'if name param not present' do
        it 'returns a 400 error with information' do
          post "/api/v1/gardens/#{garden.id}/plots"

          expect(response).not_to be_successful
          expect(response).to have_http_status(400)

          result = JSON.parse(response.body, symbolize_names: true)
          expect(result).to have_key(:errors)

          first_error = result[:errors].first
          expect(first_error).to have_key(:title)
          expect(first_error).to have_key(:detail)
        end
      end

      describe 'if name param empty' do
        it 'returns a 400 error with information' do
          post "/api/v1/gardens/#{garden.id}/plots?name="

          expect(response).not_to be_successful
          expect(response).to have_http_status(400)

          result = JSON.parse(response.body, symbolize_names: true)
          expect(result).to have_key(:errors)

          first_error = result[:errors].first
          expect(first_error).to have_key(:title)
          expect(first_error).to have_key(:detail)
        end
      end
    end
  end
end