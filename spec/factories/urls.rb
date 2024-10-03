FactoryBot.define do
  factory :url do
    original_url { "http://example.com" }
    short_url { SecureRandom.hex(4) }
    expires_at { Time.current + 1.day }
    click_count { 0 }
  end
end