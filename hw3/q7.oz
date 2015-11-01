declare Barrier in

proc {Barrier ProcList}
   if ProcList == nil then skip
   else
      local StartFlag VarList GenVarList GenVar BarrierAux Flag in
	 fun {GenVar}
	    local X in
	       X
	    end
	 end

	 fun {GenVarList Xs}
	    case Xs
	    of nil then nil
	    [] _|Xr then {GenVar}|{GenVarList Xr}
	    end
	 end
	 VarList = {GenVarList ProcList} %Get a list of barrier variables
   
	 fun {BarrierAux ProcList VarList PrevVar}
	    case ProcList
	    of nil then
	       StartFlag = unit %To ensure that all threads begin execution simultaneously
	       PrevVar %Return the last barrier variable
	    [] P|_ then
	       thread
		  {Wait StartFlag} %Synchronous start
		  {P}
		  VarList.1 = PrevVar %Barrier update
	       end
	       {BarrierAux ProcList.2 VarList.2 VarList.1} %Recursive Call
	    end
	 end

	 %First Procedure
	 thread
	    {Wait StartFlag} %Synchronous start
	    {ProcList.1}
	    VarList.1=unit %Remove the first barrier
	 end
	 Flag = {BarrierAux ProcList.2 VarList.2 VarList.1} %Get the last barrier variable
	 {Wait Flag} %Wait for the last variable to exit
      end
   end
end

{Browse startMain}
local Foo Bar in
   proc {Foo}
      {Delay 500}
      {Browse foo}
      {Delay 500}
   end
   proc {Bar}
      {Delay 500}
      {Browse bar}
      {Delay 500}
   end
   {Barrier [Foo Bar Foo Bar Foo Bar]}
end

{Browse endMain}