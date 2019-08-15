class ChangePokemonTablenameToPokemons < ActiveRecord::Migration[5.2]
  def change
    rename_table :pokemon, :pokemons
  end
end
