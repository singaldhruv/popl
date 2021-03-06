
\insert 'Stack.oz'
\insert 'Unify.oz'


declare Eval Interpret RemoveParams ParamList BindParams ComputeClosure PutParams in


fun {Interpret Stmt}
	{Eval [semstmt(stmt:Stmt env:env())]}
end

%Implementing closures -> copy the old bindings from variables used in function except those of bound vars
fun {ComputeClosure Env Stmts EnvSoFar}
try
   local NextEnv AdjoinedEnv = {Record.adjoin Env EnvSoFar} in
      case Stmts
      of nop then EnvSoFar
      [] localvar|ident(X)|S then
	 NextEnv = {ComputeClosure Env S {Record.adjoinAt EnvSoFar X undefined}}
	 {Record.subtract NextEnv X}
      [] bind|ident(X)|V|nil then
	 	NextEnv = {Record.adjoinAt EnvSoFar X AdjoinedEnv.X}
	 case V
	 of ident(Y) then
	    {Record.adjoinAt NextEnv Y AdjoinedEnv.Y}
	 [] literal(Y) then NextEnv
	 [] record|L|Pairs then
	    local RecordVars Test in
	       fun{RecordVars Vars LocEnv}
		  case Vars
		  of [literal(X) ident(Y)]|T then 
     	 {RecordVars T {Record.adjoinAt LocEnv Y AdjoinedEnv.Y}}
		  [] H|T then {RecordVars T LocEnv}
		  [] nil then LocEnv
		  end
	       end
	       %TODO confirm (works with Pairs.1)
	      	{RecordVars Pairs.1 NextEnv}
	    end
	[] proced|Vars|S|nil then
	    local EnvInner in
	       EnvInner = {ComputeClosure {PutParams {Record.adjoin Env NextEnv} Vars} S NextEnv}
	       {RemoveParams EnvInner Vars}
	    end
	else NextEnv %literal, true, false
	end

      [] conditional|ident(X)|S1|S2 then
	 NextEnv = {Record.adjoinAt EnvSoFar X AdjoinedEnv.X }
	 local CombineEnv in
	    CombineEnv = {ComputeClosure Env S1 NextEnv}
	    {ComputeClosure Env S2 CombineEnv}
	 end
      [] match|ident(X)|P|S1|S2|nil then
	 NextEnv = {Record.adjoinAt EnvSoFar X AdjoinedEnv.X }
	 
	 local CombineEnv in
	    CombineEnv = {ComputeClosure Env S1 NextEnv}
	    {ComputeClosure Env S2 CombineEnv}
	 end
      [] apply|ident(F)|Params then
	 NextEnv = {Record.adjoinAt EnvSoFar F AdjoinedEnv.F}
	 local FuncParamsBind in
	    fun{FuncParamsBind Params BindEnv}
	       case Params
	       of ident(H)|T then 
     	 {Record.adjoinAt {FuncParamsBind T BindEnv} H AdjoinedEnv.H}
	       [] Value|T then {FuncParamsBind T BindEnv}
	       [] nil then BindEnv
	       end
	    end
	    {FuncParamsBind Params NextEnv}
	 end   
      [] S1|S2 then
	 NextEnv = {ComputeClosure Env S1 EnvSoFar}
	 {ComputeClosure Env S2 NextEnv}
      [] nil then EnvSoFar
      end
    end
 catch _ then
 	raise notIntroduced end
 end
end      

fun {RemoveParams OldEnv List}
   case List
   of ident(H)|T then {RemoveParams {Record.subtract OldEnv H} T}
   []
      nil then OldEnv
   end
end

fun {PutParams OldEnv List}
   case List
   of ident(H)|T then {PutParams {Record.adjoinAt OldEnv H undefined} T}
   [] nil then OldEnv
   else raise definitionError end
   end
end

%Bind formal to actual
fun {BindParams Actual Formal FunEnv CallEnv}
   case Actual#Formal
   of (ident(Ha)|Ta)#(ident(Hf)|Tf) then
      if {Value.hasFeature CallEnv Ha} then
	 {BindParams Ta Tf {Record.adjoinAt FunEnv Hf CallEnv.Ha} CallEnv}
      else raise notIntroduced(Ha) end
      end
   [] (X|Ta)#(ident(Hf)|Tf) then % X could be literal or record
      local TempKey NewEnv in
	 TempKey = {AddKeyToSAS}
	 NewEnv = {Record.adjoinAt FunEnv Hf TempKey}
	 {Unify ident(Hf) X NewEnv}
	 {BindParams Ta Tf NewEnv CallEnv}
      end
   [] nil#nil then FunEnv
   else raise mismatchedArgCount end
   end
end     

