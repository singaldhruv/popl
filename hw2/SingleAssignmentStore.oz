declare SAS BindValueToKeyInSAS BindRefToKeyInSAS AddKeyToSAS RetrieveFromSAS BindFuncToKeyInSAS in

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

%check for proc with short circuiting added
proc {BindFuncToKeyInSAS Key Func}
   local CurVal in
      CurVal = {Dictionary.get SAS Key}
	case CurVal 
	of equivalence(X) then {Dictionary.put SAS Key Func}
	%[] reference(X) then {BindValueToKeyInSAS X Val}
	else raise alreadyAssigned(Key Func CurVal) end
	end
   end
end

proc {BindRefToKeyInSAS Key RefKey}
   if Key \= RefKey then
      {Dictionary.put SAS Key reference(RefKey)}
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
   local TempValue in
      TempValue = {Dictionary.get SAS Key}  %This raises an exception, if Key is not present in the SAS
      
      case TempValue
      of reference(X) then
	    {RetrieveFromSAS X}
      else TempValue
      end
   end
end

   

						  
