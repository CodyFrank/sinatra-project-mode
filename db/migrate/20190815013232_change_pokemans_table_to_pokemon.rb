class ChangePokemansTableToPokemon < ActiveRecord::Migration[5.2]
  def change
    rename_table :pokemons, :pokemon
  end
end
