 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Part_Icles);
require(ReplicatedStorage.Shared.Utility.Effects);
local ScaryMonsterScreenEffect = require(script.Parent.Parent.ScreenEffects.ScaryMonsterScreenEffect);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 19
    -- upvalues: Knit (copy), SfxManager (copy), Debris (copy), VfxManager (copy), ScaryMonsterScreenEffect (copy)
    Knit.GetController("BallController");
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Left Leg");
    Character:FindFirstChild("Right Leg");
    Character:FindFirstChild(script.Name .. "Revolver");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Dribble" then
        if p2.Task ~= "Time Skip" then
            if p2.Task == "Pass" then
                SfxManager:playSound({
                    Sound = "BBZ Scary Monster Revolver Pass",
                    Parent = HumanoidRootPart
                });
                task.delay(0.13333333333333333 - v3, function() -- Line: 69
                    -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                    local v4 = script.Bounce:Clone();
                    v4.Parent = Debris;
                    v4:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                    VfxManager.DestroyEffect(v4, 2);
                    shared.vfx.emit(v4);
                end);
                task.delay(0.3444444444444445 - v3, function() -- Line: 78
                    -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                    local v5 = script.Toss:Clone();
                    v5.Parent = Debris;
                    v5:PivotTo(HumanoidRootPart.CFrame);
                    VfxManager.DestroyEffect(v5, 2);
                    shared.vfx.emit(v5);
                end);
                task.delay(0.5777777777777778 - v3, function() -- Line: 87
                    -- upvalues: SfxManager (ref), HumanoidRootPart (copy), ScaryMonsterScreenEffect (ref), Character (copy), Debris (ref), VfxManager (ref)
                    SfxManager:playSound({
                        Sound = "BBZ Scary Monster Time Skip",
                        Parent = HumanoidRootPart
                    });
                    ScaryMonsterScreenEffect(Character, HumanoidRootPart.CFrame);
                    local v6 = script.Shoot:Clone();
                    v6.Parent = Debris;
                    v6.CFrame = HumanoidRootPart.CFrame;
                    VfxManager.DestroyEffect(v6, 2);
                    shared.vfx.emit(v6);
                end);
            end;

            return;
        end;

        SfxManager:playSound({
            Sound = "BBZ Scary Monster Time Skip",
            Parent = HumanoidRootPart
        });
        ScaryMonsterScreenEffect(Character, p2.CFrame);

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Scary Monster Time Skip Crossover",
        Parent = HumanoidRootPart
    });
    task.delay(0.21666666666666667 - v3, function() -- Line: 36
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v7 = script.Bounce:Clone();
        v7.Parent = Debris;
        v7:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
        VfxManager.DestroyEffect(v7, 2);
        shared.vfx.emit(v7);
    end);
    task.delay(0.5333333333333333 - v3, function() -- Line: 45
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v8 = script.Bounce:Clone();
        v8.Parent = Debris;
        v8:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
        VfxManager.DestroyEffect(v8, 2);
        shared.vfx.emit(v8);
    end);
    task.delay(0.8333333333333334 - v3, function() -- Line: 54
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v9 = script.Bounce:Clone();
        v9.Parent = Debris;
        v9:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
        VfxManager.DestroyEffect(v9, 2);
        shared.vfx.emit(v9);
    end);
end;