local Merge A B in
   fun {Merge Xs Ys}
      case Xs
      of nil then Ys
      [] Hx|Tx then
	 case Ys
	 of nil then Xs
	 [] Hy|Ty then
	    if Hx < Hy
	    then
	       Hx|{Merge Tx Ys}
	    else
	       Hy|{Merge Xs Ty}
	    end
	 end
      end
   end
   A = [1 6 9]
   B = [2 4]
   {Browse {Merge A B}}
end