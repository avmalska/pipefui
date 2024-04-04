FactoryBot.define do
  factory :field do
    sequence(:name) { |i| "Name #{i}" }
    text_type { 'text' }
    form
  end
end
