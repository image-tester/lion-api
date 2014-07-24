# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :badge do
    id 1
    user_id ""
    pull_request_id ""
    body "MyText"
    created_at "2014-07-24 09:41:47"
    updated_at "2014-07-24 09:41:47"
  end
end
