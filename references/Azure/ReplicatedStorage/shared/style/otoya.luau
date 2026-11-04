 

 

return {
    statemachine = function(p1, p2) -- Line: 3, Name: statemachine
        if p2 == "skill1" and (not p1:findcooldown("skill1") and p1.character:GetAttribute("stomach_book")) then
            return Enum.TriStateBoolean.True;
        end;

        return Enum.TriStateBoolean.Unknown;
    end
};