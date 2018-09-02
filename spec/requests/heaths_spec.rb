require 'rails_helper'

RSpec.describe 'healthcheck API', type: :request do
  # initialize test data
  let!(:healths) { create_list(:health, 10) }

  describe 'GET /healths' do
    # make HTTP get request before each example
    before { get '/healths' }

    it 'returns health' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
