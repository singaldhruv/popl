CS350A (Principles of Programming Languages) - Homework 2
=========================================================

## Team Members:
* Pranav Maneriker, 12497
* Dhruv Singal, 12243
* Sanjana Garg, 13617

## Notes: 
* There are *six* files in the submission - Eval.oz, SingleAssignmentStore.oz, Stack.oz, Unify.oz, ProcessRecords.oz and Test.oz.
* Unify.oz and ProcessRecords.oz have been provided by the instructor and have been used as is, without any modifications.
* Stack.oz provides the API for stack in Oz, to be used for the semantic stack. It has the functions - TopStack, PopStack and PushStack.
* SingleAssignmentStore.oz provides the API for the single assignment store, according to the specifications given in API docs and keeping in mind the usage of various functions in Unify.oz.
* Eval.oz is the main interpreter file. 
    * A statement *Stmt* can be interpreted by calling the function `Interpret`, which returns `true` if the statement was interpreted successfully, otherwise it either returns `false` or raises an exception.
    * The function `Eval` recursively evaluates the semantic stack. It is called for the first time by the function `Interpret`, which adds an empty environment to the argument statement *Stmt*. It parses the statement at the top of the semantic stack according to the rules of the declarative sequential model of Oz, as taught in the lectures.
* Test.oz is the file containing test cases for various parts. The examples are self explanatory.


