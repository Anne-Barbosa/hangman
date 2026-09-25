class Player
    attr_reader :name

    def initialize (name = "Player")
        @name = name
    end

    def select_letter! (board)
        loop do
            print "#{@name}, choose a letter (or type 'save' to save): "
            input = gets.chomp.downcase

            # Allow the player to save the game at any time.
            return 'save' if input == 'save'

            if input.match?(/^[a-z]$/)
                if board.letter_already_guessed?(input)
                    puts "You've already tried that letter! Try another one."
                else
                    return input
                end
            else
                puts "Invalid input. Enter only one letter from a to z."
            end
        end
    end

    def to_s
        @name
    end
end 