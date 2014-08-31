require 'spec_helper'

module HelpScoutDocs
  describe Site do
    describe "#list", :vcr do
      it "should return the list of sites" do
        sites = subject.list.response
        expect(sites).to be_kind_of(Hash)
        expect(sites).to have_key(:sites)
      end
    end

    describe "#get", :vcr do
      let(:site_id) { "540221a1e4b019254d1ec25a" }

      it "should return the site" do
        site = subject.get(site_id).response
        expect(site).to be_kind_of(Hash)
        expect(site).to have_key(:site)
      end
    end
  end
end
