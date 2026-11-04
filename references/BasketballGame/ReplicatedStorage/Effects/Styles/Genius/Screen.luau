 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 19
    -- upvalues: Debris (copy), VfxManager (copy), TweenService (copy), Players (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    local function Cleanup(p4, p5) -- Line: 26
        -- upvalues: Character (copy), Debris (ref), VfxManager (ref), TweenService (ref)
        if p4 == "Screen" then
            local v6 = Character:FindFirstChild(script.Name .. "Highlight");

            if v6 then
                v6:Destroy();
            end;

            local v7 = Debris:FindFirstChild(Character.Name .. script.Name .. "Enable");

            if v7 then
                if p5 then
                    v7:Destroy();

                    return;
                end;

                VfxManager.Enable(v7, false);
                VfxManager.DestroyEffect(v7, 4);

                if v7:FindFirstChild("Sound") then
                    TweenService:Create(v7.Sound, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Volume = 0
                    }):Play();
                end;
            end;
        end;
    end;

    if p2.Task ~= "Cutscene" then
        if p2.Task == "CutsceneCleanup" then
            local v8 = Debris:FindFirstChild(Character.Name .. script.Name .. "Slow IQ");

            if v8 then
                v8:SetAttribute("Active", nil);

                return;
            end;
        else
            if p2.Task == "Highlight" then
                local v9 = Character:FindFirstChild(script.Name .. "Highlight");

                if v9 then
                    v9:Destroy();
                end;

                local v10 = Debris:FindFirstChild(Character.Name .. script.Name .. "Enable");

                if v10 then
                    v10:Destroy();
                end;

                local Highlight = Instance.new("Highlight", Character);
                Highlight.Name = script.Name .. "Highlight";
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight.FillColor = Color3.fromRGB(0, 0, 0);
                Highlight.OutlineColor = Color3.fromRGB(133, 255, 99);
                Highlight.OutlineTransparency = 0;
                Highlight.FillTransparency = 1;
                VfxManager.DestroyEffect(Highlight, 2);
                local v11 = script.Enable:Clone();
                v11.Name = Character.Name .. script.Name .. "Enable";
                v11.Parent = Debris;
                v11.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -1.5);
                Essentials:Weld(v11, HumanoidRootPart);
                VfxManager.DestroyEffect(v11, 6);
                SfxManager:playSound({
                    Sound = "BBZ Genius Screen",
                    Parent = v11
                }).Name = "Sound";

                return;
            end;

            if p2.Task == "HighlightCleanup" then
                Cleanup("Screen");

                return;
            end;

            if p2.Task == "Screen" then
                Cleanup("Screen");
                local v12 = script.Emit:Clone();
                v12.Parent = Debris;
                v12.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -1.5) * CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966);
                VfxManager.Emit(v12);
                VfxManager.DestroyEffect(v12, 4);
                SfxManager:playSound({
                    Sound = "BBZ Genius Screen Activate",
                    Parent = v12
                });
            end;
        end;

        return;
    end;

    Players:FindFirstChild(Character.Name);
    local Head = Character:FindFirstChild("Head");
    workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    local u13 = 0;
    local u14 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u14 = RunService.RenderStepped:Connect(function(p15) -- Line: 58
        -- upvalues: u1 (copy), u14 (ref), u13 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u14:Disconnect();

            return;
        end;

        if u13 <= 0 then
            u13 = p15 * 60 * u3;
        end;

        u13 = u13 + p15 * 60;
        local v16 = script_Fov[math.ceil(u13)];

        if v16 ~= nil then
            if math.ceil(u13) >= #script_Fov then
                u14:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v16, p15 * 6);
        end;
    end);
    task.delay(4.15 - u3, function() -- Line: 80
        -- upvalues: u14 (ref)
        u14:Disconnect();
    end);

    if Debris:FindFirstChild(Character.Name .. script.Name .. "Slow IQ") then
        Debris:FindFirstChild(Character.Name .. script.Name .. "Slow IQ"):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = Character.Name .. script.Name .. "Slow IQ";
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(4.15, function() -- Line: 93
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Genius Slow IQ",
        Parent = workspace
    }).TimePosition = u3;
    local u17 = script.Cutscene_VFX:Clone();
    u17:PivotTo(HumanoidRootPart.CFrame);
    u17.Parent = Folder;
    local u18 = script.Ball:Clone();
    u18.CFrame = BALL.CFrame;
    u18.Parent = Folder;
    Essentials:Weld(u18, BALL);

    if Head then
        local v19 = script.Head:Clone();
        v19.CFrame = Head.CFrame;
        v19.Parent = Folder;
        Essentials:Weld(v19, Head);
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u20 = script.Vignette:Clone();
    u20.Parent = PlayerGui;
    u20.Enabled = true;
    local Vignette = u20.Vignette;
    local Vignette1 = u20.Vignette1;
    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u21 = ColorCorrection:Clone();
    u21.Name = "CC";
    u21.Parent = Lighting;
    u21.Enabled = true;
    task.delay(4.15, function() -- Line: 142
        -- upvalues: u21 (copy), Lighting (ref), ColorCorrection (copy)
        u21:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.delay(0.16666666666666666 - u3, function() -- Line: 149
        -- upvalues: Folder (copy), Vignette (copy), Vignette1 (copy), TweenService (ref), u21 (copy), ColorCorrection (copy), VfxManager (ref), u17 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.ImageTransparency = 0;
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(60, 255, 60);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        u21.Brightness = 1;
        u21.Contrast = 2;
        u21.Saturation = -1;
        u21.TintColor = Color3.fromRGB(60, 255, 60);
        TweenService:Create(u21, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast,
            Saturation = ColorCorrection.Saturation
        }):Play();
        TweenService:Create(u21, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        VfxManager.BetterEmit(u17.Dribble);
    end);
    task.delay(1.75 - u3, function() -- Line: 167
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Highlight (copy), Lighting (ref), VfxManager (ref), u21 (copy), ColorCorrection (copy), u18 (copy), u17 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(60, 255, 60);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        Highlight.FillTransparency = 0;
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            FillTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u21.Brightness = 1;
        u21.Contrast = 2;
        u21.Saturation = -1;
        u21.TintColor = Color3.fromRGB(60, 255, 60);
        TweenService:Create(u21, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast,
            Saturation = ColorCorrection.Saturation
        }):Play();
        TweenService:Create(u21, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        VfxManager.BetterEmit(u18);
        VfxManager.BetterEmit(u17.BeamsBack);
        VfxManager.BetterEmit(u17.Step);
    end);
    local u22 = {};

    local function v23() -- Line: 195
        -- upvalues: u22 (ref), Folder (copy), u20 (copy), Highlight (copy), u21 (copy), Lighting (ref), ColorCorrection (copy)
        for _, v in pairs(u22) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u20 then
            u20:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u21 then
            u21:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        u22 = nil;
    end;

    table.insert(u22, Folder.AttributeChanged:Connect(v23));
    table.insert(u22, Folder.Destroying:Connect(v23));
end;