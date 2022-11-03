require 'rails_helper'

RSpec.describe 'gardens#create' do
  describe 'happy paths' do
    describe 'when a post request is made to api/v1/gardens' do
      describe 'all params are present and correct' do
        post "/api/v1/gardens", params: { gardens: { user_id: 1, zip_code: "05408", state: "VT", name: "Arnold's Whimsical Carrot Grotto"}}

        expect(response).to be_successful
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'sad paths' do

  end
end