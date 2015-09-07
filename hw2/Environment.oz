declare AdjoinEnvV in

fun {AdjoinEnvV Env V}
   %binding in the environment is to a num
   %TODO, can we append a prefix (like a letter) to Num?
   local Num in
      Num = {List.length {Dictionary.keys SAS}} + 1
      if {Dictionary.member Env V} then
      %Already in the dictionary, adjoin
	 {Dictionary.remove Env V}
      end
      {Dictionary.put Env V Num}
      {Dictionary.put SAS Num nil }
      Env
   end
end