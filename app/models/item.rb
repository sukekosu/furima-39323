class Item < ApplicationRecord
  belongs_to :user
  has_one :order

  # ActiveStorageのアソシエーション
  has_one_attached :image

  # ActiveHashとのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :delv_fee
  belongs_to_active_hash :ship_from
  belongs_to_active_hash :delv_days

  # バリデーション
  validates :image, :name, :describe, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :category_id, numericality: { other_than: 0, message: 'Select' }
  validates :status_id, numericality: { other_than: 0, message: 'Select' }
  validates :delv_fee_id, numericality: { other_than: 0, message: 'Select' }
  validates :ship_from_id, numericality: { other_than: 0, message: 'Select' }
  validates :delv_days_id, numericality: { other_than: 0, message: 'Select' }
end