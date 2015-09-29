%% These are some of the examples that you can test your code on.
%% Note that the keywords may be different from those you have
%% used. Make suitable changes before using these examples to test
%% your code.
%% Examples slightly adapted from that of S. Tulsiani and A. Singh,
%% Y9. 

\insert  'Eval.oz'
%%-------------- Record bind ----------------

declare Test1 Test2 Test3 Test4 Test5 Test6 Test7 Test8 Test9 Test10 Test11 Test12 Test13 Test14 Test15 in
Test1 = [localvar ident(x)
	 [localvar ident(y)
	  [localvar ident(z)
	   [[bind ident(x)
	     [record literal(label)
	      [
	      	[literal(f1) ident(y)]
	      	[literal(f2) ident(z)]
	      ]
	     ]
	     ]
	    [bind ident(x)
	     [record literal(label) [
	     [literal(f1) literal(2)]
	     [literal(f2) literal(1)]
	     	]
	     ]
	    ]
	  ]
	 ]
	]
	]


Test2 = [localvar ident(foo)
	 [localvar ident(bar)
	  [[bind ident(foo) [record literal(person) [[literal(name) ident(bar)]]]]
	   [bind ident(bar) [record literal(person) [[literal(name) ident(foo)]]]]
	   [bind ident(foo) ident(bar)]]]]

	   
Test3 = [localvar ident(foo)
	 [localvar ident(bar)
	  [[bind ident(foo) [record literal(person) [[literal(name) ident(foo)]]]]
	   [bind ident(bar) [record literal(person) [[literal(name) ident(bar)]]]]
	   [bind ident(foo) ident(bar)]]]]
	   

%%---------------- Conditional ---------------
Test4 = 
[localvar ident(x)
 [[localvar ident(y)
   [[localvar ident(x)
     [[bind ident(x) ident(y)]
      [bind ident(y) literal(t)]
      [conditional ident(y)
       [bind ident(x) literal(t)]
       [nop]
       ]
       ]
     ]
    [bind ident(x) literal(35)]]]]]

Test5 =
[localvar ident(foo)
  [localvar ident(result)
   [[bind ident(foo) literal(t)]
    [conditional ident(foo)
     [bind ident(result) literal(t)]
     [bind ident(result) literal(f)]]
    %% Check
    [bind ident(result) literal(t)]]]]

Test6 =
[localvar ident(foo)
  [localvar ident(result)
   [[bind ident(foo) literal(f)]
    [conditional ident(foo)
     [bind ident(result) literal(t)]
     [bind ident(result) literal(f)]]
    %% Check
    [bind ident(result) literal(f)]]]]

%%---------- Procedure definition and application ---------
Test7 =
[localvar ident(x)
 [[bind ident(x)
   [proced [ident(y) ident(x)] [nop]]]]
 [apply ident(x) literal(1) literal(2)]]

Test8 = 
[localvar ident(x)
 [[bind ident(x)
   [proced [ident(y) ident(x)] [nop]]
   ]
  [apply ident(x)
   literal(1)
   [record literal(label) [[literal(f1) literal(1)]]]
   ]
 ]
]

%should not be here! duh
Test9 = 
[localvar ident(foo)
 [localvar ident(bar)
  [
   [bind ident(foo) [record literal(person)
		     [
		      [literal(name) ident(foo)]
		     ]
		    ]
	   ]
	   [
    bind ident(bar) [record literal(person)
		     [
		      [literal(name) ident(bar)]
		     ]
		    ]
   ]
    [bind ident(foo) ident(bar)]
  ]
 ]
]

Test10 = 
[localvar ident(foo)
 [localvar ident(bar)
  [localvar ident(quux)
   [
    [bind ident(bar) [proced [ident(baz)]
		      [bind ident(baz) [record literal(person)
					[
					 [literal(age) ident(foo)]
					]
				       ]
		      ]
		     ]
    ]
    [apply ident(bar) ident(quux)]
    [bind ident(quux) [record literal(person)
		       [
			[literal(age) literal(40)]
		       ]
		      ]
    ]
    [bind ident(foo) literal(42) ]
   ]
  ]
 ]
]
%order changed in test10
%fails, as expected (binding 40 to 42)

Test11 = 
[localvar ident(foo)
    [localvar ident(bar)
     [localvar ident(quux)
      [[bind ident(bar) [proced [ident(baz)]
			 [bind ident(baz)
			  [record literal(person)
			   [
			    [literal(age) ident(foo)]
			   ]
			  ]
			 ]
			]
	]
       [apply ident(bar) ident(quux)]
       [bind ident(quux)
	[record literal(person)
	 [
	  [literal(age) literal(40)]
	 ]
	]
       ]
       %% We'll check whether foo has been assigned the value by
       %% raising an exception here
       [bind ident(foo) literal(42)]
      ]
     ]
    ]
]

%%------------ Pattern Match -------------------
Test12 = 
[localvar ident(x)
 [[bind ident(x)
   [record literal(label)
    [
     [literal(f1) literal(1)]
     [literal(f2) literal(2)]
    ]
   ]
  ]
  [match ident(x)
   [record literal(label)
    [
     [literal(f1) literal(1)]
     [literal(f2) literal(2)]
    ]
   ]
    [nop]
    [nop]
  ]
 ]
]

Test13 = 
[localvar ident(foo)
 [localvar ident(result)
  [
  	[bind ident(foo) 
  		[record literal(bar)
		    [
		    	[literal(baz) literal(42)]
		     	[literal(quux) literal(314)]
		 	]
		]
	]
   [match ident(foo) 
   		[record literal(bar)
		      [
		      	[literal(baz) ident(fortytwo)]
		      	[literal(quux) ident(pitimes100)]
		      ]
		]
		[bind ident(result) ident(fortytwo)] %% if matched
    	[bind ident(result) literal(314)]
    ]
    %% This will raise an exception if result is not 42
   [bind ident(result) literal(42)]
   [nop]
   ]
  ]
]




Test14 = 
[localvar ident(foo)
  [localvar ident(bar)
   [localvar ident(baz)
    [
     [bind ident(foo) ident(bar)]
     [bind ident(bar) 
     	[record literal(myRecord)
     		[ 
     			[literal(onlyField) literal(20)]
     		]
     	]
     ]
     [match ident(foo) 
    	[record literal(myRecord)
     		[ 
     			[literal(onlyField) literal(21)]
     		]
     	]
     	[bind ident(baz) literal(t)]
      	[bind ident(baz) literal(f)]
     ]
     %% Check
     [bind ident(baz) literal(f)]
     [nop]
    ]
   ]
  ]
 ]


Test15 = 
[localvar ident(foo)
  [localvar ident(bar)
   [localvar ident(baz)
    [localvar ident(result)
     [
     	[bind ident(foo) literal(person)]
      	[bind ident(bar) literal(age)]
      	[bind ident(baz) [record literal(person) 
      						[
      							[literal(age) literal(25)]
      						]
      					 ]
      	]
      	[match ident(baz) [record literal(person) 
      				[literal(age) ident(quux)]
      				]
      		[bind ident(result) ident(quux)]
       	[bind ident(result) literal(f)]
       	]
      	%% Check
      	[bind ident(result) literal(25)]]
     ]
    ]
   ]
]

{Inspect {Interpret Test9}}
