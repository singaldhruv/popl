declare TaylorSin NextTerm Abs in

fun {Abs X}
   if X > 0 then X
   else ~X
   end
end

fun {NextTerm X N Term}
   0 - (X*X*Term)/(2*N)*(2*N+1)
end
   
fun {TaylorSin X N Term TermCond Param}
   if {TermCond X Term N Param} then Term | {TaylorSin X N+1  {NextTerm X N Term} TermCond Param}
   else nil
   end
end

local EpsCond TaylorSinEps in
   fun {EpsCond X Term N Eps}
      {Abs (Term - {NextTerm X N Term}) > Eps}
   end

   fun {TaylorSinEps X Eps} 
      {TaylorSin X 1 X EpsCond Eps}
   end

   {Browse {TaylorSinEps 1 0.01}}
end


   