require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /show" do
    context "認証されたユーザーとして" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "正常に応答すると 200 応答が返される" do 
        sign_in @user
        get user_path(@user)
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
    end
  end
end