declare Merge Scale Hamming As Bs Cs Ds in

fun lazy {Merge As Bs Cs}
   local A B C in
      A = As.1
      B = Bs.1
      C = Cs.1
      if A<B
      then %A<B
	 if A<C
	 then %A min
	    A|{Merge As.2 Bs Cs}
	 else %C =< A < B
	    if C<A
	    then %C < A < B
	       C|{Merge As Bs Cs.2}
	    else %C==A < B
	       C|{Merge As.2 Bs Cs.2}
	    end
	 end
      else %A>=B
	 if A>B
	 then %B < A
	    if B<C
	    then %B min
	       B|{Merge As Bs.2 Cs}
	    else %C <= B < A
	       if C<B
	       then %C min
		  C|{Merge As Bs Cs.2}
	       else %C == B < A
		  C|{Merge As Bs.2 Cs.2}
	       end		  
	    end
	 else %A==B
	    if A<C
	    then %A == B < C
	       A|{Merge As.2 Bs.2 Cs}
	    else % C =< B==A
	       if C<B
	       then %C < B == A
		  C|{Merge As Bs Cs.2}
	       else %C == B == A
                  C|{Merge As.2 Bs.2 Cs.2}
               end
	    end	       
	 end
      end
   end
end


fun lazy {Scale As K}
   As.1 * K | {Scale As.2 K}
end

Hamming = 1 | Ds
thread As = {Scale Hamming 2} end
thread Bs = {Scale Hamming 3} end
thread Cs = {Scale Hamming 5} end
thread Ds = {Merge As Bs Cs} end
{Browse Hamming.2.2.2.2.2.2.1}