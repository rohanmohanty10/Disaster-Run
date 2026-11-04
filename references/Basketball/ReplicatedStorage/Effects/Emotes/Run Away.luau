 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Lighting");
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
    -- upvalues: LocalPlayer (copy), Players (copy), SfxManager (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), VfxManager (copy), TweenService (copy)
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
    local u7 = p2.Other.Name == "TemplateRigChrollo" and "Chrollo" or Players:FindFirstChild(p2.Other.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local u8 = Character:FindFirstChild("Right Leg");
    workspace:WaitForChild("CamRig", 5);
    SfxManager:playSound({
        Sound = script.Sound,
        Parent = workspace
    }).TimePosition = u3;
    task.delay(0.5 - u3, function() -- Line: 41
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "My legs are in great shape!", 1.5 }
        });
    end);
    task.delay(2.5 - u3, function() -- Line: 51
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "So what are you gonna do then?", 1.5 }
        });
    end);
    task.delay(5 - u3, function() -- Line: 61
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Run as fast as i can!", 1.5 }
        });
    end);
    local u9 = 0;
    local u10 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u10 = RunService.RenderStepped:Connect(function(p11) -- Line: 74
        -- upvalues: u1 (copy), u10 (ref), u9 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u10:Disconnect();

            return;
        end;

        if u9 <= 0 then
            u9 = p11 * 60 * u3;
        end;

        u9 = u9 + p11 * 60;
        local v12 = script_Fov[math.ceil(u9)];

        if v12 ~= nil then
            if math.ceil(u9) >= #script_Fov then
                u10:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v12, p11 * 6);
        end;
    end);
    task.delay(7.117 - u3, function() -- Line: 96
        -- upvalues: u10 (ref)
        u10:Disconnect();
    end);
    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(7.117 - u3, function() -- Line: 105
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u13 = script.Cutscene_VFX:Clone();
    u13.Name = v4;
    u13.Parent = Folder;
    u13:PivotTo(HumanoidRootPart.CFrame);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u14 = script.Vignette:Clone();
    u14.Parent = PlayerGui;
    u14.Enabled = true;
    local _ = u14.Vignette1;
    u14.Vignette.ImageTransparency = 0;
    task.delay(0.48333333333333334 - u3, function() -- Line: 125
        -- upvalues: Folder (copy), u8 (copy), VfxManager (ref), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u8 then
            local Highlight = Instance.new("Highlight", u8);
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.FillColor = Color3.fromRGB(0, 0, 0);
            Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
            Highlight.OutlineTransparency = 0;
            Highlight.FillTransparency = 1;
            VfxManager.DestroyEffect(Highlight, 1);
            TweenService:Create(Highlight, TweenInfo.new(0.3), {
                FillTransparency = 0.3,
                OutlineColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(0.3, function() -- Line: 138
                -- upvalues: TweenService (ref), Highlight (copy)
                TweenService:Create(Highlight, TweenInfo.new(0.7), {
                    FillTransparency = 1,
                    OutlineColor = Color3.fromRGB(0, 0, 0)
                }):Play();
            end);
        end;
    end);
    task.delay(0.7166666666666667 - u3, function() -- Line: 144
        -- upvalues: Folder (copy), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u13.Foot);
    end);
    task.delay(5.366666666666666 - u3, function() -- Line: 150
        -- upvalues: Folder (copy), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u13.Run);
    end);
    local u15 = {};

    local function v16() -- Line: 157
        -- upvalues: u15 (ref), Folder (copy), u14 (copy)
        for _, v in pairs(u15) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u14 then
            u14:Destroy();
        end;

        u15 = nil;
    end;

    table.insert(u15, Folder.AttributeChanged:Connect(v16));
    table.insert(u15, Folder.Destroying:Connect(v16));
end;