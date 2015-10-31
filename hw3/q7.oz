declare Barrier in

proc {Barrier ProcList}
   for P in ProcList do
      thread {P} end
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
   {Barrier [Foo Bar]}
end