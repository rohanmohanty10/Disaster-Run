 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);
    SfxManager:playSound({
        Sound = "BBZ Honored One Maximum Dribble",
        Parent = HumanoidRootPart
    });
    local u4 = script.Maximum:Clone();
    u4.Parent = Debris;
    u4.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(u4.PrimaryPart, HumanoidRootPart);
    VfxManager.DestroyEffect(u4, 6);
    VfxManager.BetterEmit(u4.Appear);
    VfxManager.Emit(u4.Blue);
    VfxManager.Enable(u4.Blue, true);
    task.delay(1.5166666666666666 - v3, function() -- Line: 37
        -- upvalues: u4 (copy), VfxManager (ref)
        if u4.PrimaryPart:FindFirstChild("WeldConstraint") then
            u4.PrimaryPart:FindFirstChild("WeldConstraint"):Destroy();
        end;

        u4.PrimaryPart.Anchored = true;
        VfxManager.BetterEmit(u4.Throw);
        VfxManager.Enable(u4.Blue, false);
    end);
    task.delay(1.7166666666666666 - v3, function() -- Line: 46
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v5 = script.Bounce:Clone();
        v5.Parent = Debris;
        v5.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
        VfxManager.BetterEmit(v5);
        VfxManager.DestroyEffect(v5, 4);
    end);
    task.delay(2.216666666666667 - v3, function() -- Line: 54
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v6 = script.Bounce:Clone();
        v6.Parent = Debris;
        v6.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
        VfxManager.BetterEmit(v6);
        VfxManager.DestroyEffect(v6, 4);
    end);
    task.delay(2.65 - v3, function() -- Line: 62
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v7 = script.Bounce:Clone();
        v7.Parent = Debris;
        v7.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
        VfxManager.BetterEmit(v7);
        VfxManager.DestroyEffect(v7, 4);
    end);
end;