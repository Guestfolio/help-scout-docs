require 'spec_helper'

module HelpScoutDocs
  describe Result do
    describe "#success?" do
      it "should return true for a successful response" do
        expect(Result.new({message: "success"}).success?).to be true
      end

      it "should return false for an unsuccessful response" do
        expect(Result.new({status: "401"}).success?).to be false
      end
    end

    describe "#message" do
      it "should return the error message for a failed response" do
        expect(Result.new({status: "404", message: "Message"}).message).to eq "Message"
      end
    end
  end
end
