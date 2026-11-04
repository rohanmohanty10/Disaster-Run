 

 

return {
    bufferable = { "skill4" },

    statemachine = function(p1, p2, p3) -- Line: 7, Name: statemachine
        if p2 ~= "skill2" or (not p1.path_stack_window or p1:findcooldown("skill2")) then
            return Enum.TriStateBoolean.Unknown;
        end;

        p1.path_queued_skill2 = p3 or { "skill2" };

        return Enum.TriStateBoolean.False;
    end
};