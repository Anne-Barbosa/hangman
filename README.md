# Hangman (Ruby)

A command-line implementation of the classic word-guessing game **Hangman**, built as part of **The Odin Project** Ruby curriculum. This project demonstrates clean object-oriented architecture, multi-file organization, external dictionary parsing, and game state serialization (save/load functionality).

## Features

* **Modular Architecture:** Clean separation of concerns across multiple classes (`Game`, `Board`, and `Player`) organized within a `lib/` directory.
* **External Dictionary Integration:** Automatically loads a 10,000-word dictionary file (`dictionary.txt`) and randomly selects a secret word between 5 and 12 characters long.
* **Save & Load System (JSON):** Players can type `'save'` at any point during their turn to serialize and save their current game state to a JSON file, allowing them to resume later right where they left off.
* **Dynamic ASCII Visuals & Feedback:** Displays visual hangman stages corresponding to the number of errors, tracks guessed letters, and reveals correctly guessed letter positions.
* **Input Validation:** Case-insensitive letter validation that prevents duplicate guesses and restricts inputs to valid alphabetical characters.

## Prerequisites

Make sure you have **Ruby** installed on your system. You can check your version by running:

```bash
ruby -v
```

## How to run

1. Clone or download this repository.
2. Ensure you have the dictionary.txt file placed in the root directory.
3. Open your terminal in the project directory and run the main script:

```bash
ruby main.rb
```

## Project Structure

hangman/

├── lib/

│   ├── game.rb        # Manages game flow, loops, and serialization

│   ├── board.rb       # Handles secret word, masks, and error tracking

│   └── player.rb      # Handles user input and command validation

├── saved_games/       # Directory where JSON save files are stored

├── dictionary.txt     # Word list dataset

└── main.rb            # Entry point of the application

## Built with

- Ruby (Core language)
- Object-Oriented Programming (OOP) principles (Encapsulation and Delegation)
- File I/O and JSON serialization libraries (`json`)

## Project Learnings

Building this project reinforced advanced programming concepts such as:

- Structuring multi-file Ruby applications using `require_relative`.
- Reading and filtering large external text datasets.
- Implementing persistent data storage through JSON serialization and error handling (`rescue`).


