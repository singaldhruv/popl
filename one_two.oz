local Drop A in
   fun {Drop Xs N}
      if N>0
      then
	 local Length in
	    fun {Length Xs}
	       case Xs
	       of nil then 0
	       [] _|T then 1+{Length T}
	       end
	    end

	    if N=={Length Xs}
	    then Xs
	    else
	       case Xs
	       of nil then nil
	       [] _|T then {Drop T N}
	       end
	    end
	end
      else nil
      end
   end
   A = [1 2 3 4]
   {Browse {Drop A 5}}
end