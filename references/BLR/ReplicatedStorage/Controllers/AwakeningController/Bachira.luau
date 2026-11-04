  

local u1 = {};
u1.__index = u1;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Popup);
local Trove = require(ReplicatedStorage.Shared.Trove);
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local countStyleMastery = require(ReplicatedStorage.Shared.utils.countStyleMastery);
local PlayerData = require(ReplicatedStorage.ClientModules.ClientGlobals).PlayerData;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

function u1.Awaken(u2, p3, p4) -- Line: 22
    -- upvalues: PlayerData (copy), countStyleMastery (copy), LocalPlayer (copy), ReplicatedStorage (copy), Essentials (copy), Debris (copy), workspace_CurrentCamera (copy), RunService (copy)
    if (not PlayerData.Data and 0 or countStyleMastery(PlayerData.Data, "Bachira")) >= 4 and not PlayerData.Data.DisabledMasteryLevels.Bachira[4] then
        print("nel bachira cs");
        require(script.NELBachira)(u2, LocalPlayer);

        return;
    end;

    print("play bachira cutscene");
    u2.Camera.Cutscene = true;
    LocalPlayer.PlayerGui.InGameUI.Enabled = false;
    local u5 = ReplicatedStorage.Assets.Misc.CameraRig:Clone();
    u5.Parent = workspace;
    u5.PrimaryPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.25, 0) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
    Essentials:Weld(u5.PrimaryPart, LocalPlayer.Character.HumanoidRootPart);
    local u6 = u5.AnimationController:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.Bachira);
    u6:Play();
    task.delay(7.5, function() -- Line: 52
        -- upvalues: u6 (copy), u5 (copy)
        if u6 then
            u6:Stop();
            u6:Destroy();
        end;

        if u5 then
            u5:Destroy();
        end;
    end);
    print(7.5);
    local PlayingAnimationTracks = p4.AnimationController.Animator:GetPlayingAnimationTracks();

    for _, v in pairs(PlayingAnimationTracks) do
        v:Stop();
    end;

    table.clear(PlayingAnimationTracks);
    local v7 = p4.AnimationController:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.Monster);
    v7:Play();
    Debris:AddItem(v7, 15);
    local CFrame2 = workspace_CurrentCamera.CFrame;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local u8 = RunService.Heartbeat:Connect(function() -- Line: 78
        -- upvalues: workspace_CurrentCamera (ref), u5 (copy)
        workspace_CurrentCamera.CFrame = u5.camera.CFrame;
    end);
    local u9 = false;
    task.delay(5, function() -- Line: 84
        -- upvalues: u6 (copy), u5 (copy), u9 (ref), u2 (copy), LocalPlayer (ref), workspace_CurrentCamera (ref), CFrame2 (copy), u8 (ref)
        local u10 = nil;
        u10 = u6.Stopped:Connect(function() -- Line: 86
            -- upvalues: u5 (ref), u9 (ref), u2 (ref), LocalPlayer (ref), workspace_CurrentCamera (ref), CFrame2 (ref), u10 (ref), u8 (ref)
            u5:Destroy();
            u9 = true;
            u2.Camera.Cutscene = false;

            if LocalPlayer.Team ~= game.Teams.Visitor then
                LocalPlayer.PlayerGui.InGameUI.Enabled = true;
            end;

            workspace_CurrentCamera.CFrame = CFrame2;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            u10:Disconnect();
            u8:Disconnect();
            workspace_CurrentCamera.CFrame = CFrame2;
            u2:Awakening();
        end);
    end);
    task.delay(7.5, function() -- Line: 107
        -- upvalues: u9 (ref), u2 (copy), LocalPlayer (ref), workspace_CurrentCamera (ref), u8 (ref)
        if not u9 then
            u9 = true;
            u2.Camera.Cutscene = false;

            if LocalPlayer.Team ~= game.Teams.Visitor then
                LocalPlayer.PlayerGui.InGameUI.Enabled = true;
            end;

            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            u2:Awakening();
            u8:Disconnect();
        end;
    end);
end;

function u1.Awakening(u11) -- Line: 125
    -- upvalues: LocalPlayer (copy), RunService (copy)
    LocalPlayer.Character.Values.InCutscene.Value = false;
    LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    u11.Trove:Connect(LocalPlayer.Character.Values.Dribbling:GetPropertyChangedSignal("Value"), function() -- Line: 129
        -- upvalues: LocalPlayer (ref), u11 (copy)
        if LocalPlayer.Character.Values.Dribbling.Value then
            u11.StatesController.SpeedBoost2 = 2;
            task.delay(1, function() -- Line: 132
                -- upvalues: u11 (ref)
                if u11.StatesController.SpeedBoost2 == 2 then
                    u11.StatesController.SpeedBoost2 = 0;
                end;
            end);
        end;
    end);
    u11.Trove:Connect(RunService.Heartbeat, function(p12) -- Line: 140
        -- upvalues: LocalPlayer (ref), u11 (copy)
        if LocalPlayer.PlayerStats.AwakeningBar.Value <= 0 or (LocalPlayer.PlayerStats.InAwakening.Value == false or LocalPlayer.Team == game.Teams.Visitor) then
            u11:Destroy();
        end;
    end);
end;

function u1.Destroy(p13) -- Line: 147
    if p13.Trove then
        p13.Trove:Destroy();
        table.clear(p13);
    end;
end;

function u1.new() -- Line: 154
    -- upvalues: u1 (copy), Trove (copy), LocalPlayer (copy), Knit (copy)
    local u14 = setmetatable({}, u1);
    u14.Trove = Trove.new();
    LocalPlayer.Character.HumanoidRootPart.Anchored = true;
    u14.Animations = Knit.GetController("AnimationController");
    u14.StatesController = Knit.GetController("StatesController");
    u14.Camera = Knit.GetController("CameraController");
    u14.AwakeningService = Knit.GetService("AwakeningService");
    u14.AwakeningService.StartAwakening:Fire();
    task.delay(3, function() -- Line: 168
        -- upvalues: LocalPlayer (ref)
        LocalPlayer.Character.HumanoidRootPart.Anchored = false;
    end);
    u14.Trove:Connect(u14.AwakeningService.StartAwakening, function(p15, p16) -- Line: 172
        -- upvalues: u14 (copy)
        u14:Awaken(p15, p16);
    end);

    return u14;
end;

return u1;