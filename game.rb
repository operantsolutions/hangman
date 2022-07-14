class Game
  attr_accessor :turns_remaining, :is_over, :player, :word_length, :correct_chars

  def initialize(player, secret_word)
    self.player = player
    self.turns_remaining = 15
    self.is_over = false
    self.word_length = secret_word.length
    self.correct_chars = []
  end

end