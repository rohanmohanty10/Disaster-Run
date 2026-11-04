 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 17
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Dribble" then
        if p2.Task == "Shift" then
            SfxManager:playSound({
                Sound = "BBZ Alien Alien Shift",
                Parent = HumanoidRootPart
            });
            task.delay((p2.Direction == "R" and 0.38333333333333336 or 0.31666666666666665) - v3, function() -- Line: 63
                -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
                local v4 = script.Shift:Clone();
                v4.Parent = Debris;
                v4.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.1, 1.5), BALL.Position.Z);
                VfxManager.BetterEmit(v4);
                VfxManager.DestroyEffect(v4, 6);
            end);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Alien Alien Dribble",
        Parent = HumanoidRootPart
    });
    task.delay(0.15 - v3, function() -- Line: 29
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v5 = script.Bounce:Clone();
        v5.Parent = Debris;
        v5.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.1, 1.5), BALL.Position.Z);
        VfxManager.BetterEmit(v5);
        VfxManager.DestroyEffect(v5, 4);
    end);
    task.delay(0.48333333333333334 - v3, function() -- Line: 37
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v6 = script.Bounce:Clone();
        v6.Parent = Debris;
        v6.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.1, 1.5), BALL.Position.Z);
        VfxManager.BetterEmit(v6);
        VfxManager.DestroyEffect(v6, 4);
    end);
    task.delay(0.75 - v3, function() -- Line: 45
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v7 = script.Dribble:Clone();
        v7.Parent = Debris;
        v7.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.1, 1.5), BALL.Position.Z);
        VfxManager.BetterEmit(v7);
        VfxManager.DestroyEffect(v7, 4);
    end);
    task.delay(1.1333333333333333 - v3, function() -- Line: 53
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v8 = script.Bounce:Clone();
        v8.Parent = Debris;
        v8.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.1, 1.5), BALL.Position.Z);
        VfxManager.BetterEmit(v8);
        VfxManager.DestroyEffect(v8, 4);
    end);
end;