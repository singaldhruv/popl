
CS350A (Principles of Programming Languages) - Homework 3
=========================================================

## Team Members:
* Pranav Maneriker, 12497
* Dhruv Singal, 12243

## Notes: 
* There are *seven* files in the submission - Eval.oz, SingleAssignmentStore.oz, Stack.oz, Unify.oz, ProcessRecords.oz, Test.oz and examples.oz.
* Unify.oz and ProcessRecords.oz have been provided by the instructor and have been used as is, without any modifications.
* Stack.oz provides the API for stack in Oz, to be used for the semantic stack. It has the functions - TopStack, PopStack and PushStack.
* SingleAssignmentStore.oz provides the API for the single assignment store, according to the specifications given in API docs and keeping in mind the usage of various functions in Unify.oz.
* Eval.oz is the main interpreter file. 
    * A statement *Stmt* can be interpreted by calling the function `Interpret`, which returns `true` if the statement was interpreted successfully, otherwise it either returns `false` or raises an exception.
    * The function `Eval` recursively evaluates the semantic stack. It is called for the first time by the function `Interpret`, which adds an empty environment to the argument statement *Stmt*. It parses the statement at the top of the semantic stack according to the rules of the declarative sequential model of Oz, as taught in the lectures.
* Test.oz is the file containing test cases for various parts. The examples are self explanatory.
* examples.oz is the file containing the test cases adapted from the sample test cases provided by the instructor.
* There are some important details, all of which are in accordance with the semantics of the kernel language:
    - We are not supporting pattern matching in records, where the pattern record has values instead of variables as feature values. 
    - The case [bind value ident(X)] is not supported and [bind ident(X) value] is supported.
    - Booleans for conditionals are supported by using `literal(t)` and `literal(f)` as reserved keywords.
    - Procedure definitions must have variables as formal parameters.
* Computation of closure is done by  function `ComputeClosure` according to the rules specific to each type of statement.
* Full functionality of pattern matching is supported for records.
* Multithreading support

