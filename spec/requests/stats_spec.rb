#require 'rails_helper'

RSpec.describe 'stats API', type: :request do
  # initialize test data 
  let!(:stats) { create_list(:stat, 10) }
  
  describe 'GET /stats' do
    # make HTTP get request before each example
    before { get '/stats' }
    
    it 'returns stats' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end
    
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
