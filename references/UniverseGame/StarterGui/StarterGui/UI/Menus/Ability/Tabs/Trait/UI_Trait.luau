  

 

return function(p1) -- Line: 1
    local _ = script.Parent.Assets;
    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local _ = p1.Knit;
    require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);

    if LocalPlayer then
        LocalPlayer:FindFirstChild("Data");
    end;

    local u2 = require(script.TraitUI).new(script.Parent, p1);
    p1.MenuSignal:Connect(function(p3, p4) -- Line: 13
        -- upvalues: u2 (copy), LocalPlayer (copy)
        if p3 == "MenuUpdated" and p4 == "Ability" then
            u2:Load(LocalPlayer.Data.Ability.Value);
        end;
    end);
    script.Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 19
        -- upvalues: u2 (copy), LocalPlayer (copy)
        u2:Load(LocalPlayer.Data.Ability.Value);
    end);
    LocalPlayer.Data.Ability:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 23
        -- upvalues: u2 (copy), LocalPlayer (copy)
        u2:Load(LocalPlayer.Data.Ability.Value);
    end);
    LocalPlayer.Data.Ability:GetAttributeChangedSignal("Trait"):Connect(function() -- Line: 27
        -- upvalues: u2 (copy), LocalPlayer (copy)
        u2:Load(LocalPlayer.Data.Ability.Value);
    end);
    LocalPlayer.Data.Ability:GetAttributeChangedSignal("HexedTrait"):Connect(function() -- Line: 31
        -- upvalues: u2 (copy), LocalPlayer (copy)
        u2:Load(LocalPlayer.Data.Ability.Value);
    end);
    u2:Load(LocalPlayer.Data.Ability.Value);
end;