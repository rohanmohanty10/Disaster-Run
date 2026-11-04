 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, u2) -- Line: 15
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), Effects (copy)
    local TimeSent = u2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = u2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);
    local Hoops = workspace:FindFirstChild("Hoops");
    local u4 = nil;

    if Hoops then
        local Hoop = Hoops.Home.Hoop;
        local Hoop2 = Hoops.Away.Hoop;

        if Hoop and Hoop2 then
            u4 = (HumanoidRootPart.Position - Hoop2.Position).Magnitude < (HumanoidRootPart.Position - Hoop.Position).Magnitude and Hoop2.Position or Hoop.Position;
        end;
    end;

    SfxManager:playSound({
        Sound = "BBZ King Self Alley",
        Parent = HumanoidRootPart
    });
    task.delay(0.16666666666666666 - v3, function() -- Line: 39
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v5 = script.Bounce:Clone();
        v5.Parent = Debris;
        v5.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v5);
        VfxManager.DestroyEffect(v5, 2);
    end);
    task.delay(0.55 - v3, function() -- Line: 47
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v6 = script.Bounce:Clone();
        v6.Parent = Debris;
        v6.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v6);
        VfxManager.DestroyEffect(v6, 2);
    end);
    task.delay(1.1166666666666667 - v3, function() -- Line: 55
        -- upvalues: u2 (copy), Effects (ref), SfxManager (ref), u4 (ref), Debris (ref), BALL (copy), VfxManager (ref)
        if u2.Number == 1 then
            Effects:SubtitleV2({ { "Commentator", "Off the window. To himself! King just detonated at the rim!", 4.5 } });
        elseif u2.Number == 2 then
            Effects:SubtitleV2({ { "Commentator", "Self alley. And he crushes it!", 3 } });
        end;

        SfxManager:playSound({
            Sound = `BBZ King Self Alley Voice{u2.Number}`,
            Parent = workspace
        });

        if u4 then
            local v7 = script.Pass:Clone();
            v7.Parent = Debris;
            v7.CFrame = CFrame.new(BALL.Position, u4) * CFrame.Angles(1.5707963267948966, 0, 0);
            VfxManager.Emit(v7);
            VfxManager.DestroyEffect(v7, 6);
        end;
    end);
    task.delay(1.5666666666666667 - v3, function() -- Line: 85
        -- upvalues: u4 (ref), BALL (copy), Debris (ref), VfxManager (ref)
        if u4 then
            local v8 = script.Jump:Clone();
            v8.CFrame = CFrame.new(BALL.Position, (Vector3.new(u4, BALL.Position.Y, u4))) * CFrame.Angles(-0.6108652381980153, 0, 3.141592653589793);
            v8.Parent = Debris;
            VfxManager.Emit(v8);
            VfxManager.DestroyEffect(v8, 6);
        end;
    end);
    task.delay(1.9833333333333334 - v3, function() -- Line: 95
        -- upvalues: u4 (ref), Debris (ref), VfxManager (ref)
        if u4 then
            local v9 = script.Shoot:Clone();
            v9.CFrame = CFrame.new(u4);
            v9.Parent = Debris;
            VfxManager.Emit(v9);
            VfxManager.DestroyEffect(v9, 2);
        end;
    end);
end;