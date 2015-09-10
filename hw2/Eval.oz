%Global Single Assignment Store - A dictionary containing variables

\insert 'Stack.oz'
\insert 'Unify.oz'


declare Eval in
   fun {Eval Stack}
      local TopSemStmt TopStmt TopEnv NStack in
	 TopSemStmt = {TopStack Stack}
	 if TopSemStmt == nil then
	    %If the semantic stack is exhausted, do something
	    true
	 else
	    %TopSemStmt contains the top semantic statement
	    TopStmt = TopSemStmt.stmt
	    TopEnv = TopSemStmt.env
	    %Pop this off the stack
	    NStack = {PopStack Stack}

	    case TopStmt

	    %Skip. Evaluate the rest of the stack.
	    of nop then
	       {Eval NStack}

	    %Local variable introduction. Add a store variable in SAS, adjoin the new variable in the environment
	    [] localvar|ident(V)|InnerStmt then
	       %TODO: Keep bound list for closures implementation
	       local TempKey NewEnv in
		  TempKey = {AddKeyToSAS}
		  NewEnv = {Record.adjoinAt TopEnv V TempKey}
		  {Eval {PushStack NStack semstmt(stmt:InnerStmt env:NewEnv)}}
	       end

	    %Variable binding.
	       % If variable-variable binding, check if both the variables are present in the environment or not. If present, Unify them.
	       %If variable-value binding, check if the literal is valid. If yes, unify them.
	    [] bind|ident(X)|V|nil then
	       if {Value.hasFeature TopEnv X} then
		  case V
		  of ident(Y) then
		     if {Value.hasFeature TopEnv Y} then
			{Unify ident(X) ident(Y) TopEnv}
			{Eval NStack}
		     else
			raise notIntroduced(Y) end
		     end
		  [] literal(Y) then
		     {Unify ident(X) literal(Y) TopEnv}
		     {Eval NStack}
		  [] record|L|Pairs then
		     {Unify ident(X) record|L|Pairs TopEnv}
		     {Eval NStack}
		  else
		     raise invalidExpression(ident(X) V) end
		  end				  
	       else
		  raise notIntroduced(X) end
	       end
	 
	    %Compound statements, push the second statement, only when it is not nil. Always push the first statement.
	    [] S1|S2 then
	       local TempStack StackNew in
		  if S2 \= nil then
		     TempStack = {PushStack NStack semstmt(stmt:S2 env:TopEnv)}
		  else
		     TempStack = NStack
		  end
		  StackNew = {PushStack TempStack semstmt(stmt:S1 env:TopEnv)}
		  {Eval StackNew}
	       end

	    %else the statement does not match any of the given cases, hence an error
	    else false
	       
	    end
	 end
      end
   end

   
%Test for compound statements
/*local Test1 in
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
      Test3 = [localvar ident(x) [ [localvar ident(y) [bind ident(x) ident(y)] [nop] ]]]
      {Inspect {Eval [semstmt(stmt:Test3 env:env())]}}
end
*/

%Test for variable-literal binding
local Test4 Test5 in
   Test4 = [localvar ident(x) [localvar ident(y) [ [bind ident(x) literal(42)]  [bind ident(x) ident(y)] [bind ident(y) literal(42)] ]]]
   
   Test5 = [[ localvar ident(w) [ localvar ident(x) [ localvar ident(y) [ localvar ident(z) [ [bind ident(x) [record literal(testRecord) [ [literal(onlyFeature) ident(w)] ]]]  [bind ident(y) [record literal(testRecord) [ [literal(onlyFeature) ident(z)] ]]] [bind ident(z) literal(42)] [bind ident(w) literal(41)] ] ] ] ] ]]

   %Some issue with records, always evaluates to true, irrespective of the binding values. 
   {Inspect {Eval [semstmt(stmt:Test5 env:env())]}}
end

