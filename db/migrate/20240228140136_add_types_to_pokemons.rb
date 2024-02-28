class AddTypesToPokemons < ActiveRecord::Migration[7.1]
  def change
    add_column :pokemons, :types, :string, array: true, default: []
  end
end
