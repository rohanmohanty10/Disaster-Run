 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: Players (copy), SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy), Effects (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local u4 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);
    SfxManager:playSound({
        Sound = "BBZ Popstar Flip Dunk",
        Parent = HumanoidRootPart
    });
    local u5 = script.Ball:Clone();
    u5.Parent = Debris;
    u5.CFrame = BALL.CFrame;
    Essentials:Weld(u5, BALL);
    task.delay(0.16666666666666666 - v3, function() -- Line: 33
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v6 = script.Bounce:Clone();
        v6.Parent = Debris;
        v6.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v6);
        VfxManager.DestroyEffect(v6, 2);
    end);
    task.delay(0.6 - v3, function() -- Line: 41
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v7 = script.Bounce:Clone();
        v7.Parent = Debris;
        v7.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v7);
        VfxManager.DestroyEffect(v7, 2);
    end);
    task.delay(0.9666666666666667 - v3, function() -- Line: 49
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v8 = script.Jump:Clone();
        v8.Parent = Debris;
        v8.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, 1.5707963267948966, 2.705260340591211) + Vector3.new(0, -2.5, 0);
        VfxManager.Emit(v8);
        VfxManager.DestroyEffect(v8, 2);
    end);
    task.delay(1.3333333333333333 - v3, function() -- Line: 57
        -- upvalues: VfxManager (ref), u5 (copy)
        VfxManager.Emit(u5.Emit);
    end);
    task.delay(2.0166666666666666 - v3, function() -- Line: 61
        -- upvalues: VfxManager (ref), u5 (copy), HumanoidRootPart (copy), Effects (ref), u4 (copy), SfxManager (ref), Debris (ref)
        VfxManager.Enable(u5, false);
        VfxManager.DestroyEffect(u5, 2);

        if not HumanoidRootPart:FindFirstChild("AlignPosition") then
            return;
        end;

        task.delay(0.25, function() -- Line: 67
            -- upvalues: Effects (ref), u4 (ref)
            Effects:SubtitleV2({
                { u4, "Fly with the beat!", 1.5 }
            });
        end);
        SfxManager:playSound({
            Sound = "BBZ Popstar Flip Dunk Voice",
            Parent = HumanoidRootPart
        });
        local Hoops = workspace:FindFirstChild("Hoops");
        local v9 = nil;

        if Hoops then
            local Hoop = Hoops.Home.Hoop;
            local Hoop2 = Hoops.Away.Hoop;

            if Hoop and Hoop2 then
                v9 = (HumanoidRootPart.Position - Hoop2.Position).Magnitude < (HumanoidRootPart.Position - Hoop.Position).Magnitude and Hoop2.Position or Hoop.Position;
            end;
        end;

        if v9 then
            local v10 = script.Shoot:Clone();
            v10.Parent = Debris;
            v10.CFrame = CFrame.new(v9) * CFrame.Angles(-1.5707963267948966, 0, 0);
            VfxManager.BetterEmit(v10);
            VfxManager.DestroyEffect(v10, 4);
        end;

        VfxManager.Enable(u5, false);
        VfxManager.DestroyEffect(u5, 2);
    end);
end;