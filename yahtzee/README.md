# Command Line Yahtzee Game in OCaml

This OCaml code implements a solitaire, command line version of the popular dice game Yahtzee. The game follows the standard rules of Yahtzee, where the player rolls five dice and tries to score points by making certain combinations.

## Gameplay

1. The game starts by rolling five dice randomly.
2. The player is then given the option to re-roll any number of dice of a particular value (e.g., re-roll three 4s).
3. After the re-roll, the player can choose to re-roll again if they have any remaining re-rolls.
4. Once the player has used up all their re-rolls or chosen not to re-roll, they must select a category to score their dice.
5. The game continues for 13 rounds, one for each category on the score card.
6. At the end of the game, the final score card is displayed, and the scores are appended to a file named "scores.txt".

## Score Card

The score card in this Yahtzee game includes the following categories:

- Ones through Sixes: Score the sum of the dice showing the corresponding number.
- Three of a Kind: Score the total of all dice if there are at least three dice showing the same number.
- Four of a Kind: Score the total of all dice if there are at least four dice showing the same number.
- Full House: Score 25 points if there are three dice showing one number and two dice showing another number.
- Small Straight: Score 30 points if there are at least four dice showing consecutive numbers.
- Large Straight: Score 40 points if all five dice show consecutive numbers.
- Chance: Score the total of all dice, regardless of category.
- Yahtzee: Score 50 points if all five dice show the same number.

The game also includes an upper section bonus, which awards 35 additional points if the total of the upper section (Ones through Sixes) is greater than 62.

## User Interface

The game is played through a command line interface. The score card is displayed after each roll, showing the categories, their corresponding scores, and the current dice values. The player selects categories and makes re-roll decisions by entering the corresponding letter or number when prompted.

The game uses the OCaml Curses library to handle the command line interface, allowing for a more interactive experience.

## Implementation Details

The game is implemented using a `game` class in OCaml. The class contains methods for handling the various aspects of gameplay, such as rolling dice, re-rolling, selecting categories, and calculating scores.

The `main_loop` method controls the flow of the game, iterating through the 13 rounds and calling the appropriate methods for each stage of a turn.

The `output_scores` method is responsible for displaying the final score card and appending the scores to the "scores.txt" file.