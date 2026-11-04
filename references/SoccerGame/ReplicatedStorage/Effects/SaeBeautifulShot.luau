  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local CFrame_new_ret = CFrame.new(-44.675, 2.999, 10.646);

local function offsetFromRoot(p1) -- Line: 14
    -- upvalues: CFrame_new_ret (copy)
    local X = p1.X;
    local Y = p1.Y;
    local Z = p1.Z;
    local v2 = X - math.abs(CFrame_new_ret.X);
    local math_abs_ret = math.abs(v2);
    local v3 = Y - math.abs(CFrame_new_ret.Y);
    local math_abs_ret2 = math.abs(v3);
    local v4 = Z - math.abs(CFrame_new_ret.Z);
    local math_abs_ret3 = math.abs(v4);

    if X < 0 then
        math_abs_ret = -math_abs_ret;
    end;

    if Y < 0 then
        math_abs_ret2 = -math_abs_ret2;
    end;

    if Z < 0 then
        math_abs_ret3 = -math_abs_ret3;
    end;

    return CFrame.new(math_abs_ret, math_abs_ret2, math_abs_ret3);
end;

return function(p5) -- Line: 28
    -- upvalues: VfxManager (copy)
    local Humrp = p5.Humrp;
    task.wait(1);
    local v6 = script.SaeShot:Clone();
    v6.CFrame = Humrp.CFrame * CFrame.new(0, -1, 0);
    v6.Parent = workspace.Debris;
    VfxManager.Emit(v6);
    task.wait(1);
    v6:Destroy();
end;