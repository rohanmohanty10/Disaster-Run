 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Part_Icles);
require(ReplicatedStorage.Shared.Utility.Effects);
require(script.Parent.Parent.ScreenEffects.DarkScreenEffect);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 19
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local _ = p2.Other;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Fade" then
        if p2.Task == "Defense" then
            if p2.Start then
                SfxManager:playSound({
                    Sound = "BBZ Perfection V2 Perfect Defense",
                    Parent = HumanoidRootPart
                });
                local v4 = script.Defense.Aura:Clone();
                v4.Parent = Debris;
                v4.CFrame = HumanoidRootPart.CFrame;
                Essentials:Weld(v4, HumanoidRootPart);
                VfxManager.DestroyEffect(v4, 4);
                shared.vfx.emit(v4);
            end;

            SfxManager:playSound({
                Sound = "BBZ Perfection V2 Teleport",
                Parent = HumanoidRootPart
            });
            local v5 = script.Defense.Teleport:Clone();
            v5.Parent = Debris;
            v5.CFrame = HumanoidRootPart.CFrame;
            Essentials:Weld(v5, HumanoidRootPart);
            VfxManager.DestroyEffect(v5, 2);
            shared.vfx.emit(v5);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Perfection V2 The Perfect Shot",
        Parent = HumanoidRootPart
    });
    task.delay(0.18333333333333332 - v3, function() -- Line: 32
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v6 = script.Fade.Bounce:Clone();
        v6.Parent = Debris;
        v6:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
        VfxManager.DestroyEffect(v6, 2);
        shared.vfx.emit(v6);
    end);
    task.delay(0.2833333333333333 - v3, function() -- Line: 41
        -- upvalues: SfxManager (ref), HumanoidRootPart (copy), Debris (ref), Essentials (ref), VfxManager (ref)
        SfxManager:playSound({
            Sound = "BBZ Perfection V2 Teleport",
            Parent = HumanoidRootPart
        });
        local v7 = script.Fade.Teleport:Clone();
        v7.Parent = Debris;
        v7.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(v7, HumanoidRootPart);
        VfxManager.DestroyEffect(v7, 2);
        shared.vfx.emit(v7);
    end);
    task.delay(0.4166666666666667 - v3, function() -- Line: 53
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v8 = script.Fade.Slam:Clone();
        v8.Parent = Debris;
        v8:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
        VfxManager.DestroyEffect(v8, 2);
        shared.vfx.emit(v8);
    end);
    task.delay(0.5666666666666667 - v3, function() -- Line: 62
        -- upvalues: SfxManager (ref), HumanoidRootPart (copy), Debris (ref), Essentials (ref), VfxManager (ref)
        SfxManager:playSound({
            Sound = "BBZ Perfection V2 Teleport",
            Parent = HumanoidRootPart
        });
        local v9 = script.Fade.Teleport:Clone();
        v9.Parent = Debris;
        v9.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(v9, HumanoidRootPart);
        VfxManager.DestroyEffect(v9, 2);
        shared.vfx.emit(v9);
    end);
    task.delay(1.05 - v3, function() -- Line: 74
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v10 = script.Fade.Shoot:Clone();
        v10.Parent = Debris;
        v10:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v10, 2);
        shared.vfx.emit(v10);
    end);
end;