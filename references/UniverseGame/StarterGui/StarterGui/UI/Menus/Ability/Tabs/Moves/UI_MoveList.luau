  

 

return function(p1) -- Line: 1
    local _ = script.Parent.Assets;
    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local v2 = p1.Knit.GetService("MoveService");

    if LocalPlayer then
        LocalPlayer:FindFirstChild("Data");
    end;

    local u3 = require(script.MoveListUI).new(script.Parent, p1);
    p1.MenuSignal:Connect(function(p4, p5) -- Line: 13
        -- upvalues: u3 (copy), LocalPlayer (copy)
        if p4 == "MenuUpdated" and p5 == "Ability" then
            u3:Load(LocalPlayer.Data.Ability.Value);
        end;
    end);
    script.Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 19
        -- upvalues: u3 (copy), LocalPlayer (copy)
        u3:Load(LocalPlayer.Data.Ability.Value);
    end);
    LocalPlayer.Data.Ability:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 23
        -- upvalues: u3 (copy), LocalPlayer (copy)
        u3:Load(LocalPlayer.Data.Ability.Value);
    end);
    v2.ReloadMoveUI:Connect(function() -- Line: 27
        -- upvalues: u3 (copy), LocalPlayer (copy)
        u3:Load(LocalPlayer.Data.Ability.Value);
    end);
    u3:Load(LocalPlayer.Data.Ability.Value);
end;