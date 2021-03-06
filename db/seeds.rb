# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

recipes = JSON.parse(File.read("#{Rails.root}/db/recipes.json"))
puts "About to insert #{recipes.length} recipes..."
Recipe.insert_all(recipes)
puts "Inserted #{Recipe.count} recipes!"
