local Take Length A in
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
   A = [1 2 3 4]
   {Browse {Take A ~1}}
   {Browse {Take A 0}}
   {Browse {Take A 1}}
   {Browse {Take A 2}}
   {Browse {Take A 3}}
   {Browse {Take A 4}}
   {Browse {Take A 5}}
   
end
