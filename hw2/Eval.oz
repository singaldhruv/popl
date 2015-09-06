\insert 'Stack.oz'


declare S Eval in

   fun {Eval Stack}
      {Browse Stack}
      local TopSemStmt TopStmt in
	 TopSemStmt = {TopStack Stack}
	 if TopSemStmt == nil then
	    true
	 else
	    TopStmt = TopSemStmt.stmt

	    case TopStmt
	    of [nop] then {Eval {PopStack Stack}}
	    end
	 end
	 
      end
   end

   S = [nop]
   {Browse {Eval [semstmt(stmt:S env:Dictionary.new)]}}
