FactoryBot.define do
  factory :user, aliases: [:owner]  do
    first_name { "Aaron" }
    last_name { "Sumner" }
    # email { "tester@example.com" }
    sequence(:email) { |n| "tester#{n}@example.com"}
    password { "dottle-nouveau-pavilion-tights-furze" }
  end
end
