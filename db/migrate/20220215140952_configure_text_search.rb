# frozen_string_literal: true

class ConfigureTextSearch < ActiveRecord::Migration[6.1]
  def change
    enable_extension :unaccent

    execute <<-SQL
      CREATE TEXT SEARCH CONFIGURATION ts_unaccent_en ( COPY = english );
      ALTER TEXT SEARCH CONFIGURATION ts_unaccent_en
        ALTER MAPPING FOR hword, hword_part, word
        WITH unaccent, english_stem;
    SQL
  end
end
