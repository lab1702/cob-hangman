# COBOL Hangman
This is a simple COBOL program that implements a Hangman game. The user will guess letters to try to figure out a hidden word.

## Features
- Randomly selects a word from a predefined list.
- Allows the user to guess letters.
- Displays the current state of the word with guessed letters and an ASCII art representation of the hangman.
- Tracks the number of incorrect guesses.
- Ends the game when the word is fully guessed or when the maximum number of incorrect guesses is reached.

## Requirements
- COBOL compiler (e.g., GnuCOBOL)
- Basic understanding of COBOL syntax and structure.
- A terminal or command line interface to run the program.

## Game Flow
1. Load the list of predefined words from a text file, one word per line.
2. Initialize the game by selecting a random word from a predefined list.
3. Display the current state of the word with underscores for unguessed letters.
4. Prompt the user to guess a letter.
5. Check if the guessed letter is in the word.
6. If the letter is correct, update the displayed word.
7. If the letter is incorrect, increment the incorrect guess counter.
8. Repeat steps 2-6 until the word is fully guessed or the maximum number of incorrect guesses is reached.
9. Display the final result (win or lose) and the correct word.

## Example Word List
- COBOL
- HANGMAN
- PROGRAMMING
- COMPUTER
- LANGUAGE

## Implementation Steps
1. Define the word list as a data structure.
2. Load the word list from a text file.
3. Create a function to select a random word from the list.
4. Implement the main game loop to handle user input and game logic.
5. Display the current state of the word and the number of incorrect guesses.
6. Handle end-of-game conditions and display the final result.

## Testing
- Test with various words to ensure the game logic works correctly.
- Test with different user inputs to ensure robustness.
- Ensure the game handles edge cases, such as repeated guesses or invalid input.
