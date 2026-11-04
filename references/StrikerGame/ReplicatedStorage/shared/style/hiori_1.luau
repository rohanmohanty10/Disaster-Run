 
 

return {
    statemachine = function(p1: any, p2: string) -- Line: 3, Name: statemachine
        if p2 == "skill3" then
            return Enum.TriStateBoolean.True;
        end;

        return Enum.TriStateBoolean.Unknown;
    end
};