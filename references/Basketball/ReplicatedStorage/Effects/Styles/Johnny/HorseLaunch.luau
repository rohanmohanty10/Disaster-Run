 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Shot" then
        if p2.Task == "Launch" then
            SfxManager:playSound({
                Sound = "BBZ Johnny Horse Launch",
                Parent = HumanoidRootPart
            });
            task.delay(0.38333333333333336 - v3, function() -- Line: 94
                -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                local v4 = script.Dust:Clone();
                v4.Parent = Debris;
                v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 1);
                VfxManager.BetterEmit(v4, 4);
                VfxManager.DestroyEffect(v4, 4);
            end);
            task.delay(0.75 - v3, function() -- Line: 102
                -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                local v5 = script.Launch:Clone();
                v5.Parent = Debris;
                v5:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, -5.75));
                VfxManager.BetterEmit(v5);
                VfxManager.DestroyEffect(v5, 4);
            end);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Johnny Wormhole Shot",
        Parent = HumanoidRootPart
    });
    task.delay(0.7333333333333333 - v3, function() -- Line: 28
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v6 = script.Shoot:Clone();
        v6.Parent = Debris;
        v6.CFrame = CFrame.new(HumanoidRootPart.Position, (HumanoidRootPart.CFrame * CFrame.new(0, -3, -5.25)).Position);
        VfxManager.BetterEmit(v6, 4);
        VfxManager.DestroyEffect(v6, 4);
    end);
    task.delay(0.8333333333333334 - v3, function() -- Line: 36
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref), SfxManager (ref), BALL (copy)
        local v7 = script.Wormhole1:Clone();
        v7.Parent = Debris;
        v7:PivotTo(CFrame.new((HumanoidRootPart.CFrame * CFrame.new(0, -3, -5.25)).Position));
        VfxManager.BetterEmit(v7, 4);
        VfxManager.DestroyEffect(v7, 4);
        SfxManager:playSound({
            Sound = "BBZ Johnny Wormhole",
            Parent = v7
        });

        for _, descendant in BALL:GetDescendants() do
            if (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail")) and descendant.Enabled then
                descendant.Enabled = false;
                task.delay(0.03333333333333333, function() -- Line: 48
                    -- upvalues: descendant (copy)
                    descendant.Enabled = true;
                end);
            end;
        end;

        for _, child in Debris:GetChildren() do
            if child.Name == "Ball" then
                for _, descendant in child:GetDescendants() do
                    if (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail")) and descendant.Enabled then
                        descendant.Enabled = false;
                        task.delay(0.03333333333333333, function() -- Line: 58
                            -- upvalues: descendant (copy)
                            descendant.Enabled = true;
                        end);
                    end;
                end;
            end;
        end;
    end);
    task.delay(0.85 - v3, function() -- Line: 67
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref), SfxManager (ref)
        local Hoops = workspace:FindFirstChild("Hoops");
        local v8 = nil;

        if Hoops then
            local Hoop = Hoops.Home.Hoop;
            local Hoop2 = Hoops.Away.Hoop;

            if Hoop and Hoop2 then
                v8 = (HumanoidRootPart.Position - Hoop2.Position).Magnitude < (HumanoidRootPart.Position - Hoop.Position).Magnitude and Hoop2.Position or Hoop.Position;
            end;
        end;

        if v8 then
            local v9 = script.Wormhole2:Clone();
            v9.Parent = Debris;
            v9:PivotTo(CFrame.new(v8 + Vector3.new(0, 16, 0)) * CFrame.Angles(0, 0, 3.141592653589793));
            VfxManager.BetterEmit(v9, 4);
            VfxManager.DestroyEffect(v9, 4);
            SfxManager:playSound({
                Sound = "BBZ Johnny Wormhole",
                Parent = v9
            });
        end;
    end);
end;