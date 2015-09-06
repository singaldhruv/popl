declare AdjoinEnvV in

fun {AdjoinEnvV Env V}
   %binding in the environment is to a num
   %TODO, can we append a prefix (like a letter) to Num?
   local Num in
      {Browse Env}
      Num = {Length {SAS.keys}}
      if {Env.member V} then
      %Already in the dictionary, adjoin
	 {Env.remove V}
      end
      {Env.put V (Num+1) }
   end
end

      
      