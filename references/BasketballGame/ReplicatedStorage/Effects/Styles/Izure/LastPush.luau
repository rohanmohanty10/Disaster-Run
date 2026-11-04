 
 

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
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Shoot" then
        if p2.Task == "Dribble" then
            SfxManager:playSound({
                Sound = "BBZ Izure Last Push Dribble",
                Parent = HumanoidRootPart
            });

            if Debris:FindFirstChild(Character.Name .. script.Name .. "Aura") then
                VfxManager.Enable(Debris:FindFirstChild(Character.Name .. script.Name .. "Aura"), false);
            end;

            local u4 = script.Aura:Clone();
            u4.Parent = Debris;
            u4.CFrame = HumanoidRootPart.CFrame;
            Essentials:Weld(u4, HumanoidRootPart);
            VfxManager.DestroyEffect(u4, 3);
            shared.vfx.emit(u4);
            VfxManager.Enable(u4, true);
            task.delay(0.16666666666666666 - v3, function() -- Line: 103
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v5 = script.Bounce:Clone();
                v5.Parent = Debris;
                v5:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v5, 2);
                shared.vfx.emit(v5);
            end);
            task.delay(0.55 - v3, function() -- Line: 112
                -- upvalues: VfxManager (ref), u4 (copy), Debris (ref), HumanoidRootPart (copy), Essentials (ref)
                VfxManager.Enable(u4, false);
                local v6 = script.Spin:Clone();
                v6.Parent = Debris;
                v6.CFrame = HumanoidRootPart.CFrame;
                Essentials:Weld(v6, HumanoidRootPart);
                VfxManager.DestroyEffect(v6, 2);
                shared.vfx.emit(v6);
            end);
            task.delay(0.9333333333333333 - v3, function() -- Line: 124
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v7 = script.Bounce:Clone();
                v7.Parent = Debris;
                v7:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v7, 2);
                shared.vfx.emit(v7);
            end);
            local v8 = tick();

            repeat
                task.wait(0.05);
                local v9 = Essentials:CreateClone(Character);
                VfxManager.DestroyEffect(v9, 1);
            until tick() - v8 > 0.5 - v3;
        else
            if p2.Task == "Activate" then
                SfxManager:playSound({
                    Sound = "BBZ Izure Last Push Activate",
                    Parent = HumanoidRootPart
                });
                local u10 = script.Aura:Clone();
                u10.Name = Character.Name .. script.Name .. "Aura";
                u10.Parent = Debris;
                u10.CFrame = HumanoidRootPart.CFrame;
                Essentials:Weld(u10, HumanoidRootPart);
                VfxManager.DestroyEffect(u10, 6);
                shared.vfx.emit(u10);
                VfxManager.Enable(u10, true);
                task.delay(0.5 - v3, function() -- Line: 151
                    -- upvalues: VfxManager (ref), u10 (copy)
                    VfxManager.Enable(u10.att1, false);
                    VfxManager.Enable(u10.att2, false);
                end);
                task.delay(3 - v3, function() -- Line: 156
                    -- upvalues: VfxManager (ref), u10 (copy)
                    VfxManager.Enable(u10, false);
                end);

                return;
            end;

            if p2.Task == "Deactivate" and Debris:FindFirstChild(Character.Name .. script.Name .. "Aura") then
                VfxManager.Enable(Debris:FindFirstChild(Character.Name .. script.Name .. "Aura"), false);
            end;
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Izure Last Push Shoot",
        Parent = HumanoidRootPart
    });
    local u11 = script.Aura:Clone();
    u11.Parent = Debris;
    u11.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(u11, HumanoidRootPart);
    VfxManager.DestroyEffect(u11, 3);
    u11.att1:Destroy();
    u11.att2:Destroy();
    shared.vfx.emit(u11);
    VfxManager.Enable(u11, true);
    task.delay(0.18333333333333332 - v3, function() -- Line: 44
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v12 = script.Bounce:Clone();
        v12.Parent = Debris;
        v12:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
        VfxManager.DestroyEffect(v12, 2);
        shared.vfx.emit(v12);
    end);
    task.delay(0.43333333333333335 - v3, function() -- Line: 53
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v13 = script.Push:Clone();
        v13.Parent = Debris;
        v13:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v13, 4);
        shared.vfx.emit(v13);
    end);
    task.delay(0.75 - v3, function() -- Line: 62
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref), Essentials (ref), Character (copy)
        local v14 = script.Dash:Clone();
        v14.Parent = Debris;
        v14:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v14, 4);
        shared.vfx.emit(v14);
        local v15 = tick();

        repeat
            task.wait(0.05);
            local v16 = Essentials:CreateClone(Character);
            VfxManager.DestroyEffect(v16, 1);
        until tick() - v15 > 0.2833333333333333;
    end);
    task.delay(1.0333333333333334 - v3, function() -- Line: 77
        -- upvalues: VfxManager (ref), u11 (copy), Debris (ref), HumanoidRootPart (copy)
        VfxManager.Enable(u11, false);
        local v17 = script.Shoot:Clone();
        v17.Parent = Debris;
        v17:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v17, 4);
        shared.vfx.emit(v17);
    end);
end;