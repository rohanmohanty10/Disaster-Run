  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local script_Fov = require(script.Fov);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), SoundManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), CutsceneUtils (copy), ReplicatedStorage (copy), VfxManager (copy), TweenService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    SoundManager.SpawnSound("AwakeningKuni", 0.8, workspace, 150);
    local u2 = 0;
    local u3 = nil;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u3 = RunService.RenderStepped:Connect(function(p4) -- Line: 23
        -- upvalues: u2 (ref), script_Fov (ref), u3 (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        u2 = u2 + p4 * 60;
        local v5 = script_Fov[math.ceil(u2)];

        if v5 ~= nil then
            if math.ceil(u2) >= #script_Fov then
                u3:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v5, p4 * 10);
        end;
    end);
    task.delay(10.5, function() -- Line: 37
        -- upvalues: u3 (ref)
        u3:Disconnect();
    end);
    local HumanoidRootPart = p1.Plr.Character:FindFirstChild("HumanoidRootPart");
    local game_Lighting = game.Lighting;
    local ClockTime = game_Lighting.ClockTime;
    local Brightness = game_Lighting.Brightness;
    local Ambient = game_Lighting.Ambient;
    local ColorShift_Top = game_Lighting.ColorShift_Top;
    local ColorShift_Bottom = game_Lighting.ColorShift_Bottom;
    game_Lighting.ClockTime = 6;
    game_Lighting.Brightness = 3;
    game_Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    game_Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
    game_Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0);
    local Density = game_Lighting.Atmosphere.Density;
    local Offset = game_Lighting.Atmosphere.Offset;
    local Color = game_Lighting.Atmosphere.Color;
    local Decay = game_Lighting.Atmosphere.Decay;
    local Haze = game_Lighting.Atmosphere.Haze;
    local Glare = game_Lighting.Atmosphere.Glare;
    game_Lighting.Atmosphere.Density = 0.348;
    game_Lighting.Atmosphere.Offset = 1;
    game_Lighting.Atmosphere.Glare = 0.63;
    game_Lighting.Atmosphere.Haze = 0;
    game_Lighting.Atmosphere.Color = Color3.fromRGB(216, 255, 250);
    game_Lighting.Atmosphere.Decay = Color3.fromRGB(92, 60, 13);
    task.delay(10.6, function() -- Line: 72
        -- upvalues: game_Lighting (copy), ClockTime (copy), Brightness (copy), Ambient (copy), ColorShift_Top (copy), ColorShift_Bottom (copy), Density (copy), Offset (copy), Color (copy), Decay (copy), Glare (copy), Haze (copy), CutsceneUtils (ref), ReplicatedStorage (ref)
        game_Lighting.ClockTime = ClockTime;
        game_Lighting.Brightness = Brightness;
        game_Lighting.Ambient = Ambient;
        game_Lighting.ColorShift_Top = ColorShift_Top;
        game_Lighting.ColorShift_Bottom = ColorShift_Bottom;
        game_Lighting.Atmosphere.Density = Density;
        game_Lighting.Atmosphere.Offset = Offset;
        game_Lighting.Atmosphere.Color = Color;
        game_Lighting.Atmosphere.Decay = Decay;
        game_Lighting.Atmosphere.Glare = Glare;
        game_Lighting.Atmosphere.Haze = Haze;
        CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
    end);
    local script_Attachments = script.Attachments;

    for _, child in script_Attachments:GetChildren() do
        child:Clone().Parent = HumanoidRootPart;
    end;

    local u6 = {};

    for _, child in script:GetChildren() do
        if script_Attachments:FindFirstChild(child.Name) then
            local v7 = child:Clone();
            v7.Parent = workspace.Debris;
            v7.CFrame = HumanoidRootPart:FindFirstChild(v7.Name).WorldCFrame;
            u6[v7.Name] = v7;
        end;
    end;

    local u8 = nil;
    task.delay(6, function() -- Line: 127
        -- upvalues: u6 (copy), VfxManager (ref), u8 (ref), TweenService (ref)
        VfxManager.Enable(u6.are, true);
        local AwakeningCam = workspace:FindFirstChild("AwakeningCam");

        if AwakeningCam then
            local camera = AwakeningCam:FindFirstChild("camera");
            u8 = script.camera.Beams:Clone();
            u8.Parent = camera;
        end;

        local v9 = {};

        for _, v in u6 do
            if v.Name:find("c") then
                v9[v.Name] = v;
            end;
        end;

        for _, v in v9 do
            v.Transparency = 0;
            VfxManager.Enable(v, true);
            local u10 = TweenService:Create(v, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
                CFrame = v.CFrame * CFrame.Angles(0, 3.1590459461097367, 0)
            });
            u10:Play();
            task.delay(2.5, function() -- Line: 150
                -- upvalues: VfxManager (ref), v (copy), TweenService (ref), u10 (copy)
                VfxManager.Enable(v, false);
                TweenService:Create(v, TweenInfo.new(0.5), {
                    Transparency = 1
                }):Play();
                task.wait(1);
                u10:Cancel();
                v:Destroy();
            end);
        end;

        task.wait(2.5);
        table.clear(v9);
    end);
    task.delay(5.8, function() -- Line: 163
        -- upvalues: u6 (copy), VfxManager (ref)
        local Area = u6.Area;
        local ae = u6.ae;
        VfxManager.Emit(ae);
        VfxManager.Enable(Area, true);
        local initial = ae.Attachment.initial;
        initial.Enabled = true;
        task.wait(2.3);
        initial.Enabled = false;
    end);
    task.delay(10.6, function() -- Line: 176
        -- upvalues: u8 (ref), u6 (copy), HumanoidRootPart (copy)
        if u8 then
            u8:Destroy();
        end;

        for _, v in u6 do
            local v11 = HumanoidRootPart:FindFirstChild(v.Name);

            if v11 then
                v11:Destroy();
            end;

            v:Destroy();
        end;

        table.clear(u6);
    end);
end;