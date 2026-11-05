  

 

local LocalPlayer = game.Players.LocalPlayer;

return function(p1) -- Line: 3
    -- upvalues: LocalPlayer (copy)
    local Settings = LocalPlayer:FindFirstChild("Settings");

    if not (Settings or Settings.ImpactFrame.Value) then
        return;
    end;

    local u2 = {};

    for _, child in game.Lighting:GetChildren() do
        if child:IsA("ColorCorrectionEffect") then
            u2[child] = child.Enabled;
            child.Enabled = false;
        end;
    end;

    local u3 = script.Invert:Clone();
    u3.Parent = game.Lighting;
    task.delay(p1 or 0.08, function() -- Line: 21
        -- upvalues: u3 (copy), u2 (copy)
        u3:Destroy();

        for i, v in u2 do
            if i:IsDescendantOf(game) and i.Enabled ~= v then
                i.Enabled = v;
            end;
        end;
    end);
end;