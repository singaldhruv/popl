declare NSelect S P SnF PnF in

proc {NSelect Ls}
   P = {Port.new S}
   PnF = {Port.new SnF}
   local WaitIntBound Len LastThread in
      Len = {Length Ls}
      proc {WaitIntBound Xs}
         case Xs
         of Xn1#Sn1|nil then
%	    LastThread =
	    thread 
	       {Wait {List.nth SnF Len-1}} %All Xi are false
                            %Xn1 assumed true, so not checked
	       {Sn1}
	    end
           
         [] Xi#Si|T then
            thread
               {Wait Xi}
               if {Value.isFuture S} andthen Xi then  %protect against multiple true entry
                  {Port.send P 1}
                  {Si}
 %                 {Wait LastThread}
 %                 {Thread.terminate LastThread}
               else %Xi is false, but bound
                  {Port.send PnF 1}
               end
	    end
	    {WaitIntBound T}
         end
      end

      {WaitIntBound Ls}
   end
end

local TestF1 TestF2 TestF3 TestL X X1 X2 X3 in
   proc {TestF1}
      X = 1
   end
   proc {TestF2}
      X = 2
   end
   proc {TestF3}
      X = 3
   end
   TestL = [X1#TestF1 X2#TestF2 true#TestF3]
   {Browse TestL}
   {NSelect TestL}
   {Browse X}

   /*
   {Delay 1000}
   thread X1 = false end
   {Delay 1000}
   thread X2 = false end
   */
   /* 
   {Delay 1000}
   thread X1 = false end
   {Delay 1000}
   thread X2 = true end
   */
   {Delay 1000}
   thread X1 = true end
   thread X2 = true end
end


