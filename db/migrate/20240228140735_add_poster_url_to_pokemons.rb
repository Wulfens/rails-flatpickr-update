class AddPosterUrlToPokemons < ActiveRecord::Migration[7.1]
  def change
    add_column :pokemons, :poster_url, :string
  end
end
