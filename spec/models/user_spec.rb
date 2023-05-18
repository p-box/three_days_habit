require 'rails_helper'
#テストコードを書くルール
## 目的はあくまでアプリの完成。多すぎる、難しすぎるテスト＝不要
## 手作業より効率よくテストができる。
## 手作業では不安がのこるテスト

# modelテスト
##簡単なバリデーションは基本無視


RSpec.describe User, type: :model do
  describe 'create' do
    it 'name, email, password, password_confirmationが存在し登録できる' do
      user = build(:user)
      expect(user).to be_valid
    end
  end

end
