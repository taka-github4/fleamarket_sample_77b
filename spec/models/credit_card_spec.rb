require 'rails_helper'
RSpec.describe CreditCard, type: :model do
  describe '#create' do
    context 'CreditCardが保存できる場合' do
      it '全ての情報があれば保存' do
        expect(build(:credit_card)).to be_valid
      end
    end
    context 'CreditCardが保存できない場合' do
      it 'customer_idが空だと保存できない' do
        card = build(:credit_card,customer_id:nil)
        card.valid?
        expect(card.errors[:customer_id]).to include("は32文字で入力してください")
      end
      it 'customer_idが不正な文字列だと保存できない' do
        card = build(:credit_card,customer_id:"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
        card.valid?
        expect(card.errors[:customer_id]).to include("は不正な値です")
      end
      it 'card_idが空だと保存できない' do
        card = build(:credit_card,card_id:nil)
        card.valid?
        expect(card.errors[:card_id]).to include("は32文字で入力してください")
      end
      it 'card_idが不正な文字列だと保存できない' do
        card = build(:credit_card,card_id:"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
        card.valid?
        expect(card.errors[:card_id]).to include("は不正な値です")
      end
      it 'userが存在しないと保存できない' do
        card = build(:credit_card,user:nil)
        card.valid?
        expect(card.errors[:user]).to include("を入力してください")
      end
    end
  end
end