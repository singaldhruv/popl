local Sin SinUptoN SinUptoEpsilon SinAux in
   fun {Sin X}
      local SinAux in
	 fun lazy {SinAux N Term}
	    Term | {SinAux N+1.0 (~1.0*Term*X*X)/((2.0*N)*(2.0*N + 1.0))}
	 end

	 {SinAux 1.0 X}
      end
   end
   
   {Browse {Sin 1.2}}

   fun {SinUptoN X N}
      local SinAux Xs = {Sin X} in
	 fun {SinAux Xs M}
	    if M>N then nil
	    else
	      (Xs.1) | {SinAux Xs.2 M+1}
	    end
	 end
	 {SinAux Xs 0}
      end
   end

   %Please note that the argument X to the function SinUptoN is a float!
   {Browse {SinUptoN 2.0 10}}

   fun {SinUptoEpsilon X Epsilon}
      local SinAux Xs = {Sin X} in
	 fun {SinAux Xs Prev}
	    if {Abs (Xs.1 - Prev)} < Epsilon then Xs.1 | nil
	    else
	      Xs.1 | {SinAux Xs.2 Xs.1}
	    end
	 end
	 Xs.1 | {SinAux Xs.2 Xs.1}
      end
   end

   %Please note that the arguments X and Epsilon to the function SinUptoEpsilon are floats!
   {Browse {SinUptoEpsilon 2.0 0.01}}
end

      

