 
 

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

return function(p1, p2) -- Line: 15
    -- upvalues: Players (copy), SfxManager (copy), Debris (copy), VfxManager (copy), Effects (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local v4 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("BALL", true);
    local Hoops = workspace:FindFirstChild("Hoops");
    local u5 = nil;

    if Hoops then
        local Hoop = Hoops.Home.Hoop;
        local Hoop2 = Hoops.Away.Hoop;

        if Hoop and Hoop2 then
            u5 = (HumanoidRootPart.Position - Hoop2.Position).Magnitude < (HumanoidRootPart.Position - Hoop.Position).Magnitude and Hoop2.Position or Hoop.Position;
        end;
    end;

    if p2.Task == "Swing" then
        SfxManager:playSound({
            Sound = "BBZ Popstar Guitar Slam Swing",
            Parent = HumanoidRootPart
        });
        task.delay(0.6333333333333333 - v3, function() -- Line: 41
            -- upvalues: u5 (ref), Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            if u5 then
                local v6 = script.Hit:Clone();
                v6.Parent = Debris;
                v6.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(u5.X, HumanoidRootPart.Position.Y, u5.Z))) * CFrame.new(0, 0, -5) * CFrame.Angles(0.3490658503988659, 0, 0);
                VfxManager.Emit(v6);
                VfxManager.DestroyEffect(v6, 4);
            end;
        end);
        local u7 = script.FlashStep1:Clone();
        u7.Parent = Debris;
        u7.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, 0, 1.5707963267948966);
        task.delay(1.0333333333333334 - v3, function() -- Line: 55
            -- upvalues: VfxManager (ref), u7 (copy)
            VfxManager.Emit(u7);
            VfxManager.DestroyEffect(u7, 2);
        end);
    elseif p2.Task == "Slam" then
        Effects:SubtitleV2({
            { v4, "Here comes the shining dunk!", 2.5 }
        });
        SfxManager:playSound({
            Sound = "BBZ Popstar Guitar Slam Slam",
            Parent = HumanoidRootPart
        });
        SfxManager:playSound({
            Sound = "BBZ Popstar Guitar Slam Voice",
            Parent = HumanoidRootPart
        });
        local v8 = script.FlashStep2:Clone();
        v8.Parent = Debris;
        v8.CFrame = CFrame.new(HumanoidRootPart.Position.X, 4, HumanoidRootPart.Position.Z) * CFrame.Angles(0, 0, 1.5707963267948966);
        VfxManager.Emit(v8);
        VfxManager.DestroyEffect(v8, 2);
        task.delay(0.6 - v3, function() -- Line: 77
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            local v9 = script.Jump:Clone();
            v9:PivotTo(CFrame.new(HumanoidRootPart.Position.X, 5, HumanoidRootPart.Position.Z));
            v9.Parent = Debris;
            VfxManager.Emit(v9);
            VfxManager.DestroyEffect(v9, 4);
            local v10 = script.FlashStep3:Clone();
            v10.Parent = Debris;
            v10.CFrame = CFrame.new(HumanoidRootPart.Position.X, 36, HumanoidRootPart.Position.Z) * CFrame.Angles(0, 0, 1.5707963267948966);
            VfxManager.Emit(v10);
            VfxManager.DestroyEffect(v10, 2);
        end);
        task.delay(1.2 - v3, function() -- Line: 91
            -- upvalues: u5 (ref), Debris (ref), VfxManager (ref)
            if u5 then
                local v11 = script.Shoot:Clone();
                v11.CFrame = CFrame.new(u5) * CFrame.Angles(-1.5707963267948966, 0, 0);
                v11.Parent = Debris;
                VfxManager.Emit(v11);
                VfxManager.DestroyEffect(v11, 2);
            end;
        end);
    end;
end;