 
 

return {
    bufferable = { "skill2", "skill4" },

    statemachine = function(p1, p2) -- Line: 5, Name: statemachine
        if p1.character:GetAttribute("IsCopying") and (p2:sub(1, 5) == "skill" and tonumber(p2:sub(6))) then
            return Enum.TriStateBoolean.True;
        end;

        if p2 == "skill4" then
            local v3 = false;

            for i, _ in p1.character:GetAttributes() do
                if i:sub(1, 11) == "copiedskill" then
                    v3 = true;
                    break;
                end;
            end;

            if not v3 then
                return Enum.TriStateBoolean.True;
            end;
        end;

        return Enum.TriStateBoolean.Unknown;
    end
};