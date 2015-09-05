local S Statement in
   S = [[nop] [[nop] [nop]] [nop]]

   fun {Statement X}
      case X
      of nop then true
      [] nil then true
      [] Hs|Ts then {And {Statement Hs} {Statement Ts}}
      else false
      end
   end

   {Browse {Statement S}}
end
