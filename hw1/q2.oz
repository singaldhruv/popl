local ZipWith in
%PM
   /**
   * Edge case behaviour:
   * Lists of unequal length: ZipWith returns a list with length of the shorter list 
   **/
   fun {ZipWith BinOp Xs Ys}
      case Xs#Ys
      of nil#nil then nil
      [] _#nil then nil
      [] nil#_ then nil
      [] (X|Xr)#(Y|Yr) then {BinOp X Y}|{ZipWith BinOp Xr Yr}
      end
   end
   /*
    *Tests Zipwith
    *Library BinOp: Max
   */
   
   %{Browse {ZipWith Max [1 2 3] [2 1 5]} == [2 2 5] }
   %{Browse {ZipWith fun {$ A B} A+B end  nil [1 2]} == nil }
   %{Browse {ZipWith fun {$ A B} A*B end  [4 5 5] [1 6]} == [4 30] }
end

local Map FoldR in
%DS
   fun {FoldR Xs F I}
      case Xs
      of nil then I
      [] H|T then {F H {FoldR T F I}}
      end
   end

   fun {Map Xs F}
      {FoldR Xs fun {$ U Vs} {F U}|Vs end nil} 
   end

   %Tests Map
   %{Browse {Map [1 2 3] fun {$ X} 2*X end } == [2 4 6] }
   %{Browse {Map nil fun {$ X} X*X end} == nil }
end

    
local FoldL in
   /* Tail recursion idea */
   fun {FoldL Xs Fx I}
      case Xs
      of nil then I
      [] X|Xr then {FoldL Xr Fx {Fx I X} }
      end
   end

   /*Tests FoldL*/
   %{Browse {FoldL [1 2 3] fun {$ X Y} X+Y end 0} == 6 }
   %{Browse {FoldL [1 2 3] fun {$ X Y} X*Y end 1} == 6}

end
   
