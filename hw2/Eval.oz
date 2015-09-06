declare SAS in

SAS = {Dictionary.new}

\insert 'Stack.oz'
\insert 'EnvFuncs.oz'

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
	    of nil then true
	    [] nop then {Eval NStack}
	    [] localvar|ident(V)|InnerStmt then
	       %Adjoin and push new environment
	       %TODO: Keep bound list for closures implementation
	       local NewEnv in
		  NewEnv = {AdjoinEnvV TopEnv V}
		  {Browse {Dictionary.entries NewEnv}}
		  {Eval {PushStack NStack semstmt(stmt:InnerStmt env:NewEnv)}}
	       end
	    [] bind|X|Y then
	       
	    [] S1|S2 then
	       local Stack1 StackNew in
		  if S2 \= nil then
		     Stack1 = {PushStack NStack semstmt(stmt:S2 env:TopEnv)}
		  end
		  StackNew = {PushStack Stack1 semstmt(stmt:S1 env:TopEnv)}
		  {Eval StackNew}
	       end
	       
	    end
	 end
      end
   end

   local Test1 Test2 in
      %Test1 = [[nop] [[nop] [nop]] [nop]]
      %{Inspect {Eval [semstmt(stmt:Test1 env:{Dictionary.new})]}}

      Test2 = [localvar ident(x) [localvar ident(y) [localvar ident(x) [nop]]]]
      {Inspect {Eval [semstmt(stmt:Test2 env:{Dictionary.new})]}}
   end