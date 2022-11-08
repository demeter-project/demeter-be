require 'rails_helper'

RSpec.describe '/api/v1/plants endpoints', :vcr do
  describe 'GET plants#index' do
    it 'returns a json response containing all plants native to queried state' do
      plants = create_list(:plant, 10, states: "VT CT VA WA")
      get '/api/v1/plants', params: {zip_code: "05408", state_code: "VT"}

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result[:data].count).to eq(10)
      expected_first = plants.first
      actual_first = result[:data].first
      expect(actual_first).to have_key(:id)
      expect(actual_first[:id]).to eq(expected_first.id.to_s)
      expect(actual_first).to have_key(:attributes)
      expect(actual_first[:attributes]).to have_key(:usda_symbol)
      expect(actual_first[:attributes]).to have_key(:scientific_name)
      expect(actual_first[:attributes]).to have_key(:common_name)
      expect(actual_first[:attributes]).to have_key(:states)
      expect(actual_first[:attributes]).to have_key(:flower_color)
      expect(actual_first[:attributes]).to have_key(:drought_tolerance)
      expect(actual_first[:attributes]).to have_key(:fire_tolerance)
      expect(actual_first[:attributes]).to have_key(:moisture_use)
      expect(actual_first[:attributes]).to have_key(:toxicity)
      expect(actual_first[:attributes]).to have_key(:duration)
      expect(actual_first[:attributes]).to have_key(:growth_rate)
      expect(actual_first[:attributes]).to have_key(:salinity_tolerance)
      expect(actual_first[:attributes]).to have_key(:shade_tolerance)
      expect(actual_first[:attributes]).to have_key(:edible)
      expect(actual_first[:attributes]).to have_key(:ph_minimum)
      expect(actual_first[:attributes]).to have_key(:ph_maximum)
      expect(actual_first[:attributes]).to have_key(:temperature_min)
      expect(actual_first[:attributes]).to have_key(:frost_free_days_min)
      expect(actual_first[:attributes]).to have_key(:precipitation_min)
      expect(actual_first[:attributes]).to have_key(:precipitation_max)
    end
    
    describe 'suitable_for_hz attribute' do
      let!(:plants) { create_list(:plant, 10, states: 'VT WA VA')}
      describe 'json response includes a custom attribute suitable_for_hz' do
        describe 'happy path - zip_code info found' do
          it 'returns a boolean attr suitable_for_hz' do
            get '/api/v1/plants?state_code=VT&zip_code=05408'
    
            result = JSON.parse(response.body, symbolize_names: true)
 
            plant = result[:data].first
            expect(plant[:attributes]).to have_key(:suitable_for_hz)
            expect(plant[:attributes][:suitable_for_hz]).to be_in([true, false])
          end
        end

        describe 'sad path - zip_code not found' do
          it 'returns nil' do
            get '/api/v1/plants?state_code=VT&zip_code=99999'
            
            result = JSON.parse(response.body, symbolize_names: true)
            
            plant = result[:data].first
            expect(plant[:attributes]).to have_key(:suitable_for_hz)
            expect(plant[:attributes][:suitable_for_hz]).to be nil
          end
        end
      end
    end

    describe 'searching with additional parameters' do
      describe 'search_name' do
        let!(:plant_1) { create(:plant, common_name: "Halo Bunny", scientific_name: "Fluffy Hal", states: "VT WA VA") }
        let!(:plant_2) { create(:plant, common_name: "Halberd Flower", scientific_name: "Fluffy Halberd", states: "VT WA VA") }
        let!(:plant_3) { create(:plant, common_name: "Squirrel's Tail", scientific_name: "Bunny Bun", states: "VT WA VA") }

        it 'returns a json response with plants matching all or part of searched name' do
          get '/api/v1/plants', params: { state_code: "VT", zip_code: "05408", search_name: "hal"}

          expect(response).to be_successful
          expect(response).to have_http_status(200)

          result = JSON.parse(response.body, symbolize_names: true)
          expect(result).to have_key(:data)

          expect(result[:data].count).to eq(2)
        end

        it 'if no plants match, returns an empty response with 200 status' do
          get '/api/v1/plants?state_code=VT&zip_code=05408&search_name=x7f'

          expect(response).to be_successful
          expect(response).to have_http_status(200)

          result = JSON.parse(response.body, symbolize_names: true)
          expect(result).to have_key(:data)

          expect(result[:data].count).to eq(0)
        end
      end
    end

    describe 'sorting by attribute' do
      let!(:plant_1) { create :plant, common_name: "Dogfern", scientific_name: "A", temperature_min: 15, states: "VT VA CA" }
      let!(:plant_2) { create :plant, common_name: "Aardvarkleaf", scientific_name: "B", temperature_min: 10, states: "VT VA CA" }
      let!(:plant_3) { create :plant, common_name: "Bearwood", scientific_name: "C", temperature_min: 5, states: "VT VA CA" }

      describe 'when param[sort_by=attribute] is present' do
        it 'returns a json response of plants sorted by specified' do
          get '/api/v1/plants?state_code=VT&zip_code=05408&sort_by=common_name'

          expect(response).to be_successful
          expect(response).to have_http_status(200)

          result = JSON.parse(response.body, symbolize_names: true)
          expect(result).to have_key(:data)

          data = result[:data]
          first_plant = data.first

          expect(first_plant[:id]).to eq(plant_2.id.to_s)
        end
      end

      describe 'when params[:sort_plants]=attribute is not a valid attribute' do
        it 'returns the original collection' do
          get '/api/v1/plants?state_code=VT&zip_code=05408&sort_by=depth_perception'
          
          expect(response).to be_successful
          expect(response).to have_http_status(200)

          result = JSON.parse(response.body, symbolize_names: true)
          expect(result).to have_key(:data)

          data = result[:data]
          first_plant = data.first

          expect(first_plant[:id]).to eq(plant_1.id.to_s)
        end
      end
    end

    describe 'sad path: state missing or empty' do
      it 'returns an error' do
        create_list :plant, 10, states: "VT WA CA"
        get '/api/v1/plants?state_code=&zip_code=05408'

        expect(response).not_to be_successful
        expect(response).to have_http_status(400)
        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to have_key(:errors)

        error_hash = result[:errors].first
        expect(error_hash).to have_key(:title)
        expect(error_hash).to have_key(:detail)
        expect(error_hash[:detail]).to be_a String

        get '/api/v1/plants?zip_code=05408'
        expect(response).not_to be_successful
        expect(response).to have_http_status(400)
      end
    end

    describe 'sad path: zip_code missing or empty' do
      it 'returns an error' do
        create_list :plant, 10, states: "VT WA CA"
        get '/api/v1/plants?state_code=VT'
        expect(response).not_to be_successful
        expect(response).to have_http_status(400)

        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to have_key(:errors)

        error_hash = result[:errors].first
        expect(error_hash).to have_key(:title)
        expect(error_hash).to have_key(:detail)
        expect(error_hash[:detail]).to be_a String

        get '/api/v1/plants?state_code=VT&zip_code='
        expect(response).not_to be_successful
        expect(response).to have_http_status(400)
      end
    end

    describe 'sad path: both zip and state missing' do
      it 'returns an error' do
        create_list :plant, 10, states: "VT WA CA"

        get '/api/v1/plants'
        expect(response).not_to be_successful
        expect(response).to have_http_status(400)

        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to have_key(:errors)
        expect(result[:errors].count).to eq(2)
        
        error_hash = result[:errors].first
        expect(error_hash).to have_key(:title)
        expect(error_hash).to have_key(:detail)
        expect(error_hash[:detail]).to be_a String
      end
    end
  end
end