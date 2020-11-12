FactoryBot.define do
  factory :link do
    title { 'Example Site' }
    url { 'http://example.com' }
    slug { 'abc123' }
    visited { 0 }
  end
end
