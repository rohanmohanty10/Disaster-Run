  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1, p2) -- Line: 5
    -- upvalues: ParticleHandler (copy)
    if not p1.HumanoidRootPart then
        return nil;
    end;

    local v3 = game:GetService("ReplicatedStorage")["Client Assets"]["Star Platinum Requiem"].Explosion:Clone();
    ParticleHandler.Unusualify(v3, {
        HSVData = p2
    });
    v3.Parent = workspace.Effects;
    v3.CFrame = p1.HumanoidRootPart.CFrame;
    local v4 = 0;

    for _, child in pairs(v3.Attachment:GetChildren()) do
        if v4 < child.Lifetime.Max then
            v4 = child.Lifetime.Max or v4;
        end;

        child.Enabled = true;
        task.spawn(function() -- Line: 15
            -- upvalues: child (copy)
            task.wait(0.05);
            child.Enabled = false;
        end);
    end;

    game:GetService("Debris"):AddItem(v3, v4 + 0.1);
end;