fun {Eval Stack}
   	{Inspect {Dictionary.entries SAS}}
   	{Inspect {TopStack Stack}}
   	local TopSemStmt TopStmt TopEnv NStack in
	TopSemStmt = {TopStack Stack}
	if TopSemStmt == nil then
	    %If the semantic stack is exhausted, do something
	    accepted
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
			     	else raise notIntroduced(Y) end
			     	end
				[] literal(Y) then
					{Unify ident(X) literal(Y) TopEnv}
					{Eval NStack}
				[] record|L|Pairs then
				   {Unify ident(X) record|L|Pairs TopEnv}
				   {Eval NStack}
				[] literal(t) then
					{Unify ident(X) literal(t) TopEnv}
					{Eval NStack}
				[] literal(f) then {Unify ident(X) literal(f) TopEnv}
				   {Eval NStack}
				[] proced|Vars|S|nil then
				   case {RetrieveFromSAS TopEnv.X}
				   of equivalence(_) then
				      local FreeEnv CopyEnv in
					 CopyEnv = {Record.adjoin env() TopEnv} %Create a copy
					 FreeEnv = {ComputeClosure {PutParams CopyEnv Vars} S env()}				 
				         %Put params for computing closure, compute closure and then remove the params
					 {BindValueToKeyInSAS TopEnv.X func(def:[proced Vars S] closure:{RemoveParams FreeEnv Vars})}
				      end
				      {Eval NStack}
				   else raise alreadyAssigned(X) end
				   end				   
				else raise invalidExpression(ident(X) V) end
		  		end				  
	    	else raise notIntroduced(X) end
	       	end

	    %Conditional. Check if ident(X) is defined or not. If defined, check if it's a boolean. If it's a boolean, operate accordingly
	    [] conditional|ident(X)|S1|S2 then
			if {Value.hasFeature TopEnv X} then
		     case {RetrieveFromSAS TopEnv.X}
		     of equivalence(_) then
			raise conditionalOnUnbound(X) end
		     [] literal(t) then
			 {Eval {PushStack NStack semstmt(stmt:S1 env:TopEnv)}}
		     [] literal(f) then
			{Eval {PushStack NStack semstmt(stmt:S2 env:TopEnv)}}
		     else raise conditionalOnNonBool(X) end
		     end		
		  else raise notIntroduced(X) end
		  end

	    %Pattern Matching.
	    [] match|ident(X)|P|S1|S2|nil then
	       %Check if ident(X) is bound and determined or not
	    	if {Value.hasFeature TopEnv X} == false then
	    		raise notIntroduced(X) end
	    	else
	    		case {RetrieveFromSAS TopEnv.X}
		  		of equivalence(_) then
		     		raise matchOnUnbound(X) end
		  		[] record|LabelX|PairsX then
		     		%Handle record case here
		     		local NewEnv in
			     		try 
			     			case P
				 			of record|!LabelX|PairsP then
				      		%Check arity and process
				      			local CanonX CanonP AdjoinList in
						 			CanonX = {Canonize PairsX.1}
						 			CanonP = {Canonize PairsP.1}

					    			AdjoinList = {List.zip CanonX CanonP
							     				fun{$ XPair PPair}
													if XPair.1 \= PPair.1 then
								   						raise mismatch(XPair.1 PPair.1) end
													end
													case PPair.2.1#XPair.2.1
								   					of ident(PValue)#equivalence(XValue) then [PValue XValue]
								   					[] ident(PValue)#Value then
								   						local TempKey in 
								   							TempKey = {AddKeyToSAS}
								   							{BindValueToKeyInSAS TempKey Value}
								   							[PValue TempKey]
								   						end
								   					else raise invalidPattern end
								   					end
												end
							 					}
				      
					    			NewEnv = {FoldL AdjoinList
						      				fun{$ Env ToAdjoin}
							 					{Record.adjoinAt Env ToAdjoin.1 ToAdjoin.2.1}
						      				end
						      				TopEnv}
						      		raise success end
					    		end
					    	else raise matchOnIllegalValue(P) end
					    	end
					    catch Error then
					    	case Error 
					    	of success then {Eval {PushStack NStack semstmt(stmt:S1 env:NewEnv)}}
					    	else {Eval {PushStack NStack semstmt(stmt:S2 env:TopEnv)}}
					    	end
			     		end
				end
				%Raise an error if X is not a record. Can also be handled by simply pushing S2. 
		  		else raise matchOnIllegalValue(X) end
		  		end
		end
		%function call
	    [] apply|ident(F)|Params then
	       if {Value.hasFeature TopEnv F} then
		  local FuncEnv in
		     case {RetrieveFromSAS TopEnv.F}
		     of func(def:proced|Vars|Stmt closure:C) then
			try FuncEnv = {BindParams Params Vars C TopEnv}
			   {Eval {PushStack NStack semstmt(stmt:Stmt env:FuncEnv)} }
			catch mismatchedArgCount then raise mismatchedArgCount(F formal#Params actual#Vars) end
			end
			
			
		     else raise notAFunction(F) end
		     end
		  end
	       else raise undefinedFunction(F) end
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

