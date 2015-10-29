declare LazyAppend in

fun lazy {LazyAppend Xs Ys}
   case Xs
   of nil then Ys
   [] X|Xr then X|{LazyAppend Xr Ys}
   end
end

{Browse {LazyAppend [0 1 2] [3 4 5]}.2.2.2.2.2.1}