declare Xs Ys AverageStream GenRandom in

fun {GenRandom}
   {Int.toFloat {OS.rand}} | {GenRandom}
end

fun {AverageStream Xs Ys N}
   (Xs.1)/(N+1.0) + Ys.1*N/(N+1.0) | {AverageStream Xs.2 Ys.2 N+1.0}
end

thread Xs = {GenRandom} end
thread Ys =  Xs.1 | {AverageStream Xs.2 Ys 1.0} end
thread {Inspect Ys} end