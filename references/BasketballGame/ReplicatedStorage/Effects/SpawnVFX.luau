 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);

return function(p1, p2) -- Line: 7
    -- upvalues: Essentials (copy), TweenService (copy), VfxManager (copy)
    local u3 = p2.Vfx:Clone();

    if p2.SpawnTo then
        u3.Anchored = false;
        u3.Parent = p2.SpawnTo;
        u3.CFrame = p2.CFrame;
        Essentials:Weld(u3, p2.SpawnTo);
    else
        u3.Parent = workspace;
        u3.Anchored = true;
        u3.CFrame = p2.CFrame;
    end;

    if p2.Color then
        for _, descendant in u3:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Color = ColorSequence.new(p2.Color);
            end;
        end;
    end;

    local v4 = u3:FindFirstAncestorWhichIsA("PointLight");

    if v4 then
        v4.Brightness = 10;
        v4.Range = 12;
        TweenService:Create(u3, TweenInfo.new(1, Enum.EasingStyle.Quad), {
            Brightness = 0,
            Range = 45
        }):Play();
    end;

    VfxManager.BetterEmit(u3);
    task.delay(10, function() -- Line: 37
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
end;