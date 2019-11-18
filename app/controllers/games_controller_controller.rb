require 'open-uri'

class GamesControllerController < ApplicationController
  ALPHABET = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
  def new
    @letters = []
    10.times { @letters << ALPHABET.sample }
  end

  def score
    @letters = params[:letters].downcase
    @game = params[:game].downcase
    url = "https://wagon-dictionary.herokuapp.com/#{@game}"
    content = open(url).read
    json = JSON.parse(content)
    word = json['found']
    if word == true
      if @game.chars.all? { |letter| @game.count(letter) <= @letters.count(letter) }
        @answer = "Congratulations! #{@game} is a valid english word!"
      else
        @answer = "Sorry but #{@game} can't be built out of #{@letters}..."
      end
    else
      @answer = "This word doesn't exist. Please try again."
    end
  end
end
