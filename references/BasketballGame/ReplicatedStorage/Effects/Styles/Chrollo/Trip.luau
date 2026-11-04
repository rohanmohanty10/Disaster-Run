 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local _ = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 12
    -- upvalues: Debris (copy), Essentials (copy), VfxManager (copy), SfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Enemy = p2.Enemy;
    local HumanoidRootPart = Enemy:FindFirstChild("HumanoidRootPart");
    local u4 = Enemy:FindFirstChild("Right Leg");
    local v5 = Enemy:FindFirstChild("Left Leg");
    local v6 = script.Step:Clone();
    v6.Parent = Debris;
    v6.CFrame = v5.CFrame * CFrame.new(0, -1, 0);
    Essentials:Weld(v6, v5);
    VfxManager.Emit(v6);
    VfxManager.DestroyEffect(v6, 4);
    task.delay(0.3333333333333333 - v3, function() -- Line: 28
        -- upvalues: Debris (ref), u4 (copy), Essentials (ref), VfxManager (ref)
        local v7 = script.Step:Clone();
        v7.Parent = Debris;
        v7.CFrame = u4.CFrame * CFrame.new(0, -1, 0);
        Essentials:Weld(v7, u4);
        VfxManager.Emit(v7);
        VfxManager.DestroyEffect(v7, 4);
    end);
    local v8 = SfxManager:playSound({
        Sound = "BBZ CurrentVision Trip",
        Parent = HumanoidRootPart
    });
    v8.PlaybackSpeed = v8.PlaybackSpeed + math.random(-100, 100) / 100 * 0.25;
end;