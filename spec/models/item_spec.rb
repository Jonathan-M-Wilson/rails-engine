require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'Methods' do
    it ".find_item()" do
      item = create(:item, name: "unIque nAme")
      item_2 = create(:item, description: "unique Description")

      param = {"name"=>"unIque nAme"}
      param_2 = {"description"=>"unique Description"}

      expect(Item.find_item(param)).to eq(item)
      expect(Item.find_item(param_2)).to eq(item_2)
    end

    it ".find_all_items()" do
      item = create_list(:item, 3, name: "unIque nAme asfgh")
      item_2 = create_list(:item, 3, description: "unique description asfgh")

      param = {"name"=>"asfg"}
      param_2 = {"description"=>"asfg"}

      expect(Item.find_all_items(param).count).to eq(3)
      expect(Item.find_all_items(param_2).count).to eq(3)
    end
  end
end
