 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("BALL", true);
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
        Sound = "BBZ Eclipse Sky Katana",
        Parent = HumanoidRootPart
    });

    if u4 then
        local v5 = script.Jump1:Clone();
        v5.Parent = Debris;
        v5.CFrame = CFrame.new(HumanoidRootPart.Position + Vector3.new(0, -3, 0), (Vector3.new(u4, HumanoidRootPart.Position.Y - 3, u4))) * CFrame.Angles(0.4363323129985824, 3.141592653589793, 3.141592653589793);
        VfxManager.Emit(v5);
        VfxManager.DestroyEffect(v5, 4);
    end;

    task.delay(0.5128205128205128 - v3, function() -- Line: 47
        -- upvalues: Debris (ref), HumanoidRootPart (copy), u4 (ref), VfxManager (ref)
        local v6 = script.Jump2:Clone();
        v6.Parent = Debris;
        v6.CFrame = CFrame.new(HumanoidRootPart.Position + Vector3.new(0, -3, 0), (Vector3.new(u4, HumanoidRootPart.Position.Y - 3, u4))) * CFrame.Angles(0.7853981633974483, 3.141592653589793, 3.141592653589793);
        VfxManager.Emit(v6);
        VfxManager.DestroyEffect(v6, 4);
    end);
    task.delay(1.2307692307692308 - v3, function() -- Line: 55
        -- upvalues: u4 (ref), Debris (ref), VfxManager (ref)
        if u4 then
            local v7 = script.Dunk:Clone();
            v7.CFrame = CFrame.new(u4);
            v7.Parent = Debris;
            VfxManager.Emit(v7);
            VfxManager.DestroyEffect(v7, 2);
        end;
    end);
end;