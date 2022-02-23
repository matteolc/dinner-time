# frozen_string_literal: true

class AddFunctions < ActiveRecord::Migration[6.1]
  def change
    execute <<-SQL
      CREATE OR REPLACE FUNCTION public.f_array_to_string(text[])#{' '}
      RETURNS text as $$#{' '}
      SELECT array_to_string($1, ',');#{' '}
      $$ LANGUAGE sql IMMUTABLE PARALLEL SAFE STRICT;
    SQL
  end
end
