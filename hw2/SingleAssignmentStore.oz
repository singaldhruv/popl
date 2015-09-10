declare SAS BindValueToKeyInSAS BindRefToKeyInSAS AddKeyToSAS RetrieveFromSAS in

SAS = {Dictionary.new}


%We know that the Key to be used in this procedure will be obtained through environment, which means that the Key must exist in the SAS
proc {BindValueToKeyInSAS Key Val}
   local CurVal in
      CurVal = {Dictionary.get SAS Key}

      if CurVal \= Val then 
	 case CurVal 
	 of equivalence(X) then {Dictionary.put SAS Key Val}
	 [] reference(X) then {BindValueToKeyInSAS X Val}
	 else raise alreadyAssigned(Key Val CurVal) end
	 end
      end
   end
end

proc {BindRefToKeyInSAS Key RefKey}
   local CurVal in
      CurVal = {Dictionary.get SAS Key}
      case CurVal
      of equivalence(_) then {Dictionary.put SAS Key reference(RefKey)}
      [] reference(X) then {BindRefToKeyInSAS X RefKey}
      else raise alreadyAssignedWhileReferencing(Key RefKey) end
      end
   end
end

fun {AddKeyToSAS}
   local Len in 
      Len = {List.length {Dictionary.keys SAS}}
      {Dictionary.put SAS Len equivalence(Len)}
      Len
   end
end

fun {RetrieveFromSAS Key}
   {Dictionary.get SAS Key} %This raises an exception, if Key is not present in the SAS
end

   

						  