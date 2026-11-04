 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);
local Part_Icles = require(ReplicatedStorage.Shared.Utility.Part_Icles);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 21
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), Part_Icles (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Torso = Character:FindFirstChild("Torso");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Character:FindFirstChild("BALL", true);
    task.delay(6.25 - u3, function() -- Line: 36
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "You were never tall enough.", 2 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 49
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * u3;
        end;

        u7 = u7 + p9 * 60;
        local v10 = script_Fov[math.ceil(u7)];

        if v10 ~= nil then
            if math.ceil(u7) >= #script_Fov then
                u8:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v10, p9 * 6);
        end;
    end);
    task.delay(12.817 - u3, function() -- Line: 71
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(12.817 - u3, function() -- Line: 84
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Alien Poster",
        Parent = workspace
    }).TimePosition = u3;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
    local u12 = script.Camera_VFX:Clone();
    u12:PivotTo(CamRig.camera.CFrame);
    u12.Parent = Folder;
    Essentials:Weld(u12.camera, CamRig.camera);
    local u13;

    if Torso then
        u13 = script.Torso:Clone();
        u13.CFrame = Torso.CFrame;
        u13.Parent = Folder;
        Essentials:Weld(u13, Torso);
    else
        u13 = nil;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u14 = script.Vignette:Clone();
    u14.Parent = PlayerGui;
    u14.Enabled = true;
    local _ = u14.Vignette;
    local _ = u14.Vignette1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u15 = ColorCorrection:Clone();
    u15.Name = "CC";
    u15.Parent = Lighting;
    u15.Enabled = true;
    task.delay(12.817, function() -- Line: 126
        -- upvalues: u15 (copy), Lighting (ref), ColorCorrection (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 133
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.CamStart);
    end);
    task.delay(0.26666666666666666 - u3, function() -- Line: 139
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.Dribble1);
    end);
    task.delay(0.7166666666666667 - u3, function() -- Line: 145
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.Dribble2);
    end);
    task.delay(2.05 - u3, function() -- Line: 151
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.Throw1);
    end);
    task.delay(3.3666666666666667 - u3, function() -- Line: 157
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.Throw2);
    end);
    task.delay(3.7 - u3, function() -- Line: 163
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.BallEmit);
    end);
    task.delay(3.75 - u3, function() -- Line: 169
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.CameraAtmosphere);
    end);
    task.delay(3.9166666666666665 - u3, function() -- Line: 175
        -- upvalues: Folder (copy), TweenService (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u11.Black, TweenInfo.new(0.6666666666666666), {
            Transparency = 0.5
        }):Play();
    end);
    task.delay(5.183333333333334 - u3, function() -- Line: 181
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.AuraForEmit);
    end);
    task.delay(6.116666666666666 - u3, function() -- Line: 187
        -- upvalues: Folder (copy), u11 (copy), Part_Icles (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Black.Transparency = 1;
        Part_Icles:AbsoluteEmit(u11.Jump);
    end);
    task.delay(6.45 - u3, function() -- Line: 195
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.DunkCameraVertical);
    end);
    task.delay(6.466666666666667 - u3, function() -- Line: 201
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.Enable);
    end);
    task.delay(6.483333333333333 - u3, function() -- Line: 207
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.CamEnd);
    end);
    task.delay(7.783333333333333 - u3, function() -- Line: 213
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.Fly);
        Part_Icles:AbsoluteEmit(u11.Sphere);
        Part_Icles:AbsoluteEmit(u11.Tunnel);
        Part_Icles:AbsoluteEmit(u11.PortalOpen);
        Part_Icles:AbsoluteEmit(u11.RealExp);
        Part_Icles:AbsoluteEmit(u11.s);
        Part_Icles:AbsoluteEmit(u11.sdg);
        Part_Icles:AbsoluteEmit(u11.sqgf);
    end);
    task.delay(7.8 - u3, function() -- Line: 226
        -- upvalues: Folder (copy), u13 (ref), Part_Icles (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u13 then
            Part_Icles:AbsoluteEmit(u13);
        end;
    end);
    local u16 = {};

    local function v17() -- Line: 235
        -- upvalues: u16 (ref), Folder (copy), u14 (copy), u15 (copy), Lighting (ref), ColorCorrection (copy)
        for _, v in pairs(u16) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u14 then
            u14:Destroy();
        end;

        if u15 then
            u15:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        u16 = nil;
    end;

    table.insert(u16, Folder.AttributeChanged:Connect(v17));
    table.insert(u16, Folder.Destroying:Connect(v17));
end;