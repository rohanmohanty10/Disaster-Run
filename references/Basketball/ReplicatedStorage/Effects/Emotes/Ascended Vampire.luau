 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.LightingController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 19
    -- upvalues: LocalPlayer (copy), Players (copy), SfxManager (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), Lighting (copy), TweenService (copy)
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

    local u6 = Character.Name == "TemplateRig" and LocalPlayer or Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    workspace:WaitForChild("CamRig", 5);
    SfxManager:playSound({
        Sound = script.Sound,
        Parent = workspace
    }).TimePosition = u3;
    task.delay(0.25 - u3, function() -- Line: 39
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "I must say...", 1 }
        });
    end);
    task.delay(1.25 - u3, function() -- Line: 49
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "...I\'ve gone quite used to this body.", 2 }
        });
    end);
    task.delay(4 - u3, function() -- Line: 59
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Tell me...", 1 }
        });
    end);
    task.delay(4.75 - u3, function() -- Line: 69
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "...can you feel it?", 1 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 82
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
    task.delay(4.967 - u3, function() -- Line: 104
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);
    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(4.967 - u3, function() -- Line: 113
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u11 = script.Cutscene_VFX:Clone();
    u11.Name = v4;
    u11.Parent = Folder;
    u11:PivotTo(HumanoidRootPart.CFrame);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v12 = Character:FindFirstChild(child.Name);

        if v12 then
            local v13 = child:Clone();
            v13.CFrame = v12.CFrame;
            v13.Parent = Model;
            Essentials:Weld(v13, v12);
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u14 = script.Vignette:Clone();
    u14.Parent = PlayerGui;
    u14.Enabled = true;
    local Vignette = u14.Vignette;
    local _ = u14.Vignette1;
    Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u15 = ColorCorrection:Clone();
    u15.Name = "CC";
    u15.Parent = Lighting;
    u15.Enabled = true;
    task.delay(4.967, function() -- Line: 154
        -- upvalues: u15 (copy), Lighting (ref), ColorCorrection (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 161
        -- upvalues: Folder (copy), Model (copy), u11 (copy), u15 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(Model, u11.Menacing);
        u15.Contrast = 0.5;
        u15.Brightness = -0.15;
        u15.TintColor = Color3.fromRGB(176, 255, 150);
    end);
    task.delay(3.966666666666667 - u3, function() -- Line: 171
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), u11 (copy), u15 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        shared.vfx.emit(u11.Reveal);
        u15.Contrast = ColorCorrection.Contrast;
        u15.Brightness = ColorCorrection.Brightness;
        u15.TintColor = ColorCorrection.TintColor;
    end);
    local u16 = {};

    local function v17() -- Line: 186
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