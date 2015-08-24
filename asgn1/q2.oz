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
   %{Browse {ZipWith Max nil [1 2]} == nil }
   %{Browse {ZipWith Max [4 5 5] [1 6]} == [4 6] }
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
   {Browse {Map [1 2 3] fun {$ X} 2*X end } == [2 4 6] }
   {Browse {Map nil fun {$ X} 2*X end} == nil }
end

      
/* FoldL (func, List, Identity) -> ListItem
   Default FoldL implementation: (List, Func, Identity) -> ListItem
*/
local FoldL in
   /* Tail recursion idea */
   fun {FoldL Fx Xs I}
      case Xs
      of nil then I
      [] X|Xr then {FoldL Fx Xr {Fx I X} }
      end
   end

   /*Tests FoldL*/
   {Browse {FoldL fun {$ X Y} X+Y end [1 2 3] 0} == 6 }
   {Browse {FoldL fun {$ X Y} X*Y end [1 2 3] 1} == 6}

end
   
