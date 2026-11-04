  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(u1) -- Line: 8
    -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy), Debris (copy)
    local u2 = ReplicatedStorage.Assets.Misc.Snowman:Clone();
    u2.Parent = u1.Char;
    u2.CFrame = u1.Char.Torso.CFrame;
    Essentials:Weld(u2, u1.Char.Torso);
    local v3 = ReplicatedStorage.Assets.Vfx.IceAnkleBreaker:Clone();
    v3.Parent = workspace;
    v3.CFrame = u2.CFrame;
    VfxManager.Emit(v3);
    Debris:AddItem(v3, 2);
    task.delay(u1.Timer, function() -- Line: 21
        -- upvalues: u2 (copy), ReplicatedStorage (ref), u1 (copy), VfxManager (ref)
        u2:Destroy();
        local u4 = ReplicatedStorage.Assets.Vfx.IceAnkleBreaker:Clone();
        u4.Parent = workspace;
        u4.CFrame = u1.Char.Torso.CFrame;
        VfxManager.Emit(u4);
        task.delay(2, function() -- Line: 28
            -- upvalues: u4 (copy)
            u4:Destroy();
        end);
    end);
    task.delay(3, function() -- Line: 33
        -- upvalues: u1 (copy)
        table.clear(u1);
    end);
end;