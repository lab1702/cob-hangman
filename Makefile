# Makefile for COBOL Hangman Game

# Compiler
COBC = cobc

# Compiler flags
COBCFLAGS = -x -free

# Source file
SOURCE = hangman.cob

# Executable name
EXECUTABLE = hangman

# Default target
all: $(EXECUTABLE)

# Build the executable
$(EXECUTABLE): $(SOURCE)
	$(COBC) $(COBCFLAGS) -o $(EXECUTABLE) $(SOURCE)

# Run the game
run: $(EXECUTABLE)
	./$(EXECUTABLE)

# Clean build artifacts
clean:
	rm -f $(EXECUTABLE)

# Rebuild
rebuild: clean all

.PHONY: all run clean rebuild