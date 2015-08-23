local FoldL A in
   fun {FoldL Xs F I}
      local FoldLAux in
	 fun {FoldLAux Rem Partial}
	    case Rem
	    of nil then Partial
	    [] H|T then {FoldLAux T {F Partial H}}
	    end
	 end
	 {FoldLAux Xs I}
      end
   end
   A = [1 2 4]
   {Browse {FoldL A fun {$ X Y} X*Y end 1}}
end
