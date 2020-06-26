require 'rails_helper'
RSpec.describe Item, type: :model do
  describe '#create' do
    context 'itemを保存できる場合' do
      it '全ての項目に記載があれば保存' do
        item = build(:item)
        item.photos << build(:photo)
        expect(item).to be_valid
      end
      it 'サイズの記載がなくても保存できる' do
        item = build(:item, size_id:"")
        item.photos << build(:photo)
        expect(item).to be_valid
      end
      it 'ブランドの記載がなくても保存できる' do
        item = build(:item, brand:"")
        item.photos << build(:photo)
        expect(item).to be_valid
      end
    end
    context 'itemを保存できない場合' do
      it "写真がないと登録できない事" do
        item = build(:item)
        item.valid?
        expect(item.errors[:photos]).to include("を入力してください")
      end
      it "商品名がない場合は登録できない事" do
        item = build(:item, name: "")
        item.photos << build(:photo)
        item.valid?
        expect(item.errors[:name]).to include("を入力してください")
      end
      it "商品名が40以上の場合は登録できない事" do
        item = build(:item, name: over_word=41.times.inject("") { |str| str.concat([*"ぁ".."ん"].sample) })
        item.photos << build(:photo)
        item.valid?
        expect(item.errors[:name]).to include("は40文字以内で入力してください")
      end
      it "商品説明がない場合は登録できない事" do
        item = build(:item, description: "")
        item.photos << build(:photo)
        item.valid?
        expect(item.errors[:description]).to include("を入力してください")
      end
      it "商品説明が1001文字以上の場合は登録できない事" do
        item = build(:item, description: over_word=1001.times.inject("") { |str| str.concat([*"ぁ".."ん"].sample) })
        item.photos << build(:photo)
        item.valid?
        expect(item.errors[:description]).to include("は1000文字以内で入力してください")
      end
      it "商品の状態がない場合は登録できない事" do
        item = build(:item, item_condition_id: "")
        item.photos << build(:photo)
        item.valid?
        expect(item.errors[:item_condition_id]).to include("を入力してください")
      end
      it "送料の負担がない場合は登録できない事" do
        item = build(:item, burden_id: "")
        item.photos << build(:photo)
        item.valid?
        expect(item.errors[:burden_id]).to include("を入力してください")
      end
      it "発送元の地域がない場合は登録できない事" do
        item = build(:item, prefectures_id: "")
        item.photos << build(:photo)
        item.valid?
        expect(item.errors[:prefectures_id]).to include("を入力してください")
      end
      it "発送までの日数がない場合は登録できない事" do
        item = build(:item, days_id: "")
        item.photos << build(:photo)
        item.valid?
        expect(item.errors[:days_id]).to include("を入力してください")
      end
      it "カテゴリが空だと登録できない事" do
        item = build(:item, category_id: nil)
        item.photos << build(:photo)
        item.valid?
        expect(item.errors[:category_id]).to include("を入力してください")
      end
      it "カテゴリが３段目まで入力されていないと登録できない事" do
        item = build(:item, category_id: 158)
        item.photos << build(:photo)
        item.valid?
        expect(item.errors[:category_id]).to include("を入力してください")
      end
      it "価格が３００円未満だと登録できない事" do
        item = build(:item, price: 299)
        item.photos << build(:photo)
        item.valid?
        expect(item.errors[:price]).to include("を300円から9999999円までの間で入力してください")
      end
      it "価格が１０００００００円以上だと登録できない事" do
        item = build(:item, price: 10000000)
        item.photos << build(:photo)
        item.valid?
        expect(item.errors[:price]).to include("を300円から9999999円までの間で入力してください")
      end
    end
  end
end