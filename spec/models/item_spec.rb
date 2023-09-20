require 'rails_helper'
require 'faker'
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('public/images/test_image.png')
  end

  describe '商品出品' do
    context '出品がうまくいくとき' do
      it ':image,:name,:describe,:price,:category_id,f:status_id,delv_fee_id,:ship_from_id,:delv_days_idが存在すれば登録できる' do
        expect(@item.valid?).to eq true
      end
      it ':priceが半角数字でかつ300〜9999999の間の金額であるとき' do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end
    end

    context '出品がうまくいかないとき' do
      it ':imageが空だと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it ':nameが空だと登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it ':describeが空だと登録できない' do
        @item.describe = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Describe can't be blank")
      end
      it ':priceが空だと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it ':priceが半角数字以外だと登録できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end
      it ':priceが300~9999999の範囲外だと登録できない' do
        @item.price = '100'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end
      it ':category_idが「---」だと登録できない' do
        @item.category_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('Category Select')
      end
      it ':status_idが「---」だと登録できない' do
        @item.status_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('Status Select')
      end
      it ':delv_fee_idが「---」だと登録できない' do
        @item.delv_fee_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('Delv fee Select')
      end
      it ':ship_from_idが「---」だと登録できない' do
        @item.ship_from_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('Ship from Select')
      end
      it ':delv_days_idが「---」だと登録できない' do
        @item.delv_days_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('Delv days Select')
      end
    end
  end
end