# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  # Possible statuses for an order
  STATUSES = ["en cours", "annulé", "completé"]

  # Set default status
  after_initialize :set_default_status, if: :new_record?

  accepts_nested_attributes_for :order_items

  validates :status, inclusion: { in: STATUSES }
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :shipping_address, presence: true

  private

  def set_default_status
    self.status ||= "en cours"
  end
end
