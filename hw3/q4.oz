declare EagerPrint LazyQuickSort LazyFilter LazyAppend in

fun lazy  {LazyAppend Xs Ys}
   case Xs
   of nil then Ys
   [] X|Xr then X|{LazyAppend Xr Ys}
   end
end

fun lazy {LazyFilter Xs F}
   case Xs
   of nil then nil
   [] X|Xr then
      if {F X} then X|{LazyFilter Xr F}
      else {LazyFilter Xr F}
      end
   end
end

%{Inspect {LazyFilter [0 1 2 3 1 5] fun {$ X} X == 1 end}.2.1}

fun lazy {LazyQuickSort Xs}
   case Xs
   of nil then nil
   [] X|Xr then
      if {LazyFilter Xr fun {$ Y} Y =< X end} == nil then
	 X | {LazyQuickSort Xr}
      else
	 {LazyAppend {LazyAppend {LazyQuickSort {LazyFilter Xr fun {$ Y} Y =< X end}}  X|nil} {LazyQuickSort {LazyFilter Xr fun {$ Y} Y > X end}}}
      end
   end
end

proc {EagerPrint L}
   if L \= nil then
      {Browse L.1|L.2}
      {Delay 1000}
      {EagerPrint L.2}
   else {Browse L.1}
   end
end

{EagerPrint {LazyQuickSort [2 1 3 5 5 2]}}
