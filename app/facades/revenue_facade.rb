class RevenueFacade
  def self.revenue(amount)
    Revenue.new(amount)
  end

  def self.revenue_by_date(start_date, end_date)
    Revenue.new(Merchant.revenue_by_date(start_date, end_date))
  end
end
