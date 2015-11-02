
\insert 'Eval.oz'


%Test for compound statements
local Test1 in
     Test1 = [[[nop]] [nop]]
     {Inspect {Interpret Test1}}
end
      

%Test for localvar introduction
/*local Test2 in
     Test2 = [localvar ident(x) [localvar ident(y) [localvar ident(x) [nop]]]]
     {Inspect {Interpret Test2}}
end
      */

%Test for variable-variable binding
    /*  
local Test3 in
      Test3 = [localvar ident(x) [ [localvar ident(y) [bind ident(x) ident(y)]  ]]]
      {Inspect {Interpret Test3}}
end
*/

/*
%Test for variable-literal binding
local Test4 Test5 Test6 Test7 in
   
   Test4 = [localvar ident(x)
	    [localvar ident(y)
	     [
	      [bind ident(x) literal(42)]
	      [bind ident(x) ident(y)]
	      [bind ident(y) literal(41)]
	     ]
	    ]
	   ]
   
   Test5 = [
	    [ localvar ident(x1)
	      [ localvar ident(x)
		[ localvar ident(y)
		  [ localvar ident(y1)
		    [ [bind ident(x) [record literal(testRecord) [ [literal(onlyFeature) ident(x1)] ]]]
		      [bind ident(x1) literal(2)]
		      [bind ident(y) [record literal(testRecord) [ [literal(onlyFeature) ident(y1)] ]]]
		      [bind ident(y1) literal(2)]
		      [bind ident(x) ident(y)]
		    ]
		  ]
		]
	      ]
	    ]
	   ]


   Test6 = [
	    [ localvar ident(x)
	      [ localvar ident(y)
		[
		 [bind ident(x) [record literal(recordMe) [ [literal(myFirst) ident(y)] ]]]
		 [bind ident(y) [record literal(recordMe) [ [literal(myFirst) ident(x)] ]]]
		]
	      ]
	    ]
	   ]

   Test7 = [
	    [ localvar ident(x)
	      [ localvar ident(x1)
		[ localvar ident(y)
		  [ localvar ident(x11)
		    [ [bind ident(x1) ident(y)]
		      [bind ident(x) [record literal(recordForX) [ [literal(firstFeature) ident(x1)] ]]]
		      [bind ident(x1) ident(y)]
		      [bind ident(y) literal(3)] 
		      [bind ident(x11) literal(4)]
		      [bind ident(x) [record literal(recordForX) [ [literal(firstFeature) ident(x11)] ]]]
		    ]
		  ]
		]
	      ]
	    ]
	   ]
    
   {Inspect {Interpret Test5}}
end
*/
/*

%Test for condtionals
local Test8 in
   Test8 = [
	    [ localvar ident(x)
	      [ localvar ident(y)
		[
		 [bind ident(x) false]
		 [conditional ident(x)
		  [bind ident(y) literal(1)]
		  [bind ident(y) literal(0)]
		 ]
		]
	      ]
	    ]
	   ]

   {Inspect {Interpret Test8}}
end
   
	   */

/*
%Test for pattern matching
local Test9 in
   
   Test9 = [ localvar ident(x)
	     [ localvar ident(y)
	       [
		[bind ident(x) [record literal(myRecord) [ [literal(onlyFeature) ident(y)] ]]]
		[match ident(x) [record literal(myRecord) [ [literal(onlyFeature) ident(z)] ]]
		 [
		  [bind ident(z) literal(100)]
		  [bind ident(y) literal(100)]
		  %[bind ident(y) literal(200)]
		 ]
		 [bind ident(y) literal(300)]
		]
	       ]
	     ]
	   ]
   
	      
   
   {Inspect {Interpret Test9}}
end
*/

%test for variable proc bind
/*
local Test10 in
   Test10 = [localvar ident(x)
	     [localvar ident(y)
	      [
	       [bind ident(x) [proced [ident(y)] y]]
	      ]
	     ]
	    ]
	     
   {Inspect {Interpret Test10}}
end
*/

local Test11 in
   Test11 = [localvar ident(x)
	     [localvar ident(y)
	      [bind ident(x) [proced [ident(w)]
			       [bind ident(w) literal(1)]
			      ]
	      ]
	      [apply ident(x) ident(y)] 
	     ]
	    ]
  % {Inspect {Interpret Test11}}
end

local Test12 in
   Test12 = [localvar ident(x)
	     [
	      [bind ident(x) 1]
	      [threadt
	       [bind ident(x) 1]
	       endt
	      ]
	     ]
	    ]
   {Inspect {Interpret Test12}}
end

   