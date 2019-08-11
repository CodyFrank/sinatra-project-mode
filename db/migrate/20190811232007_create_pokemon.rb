class CreatePokemon < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemon do |t|
      t.string :name
      t.string :nickname
      t.string :type
      t.integer :trainer_id
    end
  end
end
