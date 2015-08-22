local Map FoldR A in
   fun {FoldR Xs F I}
      case Xs
      of nil then I
      [] H|T then {F H {FoldR T F I}}
      end
   end

   fun {Map Xs F}
      {FoldR Xs fun {$ U Vs} {F U}|Vs end nil} 
   end

   A = [1 2 3]
   {Browse {Map A fun {$ X} X*X end}}
end

      