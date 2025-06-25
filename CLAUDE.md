# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a COBOL Hangman game implementation. The project is currently in the planning phase with no existing code.

## Development Setup

### Compiler
- Use GnuCOBOL compiler (install with `sudo apt-get install gnucobol` on Ubuntu/Debian)
- Compile COBOL programs with: `cobc -x -free <filename>.cob`

### Project Structure
- Main game logic should be implemented in a single COBOL file (e.g., `hangman.cob`)
- Word list should be stored in `words.txt` (one word per line)
- Keep ASCII art displays simple and terminal-friendly

## Key Implementation Requirements

Based on PLAN.md, the game should include:

1. **Word Management**
   - Load words from text file
   - Random word selection
   - Support for variable-length words

2. **Game Logic**
   - Single letter input validation
   - Case-insensitive letter matching
   - Track guessed letters
   - Maximum 6 incorrect guesses

3. **Display Components**
   - Word progress (e.g., "H _ N G M _ N")
   - ASCII hangman (progressive drawing)
   - Previously guessed letters
   - Game status messages

4. **Game Flow**
   - Initialize and load words
   - Select random word
   - Game loop: input → validate → update → display
   - Win/lose conditions
   - Play again option

## COBOL-Specific Considerations

- Use RANDOM function for word selection
- Handle file I/O with standard COBOL file operations
- Keep display routines modular for ASCII art
- Use appropriate data divisions for word storage
- Consider using OCCURS for arrays (word list, guessed letters)

## Testing Approach

When implementing tests:
- Test file I/O operations
- Verify random selection works
- Check input validation
- Test win/lose conditions
- Ensure display formatting is correct