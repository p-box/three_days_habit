require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー登録' do
    it 'name, email, password, password_confirmationが存在し登録できる' do
      user = build(:user)
      expect(user).to be_valid?
    end

end
