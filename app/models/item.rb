class Item < ApplicationRecord
  belongs_to :user
  has_one :order

  # ActiveStorageのアソシエーション
  has_one_attached :image

  # ActiveHashとのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delv_fee
  belongs_to :ship_from
  belongs_to :delv_days

  # バリデーション
  validates :name, presence: true
  validates :describe, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :image, presence: true
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :status_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :delv_fee_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :ship_from_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :delv_days_id, numericality: { other_than: 1 , message: "can't be blank"}

end