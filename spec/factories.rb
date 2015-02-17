FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :user2, class: User do
    username "Pekka2"
    password "Foobar2"
    password_confirmation "Foobar2"
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :brewery do
    name "anonymous"
    year 1900
  end

  factory :brewery2, class: Brewery do
    name "Superpanimo"
    year 1905
  end

  factory :beer do
    name "anonymous"
    brewery
    style
  end

  factory :beer2, class: Beer do
    name "Superolut"
    brewery
    style
  end

  factory :style do
    name "Lager"
    description "Desc for Lager"
  end

  factory :style2, class: Style do
    name "American Blonde Ale"
    description "Desc for American Blonde Ale"
  end
end
