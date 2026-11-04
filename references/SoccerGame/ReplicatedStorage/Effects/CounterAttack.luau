  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local script_Fov = require(script.Fov);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local LightingStorage = require(ReplicatedStorage2.Shared.LightingStorage);

return function(p1) -- Line: 25
    -- upvalues: SpectatorController (copy), RunService (copy), script_Fov (copy), Essentials (copy), TweenService (copy), VfxManager (copy), LightingStorage (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    if game.Players.LocalPlayer.Character.Values.Goalie.Value and (game.Players.LocalPlayer.Character.Values.IsInPenalty.Value and p1.Char ~= game.Players.LocalPlayer.Character) then
        return;
    end;

    local HumanoidRootPart = p1.Char:FindFirstChild("HumanoidRootPart");
    local u2 = 0;
    local u3 = nil;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u3 = RunService.RenderStepped:Connect(function(p4) -- Line: 38
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
    task.delay(7.067, function() -- Line: 54
        -- upvalues: u3 (ref)
        u3:Disconnect();
    end);
    local DepthOfFieldEffect = Instance.new("DepthOfFieldEffect");
    DepthOfFieldEffect.Parent = game.Lighting;
    DepthOfFieldEffect.FarIntensity = 0.21;
    DepthOfFieldEffect.FocusDistance = 9.1;
    DepthOfFieldEffect.InFocusRadius = 0;
    DepthOfFieldEffect.NearIntensity = 0;
    task.delay(1.05, function() -- Line: 65
        -- upvalues: TweenService (ref), DepthOfFieldEffect (copy)
        TweenService:Create(DepthOfFieldEffect, TweenInfo.new(0.6), {
            FarIntensity = 1
        }):Play();
    end);
    task.delay(3.38, function() -- Line: 69
        -- upvalues: TweenService (ref), DepthOfFieldEffect (copy)
        TweenService:Create(DepthOfFieldEffect, TweenInfo.new(0.6), {
            FarIntensity = 0.1
        }):Play();
        task.wait(0.7);
        DepthOfFieldEffect:Destroy();
    end);
    local Atmosphere = game.Lighting.Atmosphere;
    Atmosphere.Color = Color3.fromRGB(0, 0, 0);
    Atmosphere.Decay = Color3.fromRGB(50, 2, 111);
    Atmosphere.Glare = 5;
    Atmosphere.Haze = 4;
    Atmosphere.Density = 0;
    Atmosphere.Offset = 0;
    task.delay(1.3, function() -- Line: 83
        -- upvalues: TweenService (ref), Atmosphere (copy)
        TweenService:Create(Atmosphere, TweenInfo.new(0.4), {
            Density = 0.7,
            Offset = 0.5
        }):Play();
    end);
    task.delay(3.183, function() -- Line: 87
        -- upvalues: TweenService (ref), Atmosphere (copy)
        TweenService:Create(Atmosphere, TweenInfo.new(0.4), {
            Density = 0.3,
            Offset = 0.5
        }):Play();
        task.wait(0.4);
        Atmosphere.Color = Color3.fromRGB(89, 94, 199);
        Atmosphere.Decay = Color3.fromRGB(49, 50, 99);
        Atmosphere.Glare = 5;
        Atmosphere.Haze = 2.04;
        Atmosphere.Density = 0.3;
        Atmosphere.Offset = 0.5;
    end);
    local script_Attachments = script.Attachments;
    local u6 = {};

    for _, child in script_Attachments:GetChildren() do
        child:Clone().Parent = HumanoidRootPart;
    end;

    for _, child in script:GetChildren() do
        if script_Attachments:FindFirstChild(child.Name) then
            local v7 = child:Clone();
            v7.Parent = workspace.Debris;
            v7.CFrame = HumanoidRootPart:FindFirstChild(v7.Name).WorldCFrame;
            u6[v7.Name] = v7;
        end;
    end;

    local u8 = script.Floor:Clone();
    u8.Parent = workspace.Debris;
    u8.CFrame = HumanoidRootPart.CFrame * CFrame.new(-17.665, -2.8, 186.271) * CFrame.Angles(0, 1.5707963267948966, 0);
    u6[u8.Name] = u8;
    task.delay(1.183, function() -- Line: 123
        -- upvalues: u6 (copy), TweenService (ref), u8 (copy), VfxManager (ref)
        local main = u6.main;
        local VFX = u6.VFX;
        local side = u6.side;
        TweenService:Create(u8, TweenInfo.new(0.2), {
            Transparency = 0
        }):Play();
        VfxManager.Enable(main, true);
        VfxManager.Enable(VFX, true);
        VfxManager.Enable(side, true);
    end);
    task.delay(1.35, function() -- Line: 135
        -- upvalues: u6 (copy), VfxManager (ref)
        VfxManager.Enable(u6.vfsx, true);
    end);
    task.delay(4.35, function() -- Line: 141
        -- upvalues: u6 (copy), TweenService (ref), u8 (copy), VfxManager (ref)
        local main = u6.main;
        local VFX = u6.VFX;
        local side = u6.side;
        local vfsx = u6.vfsx;
        TweenService:Create(u8, TweenInfo.new(0.2), {
            Transparency = 1
        }):Play();
        VfxManager.Enable(vfsx, false);
        VfxManager.Enable(main, false);
        VfxManager.Enable(VFX, false);
        VfxManager.Enable(side, false);
    end);
    task.delay(5.9, function() -- Line: 155
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref)
        local Shot = HumanoidRootPart:FindFirstChild("Shot");

        if Shot then
            VfxManager.Emit(Shot);
        end;

        task.delay(2, function() -- Line: 160
            -- upvalues: Shot (copy)
            Shot:Destroy();
        end);
    end);
    task.delay(7.067, function() -- Line: 165
        -- upvalues: LightingStorage (ref), u6 (copy), HumanoidRootPart (copy)
        LightingStorage.ResetColors();

        for _, v in u6 do
            local v9 = HumanoidRootPart:FindFirstChild(v.Name);

            if v9 then
                v9:Destroy();
            end;

            v:Destroy();
        end;
    end);
end;