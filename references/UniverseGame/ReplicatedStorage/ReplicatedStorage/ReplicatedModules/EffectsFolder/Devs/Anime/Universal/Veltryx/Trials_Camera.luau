  

 

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 19
    -- upvalues: LocalPlayer (copy), CurrentCamera (copy), RunService (copy), TweenService (copy)
    local Arena = p1.Arena;
    local v2 = p1.AcceleronTime or 6.25;
    local v3 = p1.NpcTime or 3;
    local StartTime = p1.StartTime;
    local u4 = v3 + v2 + (p1.FadeTime or 0.75) * 2;

    if not Arena then
        return;
    end;

    local u5 = nil;
    local CinematicBlackBars = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("CinematicBlackBars");
    CinematicBlackBars.Enabled = true;
    CinematicBlackBars.Upper.Position = UDim2.fromScale(0.5, -0.88);
    CinematicBlackBars.Upper.Rotation = 0;
    CinematicBlackBars.Lower.Position = UDim2.fromScale(0.5, 0.88);
    CinematicBlackBars.Lower.Rotation = 0;
    CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    CurrentCamera.FieldOfView = 70;

    local function ResetCamera() -- Line: 43
        -- upvalues: u5 (ref), CinematicBlackBars (copy), CurrentCamera (ref), LocalPlayer (ref)
        if u5 and u5.PlaybackState == Enum.PlaybackState.Playing then
            u5:Pause();
        end;

        CinematicBlackBars.Enabled = false;
        CurrentCamera.CameraType = Enum.CameraType.Custom;
        CurrentCamera.FieldOfView = LocalPlayer.Settings.FieldOfView.Value;
    end;

    local function Wait(p6) -- Line: 54
        -- upvalues: RunService (ref), StartTime (copy), u4 (copy), u5 (ref), CinematicBlackBars (copy), CurrentCamera (ref), LocalPlayer (ref)
        local v7 = 0;
        local v8 = true;

        while true do
            v7 = v7 + RunService.RenderStepped:Wait();

            if os.clock() - StartTime >= u4 * 1.15 then
                break;
            end;

            if p6 <= v7 then
                return v8;
            end;
        end;

        if u5 and u5.PlaybackState == Enum.PlaybackState.Playing then
            u5:Pause();
        end;

        CinematicBlackBars.Enabled = false;
        CurrentCamera.CameraType = Enum.CameraType.Custom;
        CurrentCamera.FieldOfView = LocalPlayer.Settings.FieldOfView.Value;

        return false;
    end;

    local CFrame2 = Arena.AcceleronLocation.CFrame;
    local CFrame3 = Arena.NpcSpawn.CFrame;
    u5 = TweenService:Create(CurrentCamera, TweenInfo.new(0.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        CFrame = CFrame.new((CFrame2 * CFrame.new(0, 0, -8)).Position, CFrame2.Position)
    });
    u5:Play();

    if not Wait(v2) then
        return;
    end;

    u5 = TweenService:Create(CurrentCamera, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        CFrame = CFrame.new((CFrame3 * CFrame.new(0, 0, -17)).Position, CFrame3.Position)
    });
    u5:Play();

    if not Wait(v3) then
        return;
    end;

    if u5 and u5.PlaybackState == Enum.PlaybackState.Playing then
        u5:Pause();
    end;

    CinematicBlackBars.Enabled = false;
    CurrentCamera.CameraType = Enum.CameraType.Custom;
    CurrentCamera.FieldOfView = LocalPlayer.Settings.FieldOfView.Value;
end;