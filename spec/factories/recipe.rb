# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    name { Faker::Food.dish }
    ingredients { Faker::Food.description.split('.') }
    author { Faker::Name.name }
    author_tip { Faker::ChuckNorris.fact }
    budget { Faker::Types.rb_string }
    cook_time { Faker::Types.rb_string }
    difficulty { Faker::Types.rb_string }
    image { Faker::LoremPixel.image }
    nb_comments { Faker::Number.between(from: 1, to: 99) }
    people_quantity { Faker::Number.between(from: 1, to: 10) }
    prep_time { Faker::Types.rb_string }
    rate { Faker::Number.between(from: 1, to: 5) }
    tags { 2.times.map { Faker::Food.ethnic_category } }
    total_time { Faker::Types.rb_string }

    factory :accented_recipe do
      ingredients do
        %w[mùstard fûel ünknown maÿbe àctual sâpiens mælevolent çabbage émoji èxtra fêta chëëse maïs metrîc pôule bœef]
      end
    end
  end
end
