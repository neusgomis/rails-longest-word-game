require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = ('A'..'Z').to_a.sample(9)
  end

  def score
    @letters = params[:letters]
    @answer = params[:answer].upcase
    @message = 'Empty word, try again' if @answer.blank?
    if @message.nil? && !valid_word(@answer, @letters)
      @message = "Sorry but #{@answer} cannot be built out of #{@letters}"
    elsif @message.nil? && english_word(@answer) == false
      @message = "Sorry but #{@answer} is not an English word"
    else
      @message = "Congratulations!#{@answer} is a valid English word!"
    end
  end

  def valid_word(word, letters)
    word.chars.all? { |letter| letters.include?(letter) && letters.count(letter) >= word.count(letter) }
  end

  def english_word(word)
    JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{word}").read)["found"]
  end
end
