local ZipWith in
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
   
   {Browse {ZipWith Max [1 2 3] [2 1 5]} == [2 2 5] }
   {Browse {ZipWith Max nil [1 2]} == nil }
   {Browse {ZipWith Max [4 5 5] [1 6]} == [4 6] }
end

local MapFoldR in
   fun {MapFoldR Fx Xs}
      case Xs
      of nil then nil
      [] X|Xr then {FoldR X|nil
		    fun{$ X Y} {Fx X} end
		    0 } | {MapFoldR Fx Xr}
      end
   end
   local Twice in
      fun {Twice X}
	 2*X
      end
      {Browse {MapFoldR Twice [1 2 3]} == [2 4 6] }
      {Browse {MapFoldR Twice nil} == nil }
   end
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
   local Sum in
      fun {Sum X Y}
	 X + Y
      end
      /*Tests*/
      {Browse {FoldL Sum [1 2 3] 0} == 6 }
   end
end
   

		       
		       
		       
      
      
      
      