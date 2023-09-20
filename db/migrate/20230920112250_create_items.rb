class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string     :name,         null:false
      t.text       :describe,     null:false
      t.integer    :category_id,  null:false
      t.integer    :status_id,    null:false
      t.integer    :delv_fee_id,  null:false
      t.integer    :ship_from_id, null:false
      t.integer    :delv_days_id, null:false
      t.integer    :price,        null:false
      t.references :user,         null:false, foreign_key: true
      t.timestamps
    end
  end
end
