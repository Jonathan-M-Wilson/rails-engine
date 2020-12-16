class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices

  scope :find_by_date, ->(param) { where("to_char(#{param.keys.first},'YYYY-MM-DD-HH-MI-SS') ILIKE ?", "%#{param.values.first}%") }
  scope :find_by_attribute, ->(param) { where("merchants.#{param.keys.first}::text ILIKE ?", "%#{param.values.first}%") }

  def self.find_merchant(param)
    attribute = param.keys.first
    if %w[created_at updated_at].include?(attribute)
      find_by_date(param).first
    else
      find_by_attribute(param).first
    end
  end

  def self.find_all_merchants(param)
    attribute = param.keys.first
    if %w[created_at updated_at].include?(attribute)
      find_by_date(param)
    else
      find_by_attribute(param)
    end
  end

  def self.most_revenue(param)
    Merchant
    .select('merchants.*, SUM(quantity * unit_price) AS revenue')
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .merge(Invoice.successful)
    .group(:id)
    .order(revenue: :desc)
    .limit(param)
  end

  def self.most_items_sold(param)
    Merchant
    .select('merchants.*, SUM(quantity) AS items_sold')
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .merge(Invoice.successful)
    .group(:id)
    .order(items_sold: :desc)
    .limit(param)
  end
end
