require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'Methods' do
    before :each do
      @merchant_1 = create(:merchant, name: "unIque nAme")
      @merchant_2 = create(:merchant, name: "unIque nAme")
      @merchant_3 = create(:merchant, name: "unIque nAme")
      @merchant_4 = create(:merchant, id: 2)

      item_1 = create(:item, merchant: @merchant_1)
      item_2 = create(:item, merchant: @merchant_2)
      item_3 = create(:item, merchant: @merchant_3)

      invoice_1 = create(:invoice, merchant: @merchant_1, status: 'shipped')
      invoice_2 = create(:invoice, merchant: @merchant_2, status: 'shipped')
      invoice_3 = create(:invoice, merchant: @merchant_3, status: 'shipped')
      invoice_4 = create(:invoice, merchant: @merchant_1, status: 'packaged')

      invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1, unit_price: 12.99, quantity: 30)
      invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_1, unit_price: 12.99, quantity: 54)
      invoice_item_3 = create(:invoice_item, invoice: invoice_3, item: item_2, unit_price: 27.34, quantity: 21)
      invoice_item_4 = create(:invoice_item, invoice: invoice_4, item: item_3, unit_price: 68.00, quantity: 11)

      transaction_1 = create(:transaction, invoice: invoice_1)
      transaction_2 = create(:transaction, invoice: invoice_2)
      transaction_3 = create(:transaction, invoice: invoice_3)
      transaction_4 = create(:transaction, invoice: invoice_4)
    end

    it ".find_merchant()" do
      param = {"name"=>"unIque nAme"}
      param_2 = {"id"=>"2"}

      expect(Merchant.find_merchant(param)).to eq(@merchant_1)
      expect(Merchant.find_merchant(param_2)).to eq(@merchant_4)
    end

    it ".find_all_merchants()" do
      param = {"name"=>"unIque nAme"}
      expect(Merchant.find_all_merchants(param).size).to eq(3)
    end

    it ".most_revenue()" do
      expect(Merchant.most_revenue(1)).to eq([@merchant_2])
    end

    it ".most_items_sold()" do
      expect(Merchant.most_items_sold(1)).to eq([@merchant_2])
    end

    it ".revenue_by_date()" do
      start_date = "2020-12-12"
      end_date = "2020-12-17"
      expect(Merchant.revenue_by_date(start_date, end_date)).to eq(1665.3)
    end
  end
end
