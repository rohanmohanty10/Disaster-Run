 
 

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
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 19
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), VfxManager (copy)
    local PassedTime = p2.PassedTime;
    local Character = p2.Character;
    local Enemy1 = p2.Enemy1;
    local Enemy2 = p2.Enemy2;
    local Enemy3 = p2.Enemy3;
    local Enemy4 = p2.Enemy4;
    local Enemy5 = p2.Enemy5;
    local v3 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v4 = p2.Task == "Cleanup" and Debris:FindFirstChild(v3);

        if v4 then
            v4:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u5 = Players:FindFirstChild(Character.Name) or Character.Name;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local u6 = workspace:FindFirstChild(script.Name .. "Pen");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Character:FindFirstChild("BALL", true);
    task.delay(3 - PassedTime, function() -- Line: 39
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Exactly as planned.", 2 }
        });
    end);
    task.delay(8.25 - PassedTime, function() -- Line: 49
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "I want the world to know of my existance...", 2.25 },
            { u5, "...and that my power is erasing evil.", 3.5 },
            { u5, "That I\'m the one doling out justice!", 3 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 72
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), PassedTime (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * PassedTime;
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
    task.delay(24 - PassedTime, function() -- Line: 94
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(24 - PassedTime, function() -- Line: 107
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Kira Final Judgement",
        Parent = workspace
    }).TimePosition = PassedTime;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
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
    u14.Vignette2.ImageTransparency = 0;
    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(99, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(99, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = -1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u15 = ColorCorrection:Clone();
    u15.Name = "CC";
    u15.Parent = Lighting;
    u15.Enabled = true;
    u15.Brightness = -0.175;
    u15.Contrast = 0.75;
    u15.Saturation = -0.5;
    task.delay(24, function() -- Line: 160
        -- upvalues: u15 (copy), Lighting (ref), ColorCorrection (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 167
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.06666666666666667), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(0.11666666666666667 - PassedTime, function() -- Line: 175
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.03333333333333333), {
            BackgroundTransparency = 0
        }):Play();
    end);
    task.delay(0.15 - PassedTime, function() -- Line: 181
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.03333333333333333), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(0.18333333333333332 - PassedTime, function() -- Line: 187
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.05), {
            BackgroundTransparency = 0
        }):Play();
    end);
    task.delay(0.23333333333333334 - PassedTime, function() -- Line: 193
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.05), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(0.2833333333333333 - PassedTime, function() -- Line: 199
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.03333333333333333), {
            BackgroundTransparency = 0
        }):Play();
    end);
    task.delay(0.31666666666666665 - PassedTime, function() -- Line: 205
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.16666666666666666), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(1.4833333333333334 - PassedTime, function() -- Line: 211
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.03333333333333333), {
            BackgroundTransparency = 0
        }):Play();
    end);
    task.delay(1.5166666666666666 - PassedTime, function() -- Line: 217
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.1), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(2.6 - PassedTime, function() -- Line: 223
        -- upvalues: Folder (copy), TweenService (ref), Highlight (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.5), {
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(4.3 - PassedTime, function() -- Line: 229
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble1);
    end);
    task.delay(5.366666666666666 - PassedTime, function() -- Line: 235
        -- upvalues: Folder (copy), u11 (copy), CamRig (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.White, CamRig.Camera.k2.k11, CamRig.Camera.k1.k22);
    end);
    task.delay(7.833333333333333 - PassedTime, function() -- Line: 241
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.3333333333333333), {
            BackgroundTransparency = 0.7
        }):Play();
    end);
    task.delay(8.166666666666666 - PassedTime, function() -- Line: 247
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(3.966666666666667), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(8.216666666666667 - PassedTime, function() -- Line: 253
        -- upvalues: Folder (copy), u6 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u6["2"].ting.Trail.Enabled = true;
    end);
    task.delay(12.133333333333333 - PassedTime, function() -- Line: 259
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.31666666666666665), {
            BackgroundTransparency = 0.7
        }):Play();
    end);
    task.delay(12.433333333333334 - PassedTime, function() -- Line: 265
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy), Enemy1 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.06666666666666667), {
            BackgroundTransparency = 1
        }):Play();

        if Enemy1 and Enemy1:FindFirstChild("Torso") then
            local v16 = script.MetalHit:Clone();
            v16.Parent = Folder;
            v16.CFrame = Enemy1.Torso.CFrame;
            VfxManager.DestroyEffect(v16, 2);
            shared.vfx.emit(v16);
        end;
    end);
    task.delay(13.15 - PassedTime, function() -- Line: 280
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.23333333333333334), {
            BackgroundTransparency = 0.7
        }):Play();
    end);
    task.delay(13.383333333333333 - PassedTime, function() -- Line: 286
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy), Enemy2 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.06666666666666667), {
            BackgroundTransparency = 1
        }):Play();

        if Enemy2 and Enemy2:FindFirstChild("Torso") then
            local v17 = script.MetalHit:Clone();
            v17.Parent = Folder;
            v17.CFrame = Enemy2.Torso.CFrame;
            VfxManager.DestroyEffect(v17, 2);
            shared.vfx.emit(v17);
        end;
    end);
    task.delay(16.883333333333333 - PassedTime, function() -- Line: 301
        -- upvalues: Folder (copy), u6 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u6["2"].ting.Trail.Enabled = false;
    end);
    task.delay(17.466666666666665 - PassedTime, function() -- Line: 307
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Catch);
    end);
    task.delay(18.25 - PassedTime, function() -- Line: 313
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.13333333333333333), {
            BackgroundTransparency = 0
        }):Play();
    end);
    task.delay(18.383333333333333 - PassedTime, function() -- Line: 319
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.13333333333333333), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(18.65 - PassedTime, function() -- Line: 325
        -- upvalues: Folder (copy), Enemy3 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if Enemy3 and Enemy3:FindFirstChild("Torso") then
            local v18 = script.MetalHit:Clone();
            v18.Parent = Folder;
            v18.CFrame = Enemy3.Torso.CFrame;
            VfxManager.DestroyEffect(v18, 2);
            shared.vfx.emit(v18);
        end;
    end);
    task.delay(19.266666666666666 - PassedTime, function() -- Line: 338
        -- upvalues: Folder (copy), Enemy4 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if Enemy4 and Enemy4:FindFirstChild("Torso") then
            local v19 = script.MetalHit:Clone();
            v19.Parent = Folder;
            v19.CFrame = Enemy4.Torso.CFrame;
            VfxManager.DestroyEffect(v19, 2);
            shared.vfx.emit(v19);
        end;
    end);
    task.delay(20.7 - PassedTime, function() -- Line: 351
        -- upvalues: Folder (copy), Enemy5 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if Enemy5 and Enemy5:FindFirstChild("Torso") then
            local v20 = script.MetalHit:Clone();
            v20.Parent = Folder;
            v20.CFrame = Enemy5.Torso.CFrame;
            VfxManager.DestroyEffect(v20, 2);
            shared.vfx.emit(v20);
        end;
    end);
    task.delay(21.283333333333335 - PassedTime, function() -- Line: 364
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.35), {
            BackgroundTransparency = 0
        }):Play();
    end);
    task.delay(21.633333333333333 - PassedTime, function() -- Line: 370
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.45), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(21.583333333333332 - PassedTime, function() -- Line: 376
        -- upvalues: Folder (copy), Model (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(Model.Head);
    end);
    task.delay(23.3 - PassedTime, function() -- Line: 382
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.7), {
            BackgroundTransparency = 0
        }):Play();
    end);
    local u21 = {};

    local function v22() -- Line: 389
        -- upvalues: u21 (ref), Folder (copy), u14 (copy), Highlight (copy)
        for _, v in pairs(u21) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u14 then
            u14:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        u21 = nil;
    end;

    table.insert(u21, Folder.AttributeChanged:Connect(v22));
    table.insert(u21, Folder.Destroying:Connect(v22));
end;