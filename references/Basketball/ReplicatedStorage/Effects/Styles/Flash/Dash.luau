 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 14
    -- upvalues: SfxManager (copy), VfxManager (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    Char:FindFirstChild("BALL", true);
    SfxManager:playSound({
        Sound = "FlashDash",
        Parent = HumanoidRootPart
    });
    local v4 = script.Emit:Clone();
    v4.Parent = workspace.Debris;
    v4:PivotTo(HumanoidRootPart.CFrame);
    VfxManager.Emit(v4);
    task.delay(2, v4.Destroy, v4);
    local u5 = script.Enable:Clone();
    u5.Parent = workspace.Debris;
    u5:PivotTo(HumanoidRootPart.CFrame);
    Essentials:Weld(u5.Root, HumanoidRootPart);
    local BALL = Char:FindFirstChild("BALL", true);
    local u6 = script.BALLVFX:Clone();
    u6.Parent = u5;
    u6.CFrame = BALL.CFrame;
    Essentials:Weld(u6, BALL);
    VfxManager.Enable(u6, true);
    VfxManager.Enable(u5, true);
    task.delay(0.5 - v3, function() -- Line: 47
        -- upvalues: VfxManager (ref), u5 (copy), u6 (copy)
        VfxManager.Enable(u5, false);
        VfxManager.Enable(u6, false);
    end);
    task.delay(2, u5.Destroy, u5);
end;