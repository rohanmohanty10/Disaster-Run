 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 17
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), Knit (copy), LocalPlayer (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;

    if p2.Task == "Dribble" then
        local Character = p2.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local BALL = Character:FindFirstChild("BALL", true);
        SfxManager:playSound({
            Sound = "BBZ Thief Stolen Dribble",
            Parent = HumanoidRootPart
        });
        task.delay(0.15 - v3, function() -- Line: 29
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v4 = script.Bounce:Clone();
            v4.Parent = Debris;
            v4.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
            VfxManager.BetterEmit(v4);
            VfxManager.DestroyEffect(v4, 2);
        end);
        task.delay(0.48333333333333334 - v3, function() -- Line: 37
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v5 = script.Bounce:Clone();
            v5.Parent = Debris;
            v5.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
            VfxManager.BetterEmit(v5);
            VfxManager.DestroyEffect(v5, 2);
        end);
        task.delay(0.85 - v3, function() -- Line: 45
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v6 = script.Bounce:Clone();
            v6.Parent = Debris;
            v6.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
            VfxManager.BetterEmit(v6);
            VfxManager.DestroyEffect(v6, 2);
        end);

        return;
    end;

    if p2.Task == "Forward" then
        local Character = p2.Character;
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
        local BALL = Character:FindFirstChild("BALL", true);
        SfxManager:playSound({
            Sound = "BBZ Thief Stolen Drive",
            Parent = HumanoidRootPart
        });
        task.delay(0.3 - v3, function() -- Line: 60
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v7 = script.Bounce:Clone();
            v7.Parent = Debris;
            v7.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
            VfxManager.BetterEmit(v7);
            VfxManager.DestroyEffect(v7, 2);
        end);
        task.delay(0.9166666666666666 - v3, function() -- Line: 68
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v8 = script.Bounce:Clone();
            v8.Parent = Debris;
            v8.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
            VfxManager.BetterEmit(v8);
            VfxManager.DestroyEffect(v8, 2);
        end);
        task.delay(1.4166666666666667 - v3, function() -- Line: 76
            -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            local v9 = script.Dash:Clone();
            v9.Parent = Debris;
            v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.357, -0.631, -2.067) * CFrame.fromEulerAnglesXYZ(0.018081611050661254, -1.5008958902525238, -0.016859880574265223);
            VfxManager.BetterEmit(v9);
            VfxManager.DestroyEffect(v9, 2);
        end);

        return;
    end;

    if p2.Task ~= "Push" then
        if p2.Task == "Stop" then
            if workspace:FindFirstChild("CamRig") then
                return;
            end;

            local Controller = Knit.GetController("AnimationController");
            Controller:StopAll();
            Controller:PlayChar("Thief", "RoughPlayEnemy", Enum.AnimationPriority.Action3, true);

            for _, descendant in pairs(LocalPlayer.LocalPlayer.Character:GetDescendants()) do
                if descendant:IsA("LinearVelocity") or descendant:IsA("BodyVelocity") then
                    descendant.Enabled = false;
                end;
            end;
        end;

        return;
    end;

    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    SfxManager:playSound({
        Sound = "BBZ Thief Rough Play",
        Parent = HumanoidRootPart
    });
    local Highlight = Instance.new("Highlight", Character);
    Highlight.Name = script.Name .. "Highlight";
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(38, 123, 255);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    VfxManager.DestroyEffect(Highlight, 0.5 - v3);
    local v10 = script.Push:Clone();
    v10.Parent = Debris;
    v10.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.507, -0.873, -1.899) * CFrame.fromEulerAnglesXYZ(0.018081611050661254, -1.5008958902525238, -0.016859880574265223);
    VfxManager.BetterEmit(v10);
    VfxManager.DestroyEffect(v10, 2);
end;