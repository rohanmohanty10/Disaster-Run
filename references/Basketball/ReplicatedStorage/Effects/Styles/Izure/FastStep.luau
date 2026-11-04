 
 

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
    -- upvalues: SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local _ = p2.Other;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Torso = Character:FindFirstChild("Torso");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task == "Dribble" then
        SfxManager:playSound({
            Sound = `BBZ Izure Instinct {p2.Tier}`,
            Parent = HumanoidRootPart
        });
        local u4 = script.Aura:Clone();
        u4.Parent = Debris;
        u4.CFrame = Torso.CFrame;
        Essentials:Weld(u4, Torso);
        VfxManager.DestroyEffect(u4, 4);
        shared.vfx.emit(u4);
        VfxManager.Enable(u4, true);

        if p2.Tier == 1 then
            task.delay(0.16666666666666666 - v3, function() -- Line: 43
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v5 = script.Bounce:Clone();
                v5.Parent = Debris;
                v5:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v5, 2);
                shared.vfx.emit(v5);
            end);
            task.delay(0.48333333333333334 - v3, function() -- Line: 52
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v6 = script.Bounce:Clone();
                v6.Parent = Debris;
                v6:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v6, 2);
                shared.vfx.emit(v6);
            end);
            task.delay(0.5 - v3, function() -- Line: 61
                -- upvalues: VfxManager (ref), u4 (copy)
                VfxManager.Enable(u4, false);
                VfxManager.Enable(u4.att2, true);
            end);
            task.delay(0.6833333333333333 - v3, function() -- Line: 66
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v7 = script.Bounce:Clone();
                v7.Parent = Debris;
                v7:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v7, 2);
                shared.vfx.emit(v7);
            end);
            task.delay(0.75 - v3, function() -- Line: 75
                -- upvalues: VfxManager (ref), u4 (copy)
                VfxManager.Enable(u4.att2, false);
            end);
        elseif p2.Tier == 2 then
            task.delay(0.2833333333333333 - v3, function() -- Line: 79
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v8 = script.Bounce:Clone();
                v8.Parent = Debris;
                v8:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v8, 2);
                shared.vfx.emit(v8);
            end);
            task.delay(0.5 - v3, function() -- Line: 88
                -- upvalues: VfxManager (ref), u4 (copy)
                VfxManager.Enable(u4, false);
                VfxManager.Enable(u4.att2, true);
            end);
            task.delay(0.5833333333333334 - v3, function() -- Line: 93
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v9 = script.Bounce:Clone();
                v9.Parent = Debris;
                v9:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v9, 2);
                shared.vfx.emit(v9);
            end);
            task.delay(0.8333333333333334 - v3, function() -- Line: 102
                -- upvalues: VfxManager (ref), u4 (copy)
                VfxManager.Enable(u4.att2, false);
            end);
        elseif p2.Tier == 3 then
            task.delay(0.21666666666666667 - v3, function() -- Line: 106
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v10 = script.Bounce:Clone();
                v10.Parent = Debris;
                v10:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v10, 2);
                shared.vfx.emit(v10);
            end);
            task.delay(0.4166666666666667 - v3, function() -- Line: 115
                -- upvalues: Debris (ref), VfxManager (ref)
                local v11 = script.CameraFX:Clone();
                v11.Parent = Debris;
                VfxManager.DestroyEffect(v11, 2);
                shared.vfx.emit(v11);
            end);
            task.delay(0.5666666666666667 - v3, function() -- Line: 123
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v12 = script.Bounce:Clone();
                v12.Parent = Debris;
                v12:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v12, 2);
                shared.vfx.emit(v12);
            end);
            task.delay(0.9 - v3, function() -- Line: 132
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v13 = script.Bounce:Clone();
                v13.Parent = Debris;
                v13:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v13, 2);
                shared.vfx.emit(v13);
            end);
            task.delay(1.2166666666666666 - v3, function() -- Line: 141
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v14 = script.Bounce:Clone();
                v14.Parent = Debris;
                v14:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v14, 2);
                shared.vfx.emit(v14);
            end);
            task.delay(1.4 - v3, function() -- Line: 150
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v15 = script.Bounce:Clone();
                v15.Parent = Debris;
                v15:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v15, 2);
                shared.vfx.emit(v15);
            end);
            task.delay(1.6666666666666667 - v3, function() -- Line: 159
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v16 = script.Bounce:Clone();
                v16.Parent = Debris;
                v16:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v16, 2);
                shared.vfx.emit(v16);
            end);
            task.delay(1.9333333333333333 - v3, function() -- Line: 168
                -- upvalues: Debris (ref), VfxManager (ref)
                local v17 = script.CameraFX:Clone();
                v17.Parent = Debris;
                VfxManager.DestroyEffect(v17, 2);
                shared.vfx.emit(v17);
            end);
            task.delay(2 - v3, function() -- Line: 176
                -- upvalues: VfxManager (ref), u4 (copy)
                VfxManager.Enable(u4, false);
                VfxManager.Enable(u4.att2, true);
            end);
            task.delay(2.2666666666666666 - v3, function() -- Line: 181
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v18 = script.Bounce:Clone();
                v18.Parent = Debris;
                v18:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v18, 2);
                shared.vfx.emit(v18);
            end);
            task.delay(2.4166666666666665 - v3, function() -- Line: 190
                -- upvalues: VfxManager (ref), u4 (copy)
                VfxManager.Enable(u4.att2, false);
            end);
        end;

        local v19 = tick();

        repeat
            task.wait(0.05);
            local v20 = Essentials:CreateClone(Character);
            VfxManager.DestroyEffect(v20, 1);
        until tick() - v19 > (p2.Tier == 1 and 0.75 or (p2.Tier == 2 and 0.8333333333333334 or (p2.Tier == 3 and 2.4166666666666665 or false))) - v3;
    elseif p2.Task == "Dash" then
        SfxManager:playSound({
            Sound = "BBZ Izure Fast Step",
            Parent = HumanoidRootPart
        });
        SfxManager:playSound({
            Sound = "BBZ Izure Last Push Activate",
            Parent = HumanoidRootPart
        });
        local u21 = script.Aura:Clone();
        u21.Parent = Debris;
        u21.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(u21, HumanoidRootPart);
        VfxManager.DestroyEffect(u21, 4);
        shared.vfx.emit(u21);
        VfxManager.Enable(u21.att2, true);
        local v22 = script.Dash:Clone();
        v22.Parent = Debris;
        v22:PivotTo(CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + p2.Direction));
        VfxManager.DestroyEffect(v22, 2);
        shared.vfx.emit(v22);
        task.delay(0.5 - v3, function() -- Line: 220
            -- upvalues: VfxManager (ref), u21 (copy)
            VfxManager.Enable(u21.att2, false);
        end);
        local v23 = tick();

        repeat
            task.wait(0.05);
            local v24 = Essentials:CreateClone(Character);
            VfxManager.DestroyEffect(v24, 1);
        until tick() - v23 > 0.5 - v3;
    end;
end;