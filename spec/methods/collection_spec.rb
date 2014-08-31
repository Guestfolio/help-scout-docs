require 'spec_helper'

module HelpScoutDocs
  describe Collection do
    describe "#list", :vcr do
      it "should return the list of collections" do
        collections = subject.list.response
        expect(collections).to be_kind_of(Hash)
        expect(collections).to have_key(:collections)
      end
    end

    describe "#get", :vcr do
      let(:collection_id) { "540221e9e4b019254d1ec25b" }

      it "should return the collection" do
        collection = subject.get(collection_id).response
        expect(collection).to be_kind_of(Hash)
        expect(collection).to have_key(:collection)
      end
    end
  end
end
