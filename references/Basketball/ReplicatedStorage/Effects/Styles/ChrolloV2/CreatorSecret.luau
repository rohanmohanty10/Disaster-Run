 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local UIController = require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 19
    -- upvalues: workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy), ReplicatedStorage (copy), UIController (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local _ = p2.Other;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local FixedBook = Character:FindFirstChild("FixedBook");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Character:FindFirstChild("BALL", true);
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 37
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
    task.delay(12.15 - u3, function() -- Line: 59
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
    task.delay(12.15 - u3, function() -- Line: 72
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Chrollo V2 Creator\'s Secret",
        Parent = workspace
    }).TimePosition = u3;
    local u10 = nil;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
    local u12 = script.Camera_VFX:Clone();
    u12:PivotTo(CamRig.camera.CFrame);
    u12.Parent = Folder;
    Essentials:Weld(u12.PrimaryPart, CamRig.camera);
    local u13;

    if FixedBook then
        u13 = script.FixedBook:Clone();
        u13.CFrame = FixedBook.CFrame;
        u13.Parent = Folder;
        Essentials:Weld(u13, FixedBook);
    else
        u13 = nil;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u14 = script.Vignette:Clone();
    u14.Parent = PlayerGui;
    u14.Enabled = true;
    local Vignette = u14.Vignette;
    local _ = u14.Vignette1;
    Vignette.ImageTransparency = 0;
    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u15 = ColorCorrection:Clone();
    u15.Name = "CC";
    u15.Parent = Lighting;
    u15.Enabled = true;
    task.delay(12.15, function() -- Line: 124
        -- upvalues: u15 (copy), Lighting (ref), ColorCorrection (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local ClockTime = Lighting.ClockTime;

    if ClockTime ~= 0 then
        Lighting.ClockTime = 0;
    end;

    task.spawn(function() -- Line: 136
        -- upvalues: Folder (copy), u11 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Background1.Sphere.Transparency = 0;
        u11.Background1.Part.Transparency = 0;
        VfxManager.Enable(u11.Space1, true);
    end);
    task.delay(0.5 - u3, function() -- Line: 145
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), u14 (copy), u15 (copy), VfxManager (ref), u11 (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(1.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        u14.ChrolloStatic.Visible = true;
        u15.Saturation = -1;
        VfxManager.Enable(u11.BookAura, true);
        VfxManager.Enable(u12.CamShade, true);
        VfxManager.Enable(u11.Space1, false);
    end);
    task.delay(2.35 - u3, function() -- Line: 162
        -- upvalues: Folder (copy), u14 (copy), u15 (copy), ColorCorrection (copy), VfxManager (ref), u11 (copy), u12 (copy), PlayerGui (copy), ReplicatedStorage (ref), UIController (ref), u3 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u14.ChrolloStatic.Visible = false;
        u15.Saturation = ColorCorrection.Saturation;
        VfxManager.Enable(u11.BookAura, false);
        VfxManager.Enable(u12.CamShade, false);
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Parent = PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        ScreenGui.DisplayOrder = -1;
        local v16 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v16.BackgroundTransparency = 0;
        v16.Parent = ScreenGui;
        UIController:PlayFlipbook(v16, "PageScroll", 0.030303030303030304, u3);
        ScreenGui:Destroy();
    end);
    task.delay(2.9 - u3, function() -- Line: 186
        -- upvalues: Folder (copy), u10 (ref), SfxManager (ref), FixedBook (copy), u13 (ref), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u10 = SfxManager:playSound({
            Sound = "BBZ Chrollo V2 Creator\'s Secret Loop",
            Parent = workspace
        });

        if FixedBook then
            FixedBook.Transparency = 0;
        end;

        if u13 then
            VfxManager.Enable(u13, true);
        end;

        VfxManager.Enable(u11.Space2, true);
    end);
    local u17 = {};

    local function v18() -- Line: 203
        -- upvalues: u17 (ref), Folder (copy), u14 (copy), Highlight (copy), u15 (copy), Lighting (ref), ColorCorrection (copy), ClockTime (copy), u10 (ref), TweenService (ref), VfxManager (ref)
        for _, v in pairs(u17) do
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

        if u15 then
            u15:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if ClockTime ~= 0 and not workspace:GetAttribute("NightMode") then
            Lighting.ClockTime = ClockTime;
        end;

        if u10 then
            TweenService:Create(u10, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Volume = 0
            }):Play();
            VfxManager.DestroyEffect(u10, 0.25);
        end;

        u17 = nil;
    end;

    table.insert(u17, Folder.AttributeChanged:Connect(v18));
    table.insert(u17, Folder.Destroying:Connect(v18));
end;