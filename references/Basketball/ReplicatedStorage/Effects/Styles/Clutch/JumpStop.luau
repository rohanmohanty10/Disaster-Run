 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local Raycast = require(ReplicatedStorage.Shared.Utility.Raycast);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 14
    -- upvalues: SfxManager (copy), Raycast (copy), VfxManager (copy), Debris (copy)
    local Character = p2.Character;
    local v3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v4 = p2.InZone and 1.25 or 1;
    SfxManager:playSound({
        Sound = "JumpStop",
        Duration = 3,
        Parent = HumanoidRootPart
    });
    local v5 = Raycast.Cast(HumanoidRootPart.Position, Vector3.new(0, -10, 0), nil, nil, true);

    if v5 then
        local v6 = script.Fall:Clone();
        v6.Parent = workspace.Debris;
        v6.CFrame = CFrame.new(v5.Position) * CFrame.new(0, 1.3, 0);
        VfxManager.Emit(v6);
        Debris:AddItem(v6, 5);
    end;

    task.delay(0.6 - v3 / v4, function() -- Line: 35
        -- upvalues: Raycast (ref), HumanoidRootPart (copy), VfxManager (ref), Debris (ref)
        local v7 = Raycast.Cast(HumanoidRootPart.Position, Vector3.new(0, -10, 0), nil, nil, true);

        if v7 then
            local v8 = script.Fall:Clone();
            v8.Parent = workspace.Debris;
            v8.CFrame = CFrame.new(v7.Position) * CFrame.new(0, 1.3, 0);
            VfxManager.Emit(v8);
            Debris:AddItem(v8, 5);
        end;
    end);
    task.delay(0.8 - v3 / v4, function() -- Line: 46
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        local v9 = HumanoidRootPart.CFrame * CFrame.new(0, 3, -3);
        local v10 = script.Shot:Clone();
        v10.Parent = workspace.Debris;
        v10.CFrame = v9;
        Debris:AddItem(v10, 5);
        VfxManager.Emit(v10);
    end);
end;