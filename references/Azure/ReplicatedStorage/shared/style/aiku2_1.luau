 
 

return {
    statemachine = function(p1: any, p2: string) -- Line: 3, Name: statemachine
        if p2 == "skill4" and (not p1:findcooldown("skill4") and p1.slip_cancel ~= nil) then
            return Enum.TriStateBoolean.True;
        end;

        return Enum.TriStateBoolean.Unknown;
    end
};