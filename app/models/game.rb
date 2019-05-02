require 'securerandom'

class Game < ApplicationRecord
  has_many :guesses

  before_create :set_slug

  @@wordnik_apikey = "3024754e412d1ecdfb3310b288107465e759f947a2fd612d6"

  def tempScore
    score = 0

    letterValue = 0
    case difficulty
    when "easy"
      letterValue = 30
    when "medium"
      letterValue = 40
    when "hard"
      letterValue = 50
    end

    if (game_won)
      score += lifeBonus = 300 - 20 * (lives)
    end

    score += (correct_guesses) * letterValue
  end

  def last_guess_correct
    self.guesses.last.is_correct(self.word)
  end

  def to_param
    slug
  end

  def word_count
    self[:word].length
  end

  def self.random_word(difficulty)
    case difficulty
    when "easy"
      minCorpusCount = "5000000"
      maxLength = "6"
    when "medium"
      minCorpusCount = "100000"
      maxLength = "10"
    when "hard"
      minCorpusCount = "500"
      maxLength = "12"     
    end

    api_data = HTTP.get("http://api.wordnik.com:80/v4/words.json/randomWord?hasDictionaryDef=true&minCorpusCount=" + minCorpusCount + "&maxCorpusCount=-1&minDictionaryCount=1&maxDictionaryCount=-1&minLength=3&maxLength=" + maxLength + "&api_key=" + @@wordnik_apikey)
    hash = JSON.parse api_data
    return hash["word"].downcase
  end

  def letter_left(letter)
    letters_array = ('a'..'z').to_a

    self.guesses.each do |guess|
      letters_array.delete(guess.letter)
    end

    return letters_array.include? letter
  end

  def has_guess(letter)
    self.guesses.each do |guess|
      if (letter == guess.letter)
        return true
      end
    end
    return false
  end

  def correct_guesses
    number = 0
    self.guesses.each do |guess|
      if (guess.is_correct(self.word))
        number = number + 1
      end
    end
    return number
  end

  def guesses_left
    lives = self[:lives]
    self.guesses.each do |guess|
      if (lives <= 0 )
        return 0
      end
      if !(guess.is_correct(self.word))
        lives = lives - 1
      end
    end
    return lives
  end

  def game_over
    return guesses_left < 1
  end

  def game_won
    self[:word].chars do |letter|
      if (!has_guess(letter))
        return false
      end
    end
    return true
  end

  def hidden_word
    display_string = ""

    if (!self[:hidden])
      self[:word].chars do |letter|
        display_string = display_string + letter + " "
      end
    else
      self[:word].chars do |letter|
        if (has_guess(letter))
          display_string = display_string + letter + " "
        else
          display_string = display_string + "_ "
        end
      end
    end

    return display_string
  end

  def hidden
    self[:hidden]
  end

  private

  def set_slug
    loop do
      self.slug = SecureRandom.urlsafe_base64(4)
      break unless Game.where(slug: slug).exists?
    end
  end

end
