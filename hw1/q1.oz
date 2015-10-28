
local Take A in
%DS
   fun {Take Xs N}
      if N>0
      then
	 case Xs
	 of nil then nil
	 [] A|X then A|{Take X N-1}
	 end
      else nil
      end
   end
   % Tests
   A = [1 2 3 4]
   /*{Browse {Take A ~1} == nil}
   {Browse {Take A 0} == nil}
   {Browse {Take A 1} == [1]}
   {Browse {Take A 2} == [1 2]}
   {Browse {Take A 3} == [1 2 3]}
   {Browse {Take A 4} == [1 2 3 4]}
   {Browse {Take A 5} == A}
   */
end

local Length Drop DropComp in
%PM
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
   
   /* Tests Drop 
   {Browse {Drop [5 1 2] ~2}== [1 2] }
   {Browse {Drop [1 4] 3} == nil }
   {Browse {Drop [1 2] 0} == [1 2] }*/
end

local Merge in
%PM
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
   {Browse {Merge [3 2 1] [2 4]} }
   {Browse {Merge nil [1 2]} == [1 2] }
   {Browse {Merge [1 3] nil} == [1 3] }
end

