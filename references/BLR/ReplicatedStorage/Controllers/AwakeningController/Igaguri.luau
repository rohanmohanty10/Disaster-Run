  

local u1 = {};
u1.__index = u1;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local StarterGui = game:GetService("StarterGui");
require(ReplicatedStorage.Shared.Popup);
local Trove = require(ReplicatedStorage.Shared.Trove);
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

function u1.Awaken(u2, u3) -- Line: 19
    -- upvalues: LocalPlayer (copy), workspace_CurrentCamera (copy), RunService (copy)
    u2.Camera.Cutscene = true;
    LocalPlayer.PlayerGui.InGameUI.Enabled = false;
    local _ = workspace_CurrentCamera.CFrame;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local u4 = false;
    local u6 = RunService.Heartbeat:Connect(function() -- Line: 52
        -- upvalues: u3 (copy), workspace_CurrentCamera (ref)
        local v5 = u3:FindFirstChild("Torso") or (u3:FindFirstChild("camera") or u3:FindFirstChild("CamPart"));

        if not v5 then
            return;
        end;

        workspace_CurrentCamera.CFrame = v5.CFrame;
    end);
    task.delay(8, function() -- Line: 94
        -- upvalues: u4 (ref), u2 (copy), LocalPlayer (ref), workspace_CurrentCamera (ref), u6 (ref)
        if not u4 then
            u4 = true;
            u2.Camera.Cutscene = false;

            if LocalPlayer.Team ~= game.Teams.Visitor then
                LocalPlayer.PlayerGui.InGameUI.Enabled = true;
            end;

            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            u6:Disconnect();
            u2:Awakening();
        end;
    end);
end;

function u1.Awakening(u7) -- Line: 115
    -- upvalues: LocalPlayer (copy), RunService (copy)
    LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    LocalPlayer.Character.Values.InCutscene.Value = false;
    u7.Trove:Connect(RunService.Heartbeat, function(p8) -- Line: 119
        -- upvalues: LocalPlayer (ref), u7 (copy)
        if LocalPlayer.PlayerStats.AwakeningBar.Value <= 0 or (LocalPlayer.PlayerStats.InAwakening.Value == false or LocalPlayer.Team == game.Teams.Visitor) then
            u7:Destroy();
        end;
    end);
end;

function u1.Destroy(p9) -- Line: 126
    -- upvalues: StarterGui (copy)
    if p9.Trove then
        local _, _ = pcall(function() -- Line: 128
            -- upvalues: StarterGui (ref)
            return StarterGui:SetCore("ResetButtonCallback", true);
        end);
        p9.Trove:Destroy();
        task.wait();

        if not p9.OkDestroyThankYou then
            repeat
                task.wait();
            until p9.OkDestroyThankYou;
        end;

        table.clear(p9);
    end;
end;

function u1.new() -- Line: 139
    -- upvalues: u1 (copy), Trove (copy), LocalPlayer (copy), Knit (copy)
    local u10 = setmetatable({}, u1);
    u10.Trove = Trove.new();
    LocalPlayer.Character.HumanoidRootPart.Anchored = true;
    u10.Animations = Knit.GetController("AnimationController");
    u10.StatesController = Knit.GetController("StatesController");
    u10.Camera = Knit.GetController("CameraController");
    u10.OkDestroyThankYou = true;
    u10.AwakeningService = Knit.GetService("AwakeningService");
    u10.AbilityService = Knit.GetService("AbilityService");
    u10.AwakeningService.StartAwakening:Fire();
    task.delay(3, function() -- Line: 155
        -- upvalues: LocalPlayer (ref)
        LocalPlayer.Character.HumanoidRootPart.Anchored = false;
    end);
    u10.Trove:Connect(u10.AwakeningService.StartAwakening, function(p11) -- Line: 159
        -- upvalues: LocalPlayer (ref), u10 (copy)
        LocalPlayer.Character.HumanoidRootPart.Anchored = false;
        u10:Awaken(p11);
    end);

    return u10;
end;

return u1;