  

local u1 = {};
u1.__index = u1;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Popup);
local Trove = require(ReplicatedStorage.Shared.Trove);
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Modules.CutsceneUtils);
require(ReplicatedStorage.Shared.utils.countStyleMastery);
local _ = require(ReplicatedStorage.ClientModules.ClientGlobals).PlayerData;
local LocalPlayer = game.Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

function u1.Awaken(u2, p3) -- Line: 24
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), Essentials (copy), workspace_CurrentCamera (copy), RunService (copy)
    u2.Camera.Cutscene = true;
    LocalPlayer.PlayerGui.InGameUI.Enabled = false;
    print("Isagi client awaken");
    local u4 = ReplicatedStorage.Assets.Misc.CameraRig:Clone();
    u4.Parent = workspace;
    u4.PrimaryPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, -0.75) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
    Essentials:Weld(u4.PrimaryPart, LocalPlayer.Character.HumanoidRootPart);
    u2.CamAnim = u4.AnimationController:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.Isagi);
    u2.CamAnim:Play();
    task.delay(15, function() -- Line: 42
        -- upvalues: u2 (copy)
        if u2.CamAnim then
            u2.CamAnim:Destroy();
        end;
    end);
    local CFrame2 = workspace_CurrentCamera.CFrame;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local u5 = RunService.Heartbeat:Connect(function() -- Line: 52
        -- upvalues: workspace_CurrentCamera (ref), u4 (copy)
        workspace_CurrentCamera.CFrame = u4.camera.CFrame;
    end);
    print(os.time());
    task.spawn(function() -- Line: 58
        -- upvalues: u2 (copy), u4 (copy), LocalPlayer (ref), workspace_CurrentCamera (ref), CFrame2 (copy), u5 (ref)
        local v6 = 0;

        while v6 < 50 do
            v6 = v6 + 1;
            task.wait(0.1);

            if u2.CamAnim.Length > 3 then
                break;
            end;
        end;

        local u7 = nil;
        u7 = u2.CamAnim.Stopped:Connect(function() -- Line: 71
            -- upvalues: u4 (ref), u2 (ref), LocalPlayer (ref), workspace_CurrentCamera (ref), CFrame2 (ref), u7 (ref), u5 (ref)
            u4:Destroy();
            u2.Camera.Cutscene = false;
            LocalPlayer.Character.HumanoidRootPart.Anchored = false;

            if LocalPlayer.Team ~= game.Teams.Visitor then
                LocalPlayer.PlayerGui.InGameUI.Enabled = true;
            end;

            print(os.time());
            workspace_CurrentCamera.CFrame = CFrame2;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
            workspace_CurrentCamera.CFrame = CFrame2;
            u7:Disconnect();
            u5:Disconnect();
            u2.StatesController.SpeedBoost = 3;
            u2:Surrounding();
        end);
    end);
end;

function u1.Destroy(u8) -- Line: 97
    -- upvalues: Players (copy)
    if u8.Trove then
        u8.Trove:Destroy();
    end;

    task.spawn(function() -- Line: 102
        -- upvalues: u8 (copy)
        game.Lighting.ColorCorrection.TintColor = Color3.new(1, 1, 1);
        u8.StatesController.SpeedBoost = 0;
    end);
    local Players2 = Players:GetPlayers();

    for _, v in pairs(Players2) do
        if v.Character:FindFirstChild("Highlight") then
            v.Character.Highlight:Destroy();
        end;
    end;

    table.clear(Players2);
    table.clear(u8);
end;

function u1.Surrounding(u9) -- Line: 119
    -- upvalues: LocalPlayer (copy), RunService (copy), Players (copy)
    LocalPlayer.PlayerGui.InGameUI.Enabled = true;
    LocalPlayer.Character.Values.InCutscene.Value = false;
    u9.Trove:Connect(RunService.Heartbeat, function(p10) -- Line: 123
        -- upvalues: Players (ref), LocalPlayer (ref), u9 (copy)
        local Players2 = Players:GetPlayers();

        for _, v in pairs(Players2) do
            if v.Team == LocalPlayer.Team and (v ~= LocalPlayer and (v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil)) then
                if v.Character:FindFirstChild("Highlight") == nil then
                    local Highlight = Instance.new("Highlight");
                    Highlight.Parent = v.Character;
                    Highlight.FillTransparency = 0.75;
                else
                    local v11 = v;
                    local v12 = 0;

                    for _, v2 in pairs(Players2) do
                        if v2.Team ~= v11.Team and (v2.Character.HumanoidRootPart.Position - v11.Character.HumanoidRootPart.Position).Magnitude <= 50 then
                            v12 = v12 + 1;
                        end;
                    end;

                    v11.Character.Highlight.FillColor = Color3.new(1, v12 / 3, v12 / 3);
                end;
            end;
        end;

        table.clear(Players2);

        if LocalPlayer.PlayerStats.AwakeningBar.Value <= 0 or LocalPlayer.PlayerStats.InAwakening.Value == false then
            u9:Destroy();
        end;
    end);
end;

function u1.new(p13: userdata) -- Line: 162
    -- upvalues: u1 (copy), Trove (copy), LocalPlayer (copy), Knit (copy)
    local u14 = setmetatable({}, u1);
    u14.Trove = Trove.new();
    LocalPlayer.Character.HumanoidRootPart.Anchored = true;
    print("start isagi awk client -------");
    u14.Animations = Knit.GetController("AnimationController");
    u14.StatesController = Knit.GetController("StatesController");
    u14.Camera = Knit.GetController("CameraController");
    u14.AwakeningService = Knit.GetService("AwakeningService");
    u14.AwakeningService.StartAwakening:Fire();
    task.delay(3, function() -- Line: 176
        -- upvalues: LocalPlayer (ref)
        LocalPlayer.Character.HumanoidRootPart.Anchored = false;
    end);
    u14.Trove:Connect(u14.AwakeningService.StartAwakening, function() -- Line: 180
        -- upvalues: LocalPlayer (ref), u14 (copy)
        LocalPlayer.Character.HumanoidRootPart.Anchored = false;
        u14:Awaken();
    end);

    return u14;
end;

return u1;