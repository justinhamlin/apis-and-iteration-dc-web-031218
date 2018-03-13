require "json"
require "rest-client"
require 'pry'

def welcome
puts "**********************"
puts "Welcome User. You smell nice today."
end

def get_character_from_user
puts "Please enter a character:"
# use gets to capture the user's input. This method should return that input, downcased.
user_input = gets.chomp.downcase

until persons_that_exist.map(&:downcase).include?(user_input)
   puts "That is an invalid character, possible choices:"
   # iterate thru choices
   # ask again for input
   persons_that_exist.each do |person|
     puts person
   end
   puts "******************"
   puts "Please enter a character:"
   user_input = gets.chomp.downcase

 end

 user_input.downcase
end

def persons_that_exist
 # all_characters = RestClient.get('http://www.swapi.co/api/people/')

 all_characters = every_character


 characters_names_array = []

 all_characters.each do |character_hash|
   characters_names_array << character_hash["name"]
 end

 characters_names_array.sort
end
