## テーブル設計

## usersテーブル
| Column             | Type   | Options                 |
| ------------------ | ------ | ----------------------- |
| nickname           | string | null: false             |
| email              | string | null: false,unique:true |
| encrypted_password | string | null: false             |
| family_name        | string | null: false             |
| first_name         | string | null: false             |
| kana_family_name   | string | null: false             |
| kana_first_name    | string | null: false             |
| birthday           | date   | null: false             |

### Association
- has_many : items
- has_many : orders
- has_many : comments


## itemsテーブル
| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| name         | string     | null: false                    |
| describe     | text       | null: false                    |
| category_id  | integer    | null: false                    |
| status_id    | integer    | null: false                    |
| delv_fee_id  | integer    | null: false                    |
| ship_from_id | integer    | null: false                    |
| delv_day_id  | integer    | null: false                    |
| price        | integer    | null: false                    |
| user         | references | null: false, foreign_key: true |

### Association
- belongs_to : user
- has_one  : order
- has_many : comments



## commentsテーブル
| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| content        | text       | null: false                    |
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |

### Association
- belongs_to : user
- belongs_to : item


## ordersテーブル
| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association
- belongs_to : user
- belongs_to : item
- has_one : address

## addressesテーブル
| Column        | Type       | Option                         |
| ------------- | ---------- | -------------------------------|
| post_code     | string     | null: false                    |
| ship_from_id  | integer    | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| billding_name | string     |                                |
| tel_num       | string     | null: false                    |
| order         | references | null: false, foreign_key: true |

### Association
- belongs_to : order
- belongs_to_active_hash :prefecture
