FactoryBot.define do
  factory :form do
    sequence(:title) { |i| "Title #{i}" }
    after(:build) do |form|
      form.fields.build(attributes_for(:field, form: :form))
    end
  end
end
