 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
require(ReplicatedStorage.Controllers.UIController);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 19
    -- upvalues: Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), LocalPlayer (copy), SfxManager (copy), VfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p2.Char;
    local u3 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    Char:FindFirstChild("Head");
    Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Char:FindFirstChild("BALL", true);
    local u4 = workspace:GetServerTimeNow() - p2.TimeSent;
    local v5 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v6 = p2.Task == "Cleanup" and Debris:FindFirstChild(v5);

        if v6 then
            v6:SetAttribute("Active", nil);
        end;

        return;
    end;

    task.delay(2, function() -- Line: 35
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            { u3, "I see prey.", 1.5 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 48
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), u4 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * u4;
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
    task.delay(5.4 - u4, function() -- Line: 67
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);
    local u11 = {};

    if Debris:FindFirstChild(v5) then
        Debris:FindFirstChild(v5):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v5;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(5.4, function() -- Line: 82
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u12 = script.Vignette:Clone();
    u12.Parent = PlayerGui;
    u12.Enabled = true;
    local _ = u12.Vignette;
    local Vignette1 = u12.Vignette1;
    SfxManager:playSound({
        Sound = "Fetch_AWK_SFX_BBZ",
        Parent = workspace
    });
    local u13 = script.Camera_VFX:Clone();
    u13:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u13.Parent = Folder;
    u13.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u13.PrimaryPart, CamRig.camera);
    local Model = Instance.new("Model");
    Model.Parent = Folder;
    local u14 = nil;
    local u15 = nil;
    local u16 = nil;
    local u17 = nil;

    for _, child in script.Aura:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v18 = child:Clone();
            v18.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v18.Parent = Model;
            Essentials:Weld(v18, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v18, false);
        end;
    end;

    local u19 = script.BALL:Clone();
    u19.CFrame = BALL.CFrame;
    u19.Parent = Folder;
    Essentials:Weld(u19, BALL);
    VfxManager.Enable(u19, false);
    local Dog = workspace:FindFirstChild("Dog");
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(27, 53, 140);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = Char;
    local Highlight2 = Instance.new("Highlight");
    Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight2.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight2.FillTransparency = 1;
    Highlight2.OutlineColor = Color3.new(0, 0, 0);
    Highlight2.OutlineTransparency = 1;
    Highlight2.Parent = BALL;
    local Highlight3 = Instance.new("Highlight");
    Highlight3.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight3.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight3.FillTransparency = 1;
    Highlight3.OutlineColor = Color3.new(0, 0, 0);
    Highlight3.OutlineTransparency = 1;
    Highlight3.Parent = Dog;
    Highlight.FillColor = Color3.fromRGB(13, 8, 22);
    Highlight.OutlineColor = Color3.fromRGB(23, 14, 45);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 0.15;
    local DepthOfField2 = game.Lighting.DepthOfField;
    DepthOfField2.FarIntensity = 1;
    DepthOfField2.FocusDistance = 48.36;
    DepthOfField2.InFocusRadius = 29.12;
    DepthOfField2.NearIntensity = 0.429;
    ColorCorrection.Brightness = -1;
    task.delay(0.2, function() -- Line: 183
        -- upvalues: Folder (copy), TweenService (ref), Highlight (copy), u17 (ref), DepthOfField2 (copy), u15 (ref), ColorCorrection (copy), u16 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(1.4, Enum.EasingStyle.Sine), {
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(0, 0, 0)
        }):Play();
        u17 = TweenService:Create(DepthOfField2, TweenInfo.new(1.4, Enum.EasingStyle.Sine), {
            FarIntensity = 0.21,
            FocusDistance = 9.1,
            InFocusRadius = 0,
            NearIntensity = 0
        });
        u17:Play();
        u15 = TweenService:Create(ColorCorrection, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {
            Brightness = 0
        });
        u15:Play();
        u16 = TweenService:Create(ColorCorrection, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {
            Saturation = -1
        });
        u16:Play();
    end);
    VfxManager.Enable(Model, true);
    task.delay(3.683 - u4, function() -- Line: 198
        -- upvalues: Folder (copy), Vignette1 (copy), game_Lighting (copy), u15 (ref), TweenService (ref), u16 (ref), u14 (ref), VfxManager (ref), Dog (copy), u13 (copy), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(255, 29, 29);
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 29, 29);
        game_Lighting.ColorCorrection.Brightness = 0.75;
        u15 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u15:Play();
        u16 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u16:Play();
        u14 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u14:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Enable(Dog, true);
        VfxManager.Enable(u13.CameraAtmosphere, true);
        VfxManager.Enable(u13.DunkCamera, true);
        VfxManager.Enable(u19, true);
    end);

    local function v20() -- Line: 223
        -- upvalues: u11 (ref), Folder (copy), VfxManager (ref), u12 (copy), u15 (ref), u16 (ref), u14 (ref), u17 (ref), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField2 (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy)
        for _, v in u11 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);

            for _, descendant in Folder:GetDescendants() do
                if descendant:IsA("Part") or (descendant:IsA("MeshPart") or descendant:IsA("Texture")) then
                    descendant.Transparency = 1;
                end;
            end;
        end;

        if u12 then
            u12:Destroy();
        end;

        if u15 then
            u15:Pause();
        end;

        if u16 then
            u16:Pause();
        end;

        if u14 then
            u14:Pause();
        end;

        if u17 then
            u17:Pause();
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        DepthOfField2.FarIntensity = FarIntensity;
        DepthOfField2.FocusDistance = FocusDistance;
        DepthOfField2.InFocusRadius = InFocusRadius;
        DepthOfField2.NearIntensity = NearIntensity;
        u11 = nil;
    end;

    table.insert(u11, Folder.AttributeChanged:Connect(v20));
    table.insert(u11, Folder.Destroying:Connect(v20));
end;