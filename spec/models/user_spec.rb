require 'rails_helper'
#テストコードを書くルール
## 目的はあくまでアプリの完成。多すぎる、難しすぎるテスト＝不要
## 手作業より効率よくテストができる。
## 手作業では不安がのこるテスト

# modelテスト
##簡単なバリデーションは基本無視


RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーション' do
    it '有効なuserの場合に保存されるか' do
      expect(build(:user)).to be_valid?
    end

    it 'nameが空欄で無効' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end
  end

end
