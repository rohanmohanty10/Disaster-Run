  

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
require(ReplicatedStorage.Controllers.AnimationController);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

function u1.Awaken(p2, p3) -- Line: 19
end;

function u1.Awakening(u4) -- Line: 38
    -- upvalues: LocalPlayer (copy), RunService (copy)
    print("client awk script");
    LocalPlayer.Character.Values.InCutscene.Value = false;
    LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    u4.Trove:Connect(RunService.Heartbeat, function(p5) -- Line: 43
        -- upvalues: LocalPlayer (ref), u4 (copy)
        if LocalPlayer.PlayerStats.AwakeningBar.Value <= 0 or (LocalPlayer.PlayerStats.InAwakening.Value == false or LocalPlayer.Team == game.Teams.Visitor) then
            u4:Destroy();
        end;
    end);
end;

function u1.Destroy(p6) -- Line: 50
    if p6.Trove then
        p6.Trove:Destroy();
        table.clear(p6);
    end;
end;

function u1.new() -- Line: 57
    -- upvalues: u1 (copy), interface (copy), Trove (copy), Knit (copy)
    local u7 = setmetatable({}, u1);
    interface.RinTwoStepsBehindUsed = nil;
    interface.RinTwoStepsBehindPending = nil;
    u7.Trove = Trove.new();
    u7.Animations = Knit.GetController("AnimationController");
    u7.StatesController = Knit.GetController("StatesController");
    u7.Camera = Knit.GetController("CameraController");
    u7.AwakeningService = Knit.GetService("AwakeningService");
    u7.AwakeningService.StartAwakening:Fire();
    u7.Trove:Connect(u7.AwakeningService.StartAwakening, function(p8) -- Line: 73
        -- upvalues: u7 (copy)
        u7:Awaken(p8);
    end);

    return u7;
end;

return u1;