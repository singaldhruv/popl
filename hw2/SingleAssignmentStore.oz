declare BindValueToKeyInSAS BindRefToKeyInSAS AddKeyToSAS RetrieveFromSAS in

proc {BindValueToKeyInSAS Key Val}
   CurVal = {Dictionary.get SAS Key}
   case CurVal 
   of equivalence(X) then {Dictionary.put SAS Key Val}
   [] reference(X) then {BindValueToKeyInSAS X Val}
   else raise alreadyAssigned(Key Val CurVal) end
   end
end

proc {BindRefToKeyInSAS Key RefKey}
   CurVal = {Dictionary.get SAS Key}
   case CurVal
   of equivalence(X) then {Dictionary.put SAS Key reference(RefKey)}
   [] reference(X) then {BindRefToKeyInSAS X RefKey}
   else skip end %when it is already bound?
   end
end

fun {AddKeyToSAS}
   Len = {List.Length {Dictionary.keys SAS}}
   {Dictionary.put SAS Len equivalence(Len)}
   Len
end

fun {RetrieveFromSAS Key}
   {Dictionary.get SAS Key} %This raises an exception. Should there be a custom exception?
end

   

						  