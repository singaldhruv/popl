declare LAppend LQuickSort LFilter EagerPrint in
 
proc {EagerPrint L}
   if L.1 \= nil then
      {Browse L.1|L.2}
      {Delay 1000}
      {EagerPrint L.2}
   else {Browse L.1}
   end
end

fun lazy {LAppend A B}
   case A
   of nil then
      case B
      of nil then nil
      [] H|T then H|{LAppend A T}
      end
   [] H|T then H|{LAppend T B}
   end
end
%%Tests Lazy append
/*
local Test1 in
   Test1 = {LAppend [1 2 3] [4 5 6]}
   {EagerPrint Test1}
end
*/

%%%

fun lazy {LQuickSort Xs}
   if Xs.2 == nil then Xs.1
   else
	local Lset Rset in
	    Lset = {LFilter
		    fun {$ A} A =< Xs.1 end
		    Xs}
	    Rset = {LFilter
		    fun {$ A} A > Xs.1 end
		    Xs}
	    {LAppend {LQuickSort Lset} {LQuickSort Rset}}
	end
   end
end
fun lazy {LFilter F X}
    case X
    of nil then nil
    [] H|T then
	if {F H} then
	H|{LFilter F T}
	else
	{LFilter F T}
	end
    end
end

local Test1 in
    Test1 = {LQuickSort [2 4 3 6 1]}
end
