  

local u1 = {};
u1.__index = u1;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Popup);
local Trove = require(ReplicatedStorage.Shared.Trove);
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

function u1.Awaken(p2, p3) -- Line: 18
end;

function u1.Awakening(u4) -- Line: 24
    -- upvalues: LocalPlayer (copy), RunService (copy)
    LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    LocalPlayer.Character.Values.InCutscene.Value = false;
    u4.Trove:Connect(RunService.Heartbeat, function(p5) -- Line: 28
        -- upvalues: LocalPlayer (ref), u4 (copy)
        if LocalPlayer.PlayerStats.AwakeningBar.Value <= 0 or (LocalPlayer.PlayerStats.InAwakening.Value == false or LocalPlayer.Team == game.Teams.Visitor) then
            u4:Destroy();
        end;
    end);
end;

function u1.Destroy(p6) -- Line: 35
    if p6.Trove then
        p6.Trove:Destroy();
        table.clear(p6);
    end;
end;

function u1.new() -- Line: 42
    -- upvalues: u1 (copy), Trove (copy), LocalPlayer (copy), Knit (copy)
    local u7 = setmetatable({}, u1);
    u7.Trove = Trove.new();
    LocalPlayer.Character.HumanoidRootPart.Anchored = true;
    u7.Animations = Knit.GetController("AnimationController");
    u7.StatesController = Knit.GetController("StatesController");
    u7.Camera = Knit.GetController("CameraController");
    u7.AwakeningService = Knit.GetService("AwakeningService");
    u7.AwakeningService.StartAwakening:Fire();
    task.delay(3, function() -- Line: 56
        -- upvalues: LocalPlayer (ref)
        LocalPlayer.Character.HumanoidRootPart.Anchored = false;
    end);
    u7.Trove:Connect(u7.AwakeningService.StartAwakening, function(p8) -- Line: 60
        -- upvalues: LocalPlayer (ref), u7 (copy)
        LocalPlayer.Character.HumanoidRootPart.Anchored = false;
        u7:Awaken(p8);
    end);

    return u7;
end;

return u1;