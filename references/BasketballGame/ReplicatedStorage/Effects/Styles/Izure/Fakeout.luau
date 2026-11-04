 
 

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
    SfxManager:playSound({
        Sound = "BBZ Izure Fakeout",
        Parent = HumanoidRootPart
    });
    local u4 = script.Aura:Clone();
    u4.Parent = Debris;
    u4.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(u4, HumanoidRootPart);
    VfxManager.DestroyEffect(u4, 4);
    u4.att1:Destroy();
    u4.att2:Destroy();
    shared.vfx.emit(u4);
    VfxManager.Enable(u4, true);
    task.delay(0.13333333333333333 - v3, function() -- Line: 43
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v5 = script.Bounce:Clone();
        v5.Parent = Debris;
        v5:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
        VfxManager.DestroyEffect(v5, 2);
        shared.vfx.emit(v5);
    end);
    task.delay(0.26666666666666666 - v3, function() -- Line: 52
        -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
        local v6 = script.Bounce:Clone();
        v6.Parent = Debris;
        v6:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
        VfxManager.DestroyEffect(v6, 2);
        shared.vfx.emit(v6);
    end);
    task.delay(0.65 - v3, function() -- Line: 61
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v7 = script.Launch:Clone();
        v7.Parent = Debris;
        v7:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v7, 2);
        shared.vfx.emit(v7);
    end);
    task.delay(1 - v3, function() -- Line: 70
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v8 = script.Catch:Clone();
        v8.Parent = Debris;
        v8.CFrame = HumanoidRootPart.CFrame * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
        VfxManager.DestroyEffect(v8, 2);
        shared.vfx.emit(v8);
    end);
    task.delay(1.3333333333333333 - v3, function() -- Line: 79
        -- upvalues: Debris (ref), VfxManager (ref), Essentials (ref), Character (copy)
        local v9 = script.CameraFX:Clone();
        v9.Parent = Debris;
        VfxManager.DestroyEffect(v9, 2);
        shared.vfx.emit(v9);
        local v10 = tick();

        repeat
            task.wait(0.05);
            local v11 = Essentials:CreateClone(Character);
            VfxManager.DestroyEffect(v11, 1);
        until tick() - v10 > 0.25;
    end);
    task.delay(1.5833333333333333 - v3, function() -- Line: 93
        -- upvalues: VfxManager (ref), u4 (copy), Debris (ref), HumanoidRootPart (copy)
        VfxManager.Enable(u4, false);
        local v12 = script.Shoot:Clone();
        v12.Parent = Debris;
        v12:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v12, 4);
        shared.vfx.emit(v12);
    end);
    local v13 = tick();

    repeat
        task.wait(0.05);
        local v14 = Essentials:CreateClone(Character);
        VfxManager.DestroyEffect(v14, 1);
    until tick() - v13 > 0.3333333333333333 - v3;
end;