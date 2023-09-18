class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # 後ほど定義
  # has_many :items
  # has_many :orders

  validates :nickname, :family_name, :first_name, :kana_family_name, :kana_first_name, :birthday, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'

  NAME_REGEX = /\A[ぁ-んァ-ン一-龥]+\z/.freeze
  validates_format_of :family_name, :first_name, with: NAME_REGEX, message: 'には全角(漢字・ひらがな・カタカナ)で入力してください'

  KANA_NAME_REGEX = /\A[ァ-ン]+\z/.freeze
  validates_format_of :kana_family_name, :kana_first_name, with: KANA_NAME_REGEX, message: 'には全角カタカナで入力してください'
end
