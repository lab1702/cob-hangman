# COBOL Hangman Game

A classic word-guessing game implemented in COBOL, demonstrating modern COBOL programming practices and file handling capabilities.

## Overview

This Hangman game is a terminal-based implementation where players guess letters to reveal a hidden word. The game features ASCII art visualization of the hangman and supports multiple rounds of play.

## Features

- Random word selection from an external word list
- Case-insensitive letter guessing
- ASCII art hangman display with progressive drawing
- Duplicate guess detection
- Configurable word list via text file
- Play again functionality
- Clean terminal-based user interface

## Requirements

- GnuCOBOL compiler (version 2.0 or higher)
- Make (for build automation)
- Unix-like operating system (Linux, macOS, WSL)

### Installing GnuCOBOL

**Ubuntu/Debian:**
```bash
sudo apt-get install gnucobol
```

**macOS (via Homebrew):**
```bash
brew install gnucobol
```

**Other systems:**
Visit the [GnuCOBOL website](https://gnucobol.sourceforge.io/) for installation instructions.

## Quick Start

1. Clone or download this repository
2. Compile the game:
   ```bash
   make
   ```
3. Run the game:
   ```bash
   make run
   ```

## How to Play

1. The game randomly selects a word from the word list
2. You see blanks representing each letter in the word
3. Guess one letter at a time
4. Correct guesses reveal the letter positions
5. Wrong guesses add body parts to the hangman
6. Win by guessing all letters before the hangman is complete
7. Lose if you make 6 wrong guesses

## Project Structure

```
cbl-hangman/
├── hangman.cob     # Main COBOL source code
├── words.txt       # Word list (one word per line)
├── Makefile        # Build automation
├── CLAUDE.md       # AI assistant guidance file
├── PLAN.md         # Original project plan
└── README.md       # This file
```

## Customization

### Adding Words

Edit `words.txt` to add your own words:
- One word per line
- Maximum 20 characters per word
- No spaces or special characters
- Case doesn't matter (internally converted to uppercase)

Example:
```
COMPUTER
PROGRAMMING
ALGORITHM
```

### Game Configuration

Currently, game parameters are hardcoded. Key values:
- Maximum wrong guesses: 6
- Maximum word length: 20 characters
- Maximum words in list: 100

## Building from Source

### Basic Commands

```bash
# Compile the game
make

# Run the game
make run

# Clean build artifacts
make clean

# Rebuild from scratch
make rebuild
```

### Manual Compilation

If you prefer not to use Make:
```bash
cobc -x -free -o hangman hangman.cob
./hangman
```

## Technical Details

### Implementation

- **Language**: COBOL (COBOL-85 standard with GnuCOBOL extensions)
- **File I/O**: Sequential file access for word list
- **Random Numbers**: Uses COBOL's FUNCTION RANDOM with time-based seed
- **Data Structures**: Arrays for word storage and character tracking

### Code Organization

The program follows standard COBOL structure:
- **IDENTIFICATION DIVISION**: Program metadata
- **ENVIRONMENT DIVISION**: File associations
- **DATA DIVISION**: Variable declarations and file descriptions
- **PROCEDURE DIVISION**: Main logic organized into paragraphs

Key procedures:
- `LOAD-WORDS`: Reads word list from file
- `GAME-LOOP`: Main game control flow
- `PROCESS-GUESS`: Validates and processes letter guesses
- `DISPLAY-HANGMAN`: Renders ASCII art based on wrong count

## Known Limitations

1. **Fixed Array Sizes**: Maximum 100 words of 20 characters each
2. **Basic Error Handling**: Limited file error recovery
3. **No Difficulty Levels**: All words treated equally
4. **Single Word List**: No category selection
5. **No Score Tracking**: Games are independent

## Future Enhancements

- [ ] Add input validation for non-alphabetic characters
- [ ] Implement file error handling with DECLARATIVES
- [ ] Add difficulty levels based on word length
- [ ] Create word categories (animals, countries, etc.)
- [ ] Add score tracking across sessions
- [ ] Implement hints system
- [ ] Add colored output support
- [ ] Create unit tests

## Contributing

This is an educational project demonstrating COBOL programming. Contributions that improve code quality, add features, or enhance documentation are welcome.

### Code Style

- Use meaningful variable names with appropriate prefixes
- Keep procedures focused on single responsibilities
- Comment complex logic
- Maintain consistent indentation
- Follow COBOL-85 standards where possible

## License

This project is provided as-is for educational purposes. Feel free to use, modify, and distribute as needed.

## Acknowledgments

- Built with GnuCOBOL, the free COBOL compiler
- Inspired by the classic Hangman word game
- Created as a demonstration of modern COBOL capabilities

## Troubleshooting

### Common Issues

1. **"cobc: command not found"**
   - Install GnuCOBOL using the instructions above

2. **"words.txt not found"**
   - Ensure words.txt is in the same directory as the executable
   - Check file permissions

3. **Compilation warnings**
   - The "_FORTIFY_SOURCE" warning is harmless and can be ignored
   - Missing newline warnings have been addressed

4. **Game crashes on start**
   - Verify words.txt exists and contains at least one valid word
   - Check that words are 20 characters or less

## Contact

For questions or suggestions, please open an issue in the project repository.