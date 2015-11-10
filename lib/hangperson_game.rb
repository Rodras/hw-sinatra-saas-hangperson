class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError if !is_admitted_letter(letter)
    letter.downcase!

    valid = (@word.include? letter)
    is_letter_already_guessed = (@guesses.include? letter)
    is_letter_already_wrong_guessed = (@wrong_guesses.include? letter)

    if valid then
      @guesses << letter if (!is_letter_already_guessed)
    else
      @wrong_guesses << letter if (!is_letter_already_wrong_guessed)
    end

    return valid && !is_letter_already_guessed && !is_letter_already_wrong_guessed
  end

  def is_admitted_letter(letter)
    letter_is_empty = (letter == '')
    letter_is_not_alphabetic = !(letter =~ /[[:alpha:]]/)
    letter_is_nil = (letter.nil?)
    !letter_is_empty && !letter_is_not_alphabetic && !letter_is_nil
  end

  def word_with_guesses
    word_result = ''

    @word.split('').each do |letter|
      if @guesses.include? letter
        word_result << letter
      else
        word_result << '-'
      end
    end

    word_result
  end

  def check_win_or_lose
    if !self.word_with_guesses.include? '-' then
      :win
    elsif @wrong_guesses.length >= 7 then
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
