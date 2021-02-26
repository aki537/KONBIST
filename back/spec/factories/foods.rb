FactoryBot.define do
  factory :food do
    sequence(:name) { |n| "#{n}testfood" }
    calorie { 100 }
    carbonhydrate { 30.1 }
    protein { 10.2 }
    lipid { 5.1 }
    details { 'メロンパン' }
    maker { 'セブンイレブン' }
    category { 'パン' }
    price { 100 }
    release { '2020-2-10' }
  end
end
