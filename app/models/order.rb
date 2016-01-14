class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_staches
  has_many :staches, through: :order_staches

  def total
    staches.map { |stache| subtotal(stache) }.sum
  end

  def quantity(stache)
    order_staches.find_by(stache_id: stache.id).quantity
  end

  def subtotal(stache)
    quantity(stache) * stache.price
  end

  def completed?
    %w(completed cancelled).include?(status) ? "Yes" : "No"
  end

  def formatted_created_date
    date = created_at.in_time_zone("Mountain Time (US & Canada)")
    date.strftime("%m/%d/%Y at %I:%M %p")
  end

  def formatted_updated_date
    date = updated_at.in_time_zone("Mountain Time (US & Canada)")
    date.strftime("%m/%d/%Y at %I:%M %p")
  end
end