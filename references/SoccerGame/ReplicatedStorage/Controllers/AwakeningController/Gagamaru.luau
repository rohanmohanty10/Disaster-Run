  

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
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

function u1.Awaken(u2, p3) -- Line: 18
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), Essentials (copy), workspace_CurrentCamera (copy), RunService (copy)
    u2.Camera.Cutscene = true;
    LocalPlayer.PlayerGui.InGameUI.Enabled = false;
    local u4 = ReplicatedStorage.Assets.Misc.CameraRig:Clone();
    u4.Parent = workspace;
    u4.PrimaryPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.25, 0) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
    Essentials:Weld(u4.PrimaryPart, LocalPlayer.Character.HumanoidRootPart);
    local u5 = u4.AnimationController:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.Gagamaru);
    u5:Play();
    task.delay(5.68, function() -- Line: 35
        -- upvalues: u5 (copy), u4 (copy)
        if u5 then
            u5:Stop();
            u5:Destroy();
        end;

        if u4 then
            u4:Destroy();
        end;
    end);
    local CFrame2 = workspace_CurrentCamera.CFrame;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local u6 = false;
    local u7 = RunService.Heartbeat:Connect(function() -- Line: 53
        -- upvalues: workspace_CurrentCamera (ref), u4 (copy)
        workspace_CurrentCamera.CFrame = u4.camera.CFrame;
    end);
    local u8 = nil;
    task.spawn(function() -- Line: 58
        -- upvalues: u8 (ref), u5 (copy), u4 (copy), u6 (ref), u2 (copy), LocalPlayer (ref), workspace_CurrentCamera (ref), CFrame2 (copy), u7 (ref)
        local v9 = 0;

        if v9 < 50 then
            local _ = v9 + 1;
            task.wait(0.1);
        end;

        u8 = u5.Stopped:Connect(function() -- Line: 69
            -- upvalues: u4 (ref), u6 (ref), u2 (ref), LocalPlayer (ref), workspace_CurrentCamera (ref), CFrame2 (ref), u8 (ref), u7 (ref)
            u4:Destroy();
            u6 = true;
            u2.Camera.Cutscene = false;

            if LocalPlayer.Team ~= game.Teams.Visitor then
                LocalPlayer.PlayerGui.InGameUI.Enabled = true;
            end;

            workspace_CurrentCamera.CFrame = CFrame2;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            u8:Disconnect();
            u7:Disconnect();
            workspace_CurrentCamera.CFrame = CFrame2;
            u2:Awakening();
        end);
    end);
    task.delay(5.68, function() -- Line: 90
        -- upvalues: u6 (ref), u2 (copy), LocalPlayer (ref), workspace_CurrentCamera (ref), u8 (ref), u7 (ref)
        if not u6 then
            u6 = true;
            u2.Camera.Cutscene = false;

            if LocalPlayer.Team ~= game.Teams.Visitor then
                LocalPlayer.PlayerGui.InGameUI.Enabled = true;
            end;

            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;

            if u8 then
                u8:Disconnect();
            end;

            u7:Disconnect();
            u2:Awakening();
        end;
    end);
end;

function u1.Awakening(u10) -- Line: 111
    -- upvalues: LocalPlayer (copy), RunService (copy)
    LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    LocalPlayer.Character.Values.InCutscene.Value = false;
    u10.Trove:Connect(RunService.Heartbeat, function(p11) -- Line: 115
        -- upvalues: LocalPlayer (ref), u10 (copy)
        if LocalPlayer.PlayerStats.AwakeningBar.Value <= 0 or (LocalPlayer.PlayerStats.InAwakening.Value == false or LocalPlayer.Team == game.Teams.Visitor) then
            u10:Destroy();
        end;
    end);
end;

function u1.Destroy(p12) -- Line: 122
    if p12.Trove then
        p12.Trove:Destroy();
        table.clear(p12);
    end;
end;

function u1.new() -- Line: 129
    -- upvalues: u1 (copy), Trove (copy), LocalPlayer (copy), Knit (copy)
    local u13 = setmetatable({}, u1);
    u13.Trove = Trove.new();
    LocalPlayer.Character.HumanoidRootPart.Anchored = true;
    task.delay(3, function() -- Line: 135
        -- upvalues: LocalPlayer (ref)
        LocalPlayer.Character.HumanoidRootPart.Anchored = false;
    end);
    u13.Animations = Knit.GetController("AnimationController");
    u13.StatesController = Knit.GetController("StatesController");
    u13.Camera = Knit.GetController("CameraController");
    u13.AwakeningService = Knit.GetService("AwakeningService");
    u13.AwakeningService.StartAwakening:Fire();
    u13.Trove:Connect(u13.AwakeningService.StartAwakening, function(p14) -- Line: 148
        -- upvalues: LocalPlayer (ref), u13 (copy)
        LocalPlayer.Character.HumanoidRootPart.Anchored = false;
        u13:Awaken(u13.Player, p14);
    end);

    return u13;
end;

return u1;