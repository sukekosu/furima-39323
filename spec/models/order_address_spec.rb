require 'rails_helper'
require 'faker'
RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item ,image: fixture_file_upload('public/images/test_image.png'))
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
  end

  describe '購入者情報の保存' do
    context '購入できる場合' do
      it 'すべての値が正しく入力されていれば購入できる' do
        expect(@order_address).to be_valid
      end
      it 'building_nameは空でも購入できる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '購入できない場合' do
      it 'post_codeが空だと購入できない' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeは「3桁ハイフン4桁」の半角文字列のみ保存可能なこと' do
        @order_address.post_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code is invalid")
      end
      it 'cityが空だと購入できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空だと購入できない' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end
      it 'tel_numが空だと購入できない' do
        @order_address.tel_num = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tel num can't be blank")
      end
      it 'tel_numは9桁以下だと購入できない' do
        @order_address.tel_num = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tel num is invalid")
      end
      it 'tel_numは12桁以上だと購入できない' do
        @order_address.tel_num = '123456789123'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tel num is invalid")
      end
      it 'tel_numは半角数字以外が含まれている場合だと購入できない' do
        @order_address.tel_num = '090-1234'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Tel num is invalid")
      end
      it 'ship_from_idに「0」が選択されている場合は出品できない' do
        @order_address.ship_from_id = '0'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Ship from can't be blank")
      end
      it 'tokenが空だと購入できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'userが紐付いていなければ購入できない' do
        @order_address.user_id= nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていなければ購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end