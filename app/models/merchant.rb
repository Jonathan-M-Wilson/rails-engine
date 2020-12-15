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
end
