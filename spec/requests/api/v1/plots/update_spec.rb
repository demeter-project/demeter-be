require 'rails_helper'

RSpec.describe 'plots#update', :vcr do
  describe 'when a PATCH request is sent to /gardens/:garden_id/plots' do
    let!(:garden) { create(:garden) }
    let!(:plot) { create(:plot, garden: garden) }
    let!(:plants) { create_list(:plant, 20) }
    let!(:headers) { {"CONTENT_TYPE" => "application/json"} }

    describe 'happy path' do
      let!(:body) { JSON.generate(plant_ids: [plants[5].id, plants[12].id]) }

      it 'can add plants to a plot' do
        patch "/api/v1/gardens/#{garden.id}/plots/#{plot.id}", headers: headers, params: body

        expect(response).to be_successful
        expect(response).to have_http_status(200)

        result = JSON.parse(response.body, symbolize_names: true)

        expect(result).to have_key(:data)

        data = result[:data]
        expect(data[:id]).to eq(plot.id.to_s)
        expect(data[:type]).to eq("plot")
        expect(data).to have_key(:attributes)

        attributes = data[:attributes]
        expect(attributes).to have_key(:name)
        expect(attributes[:name]).to eq(plot.name)

        plot.reload
        expect(plot.plants).to eq([plants[5], plants[12]])
      end

      it 'updates to plant_ids add to plants instead of replacing' do
        plot.plants << [plants[1], plants[6]]

        patch "/api/v1/gardens/#{garden.id}/plots/#{plot.id}", headers: headers, params: body

        expect(response).to be_successful
        expect(response).to have_http_status(200)
        
        plot.reload

        expect(plot.plants).to match_array([plants[1], plants[6], plants[5], plants[12]])
      end
    end

    describe 'sad path' do
      describe 'if plant id does not exist' do
        let!(:body) { JSON.generate(plant_ids: [plants[5].id, 6516516]) }

        it 'returns a 400 error with information' do
          patch "/api/v1/gardens/#{garden.id}/plots/#{plot.id}", headers: headers, params: body

          expect(response).not_to be_successful
          expect(response).to have_http_status(404)

          result = JSON.parse(response.body, symbolize_names: true)
          
          expect(result).to have_key(:message)
          expect(result[:message]).to eq("Couldn't find all Plants with 'id': (#{plants[5].id}, 6516516) (found 1 results, but was looking for 2). Couldn't find Plant with id 6516516.")
        end
      end
    end
  end
end