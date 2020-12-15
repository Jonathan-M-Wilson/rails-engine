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
    it ".find_merchant()" do
      merchant = create(:merchant, name: "unIque nAme")
      merchant_2 = create(:merchant, id: 2)

      param = {"name"=>"unIque nAme"}
      param_2 = {"id"=>"2"}

      expect(Merchant.find_merchant(param)).to eq(merchant)
      expect(Merchant.find_merchant(param_2)).to eq(merchant_2)
    end

    it ".find_all_merchants()" do
      create_list(:merchant, 3, name: "unIque nAme")
      param = {"name"=>"unIque nAme"}
      expect(Merchant.find_all_merchants(param).size).to eq(3)
    end
  end
end
