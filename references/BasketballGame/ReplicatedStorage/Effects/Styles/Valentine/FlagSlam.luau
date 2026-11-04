 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local Module = require(script.Parent.Mesh.Module);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 17
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), Module (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local D4C = Character:FindFirstChild("D4C");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Dribble" then
        if p2.Task == "Slam" then
            if not D4C then
                return;
            end;

            local Position = D4C.HumanoidRootPart.Position;
            local Highlight = Instance.new("Highlight", D4C);
            Highlight.Name = script.Name .. "Highlight";
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.FillColor = Color3.fromRGB(0, 0, 0);
            Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
            Highlight.OutlineTransparency = 0;
            Highlight.FillTransparency = 0;
            TweenService:Create(Highlight, TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Sine), {
                FillTransparency = 1,
                OutlineColor = Color3.fromRGB(0, 0, 0)
            }):Play();
            local v4 = script.Summon:Clone();
            v4.Parent = Debris;
            v4.CFrame = CFrame.new(Position.X, 1, Position.Z);
            VfxManager.Emit(v4);
            VfxManager.DestroyEffect(v4, 6);
            SfxManager:playSound({
                Sound = "BBZ Valentine Flag Slam",
                Parent = v4
            });
            task.wait(0.5333333333333333 - v3);
            local v5 = script.Slam:Clone();
            v5.Parent = Debris;
            v5.CFrame = CFrame.new(Position.X, 4, Position.Z);
            VfxManager.Emit(v5);
            VfxManager.DestroyEffect(v5, 4);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Valentine Flag Breaker",
        Parent = HumanoidRootPart
    });
    task.delay(0.35 - v3, function() -- Line: 30
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v6 = script.Bounce:Clone();
        v6.Parent = Debris;
        v6.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
        VfxManager.BetterEmit(v6);
        VfxManager.DestroyEffect(v6, 4);
    end);
    task.delay(0.5833333333333334 - v3, function() -- Line: 38
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v7 = script.Bounce:Clone();
        v7.Parent = Debris;
        v7.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
        VfxManager.BetterEmit(v7);
        VfxManager.DestroyEffect(v7, 4);
    end);
    task.delay(1.0666666666666667 - v3, function() -- Line: 46
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v8 = script.Spawn:Clone();
        v8.Parent = Debris;
        v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1, 0.35, -0.5);
        VfxManager.BetterEmit(v8);
        VfxManager.DestroyEffect(v8, 4);
    end);
    task.delay(1.3333333333333333 - v3, function() -- Line: 54
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref), Module (ref)
        local v9 = script.Spawn:Clone();
        v9.Parent = Debris;
        v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.2, 0.5, -2.5);
        VfxManager.BetterEmit(v9);
        VfxManager.DestroyEffect(v9, 4);
        Module(HumanoidRootPart.CFrame * CFrame.new(0, -1, 2.2), Debris);
    end);
end;