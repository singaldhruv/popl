\insert 'Stack.oz'


declare S Eval in

   fun {Eval Stack}
      local TopSemStmt TopStmt TopEnv in
	 TopSemStmt = {TopStack Stack}
	 if TopSemStmt == nil then
	    %If the semantic stack is exhausted, do something
	    true
	 else
	    %TopSemStmt contains the top semantic statement
	    TopStmt = TopSemStmt.stmt
	    TopEnv = TopSemStmt.env
	    
	    case TopStmt.1
	    of nop then {Eval {PopStack Stack}}
	    else
	       local PushStmtSeq in
		  fun {PushStmtSeq RemStmt PartStack}
		     case RemStmt
		     of nil then PartStack
		     [] H|T then {PushStack {PushStmtSeq T PartStack} semstmt(stmt:H env:TopEnv)}
		     end
		  end
		  {Eval {PushStmtSeq TopStmt {PopStack Stack}}}		  
	       end	  
	    end
	 end
	 
      end
   end

   S = [[nop] [nop] [nop]]
   
   {Browse {Eval [semstmt(stmt:S env:Dictionary.new)]}}
