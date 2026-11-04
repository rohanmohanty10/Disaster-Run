 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 13
    -- upvalues: VfxManager (copy), Essentials (copy)
    local Character = p2.Character;
    local v3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local HumanoidRootPart2 = p2.Victim:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart2 then
        return;
    end;

    local u4 = script.ballslam:Clone();
    local u5 = script.HIT:Clone();
    local u6 = script.spin:Clone();
    local u7 = script.throw:Clone();
    task.delay(0.55 - v3, function() -- Line: 28
        -- upvalues: u4 (copy), HumanoidRootPart (copy), VfxManager (ref)
        u4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, -3);
        u4.Parent = workspace;
        VfxManager.Emit(u4);
    end);
    task.delay(1.12 - v3, function() -- Line: 34
        -- upvalues: u5 (copy), HumanoidRootPart2 (copy), Essentials (ref), VfxManager (ref)
        u5.Parent = HumanoidRootPart2;
        u5.CFrame = HumanoidRootPart2.CFrame;
        Essentials:Weld(u5, HumanoidRootPart2);
        VfxManager.Emit(u5);
    end);
    task.delay(1.48 - v3, function() -- Line: 41
        -- upvalues: u6 (copy), HumanoidRootPart (copy), Essentials (ref), VfxManager (ref)
        u6.Parent = HumanoidRootPart;
        u6.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(u6, HumanoidRootPart);
        VfxManager.Emit(u6);
    end);
    task.delay(1.93 - v3, function() -- Line: 48
        -- upvalues: u7 (copy), HumanoidRootPart (copy), VfxManager (ref)
        u7.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -3);
        u7.Parent = workspace;
        VfxManager.Emit(u7);
    end);
end;