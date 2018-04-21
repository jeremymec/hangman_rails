class Game < ApplicationRecord
  has_many :guesses

  @@wordnik_apikey = "3024754e412d1ecdfb3310b288107465e759f947a2fd612d6"

  def word_count
    self[:word].length
  end

  def random_word
    api_data = HTTP.get("http://api.wordnik.com:80/v4/words.json/randomWord?hasDictionaryDef=true&minCorpusCount=0&maxCorpusCount=-1&minDictionaryCount=20&maxDictionaryCount=-1&minLength=5&maxLength=15&api_key=" + @@wordnik_apikey)
    hash = JSON.parse api_data
    return hash["word"]
  end

  def letters_left
    letters_array = ('a'..'z').to_a

    self.guesses.each do |guess|
      letters_array.delete(guess.letter)
    end

    return letters_array
  end

  def has_guess(letter)
    self.guesses.each do |guess|
      if (letter == guess.letter)
        return true
      end
    end
    return false
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

  def grade_percentage
    (guesses_left.to_f / self[:lives].to_f).to_f * 100
  end

  def game_over
    return guesses_left < 1
  end

  def grade_letter
    case grade_percentage
    when 90..100
      return "A+"
    when 80..90
      return "A"
    when 70..80
      return "A-"
    when 60..70
      return "B+"
    when 50..60
      return "B"
    when 40..50
      return "B-"
    when 30..40
      return "C+"
    when 20..30
      return "C"
    when 10..20
      return "C-"
    when 0..10
      return "F"
    end
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

end
