  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(u1) -- Line: 8
    -- upvalues: ReplicatedStorage (copy), Essentials (copy), VfxManager (copy), Debris (copy)
    local u2 = ReplicatedStorage.Assets.Misc.IceCube:Clone();
    u2.Parent = u1.Char;
    u2.CFrame = u1.Char.Torso.CFrame;
    Essentials:Weld(u2, u1.Char.Torso);
    local v3 = ReplicatedStorage.Assets.Vfx.IceAnkleBreaker:Clone();
    v3.Parent = workspace;
    v3.CFrame = u2.CFrame;
    VfxManager.Emit(v3);
    Debris:AddItem(v3, 2);
    task.delay(u1.Timer, function() -- Line: 20
        -- upvalues: u2 (copy), u1 (copy), ReplicatedStorage (ref), VfxManager (ref)
        local v4 = u2 and (u2.Parent and u2.CFrame) or u1.Char.Torso.CFrame;

        if u2 then
            u2:Destroy();
        end;

        local u5 = ReplicatedStorage.Assets.Vfx.IceAnkleBreaker:Clone();
        u5.Parent = workspace;
        u5.CFrame = v4;
        VfxManager.Emit(u5);
        task.delay(2, function() -- Line: 29
            -- upvalues: u5 (copy)
            u5:Destroy();
        end);
    end);
    task.delay(3, function() -- Line: 34
        -- upvalues: u1 (copy)
        table.clear(u1);
    end);
end;