local Sin SinUptoN in
   fun {Sin X}
      local SinAux in
	 fun lazy {SinAux N Term}
	    Term | {SinAux N+1.0 (~1.0*Term*X*X)/((2.0*N)*(2.0*N + 1.0))}
	 end

	 {SinAux 1.0 X}
      end
   end

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
end
