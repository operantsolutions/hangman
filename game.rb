require 'yaml'

class Game
  attr_accessor :player, :turns_remaining, :is_won, :correct_chars

  def initialize(player, turns_remaining="new", is_won="new", correct_chars="new")
    if turns_remaining == "new" || is_won == "new" || is_won == "new" || correct_chars == "new"
      self.player = player
      self.turns_remaining = 15
      self.is_won = false
      self.correct_chars = []
    else
      self.player = player
      self.turns_remaining = turns_remaining
      self.is_won = is_won
      self.correct_chars = correct_chars
    end
  end

  def to_yaml
    YAML.dump({
      :turns_remaining => self.turns_remaining,
      :is_won => self.is_won,
      :player => self.player,
      :correct_chars => self.correct_chars
    })

  end

end