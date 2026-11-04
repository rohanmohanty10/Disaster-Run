 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local TatlisV2ScreenEffect = require(script.Parent.Parent.ScreenEffects.TatlisV2ScreenEffect);
local DarkScreenEffect = require(script.Parent.Parent.ScreenEffects.DarkScreenEffect);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 21
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), VfxManager (copy), TatlisV2ScreenEffect (copy), DarkScreenEffect (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Other = p2.Other;
    Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("BALL", true);

    if p2.Enemy then
        local v4 = Character.Name .. script.Parent.Name .. script.Name;

        if p2.Task == "Cutscene" then
            local u5 = Players:FindFirstChild(Character.Name);
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
            local CamRig = workspace:WaitForChild("CamRig", 5);
            Character:FindFirstChild("BALL", true);
            task.delay(1.75 - u3, function() -- Line: 41
                -- upvalues: Effects (ref), u5 (copy)
                Effects:SubtitleV2({
                    { u5, "This isn’t your choice anymore...", 2.25 },
                    { u5, "...your only purpose now is to turn around and carry out my will.", 2 }
                });
            end);
            local u6 = 0;
            local u7 = nil;
            local FieldOfView = workspace_CurrentCamera.FieldOfView;
            u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 59
                -- upvalues: u1 (copy), u7 (ref), u6 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
                if not u1.MovementController.States.Ability then
                    u7:Disconnect();

                    return;
                end;

                if u6 <= 0 then
                    u6 = p8 * 60 * u3;
                end;

                u6 = u6 + p8 * 60;
                local v9 = script_Fov[math.ceil(u6)];

                if v9 ~= nil then
                    if math.ceil(u6) >= #script_Fov then
                        u7:Disconnect();

                        return;
                    end;

                    workspace_CurrentCamera.FieldOfView = FieldOfView;
                    FieldOfView = Essentials:Lerp(FieldOfView, v9, p8 * 6);
                end;
            end);
            task.delay(14.5 - u3, function() -- Line: 81
                -- upvalues: u7 (ref)
                u7:Disconnect();
            end);

            if Debris:FindFirstChild(v4) then
                Debris:FindFirstChild(v4):Destroy();
            end;

            local Folder = Instance.new("Folder");
            Folder.Name = v4;
            Folder.Parent = Debris;
            Folder:SetAttribute("Active", true);
            task.delay(14.5 - u3, function() -- Line: 94
                -- upvalues: Folder (copy)
                if not (Folder and Folder:GetAttribute("Active")) then
                    return;
                end;

                Folder:SetAttribute("Active", nil);
            end);
            SfxManager:playSound({
                Sound = "BBZ Tatlis V2 Death Painting Cutscene",
                Parent = workspace
            }).TimePosition = u3;
            local u10 = script.Cutscene_VFX:Clone();
            u10:PivotTo(HumanoidRootPart.CFrame);
            u10.Parent = Folder;
            local u11 = script.Camera_VFX:Clone();
            u11:PivotTo(CamRig.camera.CFrame);
            u11.Parent = Folder;
            Essentials:Weld(u11.PrimaryPart, CamRig.camera);
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

            local Model2 = Instance.new("Model");
            Model2.Parent = Folder;
            local Model3 = Instance.new("Model");
            Model3.Parent = Folder;

            if Other then
                for _, child in pairs(script.AuraBodyPartsToWeldOther:GetChildren()) do
                    local v14 = Other:FindFirstChild(child.Name);

                    if v14 then
                        local v15 = child:Clone();
                        v15.CFrame = v14.CFrame;
                        v15.Parent = Model2;
                        Essentials:Weld(v15, v14);
                    end;
                end;

                for _, child in pairs(script.Sweat:GetChildren()) do
                    local v16 = Other:FindFirstChild(child.Name);

                    if v16 then
                        local v17 = child:Clone();
                        v17.CFrame = v16.CFrame;
                        v17.Parent = Model3;
                        Essentials:Weld(v17, v16);
                    end;
                end;
            end;

            local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
            local u18 = script.Vignette:Clone();
            u18.Parent = PlayerGui;
            u18.Enabled = true;
            local Vignette = u18.Vignette;
            local Vignette1 = u18.Vignette1;
            Vignette.ImageTransparency = 0;
            local Highlight = Instance.new("Highlight", Character);
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.FillColor = Color3.fromRGB(0, 0, 0);
            Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
            Highlight.OutlineTransparency = 0;
            Highlight.FillTransparency = 0;
            local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
            ColorCorrection.Enabled = false;
            local u19 = ColorCorrection:Clone();
            u19.Name = "CC";
            u19.Parent = Lighting;
            u19.Enabled = true;
            task.delay(14.5, function() -- Line: 177
                -- upvalues: u19 (copy), Lighting (ref), ColorCorrection (copy)
                u19:Destroy();

                if not Lighting:FindFirstChild("CC") then
                    ColorCorrection.Enabled = true;
                end;
            end);
            local DepthOfField = Lighting:FindFirstChild("DepthOfField");
            DepthOfField.Enabled = false;
            local u20 = DepthOfField:Clone();
            u20.Name = "D";
            u20.Parent = Lighting;
            u20.Enabled = true;
            u20.FarIntensity = 1;
            u20.FocusDistance = 75;
            u20.InFocusRadius = 0;
            u20.NearIntensity = 0;
            task.delay(14.5, function() -- Line: 196
                -- upvalues: u20 (copy), Lighting (ref), DepthOfField (copy)
                u20:Destroy();

                if not Lighting:FindFirstChild("D") then
                    DepthOfField.Enabled = true;
                end;
            end);
            task.spawn(function() -- Line: 203
                -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), u18 (copy), VfxManager (ref), Model3 (copy), u11 (copy)
                if not (Folder and Folder:GetAttribute("Active")) then
                    return;
                end;

                Vignette.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                Vignette.BackgroundTransparency = 0;
                TweenService:Create(Vignette, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 1
                }):Play();
                TweenService:Create(u18.Vignette2, TweenInfo.new(1.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ImageTransparency = 0
                }):Play();
                VfxManager.Enable(Model3, true);
                VfxManager.Enable(u11.CamShade, true);
                u11.CamShade.Attachment.SurfaceLight.Enabled = true;
            end);
            task.delay(0.8 - u3, function() -- Line: 218
                -- upvalues: Folder (copy), VfxManager (ref), Model (copy), TweenService (ref), Highlight (copy), u10 (copy)
                if not (Folder and Folder:GetAttribute("Active")) then
                    return;
                end;

                VfxManager.Enable(Model, true);
                task.delay(1, function() -- Line: 223
                    -- upvalues: TweenService (ref), Highlight (ref), u10 (ref)
                    TweenService:Create(Highlight, TweenInfo.new(1.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        FillTransparency = 1
                    }):Play();
                    TweenService:Create(u10.Background1.Sphere, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Transparency = 0.55
                    }):Play();
                    TweenService:Create(u10.Background1.Part, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Transparency = 0.55
                    }):Play();
                end);
            end);
            task.delay(5.8 - u3, function() -- Line: 231
                -- upvalues: Folder (copy), u11 (copy)
                if not (Folder and Folder:GetAttribute("Active")) then
                    return;
                end;

                shared.vfx.emit(u11.CamTrans);
            end);
            task.delay(6 - u3, function() -- Line: 237
                -- upvalues: Folder (copy), u18 (copy), VfxManager (ref), Model2 (copy), u10 (copy), u11 (copy)
                if not (Folder and Folder:GetAttribute("Active")) then
                    return;
                end;

                u18.Vignette2.ImageTransparency = 1;
                VfxManager.Enable(Model2, true);
                VfxManager.Enable(u10.Test, true);
                VfxManager.Enable(u11.SpeedlinesFX, true);
                VfxManager.Enable(u11.CamShadeV2, true);
                VfxManager.Enable(u11.CamShade, false);
            end);
            task.delay(8.883333333333333 - u3, function() -- Line: 249
                -- upvalues: Folder (copy), u11 (copy)
                if not (Folder and Folder:GetAttribute("Active")) then
                    return;
                end;

                shared.vfx.emit(u11.CamTransV2);
            end);
            task.delay(8.916666666666666 - u3, function() -- Line: 255
                -- upvalues: Folder (copy), u10 (copy), VfxManager (ref), Model (copy), Model2 (copy), u11 (copy)
                if not (Folder and Folder:GetAttribute("Active")) then
                    return;
                end;

                u10.Background1.Sphere.Transparency = 1;
                u10.Background1.Part.Transparency = 1;
                u10.Background2.Sphere.Transparency = 0.2;
                u10.Background2.Part.Transparency = 0;
                VfxManager.Enable(Model, false);
                VfxManager.Enable(Model2, false);
                VfxManager.Enable(u10.Test, false);
                VfxManager.Enable(u10.SpeedlineTest, true);
                VfxManager.Enable(u10.Background2, true);
                VfxManager.Enable(u11.CamShadev1, true);
                VfxManager.Enable(u11.SpeedlinesFX, false);
                VfxManager.Enable(u11.CamShadeV2, false);
            end);
            task.delay(13.2 - u3, function() -- Line: 273
                -- upvalues: Folder (copy), u11 (copy)
                if not (Folder and Folder:GetAttribute("Active")) then
                    return;
                end;

                u11.CamShadev1.Attachment.SurfaceLight.Enabled = false;
            end);
            task.delay(13.7 - u3, function() -- Line: 279
                -- upvalues: Folder (copy), u10 (copy), VfxManager (ref), Vignette1 (copy), TweenService (ref), Lighting (ref), u19 (copy), ColorCorrection (copy)
                if not (Folder and Folder:GetAttribute("Active")) then
                    return;
                end;

                u10.Background2.Sphere.Transparency = 1;
                u10.Background2.Part.Transparency = 1;
                VfxManager.Enable(u10.SpeedlineTest, false);
                VfxManager.Enable(u10.Background2, false);
                shared.vfx.emit(u10.ScoreFX);
                Vignette1.ImageColor3 = Color3.fromRGB(255, 0, 0);
                Vignette1.ImageTransparency = 0.25;
                TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
                    ImageTransparency = 1
                }):Play();
                local BlurEffect = Instance.new("BlurEffect", Lighting);
                BlurEffect.Size = 15;
                TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
                    Size = 0
                }):Play();
                VfxManager.DestroyEffect(BlurEffect, 0.5);
                u19.Brightness = 0.65;
                u19.Saturation = -1;
                u19.TintColor = Color3.fromRGB(255, 69, 69);
                TweenService:Create(u19, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
                    TintColor = ColorCorrection.TintColor
                }):Play();
                TweenService:Create(u19, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
                    Brightness = ColorCorrection.Brightness,
                    Saturation = ColorCorrection.Saturation
                }):Play();
            end);
            local u21 = {};

            local function v22() -- Line: 308
                -- upvalues: u21 (ref), Folder (copy), u18 (copy), u19 (copy), Lighting (ref), ColorCorrection (copy), u20 (copy), DepthOfField (copy), Highlight (copy)
                for _, v in pairs(u21) do
                    v:Disconnect();
                end;

                if Folder then
                    Folder:Destroy();
                end;

                if u18 then
                    u18:Destroy();
                end;

                if u19 then
                    u19:Destroy();

                    if not Lighting:FindFirstChild("CC") then
                        ColorCorrection.Enabled = true;
                    end;
                end;

                if u20 then
                    u20:Destroy();

                    if not Lighting:FindFirstChild("D") then
                        DepthOfField.Enabled = true;
                    end;
                end;

                if Highlight then
                    Highlight:Destroy();
                end;

                u21 = nil;
            end;

            table.insert(u21, Folder.AttributeChanged:Connect(v22));
            table.insert(u21, Folder.Destroying:Connect(v22));

            return;
        end;

        local v23 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v23 then
            v23:SetAttribute("Active", nil);
        end;
    else
        local HumanoidRootPart = Other:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return;
        end;

        SfxManager:playSound({
            Sound = "BBZ Tatlis V2 Death Painting Pass",
            Parent = HumanoidRootPart
        });
        task.delay(0.6166666666666667 - u3, function() -- Line: 356
            -- upvalues: LocalPlayer (ref), Character (copy), Other (copy), TatlisV2ScreenEffect (ref), Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            if LocalPlayer.Character == Character or LocalPlayer.Character == Other then
                TatlisV2ScreenEffect();
            end;

            local v24 = script.Pop:Clone();
            v24.Parent = Debris;
            v24:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v24, 2);
            shared.vfx.emit(v24);
        end);
        task.delay(2.6 - u3, function() -- Line: 369
            -- upvalues: LocalPlayer (ref), Character (copy), Other (copy), TatlisV2ScreenEffect (ref), Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            if LocalPlayer.Character == Character or LocalPlayer.Character == Other then
                TatlisV2ScreenEffect();
            end;

            local v25 = script.Pop:Clone();
            v25.Parent = Debris;
            v25:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v25, 2);
            shared.vfx.emit(v25);
        end);
        task.delay(2.783333333333333 - u3, function() -- Line: 382
            -- upvalues: DarkScreenEffect (ref)
            DarkScreenEffect();
        end);
    end;
end;