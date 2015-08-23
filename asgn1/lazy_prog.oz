declare TaylorSin NextTerm NCond TaylorSinN EpsCond TaylorSinEps in

fun {NextTerm X N Term}
   X*X*Term/{Int.toFloat (2*N)*(2*N+1) }
end

/* For testing, consider removing the lazy declaration */

fun lazy {TaylorSin X N Term TermCond Param}
   if {TermCond X Term N Param} then Term | {TaylorSin X N+1  {NextTerm X N Term} TermCond Param}
   else nil
   end
end

fun {NCond X Term NTaylor N}
   NTaylor =< N
end

fun {TaylorSinN X N} 
   {TaylorSin X 1 X NCond N}
end

{Browse {TaylorSinN 0.5 4}}


fun {EpsCond X Term N Eps}
   {Abs Term - {NextTerm X N Term}} > Eps
end

fun {TaylorSinEps X Eps} 
   {TaylorSin X 1 X EpsCond Eps}
end

{Browse {TaylorSinEps 0.5 0.00001}}
