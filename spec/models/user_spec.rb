require 'rails_helper'
require 'faker'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまく行くとき' do
      it 'nickname,email,password,password_confirmation,family_name,first_name,kana_family_name,kana_first_name,birthdayが存在すれば登録できる' do
        expect(@user.valid?).to eq true
      end
      it 'emailが＠を含んでいれば登録できる' do
        @user.email = 'aaa@gmail.com'
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上、英数混合、password_confirmationが同じであれば登録できる' do
        @user.password = '12345a'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
      it 'family_nameが漢字orひらがなorカタカナなら登録できる' do
        @user.family_name = '山田'
        expect(@user).to be_valid
      end
      it 'first_nameが漢字orひらがなorカタカナなら登録できる' do
        @user.first_name = '太郎'
        expect(@user).to be_valid
      end
      it 'kana_family_nameがカタカナなら登録できる' do
        @user.kana_family_name = 'ヤマダ'
        expect(@user).to be_valid
      end
      it 'kana_first_nameがカタカナなら登録できる' do
        @user.kana_first_name = 'タロウ'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailが＠が含まれていなければ登録できない' do
        @user.email = 'aaa.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '1a1a1'
        @user.password_confirmation = '1a1a1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordは全角の英数字では保存できない' do
        @user.password = 'A１１１１１'
        @user.password_confirmation = 'A１１１１１'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordとpassword_confirmationが一致しなければ保存できない' do
        @user.password = '12345a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it 'family_nameが漢字orひらがなorカタカナ以外だと登録できない' do
        @user.family_name = 'Depp'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name には全角(漢字・ひらがな・カタカナ)で入力してください')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_nameが漢字orひらがなorカタカナ以外だと登録できない' do
        @user.first_name = 'Johnny'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name には全角(漢字・ひらがな・カタカナ)で入力してください')
      end
      it 'kana_family_nameが空では登録できない' do
        @user.kana_family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana family name can't be blank")
      end
      it 'kana_family_nameがカタカナ以外だと登録できない' do
        @user.kana_family_name = 'でっぷ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana family name には全角カタカナで入力してください')
      end
      it 'kana_first_nameが空では登録できない' do
        @user.kana_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first name can't be blank")
      end
      it 'kana_first_nameがカタカナ以外だと登録できない' do
        @user.kana_first_name = 'じょにー'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana first name には全角カタカナで入力してください')
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
