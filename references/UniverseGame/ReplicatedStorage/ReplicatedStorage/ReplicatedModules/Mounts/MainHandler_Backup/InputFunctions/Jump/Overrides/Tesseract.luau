  

 

return {
    BypassJump = true,
    BypassCharge = true,
    Yield = true,

    Check = function(p1, p2) -- Line: 6, Name: Check
        if p1 and p1.State then
            return p1.State == "Idle";
        end;

        return false;
    end,

    OnJump = function(p3) -- Line: 13, Name: OnJump
        local Character = p3.Character;

        if Character and Character.Parent then
        end;
    end
};