require 'spec_helper'

module HelpScoutDocs
  describe Category do
    let(:category_id)   { "540227d7e4b003be53bdcd28" }
    let(:collection_id) { "540221e9e4b019254d1ec25b" }

    describe "#list", :vcr do
      it "should return the list of categories" do
        categories = subject.list(collection_id).response
        expect(categories).to be_kind_of(Hash)
        expect(categories).to have_key(:categories)
      end
    end

    describe "#get", :vcr do
      it "should return the category" do
        category = subject.get(category_id).response
        expect(category).to be_kind_of(Hash)
        expect(category).to have_key(:category)
      end
    end
  end
end
