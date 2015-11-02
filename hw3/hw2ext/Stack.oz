declare PopStack PushStack TopStack AppendStack in

    fun {PopStack S}
       case S
       of nil then raise emptyStackPopAttempt end
       [] _|T then T
       end
    end

    fun {TopStack S}
       case S
       of nil then nil
       [] H|_ then H
       end
    end

    fun {PushStack S Elem}
       Elem | S
    end

    fun {AppendStack S Elems}
       {Append S Elems}
    end
   

