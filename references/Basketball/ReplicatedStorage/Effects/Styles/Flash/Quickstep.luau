 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 13
    -- upvalues: Essentials (copy), VfxManager (copy), SfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local script_DribblesL = script.DribblesL;

    if p2.Right then
        script_DribblesL = script.DribblesR;
    end;

    local u4 = script_DribblesL:Clone();
    u4.Parent = workspace.Debris;
    u4:PivotTo(HumanoidRootPart.CFrame);
    local BALL = Char:FindFirstChild("BALL", true);
    local u5 = script.BALLVFX:Clone();
    u5.Parent = workspace.Debris;
    u5.CFrame = BALL.CFrame;
    Essentials:Weld(u5, BALL);
    VfxManager.Enable(u5, true);
    SfxManager:playSound({
        Sound = "FlashDribble",
        Parent = HumanoidRootPart
    });
    local u6 = false;
    task.delay(0.25 - v3, function() -- Line: 43
        -- upvalues: u4 (ref), HumanoidRootPart (copy), VfxManager (ref)
        u4:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.Emit(u4.Dribble1);
    end);
    task.delay(0.5 - v3, function() -- Line: 48
        -- upvalues: u4 (ref), HumanoidRootPart (copy), VfxManager (ref)
        u4:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.Emit(u4.Dribble2);
    end);
    task.delay(0.98, function() -- Line: 53
        -- upvalues: u4 (ref), HumanoidRootPart (copy), VfxManager (ref), u5 (copy)
        u4:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.Emit(u4.Dribble3);
        VfxManager.Enable(u5, false);
        task.delay(1, u5.Destroy, u5);
        task.delay(1, u4.Destroy, u4);
    end);
    task.delay(0.43 - v3, function() -- Line: 62
        -- upvalues: Char (copy), u6 (ref)
        if Char:GetAttribute("LayUpEffect") then
            u6 = true;
        end;
    end);
    local u7 = nil;
    task.delay(0.467 - v3, function() -- Line: 68
        -- upvalues: u6 (ref), u7 (ref), HumanoidRootPart (copy), VfxManager (ref), SfxManager (ref)
        if not u6 then
            return;
        end;

        u7 = script.Jump:Clone();
        u7.Parent = workspace.Debris;
        u7:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.Emit(u7.Drible);
        VfxManager.Emit(u7.Shard);
        SfxManager:playSound({
            Sound = "FlashImpact",
            Parent = HumanoidRootPart
        });
        task.delay(3, u7.Destroy, u7);
    end);
    task.delay(1.1, function() -- Line: 82
        -- upvalues: u6 (ref), u7 (ref), HumanoidRootPart (copy), VfxManager (ref)
        if not (u6 and u7) then
            return;
        end;

        u7:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.Emit(u7.Shoot);
    end);
end;