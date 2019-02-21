FactoryGirl.define do
  factory :post do
    sequence(:title) {|n| "title_#{n}" }
    sequence(:body) {|n| "body_#{n}"}
  end

  factory :comment do
    sequence(:body) {|n| "body_#{n}"}
    post
  end

end