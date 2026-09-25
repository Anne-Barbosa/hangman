class Board
    HANGMAN_STAGES = [
        # 0 errors
        %q{
        +---+
        |   |
            |
            |
            |
            |
        =========
        },
        # 1 error
        %q{
        +---+
        |   |
        O   |
            |
            |
            |
        =========
        },
        # 2 errors
        %q{
        +---+
        |   |
        O   |
        |   |
            |
            |
        =========
        },
        # 3 errors 
        %q{
        +---+
        |   |
        O   |
       /|   |
            |
            |
        =========
        },
        # 4 errors
        %q{
        +---+
        |   |
        O   |
       /|\  |
            |
            |
        =========
        },
        # 5 errors
        %q{
        +---+
        |   |
        O   |
       /|\  |
       /    |
            |
        =========
        },
        # 6 errors (game over)
        %q{
        +---+
        |   |
        O   |
       /|\  |
       / \  |
            |
        =========
        },
    ]

    attr_reader :guessed_letters, :word, :errors

    def initialize (word)
        @word = word.downcase
        @guessed_letters = []
        @errors = 0
    end

    def display
        puts HANGMAN_STAGES[@errors]
        puts "Word: " + masked_word
        puts "Letters tried: #{@guessed_letters.join(', ')}"
        puts "Errors: #{@errors}/#{HANGMAN_STAGES.size - 1}"
    end

    def letters_already_guessed?(letter)
        @guessed_letters.include?(letter)
    end

    def guessed_letter (letter)
        @guessed_letters << letter
        unless @word.include?(letter)
            @errors += 1
        end
    end

    def game_over?
        won? || lost?
    end

    def won?
        @word.chars.all? { |ch| @guessed_letters.include?(ch) }
    end

    def lost?
        @errors >= HANGMAN_STAGES.size - 1
    end

    private

    def masked_word
        @word.chars.map { |ch| @guessed_letters.include?(ch) ? ch : "_".join(" ")}
    end
end

