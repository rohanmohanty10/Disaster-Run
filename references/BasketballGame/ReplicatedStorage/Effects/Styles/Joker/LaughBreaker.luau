 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: Players (copy), SfxManager (copy), Debris (copy), VfxManager (copy), Effects (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local v4 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("BALL", true);

    if p2.Task == "Crossover" then
        SfxManager:playSound({
            Sound = "BBZ Joker Laugh Breaker Crossover",
            Parent = HumanoidRootPart
        });
        task.spawn(function() -- Line: 28
            -- upvalues: Debris (ref), HumanoidRootPart (ref), VfxManager (ref)
            local v5 = script.Dash:Clone();
            v5.Parent = Debris;
            v5.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + HumanoidRootPart.Velocity) + Vector3.new(0, -3 + v5.Size.Y / 2, 0);
            VfxManager.Emit(v5);
            VfxManager.DestroyEffect(v5, 2);
            task.wait(0.18333333333333332);
            local v6 = script.Dash:Clone();
            v6.Parent = Debris;
            v6.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + HumanoidRootPart.Velocity) + Vector3.new(0, -3 + v6.Size.Y / 2, 0);
            VfxManager.Emit(v6);
            VfxManager.DestroyEffect(v6, 2);
            task.wait(0.65);
            local v7 = script.Dash:Clone();
            v7.Parent = Debris;
            v7.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + HumanoidRootPart.Velocity) + Vector3.new(0, -3 + v7.Size.Y / 2, 0);
            VfxManager.Emit(v7);
            VfxManager.DestroyEffect(v7, 2);
        end);
        task.delay(0.25 - v3, function() -- Line: 52
            -- upvalues: Debris (ref), HumanoidRootPart (ref), VfxManager (ref)
            local v8 = script.Bounce1:Clone();
            v8.Parent = Debris;
            v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.014, -2.797, -0.144) * CFrame.Angles(0, 0, -1.5707963267948966);
            VfxManager.Emit(v8);
            VfxManager.DestroyEffect(v8, 2);
        end);
        task.delay(0.5833333333333334 - v3, function() -- Line: 60
            -- upvalues: Debris (ref), HumanoidRootPart (ref), VfxManager (ref)
            local v9 = script.Bounce2:Clone();
            v9.Parent = Debris;
            v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.014, -2.808, 0.167) * CFrame.Angles(0, 0, -1.5707963267948966);
            VfxManager.Emit(v9);
            VfxManager.DestroyEffect(v9, 2);
        end);
        task.delay(1.05 - v3, function() -- Line: 68
            -- upvalues: Debris (ref), HumanoidRootPart (ref), VfxManager (ref)
            local v10 = script.Bounce3:Clone();
            v10.Parent = Debris;
            v10.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.186, -2.808, -1.371) * CFrame.Angles(0, 0, -1.5707963267948966);
            VfxManager.Emit(v10);
            VfxManager.DestroyEffect(v10, 2);
        end);
    elseif p2.Task == "Throw" then
        Effects:SubtitleV2({
            { v4, "Duck and cover! AHAHAHAHAHA", 3 }
        });
        SfxManager:playSound({
            Sound = "BBZ Joker Laugh Breaker Voice",
            Parent = HumanoidRootPart
        });
        local v11 = script.Throw:Clone();
        v11.Parent = Debris;
        v11.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.918, 0.363, -2.714);

        if p2.Enemy then
            v11.CFrame = CFrame.new(v11.Position) * CFrame.fromOrientation(CFrame.new(HumanoidRootPart.Position, p2.Enemy.HumanoidRootPart.Position):ToOrientation());
        end;

        VfxManager.Emit(v11);
        VfxManager.DestroyEffect(v11, 2);
    elseif p2.Task == "Catch" then
        local Enemy = p2.Enemy;
        local HumanoidRootPart2 = Enemy:FindFirstChild("HumanoidRootPart");
        task.delay(0.25 - v3, function() -- Line: 100
            -- upvalues: SfxManager (ref), HumanoidRootPart2 (ref), Enemy (ref), Debris (ref), VfxManager (ref)
            SfxManager:playSound({
                Sound = "BBZ Joker Laugh Breaker Stun",
                Parent = HumanoidRootPart2
            });
            local v12 = Enemy:FindFirstChild(script.Name .. "Duck");

            if v12 then
                v12:Destroy();
            end;

            local v13 = script.Stun:Clone();
            v13.Parent = Debris;
            v13.CFrame = HumanoidRootPart2.CFrame * CFrame.new(0.608, -0.037, -0.202) * CFrame.Angles(0, 0, -1.5707963267948966);
            VfxManager.Emit(v13);
            VfxManager.DestroyEffect(v13, 2);
        end);
    end;
end;