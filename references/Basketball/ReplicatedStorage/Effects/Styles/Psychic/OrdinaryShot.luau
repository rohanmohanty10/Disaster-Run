 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task ~= "Activate" then
        if p2.Task == "TP" then
            SfxManager:playSound({
                Sound = "BBZ Psychic teleport aura turn thing",
                Parent = HumanoidRootPart
            });
            local Origin = p2.Origin;
            local Goal = p2.Goal;
            local v4 = script.TP:Clone();
            v4:PivotTo(Origin);
            v4.Parent = Debris;
            VfxManager.Emit(v4);
            VfxManager.DestroyEffect(v4, 3);
            local v5 = script.TP:Clone();
            v5:PivotTo(Goal);
            v5.Parent = Debris;
            VfxManager.Emit(v5);
            VfxManager.DestroyEffect(v5, 3);
        end;

        return;
    end;

    task.wait(0.08);
    SfxManager:playSound({
        Sound = "BBZ Psychic lazy shot",
        Parent = HumanoidRootPart
    });
    task.delay(0.267 - v3, function() -- Line: 29
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        local v6 = script.Shoot:Clone();
        v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 2, -1.5) * CFrame.Angles(-0.7853981633974483, 0, 0);
        v6.Parent = Debris;
        VfxManager.Emit(v6);
        VfxManager.DestroyEffect(v6, 3);
    end);
end;