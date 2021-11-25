FactoryBot.define do
  factory :carbonfootprint do
    co2_emitted { 1 }
    co2sequestered { 1 }
    co2total { "MyString" }
  end
end
