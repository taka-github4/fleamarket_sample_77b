require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    context 'userを保存できる場合' do
      it '全ての項目に記載があれば保存' do
        expect(build(:user)).to be_valid
      end
    end

    context 'userを保存できない場合' do
      it ' first_nameが空だと保存できない' do
        user = build(:user, first_name: nil)
        user.valid?
        expect(user.errors[:first_name]).to include("を入力してください")
      end
      it ' last_nameが空だと保存できない' do
        user = build(:user, last_name: nil)
        user.valid?
        expect(user.errors[:last_name]).to include("を入力してください")
      end
      it ' first_name_kanaが空だと保存できない' do
        user = build(:user, first_name_kana: nil)
        user.valid?
        expect(user.errors[:first_name_kana]).to include("を入力してください")
      end
      it ' last_name_kanaが空だと保存できない' do
        user = build(:user, last_name_kana: nil)
        user.valid?
        expect(user.errors[:last_name_kana]).to include("を入力してください")
      end
      it ' first_name_kanaがひらがな以外だと保存できない' do
        user = build(:user, first_name_kana: "太郎")
        user.valid?
        expect(user.errors[:first_name_kana]).to include("は不正な値です")
      end
      it ' last_name_kanaがひらがな以外だと保存できない' do
        user = build(:user, last_name_kana: "田中")
        user.valid?
        expect(user.errors[:last_name_kana]).to include("は不正な値です")
      end
      it ' nicknameが空だと保存できない' do
        user = build(:user, nickname: nil)
        user.valid?
        expect(user.errors[:nickname]).to include("を入力してください")
      end
      it ' birthdayが空だと保存できない' do
        user = build(:user, birthday: nil)
        user.valid?
        expect(user.errors[:birthday]).to include("を入力してください")
      end
      it ' emailが空だと保存できない' do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end
      it ' emailにドメイン名が無いと保存できない' do
        user = build(:user, email: "aaa@aaa")
        user.valid?
        expect(user.errors[:email]).to include("は不正な値です")
      end
      it "既に登録済みのemailは登録できない" do
        user = create(:user)
        another_user = build(:user, email: user.email)
        another_user.valid?
        expect(another_user.errors[:email]).to include("はすでに存在します")
      end
      it ' passwordが空だと保存できない' do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end
      it ' passwordが6文字以下だと保存できない' do
        user = build(:user, password: "aaaaaa")
        user.valid?
        expect(user.errors[:password]).to include("は7文字以上で入力してください")
      end
      it ' passwordとpassword_confirmationが一致しないので保存できない' do
        user = build(:user, password: "aaaaaaa", password_confirmation: "bbbbbbb")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end
    end
  end
end
