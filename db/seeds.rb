require 'open-uri'
require "nokogiri"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Booking.destroy_all
Pokemon.destroy_all
User.destroy_all

User.create!(
  email: "truc@truc.com",
  password: "123456"
)

User.create!(
  email: "trucmuche@truc.com",
  password: "123456"
)

User.create!(
  email: "machintruc@truc.com",
  password: "123456"
)

# addresses = ["12 rue de la croix de bois, Boran sur Oise", "68 Avenue Parmentier, Paris", "30 rue victor Basch, Vincennes", "2 avenue de l'orangerie, Villers Saint Paul", "6 Rue de la planchette, Gouvieux", "16 Villa Gaudelet, Paris"]

# all_types = %w[acier combat dragon eau electrik feu fee glace insecte normal plante poison psy roche sol spectre tenebres vol]

url = "https://eternia.fr/fr/pokedex/liste-pokemon/"


html_file = URI.parse(url).open
html_doc = Nokogiri::HTML(html_file)
i = 0
html_doc.search("tr").each do |element|
  next if element.children[1].name == "th"

  name = element.search('td > a').text
  next if name.match?(/\bméga/i) || name.match?(/alola\b/i)

  pokemon = Pokemon.new(name: name, price_per_day: rand(50))
  types = element.search('span').map { |type| Pokemon::TYPES.include?(type.text) ? type.text : "" }

  href_poster = element.search('td > a').attribute('href').value
  url_poster = "https://eternia.fr#{href_poster}"
  begin
    poster_file = URI.parse(url_poster).open
    poster_doc = Nokogiri::HTML(poster_file)
    image_src = poster_doc.search('.artwork_off > img').attribute('src').value
    pokemon.poster_url = "https://eternia.fr#{image_src}"
  rescue OpenURI::HTTPError => e
    e.message
  end
  pokemon.types = types
  pokemon.user = User.all.sample
  pokemon.save!
  puts "#{pokemon.name} has been created !"
  i += 1
  break if i == 151
end
