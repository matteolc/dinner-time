# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.string :author, null: false
      t.string :rate
      t.string :difficulty, null: false
      t.string :people_quantity
      t.string :cook_time, null: false
      t.string :author_tip, null: false
      t.string :budget, null: false
      t.string :prep_time, null: false
      t.string :ingredients, array: true, null: false
      t.string :tags, array: true, null: false
      t.string :total_time, null: false
      t.string :image, null: false
      t.string :nb_comments, null: false
    end
  end
end
