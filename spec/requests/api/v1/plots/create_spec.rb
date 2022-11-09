require 'rails_helper'

RSpec.describe 'plot creation', :vcr do
  describe 'when a POST request is sent to /gardens/:garden_id/plots' do
    let!(:garden) { create :garden }
    let!(:headers) { {"CONTENT_TYPE" => "application/json"} }
    
    describe 'happy path' do
      let!(:body) { JSON.generate("name": "Colorado Wildflowers") }
      
      it 'returns a response with status 201 and data from the newly created Plot' do
        post "/api/v1/gardens/#{garden.id}/plots", headers: headers, params: body

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
      describe 'if name is empty' do
        let!(:body) { JSON.generate(name: "") }
        it 'returns a 400 error with information' do
          post "/api/v1/gardens/#{garden.id}/plots", headers: headers, params: body

          expect(response).not_to be_successful
          expect(response).to have_http_status(400)

          result = JSON.parse(response.body, symbolize_names: true)
          
          expect(result).to have_key(:errors)
          expect(result[:errors].first).to have_key(:title)
          expect(result[:errors].first).to have_key(:detail)
        end
      end

      describe 'if json response body is empty' do
        it 'returns a 400 error with information' do
          post "/api/v1/gardens/#{garden.id}/plots", headers: headers

          expect(response).not_to be_successful
          expect(response).to have_http_status(400)

          result = JSON.parse(response.body, symbolize_names: true)

          expect(result).to have_key(:errors)
          expect(result[:errors].first).to have_key(:title)
          expect(result[:errors].first).to have_key(:detail)
          expect(result[:errors].first[:detail].first).to eq("Name can't be blank")
        end
      end
    end
  end
end