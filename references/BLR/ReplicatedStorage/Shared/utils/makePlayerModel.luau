  

local LocalPlayer = game:GetService("Players").LocalPlayer;

return function(p1: boolean) -- Line: 5, Name: makePlayerModel
    -- upvalues: LocalPlayer (copy)
    local u2 = script.R6:Clone();
    u2.Parent = workspace;

    local function load() -- Line: 9
        -- upvalues: LocalPlayer (ref), u2 (copy)
        local AppliedDescription = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()).Humanoid:GetAppliedDescription();
        AppliedDescription.Shirt = 123131529989502;
        AppliedDescription.Pants = 76318455215217;
        u2.Humanoid:ApplyDescription(AppliedDescription);
    end;

    if p1 then
        task.spawn(load);

        return u2;
    end;

    local success, result = pcall(load);

    if not success then
        warn(result);
    end;

    return u2;
end;