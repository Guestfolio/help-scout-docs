require 'spec_helper'
require 'json'

module HelpScoutDocs
  describe Client do
    let(:config) {
      {
        api_key:      "api-key",
        api_password: "api-password"
      }
    }

    describe "#initialize" do
      context "by default" do
        it "should initialize a logger" do
          expect(subject.logger).not_to be_nil
        end
      end

      it "should allow the default attributes to be set" do
        expect(Client.new(config).instance_variable_get("@api_key")).to eq config[:api_key]
      end
    end

    describe "#get" do
      it "should return back a result", :vcr do
        expect(subject.get("sites")).to be_kind_of(Result)
      end

      context "with invalid authentication params", :vcr do
        subject(:client) { Client.new(api_key: "invalid") }

        it "should raise an exception" do
          expect { subject.get("sites") }.to raise_error Error::AuthenticationError
        end
      end

      context "with missing path params", :vcr do
        it "should raise an exception" do
          expect { subject.get(nil) }.to raise_error ArgumentError
        end
      end

      context "with valid params", :vcr do
        it "should call the requested method" do
          result = subject.get("sites")
          expect(result.success?).to be true
          expect(result.response).to be_a_kind_of(Hash)
        end
      end

      context "for a missing request", :vcr do
        it "should raise an exception" do
          expect{ subject.get("sites/1") }.to raise_error HelpScoutDocs::Error::ResourceNotFoundError
        end
      end

      context "when the response cannot be parsed" do
        it "should throw an exception and log the error" do
          logger = double(:logger)
          expect(logger).to receive(:error).with(an_instance_of(String)) do |error|
            expect(error).to eq "Unable to parse Help Scout Docs API response: JSON::ParserError"
          end
          expect(logger).to receive(:debug)

          subject = Client.new(config.merge(logger: logger))

          expect_any_instance_of(Faraday::Connection).to receive(:get) { raise JSON::ParserError }
          expect { subject.get("sites") }.to raise_error HelpScoutDocs::Error::ParserError
        end
      end
    end

    describe "#post" do
      # See .get
    end
  end
end
