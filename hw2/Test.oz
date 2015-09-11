
\insert 'Eval.oz'

/*
%Test for compound statements
local Test1 in
     Test1 = [[[nop]] [nop]]
     {Inspect { Eval [semstmt(stmt:Test1 env:env())]}}
end
      */

%Test for localvar introduction
/*local Test2 in
     Test2 = [localvar ident(x) [localvar ident(y) [localvar ident(x) [nop]]]]
     {Inspect {Eval [semstmt(stmt:Test2 env:env())]}}
end
      */

%Test for variable-variable binding
    /*  
local Test3 in
      Test3 = [localvar ident(x) [ [localvar ident(y) [bind ident(x) ident(y)]  ]]]
      {Inspect {Eval [semstmt(stmt:Test3 env:env())]}}
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
		      [bind ident(x1) literal(1)]
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
   

   %Some issue with records, always evaluates to true, irrespective of the binding values. 
   {Inspect {Eval [semstmt(stmt:Test7 env:env())]}}
end
*/