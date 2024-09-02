class Product < ApplicationRecord
    validates :name, presence: true
    validates :price, numericality: { greater_than: 0 }
    has_many :order_items
end
