\insert 'Stack.oz'

local S Eval in
   S = [[nop] [nop] [nop]]

   fun {Eval Stack}
      TopSemStmt = {TopStack Stack}
      TopStmt = TopSemStmt.stmt
      case TopStmt
      of nop then {Eval {PopStack Stack}}
      end
   end
   {Browse {Eval semstack(stmt:S env:Dictionary.new}}
end

   