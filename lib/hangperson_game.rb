class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    if letter.nil? || letter.length == 0 || (letter =~ /[[A-Za-z]]/) != 0
      raise ArgumentError
    end
    letter = letter.downcase
    valid = @word.include?letter
    if valid
      if !@guesses.include?(letter)
        @guesses << letter
      else
        false
      end
    else
      if !@wrong_guesses.include?(letter)
        @wrong_guesses << letter
      else
        false
      end
    end
  end

  def word_with_guesses
    displayed = '-' * @word.length
    word_to_modify = @word
    @guesses.split('').each do |character|
      @word.count(character).times do
        displayed [@word.index(character)] = character
        word_to_modify [@word.index(character)] = '-'
      end
    end
    displayed
  end

  def check_win_or_lose
    if !self.word_with_guesses.include? '-'
      :win
    elsif @wrong_guesses.length >= 7
      :lose
    else
      :play
    end
  end


  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
