  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local CutsceneUtils = require(ReplicatedStorage2.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage2.Controllers.SpectatorController);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 20
    -- upvalues: SpectatorController (copy), SoundManager (copy), RunService (copy), CutsceneUtils (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local _ = p1.EnemyChar;
    SoundManager.SpawnSound("BachiraAwkNewest", 0.6, workspace, 150);
    local v2 = script.Reo:Clone();
    local v3 = script.Nagi:Clone();
    local v4 = script.Nagi:Clone();
    local script_CamAnim = script.CamAnim;
    local u5 = script.Cam:Clone();
    u5:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0));
    u5.Parent = workspace;
    u5.AnimationController.Animator:LoadAnimation(script_CamAnim):Play();
    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local v6 = RunService.Heartbeat:Connect(function() -- Line: 47
        -- upvalues: u5 (copy)
        workspace.CurrentCamera.CFrame = u5.CamPart.CFrame;
    end);
    CutsceneUtils.PlayCutscene(Char, {
        TemplateR6 = Char,
        rig1 = v2,
        rig2 = v3,
        rig3 = v4
    }, "BachiraAwk", script.CodeEvents);
    v6:Disconnect();
    u5:Destroy();
    v2:Destroy();
    v3:Destroy();
end;