require 'rails_helper'

RSpec.describe UrlRedirector do
  let(:url) { FactoryBot.create(:url, expires_at: Time.current + 1.hour, click_count: 0) }
  subject { described_class.new(url) }

  describe "#perform" do
    context "when URL is active" do
      it "returns redirect status and increments click count" do
        result = subject.perform

        expect(result[:status]).to eq(:redirect)
        expect(result[:destination]).to eq(url.original_url)
        expect(url.reload.click_count).to eq(1)
      end
    end

    context "when URL is expired" do
      it "returns expired status and does not increment click count" do
        url.update!(expires_at: Time.current - 1.hour)
        result = subject.perform

        expect(result[:status]).to eq(:expired)
        expect(url.reload.click_count).to eq(0)
      end
    end
  end
end
