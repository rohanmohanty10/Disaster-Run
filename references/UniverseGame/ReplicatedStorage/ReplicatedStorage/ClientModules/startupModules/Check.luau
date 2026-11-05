  

 

local CollectionService = game:GetService("CollectionService");

return {
    CanAttack = function(p1, p2, p3) -- Line: 5, Name: CanAttack
        -- upvalues: CollectionService (copy)
        if p1.Cooldowns:FindFirstChild(p2) then
            return false;
        end;

        if p3.CheckActive and p1.Character.Values.Active.Value ~= "" then
            return false;
        end;

        if p3.CheckStunned and CollectionService:HasTag(p1.Character, "Stunned") then
            return false;
        end;

        if p3.CheckDisabled and CollectionService:HasTag(p1.Character, "Disabled") then
            return false;
        end;

        if p3.CheckSummoned and not CollectionService:HasTag(p1.Character, "Summoned") then
            return false;
        end;

        if p3.CheckTimestop and CollectionService:HasTag(p1.Character, "Timestopped") then
            return false;
        end;

        return not p3.ExtraCheck and true or (p3.ExtraCheck(p1) and true or false);
    end
};