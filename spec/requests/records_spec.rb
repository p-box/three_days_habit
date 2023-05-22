require 'rails_helper'

RSpec.describe "Records", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/records/create"
      expect(response).to have_http_status(:success)
    end
  end

end
