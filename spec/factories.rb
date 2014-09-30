FactoryGirl.define do
  factory :user do
    name     "Yogi"
    email    "yogi@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
