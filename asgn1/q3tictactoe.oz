local WhoWon Won WonRow WonCol WonDiag RowSame ColSame Nth WonLeadD BoardRev in

   fun {Nth N List}
      if N == 1 then List.1
      else {Nth N-1 List.2}
      end
   end
   
   fun {RowSame M Row}
      case Row
      of nil then true
      [] X|Xr then {And (X==M) {RowSame M Xr}}
      end
   end
      
   fun {WonRow M Board}
      case Board
      of nil then false
      [] X|Xr then {Or {RowSame M X} {WonRow M Xr}}
      end
   end

   fun {ColSame Col M Board}
      case Board
      of nil then true
      [] X|Xr then {And {Nth Col X} == M {ColSame Col M Xr}}
      end
   end
   

   fun {WonCol M Board}
      {Or {ColSame 1 M Board} {Or {ColSame 2 M Board} {ColSame 3 M Board}}}
   end

   fun {WonLeadD Elem M Board}
      case Board
      of nil then true
      [] X|Xs then {And {Nth Elem X} == M {WonLeadD Elem+1 M Xs} }
      end
   end
   /* can be improved */
   fun {BoardRev Board}
      case Board
      of nil then nil
      [] X|Xs then {Reverse X}|{BoardRev Xs}
      end
   end
   
   fun {WonDiag M Board}
      {Or {WonLeadD 1 M Board} {WonLeadD 1 M {BoardRev Board} } }
   end
   
   fun {Won M Board}
      {Or {WonRow M Board} {Or {WonCol M Board} {WonDiag M Board} } } 
   end
   
   fun {WhoWon Board}
      if {Won x Board}
      then x
      elseif {Won o Board}
      then o
      else draw
      end
   end
   
   /* tests */

   local TestB1 TestB2 in
      /*
      x x o
      x o o
      o o x
      */
      TestB1 = [ [x x o] [x o o] [o o x] ]
      /*
      o x o
      x x x
      o o x
      */
      TestB2 = [[o x o] [x x x] [o o x]]
      %{Browse {WhoWon TestB1} == o}
      %{Browse {WhoWon TestB2} == x}
   end
end

local AllBoards RepS RepsAux Cross1 Cross2 Cross3 in
   %CrossN is the function returning all lists in the cartesian product of the set of lists in the Nth position with the rest of the lists.
   fun {Cross1 Xs Y Z}
      case Xs
      of nil then nil
      [] X|Xr then [X Y Z]|{Cross1 Xr Y Z}
      end
   end

   fun {Cross2 X Ys Z}
      case Ys
      of nil then nil
      [] Y|Yr then [X Y Z]|{Cross2 X Yr Z}
      end
   end

   fun {Cross3 X Y Zs}
      case Zs
      of nil then nil
      [] Z|Zr then [X Y Z]|{Cross3 X Y Zr}
      end
   end
   
   fun {RepsAux M Xl Xr SoFar}
	    case Xr
	    of nil then SoFar
	    [] X|Xrnew then
	       if X == s then {RepsAux M {Append Xl [X]} Xrnew {Append Xl M|Xrnew}|SoFar}
	       else {RepsAux M {Append Xl [X]} Xrnew SoFar}
	       end
	    end
   end

   fun {RepS M Xs}
	 {RepsAux M nil Xs nil}
   end
	 
   fun {AllBoards M Board}
      case Board
      of X|Xr then
	 case Xr
	 of Y|Z then
	    {Append {Append {Cross1 {RepS M X} Y Z.1} {Cross2 X {RepS M Y} Z.1}} {Cross3 X Y {RepS M Z.1}} }
	 end
      end
   end
   %Tests TicTacToe
   local TestB1 TestB2 in
      /*
      o o s
      x o x
      x o s
      */
      TestB1 = [[o o s] [x o x] [x o s]]
      /*
      o s s
      x s o
      x o x
      */
      TestB2 = [[o s s] [x s o] [x o x]]
      
      %{Browse {AllBoards o TestB1} }
      %{Browse {AllBoards x TestB2}}
   end
end


      