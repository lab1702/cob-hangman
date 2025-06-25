       IDENTIFICATION DIVISION.
       PROGRAM-ID. HANGMAN.
       AUTHOR. CLAUDE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT WORD-FILE ASSIGN TO "words.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  WORD-FILE.
       01  WORD-RECORD         PIC X(20).

       WORKING-STORAGE SECTION.
       01  WS-WORD-TABLE.
           05  WS-WORD-COUNT   PIC 99 VALUE 0.
           05  WS-WORDS OCCURS 100 TIMES.
               10  WS-WORD     PIC X(20).
       
       01  WS-GAME-DATA.
           05  WS-SELECTED-WORD    PIC X(20).
           05  WS-WORD-LENGTH      PIC 99.
           05  WS-DISPLAY-WORD     PIC X(40).
           05  WS-GUESSED-LETTERS  PIC X(26) VALUE SPACES.
           05  WS-GUESS-COUNT      PIC 99 VALUE 0.
           05  WS-WRONG-COUNT      PIC 9 VALUE 0.
           05  WS-MAX-WRONG        PIC 9 VALUE 6.
           05  WS-GAME-WON         PIC X VALUE 'N'.
           05  WS-GAME-OVER        PIC X VALUE 'N'.

       01  WS-INPUT-DATA.
           05  WS-USER-GUESS       PIC X.
           05  WS-PLAY-AGAIN       PIC X.

       01  WS-TEMP-DATA.
           05  WS-RANDOM-NUM       PIC 99.
           05  WS-SEED             PIC 9(8).
           05  WS-INDEX            PIC 99.
           05  WS-CHAR-INDEX       PIC 99.
           05  WS-FOUND-FLAG       PIC X VALUE 'N'.
           05  WS-ALREADY-GUESSED  PIC X VALUE 'N'.
           05  WS-CURRENT-CHAR     PIC X.
           05  WS-WORD-CHAR        PIC X.
           05  WS-DISPLAY-POS      PIC 99.

       01  WS-FILE-STATUS.
           05  WS-EOF              PIC X VALUE 'N'.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           PERFORM INITIALIZE-GAME
           PERFORM LOAD-WORDS
           PERFORM GAME-LOOP UNTIL WS-PLAY-AGAIN = 'N' OR 'n'
           DISPLAY "Thanks for playing!"
           STOP RUN.

       INITIALIZE-GAME.
           MOVE FUNCTION CURRENT-DATE (9:8) TO WS-SEED
           COMPUTE WS-RANDOM-NUM = FUNCTION RANDOM(WS-SEED) * 100.

       LOAD-WORDS.
           OPEN INPUT WORD-FILE
           PERFORM UNTIL WS-EOF = 'Y' OR WS-WORD-COUNT >= 100
               READ WORD-FILE
                   AT END
                       MOVE 'Y' TO WS-EOF
                   NOT AT END
                       ADD 1 TO WS-WORD-COUNT
                       MOVE WORD-RECORD TO WS-WORDS(WS-WORD-COUNT)
               END-READ
           END-PERFORM
           CLOSE WORD-FILE.

       GAME-LOOP.
           PERFORM SETUP-NEW-GAME
           PERFORM PLAY-ROUND UNTIL WS-GAME-OVER = 'Y'
           PERFORM END-GAME
           PERFORM ASK-PLAY-AGAIN.

       SETUP-NEW-GAME.
           MOVE 'N' TO WS-GAME-WON
           MOVE 'N' TO WS-GAME-OVER
           MOVE 0 TO WS-WRONG-COUNT
           MOVE 0 TO WS-GUESS-COUNT
           MOVE SPACES TO WS-GUESSED-LETTERS
           MOVE SPACES TO WS-DISPLAY-WORD
           
           COMPUTE WS-RANDOM-NUM = FUNCTION RANDOM * WS-WORD-COUNT + 1
           MOVE WS-WORDS(WS-RANDOM-NUM) TO WS-SELECTED-WORD
           
           MOVE 0 TO WS-WORD-LENGTH
           PERFORM VARYING WS-INDEX FROM 1 BY 1 
                   UNTIL WS-INDEX > 20 OR WS-SELECTED-WORD(WS-INDEX:1) = SPACE
               ADD 1 TO WS-WORD-LENGTH
           END-PERFORM
           
           PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > WS-WORD-LENGTH
               COMPUTE WS-DISPLAY-POS = (WS-INDEX - 1) * 2 + 1
               MOVE '_' TO WS-DISPLAY-WORD(WS-DISPLAY-POS:1)
               IF WS-INDEX < WS-WORD-LENGTH
                   MOVE ' ' TO WS-DISPLAY-WORD(WS-DISPLAY-POS + 1:1)
               END-IF
           END-PERFORM.

       PLAY-ROUND.
           DISPLAY " "
           PERFORM DISPLAY-HANGMAN
           DISPLAY " "
           DISPLAY "Word: " WS-DISPLAY-WORD
           DISPLAY "Guessed letters: " WS-GUESSED-LETTERS
           DISPLAY " "
           DISPLAY "Enter a letter: " WITH NO ADVANCING
           ACCEPT WS-USER-GUESS
           
           MOVE FUNCTION UPPER-CASE(WS-USER-GUESS) TO WS-USER-GUESS
           
           PERFORM CHECK-ALREADY-GUESSED
           IF WS-ALREADY-GUESSED = 'Y'
               DISPLAY "You already guessed that letter!"
           ELSE
               PERFORM PROCESS-GUESS
           END-IF
           
           PERFORM CHECK-WIN-CONDITION
           PERFORM CHECK-LOSE-CONDITION.

       CHECK-ALREADY-GUESSED.
           MOVE 'N' TO WS-ALREADY-GUESSED
           PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > 26
               IF WS-GUESSED-LETTERS(WS-INDEX:1) = WS-USER-GUESS
                   MOVE 'Y' TO WS-ALREADY-GUESSED
                   EXIT PERFORM
               END-IF
           END-PERFORM.

       PROCESS-GUESS.
           ADD 1 TO WS-GUESS-COUNT
           MOVE WS-USER-GUESS TO WS-GUESSED-LETTERS(WS-GUESS-COUNT:1)
           
           MOVE 'N' TO WS-FOUND-FLAG
           PERFORM VARYING WS-CHAR-INDEX FROM 1 BY 1 
                   UNTIL WS-CHAR-INDEX > WS-WORD-LENGTH
               MOVE WS-SELECTED-WORD(WS-CHAR-INDEX:1) TO WS-WORD-CHAR
               MOVE FUNCTION UPPER-CASE(WS-WORD-CHAR) TO WS-WORD-CHAR
               
               IF WS-WORD-CHAR = WS-USER-GUESS
                   MOVE 'Y' TO WS-FOUND-FLAG
                   COMPUTE WS-DISPLAY-POS = (WS-CHAR-INDEX - 1) * 2 + 1
                   MOVE WS-SELECTED-WORD(WS-CHAR-INDEX:1) TO 
                        WS-DISPLAY-WORD(WS-DISPLAY-POS:1)
               END-IF
           END-PERFORM
           
           IF WS-FOUND-FLAG = 'N'
               ADD 1 TO WS-WRONG-COUNT
               DISPLAY "Wrong guess!"
           ELSE
               DISPLAY "Good guess!"
           END-IF.

       CHECK-WIN-CONDITION.
           MOVE 'Y' TO WS-GAME-WON
           PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > WS-WORD-LENGTH
               COMPUTE WS-DISPLAY-POS = (WS-INDEX - 1) * 2 + 1
               IF WS-DISPLAY-WORD(WS-DISPLAY-POS:1) = '_'
                   MOVE 'N' TO WS-GAME-WON
                   EXIT PERFORM
               END-IF
           END-PERFORM
           
           IF WS-GAME-WON = 'Y'
               MOVE 'Y' TO WS-GAME-OVER
           END-IF.

       CHECK-LOSE-CONDITION.
           IF WS-WRONG-COUNT >= WS-MAX-WRONG
               MOVE 'Y' TO WS-GAME-OVER
           END-IF.

       DISPLAY-HANGMAN.
           EVALUATE WS-WRONG-COUNT
               WHEN 0
                   DISPLAY "  +---+"
                   DISPLAY "  |   |"
                   DISPLAY "      |"
                   DISPLAY "      |"
                   DISPLAY "      |"
                   DISPLAY "      |"
                   DISPLAY "========="
               WHEN 1
                   DISPLAY "  +---+"
                   DISPLAY "  |   |"
                   DISPLAY "  O   |"
                   DISPLAY "      |"
                   DISPLAY "      |"
                   DISPLAY "      |"
                   DISPLAY "========="
               WHEN 2
                   DISPLAY "  +---+"
                   DISPLAY "  |   |"
                   DISPLAY "  O   |"
                   DISPLAY "  |   |"
                   DISPLAY "      |"
                   DISPLAY "      |"
                   DISPLAY "========="
               WHEN 3
                   DISPLAY "  +---+"
                   DISPLAY "  |   |"
                   DISPLAY "  O   |"
                   DISPLAY " /|   |"
                   DISPLAY "      |"
                   DISPLAY "      |"
                   DISPLAY "========="
               WHEN 4
                   DISPLAY "  +---+"
                   DISPLAY "  |   |"
                   DISPLAY "  O   |"
                   DISPLAY " /|\  |"
                   DISPLAY "      |"
                   DISPLAY "      |"
                   DISPLAY "========="
               WHEN 5
                   DISPLAY "  +---+"
                   DISPLAY "  |   |"
                   DISPLAY "  O   |"
                   DISPLAY " /|\  |"
                   DISPLAY " /    |"
                   DISPLAY "      |"
                   DISPLAY "========="
               WHEN 6
                   DISPLAY "  +---+"
                   DISPLAY "  |   |"
                   DISPLAY "  O   |"
                   DISPLAY " /|\  |"
                   DISPLAY " / \  |"
                   DISPLAY "      |"
                   DISPLAY "========="
           END-EVALUATE.

       END-GAME.
           DISPLAY " "
           PERFORM DISPLAY-HANGMAN
           DISPLAY " "
           
           IF WS-GAME-WON = 'Y'
               DISPLAY "Congratulations! You won!"
               DISPLAY "The word was: " WS-SELECTED-WORD
           ELSE
               DISPLAY "Sorry, you lost!"
               DISPLAY "The word was: " WS-SELECTED-WORD
           END-IF.

       ASK-PLAY-AGAIN.
           DISPLAY " "
           DISPLAY "Play again? (Y/N): " WITH NO ADVANCING
           ACCEPT WS-PLAY-AGAIN.
