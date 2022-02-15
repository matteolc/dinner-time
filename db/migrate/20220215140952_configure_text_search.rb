class ConfigureTextSearch < ActiveRecord::Migration[6.1]
  def change

    execute <<-SQL
      CREATE EXTENSION unaccent;
      CREATE TEXT SEARCH CONFIGURATION fr ( COPY = french );
      ALTER TEXT SEARCH CONFIGURATION fr
        ALTER MAPPING FOR hword, hword_part, word
        WITH unaccent, french_stem;
    SQL
        
  end
end
