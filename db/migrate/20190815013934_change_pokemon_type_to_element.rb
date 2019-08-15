class ChangePokemonTypeToElement < ActiveRecord::Migration[5.2]
  def change
    rename_column :pokemons, :type, :element
  end
end
