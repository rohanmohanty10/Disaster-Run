  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1, p2, p3) -- Line: 4
    -- upvalues: ParticleHandler (copy)
    local v4 = game:GetService("ReplicatedStorage")["Client Assets"]["Star Platinum Requiem"].traileffect:Clone();
    local v5 = ParticleHandler.GetUnusualHSVData({
        Character = p1
    });

    if v5 ~= nil then
        v4.Color = ParticleHandler.HSVShift(v4.Color, v5);
        ParticleHandler.Unusualify(v4, {
            HSVData = v5
        });
    end;

    v4.Parent = workspace.Effects;
    game:GetService("Debris"):AddItem(v4, p3);
    local v6 = 0;

    while v6 <= p3 do
        v4.CFrame = p2.CFrame;
        v6 = v6 + game:GetService("RunService").RenderStepped:Wait();
    end;
end;