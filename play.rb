require './secret_word.rb'
require './game.rb'
require 'pry-byebug'
require 'yaml'

def save_game(secret_word, game)
  secret_word_content = secret_word.to_yaml
  game_content = game.to_yaml
  puts "\nName the save file."
  save_file = File.open("./saves/#{gets.chomp}", "w")
  save_file.puts(secret_word_content)
  save_file.puts(game_content)
  save_file.close
  exit(true)
end

def update_board(secret_word, game)
  if game.correct_chars.sort == secret_word.chars.sort
    game.is_won = true
    puts "You figured out the secret word!"
  else
    board = Array.new(secret_word.word.length, " __ ")
    secret_word.word.split("").each_with_index do |char, i|
      if game.correct_chars.include?(char)
        board[i] = " #{char} "
      end
    end
    print "#{board.join}\n"
  end
end

def show_board(secret_word, game)
  board = Array.new(secret_word.word.length, " __ ")
    secret_word.word.split("").each_with_index do |char, i|
      if game.correct_chars.include?(char)
        board[i] = " #{char} "
      end
    end
    print "#{board.join}\n"
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
  puts "The secret word has #{secret_word.word.length} letters."
  show_board(secret_word, game)
  sleep 1
  puts "Guess a letter. Or, enter 'SAVE' to save your game and quit."
  guess = gets.chomp.downcase
  case guess
  when "save"
    save_game(secret_word, game)
  else
    until guess.length == 1
      puts "Your guess must be one letter. Remember, do NOT include spaces!"
      guess = gets.chomp.downcase
    end
  end
  puts "Your guess was #{guess}"
  sleep 1
  puts "Checking your guess..."
  sleep 1
  check_guess(guess, secret_word, game, current_turn)
  update_board(secret_word, game)
  game.turns_remaining -= 1
end

def play_hangman
  puts "Let's play hangman. Would you like to play a 'NEW' game? Or 'LOAD' a saved game?"
  state = gets.chomp.downcase
  if state == "new"
    puts "Welcome to hangman."
    sleep 1
    puts "The computer is finding its secret word..."
    sleep 1
    current_secret_word = Secret_Word.new
    puts "The secret word has been chosen!"
    sleep 1
    puts "Who is playing?"
    current_game = Game.new(gets.chomp)
    board = Hash.new(Array.new(current_secret_word.word.length, " __ "))
    sleep 1
    puts "Initializing the game..."
    sleep 1
    puts "\nGood luck, #{current_game.player}!"
    sleep 1
  elsif state == "load"
    puts "\nEnter the file name."
    loaded_file = File.open("./saves/#{gets.chomp}", "r")
    file_content = loaded_file.read
    loaded_content = YAML.load_stream(file_content)
    current_secret_word = Secret_Word.new(loaded_content[0][:word], loaded_content[0][:chars])
    current_game = Game.new(loaded_content[1][:player], loaded_content[1][:turns_remaining], loaded_content[1][:is_won], loaded_content[1][:correct_chars])
  else  
    puts "GAME STATE INPUT ERROR"
    sleep 1
    puts "RESTARTING"
    sleep 1
    play_hangman
  end
  while current_game.is_won == false && current_game.turns_remaining > 0
    take_turn(current_secret_word, current_game, board)
  end

  puts "The game is over."
  if current_game.is_won == true
    return "You won! The secret word was #{current_secret_word.word}."
  else 
    return "You lost. Better luck next time! The secret word was #{current_secret_word.word}."
  end
end

play_hangman()
