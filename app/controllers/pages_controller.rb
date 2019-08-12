require "json"
require 'open-uri'


class PagesController < ApplicationController



  def new
    @letters = generate_grid()
  end

  def old
    @word = params[:word]
    @letters = params[:letters]
    puts @letters
    # check if the word uses at most 1 & if
    freq_attempt = char_frequencies(@word)
    # freq_grid ={}
    freq_grid = char_frequencies(@letters.gsub(/\s+/, ""))
    freq = freq_attempt == freq_grid ? true : false
    # check if it is a word
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    # user = URI.parse(url)
    valid = user[:found]
    length = user[:length]

    if freq == false
      @output = "Sorry #{@word.upcase} Cant be built out of #{@letters.split(" ")}"
    elsif valid == false
      @output = "Sorry #{@word.upcase} does not seem to be a valid English word"
    else
      @output = "Congratulations, #{@word.upcase} is a beauitful word & you score #{length} points"
    end

  end

  def generate_grid()
  # TODO: generate random grid of letters
    grip = []
    i = 1
      while i <= 10
        grip << ('A'..'Z').to_a.sample
        i += 1
      end
    grip
  end

  def char_frequencies(a_string)
    normalized_string(a_string).chars.reduce(Hash.new(0)) do |hash, char|
      hash[char] += 1
      hash
    end
  end

  def normalized_string(string)
    string.gsub(/\W/, "").downcase # \W => standing for any non-word character
  end

end
