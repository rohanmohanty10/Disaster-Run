  

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
local Raycast = require(ReplicatedStorage.Shared.Raycast);
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

function u1.Awaken(u2, p3) -- Line: 19
    -- upvalues: LocalPlayer (copy), Raycast (copy), ReplicatedStorage (copy), Essentials (copy), workspace_CurrentCamera (copy), RunService (copy)
    u2.Camera.Cutscene = true;
    LocalPlayer.PlayerGui.InGameUI.Enabled = false;
    u2.Animations.Ball.OtoyaPlr.Priority = Enum.AnimationPriority.Action4;
    u2.Animations.Ball.OtoyaPlr:Play();
    local HumanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
    local v4 = Raycast.Cast(HumanoidRootPart.Position, Vector3.new(0, -20, 0), nil, nil, true);

    if v4 then
        local Normal = v4.Normal;
        HumanoidRootPart.CFrame = CFrame.fromMatrix(v4.Position + Vector3.new(0, 3, 0), Normal, Normal:Cross(HumanoidRootPart.CFrame.LookVector)) * CFrame.Angles(0, 0, -1.5707963267948966);
    end;

    for _, child in workspace.Colliders:GetChildren() do
        child.CanCollide = false;
    end;

    task.delay(5, function() -- Line: 38
        for _, child in workspace.Colliders:GetChildren() do
            child.CanCollide = true;
        end;
    end);
    local u5 = ReplicatedStorage.Assets.Misc.Igaguri.CameraRig:Clone();
    u5.Name = "NagiCam";
    u5.Parent = workspace;
    u5.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
    Essentials:Weld(u5.PrimaryPart, LocalPlayer.Character.HumanoidRootPart);
    local u6 = u5.AnimationController:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.OtoyaCam);
    u6:Play();
    task.delay(4.6, function() -- Line: 54
        -- upvalues: u6 (copy), u5 (copy)
        if u6 then
            u6:Stop();
            u6:Destroy();
        end;

        if u5 then
            u5:Destroy();
        end;
    end);
    local CFrame2 = workspace_CurrentCamera.CFrame;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local u7 = false;
    local u8 = RunService.Heartbeat:Connect(function() -- Line: 71
        -- upvalues: workspace_CurrentCamera (ref), u5 (copy)
        workspace_CurrentCamera.CFrame = u5.CamPart.CFrame;
    end);
    local u9 = nil;
    task.spawn(function() -- Line: 76
        -- upvalues: u9 (ref), u6 (copy), u5 (copy), u7 (ref), u2 (copy), LocalPlayer (ref), workspace_CurrentCamera (ref), CFrame2 (copy), u8 (ref)
        local v10 = 0;

        if v10 < 50 then
            local _ = v10 + 1;
            task.wait(0.1);
        end;

        u9 = u6.Stopped:Connect(function() -- Line: 87
            -- upvalues: u5 (ref), u7 (ref), u2 (ref), LocalPlayer (ref), workspace_CurrentCamera (ref), CFrame2 (ref), u9 (ref), u8 (ref)
            u5:Destroy();
            u7 = true;
            u2.Camera.Cutscene = false;

            if LocalPlayer.Team ~= game.Teams.Visitor then
                LocalPlayer.PlayerGui.InGameUI.Enabled = true;
            end;

            workspace_CurrentCamera.CFrame = CFrame2;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            u9:Disconnect();
            u8:Disconnect();
            workspace_CurrentCamera.CFrame = CFrame2;
            u2:Awakening();
        end);
    end);
    task.delay(4.6, function() -- Line: 108
        -- upvalues: u7 (ref), u2 (copy), LocalPlayer (ref), workspace_CurrentCamera (ref), u9 (ref), u8 (ref)
        if not u7 then
            u7 = true;
            u2.Camera.Cutscene = false;

            if LocalPlayer.Team ~= game.Teams.Visitor then
                LocalPlayer.PlayerGui.InGameUI.Enabled = true;
            end;

            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;

            if u9 then
                u9:Disconnect();
            end;

            u8:Disconnect();
            u2:Awakening();
        end;
    end);
end;

function u1.Awakening(u11) -- Line: 129
    -- upvalues: LocalPlayer (copy), RunService (copy)
    LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    LocalPlayer.Character.Values.InCutscene.Value = false;
    u11.Trove:Connect(RunService.Heartbeat, function(p12) -- Line: 133
        -- upvalues: LocalPlayer (ref), u11 (copy)
        if LocalPlayer.PlayerStats.AwakeningBar.Value <= 0 or (LocalPlayer.PlayerStats.InAwakening.Value == false or LocalPlayer.Team == game.Teams.Visitor) then
            u11:Destroy();
        end;
    end);
end;

function u1.Destroy(p13) -- Line: 140
    if p13.Trove then
        p13.Trove:Destroy();
        table.clear(p13);
    end;
end;

function u1.new() -- Line: 147
    -- upvalues: u1 (copy), Trove (copy), LocalPlayer (copy), Knit (copy)
    local u14 = setmetatable({}, u1);
    u14.Trove = Trove.new();
    LocalPlayer.Character.HumanoidRootPart.Anchored = true;
    u14.Animations = Knit.GetController("AnimationController");
    u14.StatesController = Knit.GetController("StatesController");
    u14.Camera = Knit.GetController("CameraController");
    u14.AwakeningService = Knit.GetService("AwakeningService");
    u14.AwakeningService.StartAwakening:Fire();
    task.delay(3, function() -- Line: 161
        -- upvalues: LocalPlayer (ref)
        LocalPlayer.Character.HumanoidRootPart.Anchored = false;
    end);
    u14.Trove:Connect(u14.AwakeningService.StartAwakening, function(p15) -- Line: 165
        -- upvalues: LocalPlayer (ref), u14 (copy)
        LocalPlayer.Character.HumanoidRootPart.Anchored = false;
        u14:Awaken(p15);
    end);

    return u14;
end;

return u1;