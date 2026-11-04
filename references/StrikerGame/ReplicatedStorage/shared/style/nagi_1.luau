 
 

return {
    bufferable = { "Tspecialer" },

    statemachine = function(p1, p2) -- Line: 5, Name: statemachine
        if p2 == "skill3" and (not p1:findcooldown("skill3") and (p1.character:GetAttribute("Tackling") or p1.character:GetAttribute("run_it_back"))) then
            return Enum.TriStateBoolean.True;
        end;

        return Enum.TriStateBoolean.Unknown;
    end
};