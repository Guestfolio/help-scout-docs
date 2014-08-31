require 'spec_helper'

module HelpScoutDocs
  describe Article do
    let(:article_id)    { "54027853e4b019254d1ec268" }
    let(:category_id)   { "540227d7e4b003be53bdcd28" }
    let(:collection_id) { "540221e9e4b019254d1ec25b" }

    describe "#list_by_category", :vcr do
      it "should return the list of articles by category" do
        articles = subject.list_by_category(category_id).response
        expect(articles).to be_kind_of(Hash)
        expect(articles).to have_key(:articles)
      end
    end

    describe "#list_by_collection", :vcr do
      it "should return the list of articles by collection" do
        articles = subject.list_by_collection(collection_id).response
        expect(articles).to be_kind_of(Hash)
        expect(articles).to have_key(:articles)
      end
    end

    describe "#list" do
      it "should call #list_by_category by default" do
        expect(subject).to receive(:list_by_category).with(category_id, {})
        subject.list(category_id)
      end

      context "passing :collection as type" do
        it "should call #list_by_collection" do
          expect(subject).to receive(:list_by_collection).with(collection_id, {})
          subject.list(collection_id, :collection)
        end
      end
    end

    describe "#get", :vcr do
      it "should return the article" do
        article = subject.get(article_id).response
        expect(article).to be_kind_of(Hash)
        expect(article).to have_key(:article)
      end

      context "when using an id" do
        it "should return the article" do
          article = subject.get(article_id).response
          expect(article).to be_kind_of(Hash)
          expect(article).to have_key(:article)
        end
      end
    end

    describe "#related", :vcr do
      it "should return related articles" do
        related = subject.related(article_id).response
        expect(related).to be_kind_of(Hash)
        expect(related).to have_key(:articles)
      end
    end

    describe "#revisions", :vcr do
      it "should return article revisions" do
        revisions = subject.related(article_id).response
        expect(revisions).to be_kind_of(Hash)
        expect(revisions).to have_key(:articles)
      end
    end
  end
end
