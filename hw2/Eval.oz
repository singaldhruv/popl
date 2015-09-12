%Global Single Assignment Store - A dictionary containing variables

\insert 'Stack.oz'
\insert 'Unify.oz'


declare Eval Interpret in


fun {Interpret Stmt}
   {Eval [semstmt(stmt:Stmt env:env())]}
end


fun {Eval Stack}
   {Inspect {Dictionary.entries SAS}}
   {Inspect {TopStack Stack}}
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
		  [] true then
		     {Unify ident(X) true TopEnv}
		     {Eval NStack}
		  [] false then
		     {Unify ident(X) false TopEnv}
		     {Eval NStack}
		  else
		     raise invalidExpression(ident(X) V) end
		  end				  
	       else
		  raise notIntroduced(X) end
	       end

	    %Conditional. Check if ident(X) is defined or not. If defined, check if it's a boolean. If it's a boolean, operate accordingly
	       [] conditional|ident(X)|S1|S2 then
		  if {Value.hasFeature TopEnv X} then
		     case {RetrieveFromSAS TopEnv.X}
		     of equivalence(_) then
			raise conditionalOnUnbound(X) end
		     [] true then
			 {Eval {PushStack NStack semstmt(stmt:S1 env:TopEnv)}}
		     [] false then
			{Eval {PushStack NStack semstmt(stmt:S2 env:TopEnv)}}
		     else raise conditionalOnNonBool(X) end
		     end		
		  else raise notIntroduced(X) end
		  end
/*
	    %Pattern Matching.
	    [] match|ident(X)|P|S1|S2 then
	       %Check if ident(X) is bound and determined or not
	       if {Value.hasFeature TopEnv X} then
		  case {RetrieveFromSAS TopEnv.X}
		  of equivalence(_) then
		     raise matchOnUnbound(X) end
		  [] record|LabelX|PairsX then
		     %Handle record case here
		     case P
		     of record|LabelP|PairsP then
			%Check arity and process
			local CanonX CanonP in
			   CanonX = {Canonize PairsX.1}
			   CanonP = {Canonize PairsP.1}

			   local AdjoinList NewEnv in
			      AdjoinList = {List.zip CanonX CanonP
					    fun{$ XPair PPair}
					       if XPair.1 \= PPair.1 then
						  raise mismatchInFeatures(XPair.1 PPair.1) end
					       end
					       case PPair.2.1
					       of ident(PValue) then
						  [PValue XPair.2.1]
					       else raise invalidPattern(PPair) end
					       end
					    end
					   }
			      
			      NewEnv = {FoldL AdjoinList
					fun{$ Env ToAdjoin}
					   {Record.adjoinAt Env ToAdjoin.1 ToAdjoin.2.1}
					end
					TopEnv}
			      
					   
			       
			end
		     else raise matchToNonRecord(P) end
		     end
		  else raise matchOnNonRecord(X) end
		  end
	       else raise notIntroduced(X) end
	       end
	       
	       
		  */

	       
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

