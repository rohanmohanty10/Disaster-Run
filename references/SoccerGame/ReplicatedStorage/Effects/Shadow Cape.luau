  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(u1) -- Line: 8
    -- upvalues: ReplicatedStorage (copy), VfxManager (copy), Debris (copy)
    local u2 = ReplicatedStorage.Assets.Auras.Trap.Activate:Clone();
    u2.Emit2.CFrame = CFrame.new(0, 0, 0);
    u2.Parent = workspace;
    u2.CFrame = u1.Char.Torso.CFrame;
    u2.Anchored = true;

    for _, descendant in u2:GetDescendants() do
        if descendant:IsA("ParticleEmitter") ~= false then
            descendant.Color = ColorSequence.new(Color3.new(0.113725, 0.109804, 0.105882));
        end;
    end;

    VfxManager.Emit(u2);
    Debris:AddItem(u2, 2);
    task.delay(u1.Timer, function() -- Line: 23
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
    task.delay(3, function() -- Line: 27
        -- upvalues: u1 (copy)
        table.clear(u1);
    end);
end;