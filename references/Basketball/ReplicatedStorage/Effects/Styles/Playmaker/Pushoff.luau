 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(p1, u2) -- Line: 13
    -- upvalues: SfxManager (copy), VfxManager (copy)
    local TimeSent = u2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = u2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    Char:FindFirstChild("BALL", true);
    SfxManager:playSound({
        Sound = "PushOffPlaymake",
        Parent = HumanoidRootPart
    });
    local u4 = script.VFX:Clone();
    u4.Parent = workspace.Debris;
    u4:PivotTo(HumanoidRootPart.CFrame);
    task.delay(3, u4.Destroy, u4);
    task.delay(0.38 - v3, function() -- Line: 30
        -- upvalues: u4 (copy), HumanoidRootPart (copy), u2 (copy), VfxManager (ref)
        u4:PivotTo(HumanoidRootPart.CFrame);

        if u2.Right then
            VfxManager.Emit(u4.Dribble_0L);

            return;
        end;

        VfxManager.Emit(u4.Dribble_0R);
    end);
    task.delay(0.86 - v3, function() -- Line: 39
        -- upvalues: u4 (copy), HumanoidRootPart (copy), VfxManager (ref)
        u4:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.Emit(u4.Dribble);
    end);
    task.delay(1.3 - v3, function() -- Line: 44
        -- upvalues: u4 (copy), HumanoidRootPart (copy), VfxManager (ref)
        u4:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.Emit(u4.JumpFX);
    end);
    task.delay(1.9 - v3, function() -- Line: 49
        -- upvalues: u4 (copy), HumanoidRootPart (copy), VfxManager (ref)
        u4:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.Emit(u4.Shoot);
    end);
end;