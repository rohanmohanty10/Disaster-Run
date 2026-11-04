  

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

function u1.Awaken(u2, p3) -- Line: 20
    -- upvalues: LocalPlayer (copy)
    print("King awakening");
    u2.Camera.Cutscene = true;
    LocalPlayer.Character.Values.InCutscene.Value = true;
    LocalPlayer.PlayerGui.InGameUI.Enabled = false;
    task.delay(18.333333333333332, function() -- Line: 27
        -- upvalues: u2 (copy), LocalPlayer (ref)
        u2.Camera.Cutscene = false;

        if LocalPlayer.Team ~= game.Teams.Visitor then
            LocalPlayer.PlayerGui.InGameUI.Enabled = true;
        end;

        u2:Awakening();
    end);
end;

function u1.Awakening(u4) -- Line: 38
    -- upvalues: LocalPlayer (copy), RunService (copy)
    LocalPlayer.Character.Values.InCutscene.Value = false;
    LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    u4.Trove:Connect(RunService.Heartbeat, function(p5) -- Line: 44
        -- upvalues: LocalPlayer (ref), u4 (copy)
        if LocalPlayer.PlayerStats.AwakeningBar.Value <= 0 or (LocalPlayer.PlayerStats.InAwakening.Value == false or LocalPlayer.Team == game.Teams.Visitor) then
            u4:Destroy();
        end;
    end);
end;

function u1.Destroy(p6) -- Line: 51
    if p6.Trove then
        p6.Trove:Destroy();
        table.clear(p6);
    end;
end;

function u1.new() -- Line: 58
    -- upvalues: u1 (copy), Trove (copy), LocalPlayer (copy), Knit (copy)
    local u7 = setmetatable({}, u1);
    u7.Trove = Trove.new();
    LocalPlayer.Character.HumanoidRootPart.Anchored = true;
    u7.Animations = Knit.GetController("AnimationController");
    u7.StatesController = Knit.GetController("StatesController");
    u7.Camera = Knit.GetController("CameraController");
    u7.AwakeningService = Knit.GetService("AwakeningService");
    u7.AwakeningService.StartAwakening:Fire();
    task.delay(3, function() -- Line: 72
        -- upvalues: LocalPlayer (ref)
        LocalPlayer.Character.HumanoidRootPart.Anchored = false;
    end);
    u7.Trove:Connect(u7.AwakeningService.StartAwakening, function(p8) -- Line: 77
        -- upvalues: LocalPlayer (ref), u7 (copy)
        LocalPlayer.Character.HumanoidRootPart.Anchored = false;
        u7:Awaken(p8);
    end);

    return u7;
end;

return u1;