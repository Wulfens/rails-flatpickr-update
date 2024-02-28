class PokemonsController < ApplicationController
  before_action :set_pokemon, only: %i[show edit update destroy]
  def index
    @pokemons = Pokemon.all
  end

  def show
    @booking = Booking.new
  end

  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.user = current_user
    if @pokemon.save
      redirect_to pokemon_path(@pokemon)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @pokemon.update(pokemon_params)
      redirect_to pokemon_path(@pokemon)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @pokemon.destroy
    redirect_to pokemons_path, status: :see_other
  end

  private

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end

  def pokemon_params
    params.require(:pokemon).permit(:name, :price_per_day, :photo, :poster_url, types: [])
  end

end
