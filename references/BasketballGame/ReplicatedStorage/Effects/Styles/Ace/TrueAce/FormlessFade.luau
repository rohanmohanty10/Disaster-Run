 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 13
    -- upvalues: SfxManager (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local speed = p2.speed;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    SfxManager:playSound({
        Sound = "FormlessFade",
        Duration = 4,
        Parent = HumanoidRootPart
    });
    local u4 = script.VFX:Clone();
    u4.Parent = workspace.Debris;
    u4:PivotTo(HumanoidRootPart.CFrame);
    local v5 = v3 / speed;
    task.delay(0.1 - v5, function() -- Line: 30
        -- upvalues: u4 (copy), HumanoidRootPart (copy), VfxManager (ref)
        u4:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.Emit(u4.Dribble);
    end);
    task.delay(0.4 - v5, function() -- Line: 35
        -- upvalues: u4 (copy), HumanoidRootPart (copy), VfxManager (ref)
        u4:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.Emit(u4.Dribble);
    end);
    task.delay(0.7 - v5, function() -- Line: 40
        -- upvalues: u4 (copy), HumanoidRootPart (copy), VfxManager (ref)
        u4:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.Emit(u4.Dribble);
    end);
    task.delay(0.8 - v5, function() -- Line: 45
        -- upvalues: u4 (copy), HumanoidRootPart (copy), VfxManager (ref)
        u4:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.Emit(u4.Jump);
    end);
    task.delay(1.1 - v5, function() -- Line: 50
        -- upvalues: u4 (copy), HumanoidRootPart (copy), VfxManager (ref)
        u4:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.Emit(u4.Shoot);
    end);
    task.delay(2, function() -- Line: 55
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
end;