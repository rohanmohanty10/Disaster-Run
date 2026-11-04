 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.LightingController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 19
    -- upvalues: LocalPlayer (copy), Players (copy), SfxManager (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
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
    local Head = Character:FindFirstChild("Head");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u7 = workspace:FindFirstChild(script.Name .. "Gun");
    SfxManager:playSound({
        Sound = script.Sound,
        Parent = workspace
    }).TimePosition = u3;
    task.spawn(function() -- Line: 41
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Huh?", 0.5 }
        });
    end);
    task.delay(0.75 - u3, function() -- Line: 51
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "This is just a blank sheet of-", 1.75 }
        });
    end);
    task.delay(2.25 - u3, function() -- Line: 61
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "WHA-", 0.5 }
        });
    end);
    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 74
        -- upvalues: u1 (copy), u9 (ref), u8 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u9:Disconnect();

            return;
        end;

        if u8 <= 0 then
            u8 = p10 * 60 * u3;
        end;

        u8 = u8 + p10 * 60;
        local v11 = script_Fov[math.ceil(u8)];

        if v11 ~= nil then
            if math.ceil(u8) >= #script_Fov then
                u9:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v11, p10 * 6);
        end;
    end);
    task.delay(3.683 - u3, function() -- Line: 96
        -- upvalues: u9 (ref)
        u9:Disconnect();
    end);
    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(3.683 - u3, function() -- Line: 105
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u12 = script.Cutscene_VFX:Clone();
    u12.Name = v4;
    u12.Parent = Folder;
    u12:PivotTo(HumanoidRootPart.CFrame);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u13 = script.Vignette:Clone();
    u13.Parent = PlayerGui;
    u13.Enabled = true;
    local _ = u13.Vignette1;
    u13.Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u14 = ColorCorrection:Clone();
    u14.Name = "CC";
    u14.Parent = Lighting;
    u14.Enabled = true;
    task.delay(3.683, function() -- Line: 133
        -- upvalues: u14 (copy), Lighting (ref), ColorCorrection (copy)
        u14:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 140
        -- upvalues: Folder (copy), CamRig (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig then
            shared.vfx.emit(CamRig);
        end;
    end);
    task.delay(0.25 - u3, function() -- Line: 148
        -- upvalues: Folder (copy), Head (copy), Essentials (ref), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v15 = script.Head:Clone();
        v15.Parent = Folder;
        v15.CFrame = Head.CFrame;
        Essentials:Weld(v15, Head);
        VfxManager.DestroyEffect(v15, 2);
        shared.vfx.emit(v15);
    end);
    task.delay(2.1333333333333333 - u3, function() -- Line: 160
        -- upvalues: Folder (copy), u12 (copy), Character (copy), VfxManager (ref), TweenService (ref), u7 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.Reveal);
        local Highlight = Instance.new("Highlight", Character);
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.FillColor = Color3.fromRGB(0, 0, 0);
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
        Highlight.OutlineTransparency = 0;
        Highlight.FillTransparency = 0.5;
        VfxManager.DestroyEffect(Highlight, 1);
        TweenService:Create(Highlight, TweenInfo.new(1), {
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(0, 0, 0)
        }):Play();

        if u7 then
            local Highlight2 = Instance.new("Highlight", u7);
            Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight2.FillColor = Color3.fromRGB(0, 0, 0);
            Highlight2.OutlineColor = Color3.fromRGB(255, 255, 255);
            Highlight2.OutlineTransparency = 0;
            Highlight2.FillTransparency = 0.5;
            VfxManager.DestroyEffect(Highlight2, 1);
            TweenService:Create(Highlight2, TweenInfo.new(1), {
                FillTransparency = 1,
                OutlineColor = Color3.fromRGB(0, 0, 0)
            }):Play();
        end;
    end);
    task.delay(2.2333333333333334 - u3, function() -- Line: 188
        -- upvalues: Folder (copy), u14 (copy), TweenService (ref), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u14.Brightness = 0.2;
        u14.Contrast = 1;
        u14.Saturation = -2;
        TweenService:Create(u14, TweenInfo.new(1), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    local u16 = {};

    local function v17() -- Line: 199
        -- upvalues: u16 (ref), Folder (copy), u13 (copy), u14 (copy), Lighting (ref), ColorCorrection (copy)
        for _, v in pairs(u16) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u13 then
            u13:Destroy();
        end;

        if u14 then
            u14:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        u16 = nil;
    end;

    table.insert(u16, Folder.AttributeChanged:Connect(v17));
    table.insert(u16, Folder.Destroying:Connect(v17));
end;