declare Barrier GenVar in


fun {GenVar}
   local X in
      X
   end
end

proc {Barrier ProcList}
   if ProcList == nil then skip
   else
      local VarList GenVarList BarrierAux Flag in
	 fun {GenVarList Xs}
	    case Xs
	    of nil then nil
	    [] X|Xr then {GenVar}|{GenVarList Xr}
	    end
	 end
	 VarList = {GenVarList ProcList}
   
	 fun {BarrierAux ProcList VarList PrevVar}
	    case ProcList
	    of nil then PrevVar
	    [] P|Pr then
	       thread {P} VarList.1 = PrevVar end
	       {BarrierAux ProcList.2 VarList.2 VarList.1}
	    end
	 end
	 thread {ProcList.1} VarList.1=unit end
	 Flag = {BarrierAux ProcList.2 VarList.2 VarList.1}
	 {Wait Flag}
      end
   end
end




local Foo Bar in
   proc {Foo}
      {Delay 1000}
      {Browse foo}
   end
   proc {Bar}
      {Delay 1000}
      {Browse bar}
   end
   {Barrier [Foo Bar Foo Bar Foo]}
   {Browse ended}
end