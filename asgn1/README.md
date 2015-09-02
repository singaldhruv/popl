CS350A (Principles of Programming Languages) - Homework 1
=========================================================

## Team Members:
* Pranav Maneriker, 12497
* Dhruv Singal, 12243
* Sanjana Garg, 13617

## Notes: 
* There are *four* files in the submission - q1.oz, q2.oz, q3taylor.oz and q3tictactoe.oz

* All the files have test cases written and commented out.

* Some particular files have input and testing instructions written near the test function calls, e.g. Taylor functions sometimes require float input.

* `Take`, `Drop` and `Merge` have straightforward functional implementation in _q1.oz_.

* We have supported some uncommon corner cases in `ZipWith` like handling lists of unequal length. The details are mentioned along with the function definition. _q2.oz_ also contains `Map` and `FoldL`.

* In _q3taylor.oz_:
   * `{Sin X}` is the lazy function outputting the Taylor series of _sin(x)_ in the form of a list. The argument _X_ is a **float** argument, e.g. `{Sin 1.0}` instead of `{Sin 1}`.
   * In `{SinUptoN X N}` , the argument _X_ is a **float** argument and the argument _N_ is an **int** argument, e.g. {SinUptoN 1.0 13}` instead of `{SinUptoN 1 13}`.
   * `{SinUptoEpsilon X Epsilon}` returns the list of the terms in the Taylor series of _sin(X)_ such that the last two terms in the list are the first terms in the series within _Epsilon_ of each other. The arguments _X_ and _Epsilon_ are both **float** arguments.

* In _q3tictactoe.oz_:
   * We assume that the board is _complete_, i.e. either _x_ has won, _o_ has won or it is a draw. The game is over at this point.
   * `{WhoWon Board}` is the _main_ function which **returns** the winner or lack thereof.
   * `{AllBoards M Board}` is the _main_ function which **returns** the list of all possible board positions resulting after _M_ makes a move in _Board_.
   * Note that we are **returning** the answer instead of **printing** it.
