 
 

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
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local HumanoidRootPart2 = p2.Char2:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("BALL", true);
    local u4 = script.Throw:Clone();
    u4.Parent = workspace.Debris;
    u4:PivotTo(HumanoidRootPart.CFrame);
    task.delay(2, u4.Destroy, u4);
    local u5 = script.TeamateJump:Clone();
    u5.Parent = workspace.Debris;
    task.delay(2, u5.Destroy, u5);
    local u6 = script.TeamateGrab:Clone();
    u6.Parent = workspace.Debris;
    task.delay(3, u6.Destroy, u6);
    task.delay(0.283 - v3, function() -- Line: 39
        -- upvalues: SfxManager (ref), HumanoidRootPart (copy), u4 (copy), VfxManager (ref)
        SfxManager:playSound({
            Sound = "AlleyThrow",
            Parent = HumanoidRootPart
        });
        u4:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.Emit(u4);
    end);
    task.delay(0.533, function() -- Line: 46
        -- upvalues: SfxManager (ref), HumanoidRootPart2 (copy), u5 (copy), VfxManager (ref)
        SfxManager:playSound({
            Sound = "AlleyJump",
            Parent = HumanoidRootPart2
        });
        u5.CFrame = HumanoidRootPart2.CFrame * CFrame.new(0, -2.9, 0);
        VfxManager.Emit(u5);
    end);
    task.delay(0.7, function() -- Line: 53
        -- upvalues: SfxManager (ref), HumanoidRootPart2 (copy), u6 (copy), VfxManager (ref)
        SfxManager:playSound({
            Sound = "AlleyCatch",
            Parent = HumanoidRootPart2
        });
        u6:PivotTo(HumanoidRootPart2.CFrame);
        VfxManager.Emit(u6);
    end);
end;