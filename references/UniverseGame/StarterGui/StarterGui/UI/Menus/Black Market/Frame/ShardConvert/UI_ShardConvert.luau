  

 

return function(p1) -- Line: 1
    local _ = script.Parent;
    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local _ = p1.Knit;
    local u2 = require(script.ShardConvertUI).new(script.Parent, p1);
    script.Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 10
        -- upvalues: u2 (copy), LocalPlayer (copy)
        u2:Load(LocalPlayer.Data.Ability.Value);
    end);
    script.Parent.Parent.Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 14
        -- upvalues: u2 (copy), LocalPlayer (copy)
        u2:Load(LocalPlayer.Data.Ability.Value);
    end);
    LocalPlayer.Data.Ability:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 18
        -- upvalues: u2 (copy), LocalPlayer (copy)
        u2:Load(LocalPlayer.Data.Ability.Value);
    end);
    u2:Load(LocalPlayer.Data.Ability.Value);
end;