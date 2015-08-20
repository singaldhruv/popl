local Take in
   fun {Take Xs N}
      if N=<0 then nil
      else
	 case Xs
	 of nil then nil
	 [] X|Xr then X|{Take Xr N-1}
	 end
      end
   end
   /* Tests Take*/
   {Browse {Take [1 2 3] 2} == [1 2] }
   {Browse {Take [1 2 3] 4} == [1 2 3] }
   {Browse {Take [1 2 3] 0} == nil }
end

local Length Drop DropComp in
   fun {Length Xs}
      case Xs
      of nil then 0
      [] _|Xr then 1 + {Length Xr}
      end
   end

   fun {DropComp Xs N}
      case Xs
      of nil then nil
      [] _|Xr then
	 if N > 0 then {DropComp Xr N-1}
	 elseif N == 0 then Xs
	 else nil 
	 end
      end
   end
   
   fun {Drop Xs N}
      if N =< 0 then Xs
      else { DropComp Xs ({Length Xs} - N) }
      end
   end
   
   /* Tests Drop */
   {Browse {Drop [5 1 2] 2} == [1 2] }
   {Browse {Drop [1 4] 3} == nil }
   {Browse {Drop [1 2] 0} == [1 2] }
end

local Merge in
   fun {Merge Xs Ys}
      case Xs#Ys
      of nil#nil then nil
      [] nil#Ys then Ys
      [] Xs#nil then Xs
      [] (X|Xr)#(Y|Yr) then
	 if X < Y then X|{Merge Xr Ys}
	 else Y|{Merge Xs Yr}
	 end
      end
   end
   /* Tests Merge */
   {Browse {Merge [1 2 3] [2 4]} == [1 2 2 3 4] }
   {Browse {Merge nil [1 2]} == [1 2] }
   {Browse {Merge [1 3] nil} == [1 3] }
end
