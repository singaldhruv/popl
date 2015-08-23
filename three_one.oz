local Sin in
   fun {Sin X}
      local SinAux in
	 fun lazy {SinAux N Term}
	    Term | {SinAux N+1.0 (~1.0*Term*X*X)/((2.0*N)*(2.0*N + 1.0))}
	 end

	 {SinAux 1.0 X}
      end
   end
   
   {Browse {Sin 1.2}}
end

      