require 'rest-client'
require 'json'
require 'pry'

def every_character
 all_characters = []

 (1..9).to_a.each do |number|
   num_as_string = number.to_s
   edited_url = "https://www.swapi.co/api/people/?page=" + num_as_string
   page_string = RestClient.get(edited_url)
   page_hash = JSON.parse(page_string)

   page_all_characters = page_hash["results"] #array of character hashes for the page

   page_all_characters.each do |character_hash|
     all_characters << character_hash
   end

 end

 all_characters
end


def get_character_movies_from_api(character)
 #make the web request

 # iterate over the character hash to find the collection of `films` for the given
 #   `character`
 # collect those film API urls, make a web request to each URL to get the info
 #  for that film
 # return value of this method should be collection of info about each film.
 #  i.e. an array of hashes in which each hash reps a given film
 # this collection will be the argument given to `parse_character_movies`
 #  and that method will do some nice presentation stuff: puts out a list
 #  of movies by title. play around with puts out other info about a given film.
 all_characters = every_character

 films_array = nil

 all_characters.each do |character_hash|
   if character_hash["name"].downcase == character
     films_array = character_hash["films"]
   end
 end

 movie_array = []

 films_array.each do |movie_link|
   movie_string = RestClient.get(movie_link)
   movie_hash = JSON.parse(movie_string)

   movie_array << movie_hash
 end

 movie_array

 # return an array of hashes, where each hash represents a movie.
end



def parse_character_movies(films_hash_array)
 # some iteration magic and puts out the movies in a nice list
 puts "***** PRESENT IN *****"
 films_hash_array.each_with_index do |film, i|
   puts "#{i+1}. #{film["title"]}"
 end
 puts "**********************"
end

def show_character_movies(character)
 films_hash_array = get_character_movies_from_api(character)
 parse_character_movies(films_hash_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
