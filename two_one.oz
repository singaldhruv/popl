local ZipWith A B in
   fun {ZipWith BinOp Xs Ys}
      case Xs
      of nil then nil
      [] Hx|Tx then
	 case Ys
	 of Hy|Ty then {BinOp Hx Hy}|{ZipWith BinOp Tx Ty}
	 end
      end
   end
   A = [1 2 3]
   B = [2 3 4]
   {Browse {ZipWith fun{$ X Y} X+Y end A B}}
end
