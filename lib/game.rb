# lib/game.rb

require_relative 'board'
require_relative 'player'
require 'json'

class Game
  SAVE_FILE = 'saved_games/hangman_save.json'
  DICTIONARY_PATH = 'dic.txt' 

  def initialize(saved_data = nil)
    if saved_data
      @board = Board.new(saved_data[:word])
    
      saved_data[:guessed_letters].each { |l| @board.guess_letter(l) }
     
      @player = Player.new
    else
      word = select_random_word
      @board = Board.new(word)
      @player = Player.new
    end
  end

  def start
    loop do
      system("clear") rescue nil
      puts "=== Welcome to Hangman! ==="
      puts "1. New Game"
      puts "2. Load Game"
      puts "3. Exit"
      print "Choose an option: "
      choice = gets.chomp.to_i

      case choice
      when 1
        play
        break
      when 2
        loaded_game = Game.load_game
        if loaded_game
          loaded_game.play
          break
        else
          puts "Press Enter to continue..."
          gets
        end
      when 3
        puts "Goodbye!"
        break
      else
        puts "Invalid choice. Try again."
        sleep(1)
      end
    end
  end

  def play
    until @board.game_over?
      system("clear") rescue nil
      @board.display

      print "\nEnter a letter (or type 'save' to save and exit): "
      input = @player.select_letter!(@board)

      if input == 'save'
        save_game
        return
      end

      @board.guess_letter(input)
    end

    system("clear") rescue nil
    @board.display

    if @board.won?
      puts "\n🎉 Congratulations! You guessed the word: #{@board.word.upcase}"
    else
      puts "\n💀 Game over! The secret word was: #{@board.word.upcase}"
    end

    File.delete(SAVE_FILE) if File.exist?(SAVE_FILE)
  end

  private

  def select_random_word
    unless File.exist?(DICTIONARY_PATH)
      abort("Error: The file '#{DICTIONARY_PATH}' was not found in the project root!")
    end

    words = File.readlines(DICTIONARY_PATH, chomp: true).select do |w|
      w.length.between?(5, 12)
    end

    words.sample.downcase
  end

  def save_game
    data = {
      word: @board.word,
      guessed_letters: @board.guessed_letters
    }
    
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    
    File.write(SAVE_FILE, JSON.pretty_generate(data))
    puts "\nGame successfully saved to #{SAVE_FILE}!"
  end

  def self.load_game
    unless File.exist?(SAVE_FILE)
      puts "No saved game found."
      return nil
    end

    data = JSON.parse(File.read(SAVE_FILE), symbolize_names: true)
    puts "Game loaded successfully!"
    sleep(1)
    new(data)
  rescue JSON::ParserError
    puts "Save file is corrupted."
    nil
  end
end
