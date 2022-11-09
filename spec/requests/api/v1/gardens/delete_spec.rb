require 'rails_helper'

RSpec.describe 'gardens#delete', :vcr do
  it 'deletes a garden and returns a 204 status' do
    garden_1 = create :garden
    garden_2 = create :garden
    
    expect(Garden.all).to include(garden_1)

    delete "/api/v1/gardens/#{garden_1.id}"

    expect(response).to be_successful
    expect(response).to have_http_status(204)

    expect(Garden.all).not_to include(garden_1)
  end

  it 'returns an error if garden cant be found' do
    delete '/api/v1/gardens/9999999' do
      expect(respone).not_to be_successful
      expect(response).to have_http_status(400)
    end
  end
end