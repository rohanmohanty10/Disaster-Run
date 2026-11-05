  

 

return function(p1) -- Line: 1
    local _ = script.Parent.Assets;
    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local Knit = p1.Knit;
    Knit.GetService("LevelService");
    Knit.GetService("StatService");

    if LocalPlayer then
        LocalPlayer:FindFirstChild("Data");
    end;

    local u2 = require(script.AscensionUI).new(script.Parent, p1);
    p1.MenuSignal:Connect(function(p3, p4) -- Line: 14
        -- upvalues: u2 (copy), LocalPlayer (copy)
        if p3 == "MenuUpdated" and p4 == "Ability" then
            u2:Load(LocalPlayer.Data.Ability.Value);
        end;
    end);
    script.Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 20
        -- upvalues: u2 (copy), LocalPlayer (copy)
        u2:Load(LocalPlayer.Data.Ability.Value);
    end);
    LocalPlayer.Data.Ability:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 24
        -- upvalues: u2 (copy), LocalPlayer (copy)
        u2:Load(LocalPlayer.Data.Ability.Value);
    end);
    u2:Load(LocalPlayer.Data.Ability.Value);
end;