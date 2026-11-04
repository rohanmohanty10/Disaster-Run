  

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
local ClientGlobals = require(ReplicatedStorage.ClientModules.ClientGlobals);
local countStyleMastery = require(ReplicatedStorage.Shared.utils.countStyleMastery);
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

function u1.Awaken(u2, p3) -- Line: 20
    -- upvalues: LocalPlayer (copy)
    u2.Camera.Cutscene = true;
    LocalPlayer.Character.Values.InCutscene.Value = true;
    LocalPlayer.PlayerGui.InGameUI.Enabled = false;
    task.delay(12, function() -- Line: 26
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
    u4.Trove:Connect(RunService.Heartbeat, function(p5) -- Line: 42
        -- upvalues: LocalPlayer (ref), u4 (copy)
        if LocalPlayer.PlayerStats.AwakeningBar.Value <= 0 or (LocalPlayer.PlayerStats.InAwakening.Value == false or LocalPlayer.Team == game.Teams.Visitor) then
            u4:Destroy();
        end;
    end);
end;

function u1.Destroy(p6) -- Line: 49
    if p6.Trove then
        p6.Trove:Destroy();
        table.clear(p6);
    end;
end;

function u1.new() -- Line: 56
    -- upvalues: ClientGlobals (copy), countStyleMastery (copy), u1 (copy), Trove (copy), Knit (copy)
    local Data = ClientGlobals.PlayerData.Data;
    local v7 = Data and Data.DisabledMasteryLevels and Data.DisabledMasteryLevels.Aiku;

    if Data and (countStyleMastery(Data, "Aiku") >= 4 and not (v7 and v7[4])) then
        return require(script.NELAwakening).new();
    end;

    local u8 = setmetatable({}, u1);
    u8.Trove = Trove.new();
    u8.Animations = Knit.GetController("AnimationController");
    u8.StatesController = Knit.GetController("StatesController");
    u8.Camera = Knit.GetController("CameraController");
    u8.AwakeningService = Knit.GetService("AwakeningService");
    u8.AwakeningService.StartAwakening:Fire();
    u8.Trove:Connect(u8.AwakeningService.StartAwakening, function(p9) -- Line: 73
        -- upvalues: u8 (copy)
        u8:Awaken(p9);
    end);

    return u8;
end;

return u1;