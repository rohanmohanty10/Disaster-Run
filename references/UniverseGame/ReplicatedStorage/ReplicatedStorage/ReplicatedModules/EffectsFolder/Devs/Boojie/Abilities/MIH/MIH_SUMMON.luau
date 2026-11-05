  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local u1 = PathShortcuts.ClientAssets["Made In Heaven"];
game:GetService("RunService");

return function(p2) -- Line: 8
    -- upvalues: u1 (copy), GenericModule (copy)
    local u3 = u1.Summon:Clone();
    u3.CFrame = p2.CFrame;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p2;
    WeldConstraint.Part1 = u3;
    WeldConstraint.Parent = u3;
    u3.Parent = game.Workspace.Effects;

    for _, descendant in pairs(u3:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            GenericModule.Emit(descendant);
        end;
    end;

    task.delay(1.5, function() -- Line: 25
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
end;