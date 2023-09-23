class Order < ApplicationRecord
  class Purchase < ApplicationRecord
    belongs_to :user
    belongs_to :item
  end
end
