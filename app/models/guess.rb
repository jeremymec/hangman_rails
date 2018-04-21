class Guess < ApplicationRecord
  belongs_to :game

  def is_correct(word)
    word.chars do |letter|
      if (self.letter == letter)
        return true
      end
    end
    return false
  end

end
