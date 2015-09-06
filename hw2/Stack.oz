declare PopStack PushStack TopStack in

    fun {PopStack S}
       case S
       of nil then {Error "Tried popping empty stack"}
       [] H|T then T
       end
    end

    fun {TopStack S}
       case S
       of nil then nil
       [] H|T then H
       end
    end

    fun {PushStack S Elem}
       Elem | S
    end


