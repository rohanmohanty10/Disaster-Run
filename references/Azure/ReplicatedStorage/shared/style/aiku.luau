 

 

return {
    statemachine = function(p1: any, p2: string) -- Line: 3, Name: statemachine
        if p2 == "skill4" and not (p1:findcooldown("skill4") or not p1.character:GetAttribute("SerpentineJump") and p1.slip_cancel == nil) then
            return Enum.TriStateBoolean.True;
        end;

        return Enum.TriStateBoolean.Unknown;
    end
};