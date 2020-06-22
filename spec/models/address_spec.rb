require 'rails_helper'

RSpec.describe Address, type: :model do

  describe '#create' do
  before do
  end
    context 'Addressを保存できる場合' do
      it '全ての項目に記載があれば保存' do
        expect(build(:address)).to be_valid
      end
      it 'apartmentが空でも保存できる' do
        expect(build(:address, apartment: nil)).to be_valid
      end
    end

    context 'Addressを保存できない場合' do
      it ' first_nameが空だと保存できない' do
        address = build(:address, first_name: nil)
        address.valid?
        expect(address.errors[:first_name]).to include("を入力してください")
      end
      it ' last_nameが空だと保存できない' do
        address = build(:address, last_name: nil)
        address.valid?
        expect(address.errors[:last_name]).to include("を入力してください")
      end
      it ' first_name_kanaが空だと保存できない' do
        address = build(:address, first_name_kana: nil)
        address.valid?
        expect(address.errors[:first_name_kana]).to include("を入力してください")
      end
      it ' last_name_kanaが空だと保存できない' do
        address = build(:address, last_name_kana: nil)
        address.valid?
        expect(address.errors[:last_name_kana]).to include("を入力してください")
      end
      it ' first_name_kanaがひらがな以外だと保存できない' do
        address = build(:address, first_name_kana: "太郎")
        address.valid?
        expect(address.errors[:first_name_kana]).to include("は不正な値です")
      end
      it ' last_name_kanaがひらがな以外だと保存できない' do
        address = build(:address, last_name_kana: "田中")
        address.valid?
        expect(address.errors[:last_name_kana]).to include("は不正な値です")
      end
      it ' zip_codeが空だと保存できない' do
        address = build(:address, zip_code: nil)
        address.valid?
        expect(address.errors[:zip_code]).to include("を入力してください")
      end
      it ' 存在しないzip_codeは保存できない（値が小さい場合）' do
        address = build(:address, zip_code: 10009)
        address.valid?
        expect(address.errors[:zip_code]).to include("に入力された番号は存在しません")
      end
      it ' 存在しないzip_codeは保存できない（値が大きい場合）' do
        address = build(:address, zip_code: 9998532)
        address.valid?
        expect(address.errors[:zip_code]).to include("に入力された番号は存在しません")
      end
      it ' prefectureが空だと保存できない' do
        address = build(:address, prefecture: nil)
        address.valid?
        expect(address.errors[:prefecture]).to include("を入力してください")
      end
      it ' prefectureが---だと保存できない' do
        address = build(:address, prefecture: 0)
        address.valid?
        expect(address.errors[:prefecture]).to include("を選択してください")
      end
      it ' cityが空だと保存できない' do
        address = build(:address, city: nil)
        address.valid?
        expect(address.errors[:city]).to include("を入力してください")
      end
      it ' house_numberが空だと保存できない' do
        address = build(:address, house_number: nil)
        address.valid?
        expect(address.errors[:house_number]).to include("を入力してください")
      end
    end
  end
end
