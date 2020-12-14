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
    it ".search()" do
      merchant = create(:merchant, name: "unIque nAme")
      merchant_2 = create(:merchant, id: 2)

      param = {"name"=>"unIque nAme"}
      param_2 = {"id"=>"2"}

      expect(Merchant.search(param)).to eq(merchant)
      expect(Merchant.search(param_2)).to eq(merchant_2)
    end
  end
end
