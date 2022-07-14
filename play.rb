require './secret_word.rb'
require './game.rb'
require 'pry-byebug'

def update_board(secret_word, game)
  if game.correct_chars.sort == secret_word.chars.sort
    game.is_over = true
    puts "You figured out the secret word!"
  else
    board = Array.new(game.word_length, " __ ")
    secret_word.word.split("").each_with_index do |char, i|
      if game.correct_chars.include?(char)
        board[i] = " #{char} "
      end
    end
    print "#{board.join}\n"
  end
end

def check_guess(guess, secret_word, game, current_turn)
  if secret_word.chars.include?(guess)
    if game.correct_chars.include?(guess)
    else    
      game.correct_chars.push(guess)
    end
  end
end

def take_turn(secret_word, game, board)
  current_turn = 16 - game.turns_remaining
  puts "\n\n"
  puts "You have #{game.turns_remaining} turns left!"
  sleep 1
  puts "Showing the board..."
  sleep 1
  update_board(secret_word, game)
  puts "Guess a letter."
  guess = gets.chomp.downcase
  until guess.length == 1
    puts "Your guess must be one letter. Remember, do NOT include spaces!"
    guess = gets.chomp.downcase
  end
  puts "Your guess was #{guess}"
  sleep 1
  puts "Checking your guess..."
  sleep 1
  check_guess(guess, secret_word, game, current_turn)
  game.turns_remaining -= 1
end

def play_hangman
  puts "Welcome to hangman."
  sleep 1
  puts "The computer is finding its secret word..."
  sleep 1
  current_secret_word = Secret_Word.new
  puts "The secret word has been chosen!"
  sleep 1
  puts "Who is playing?"
  current_game = Game.new(gets.chomp, current_secret_word.word)
  board = Hash.new(Array.new(current_game.word_length, " __ "))
  sleep 1
  puts "Initializing the game..."
  sleep 1
  puts "\nGood luck, #{current_game.player}!"
  sleep 1

  while current_game.is_over == false && current_game.turns_remaining > 0
    take_turn(current_secret_word, current_game, board)
  end

  puts "The game is over."
  if current_game.is_over == true
    return "You won! The secret word was #{current_secret_word.word}."
  else 
    return "You lost. Better luck next time! The secret word was #{current_secret_word.word}."
  end
end

play_hangman()
