 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

local function Destroy_Effect(u1: userdata, p2: number) -- Line: 17
    task.delay(p2, function() -- Line: 18
        -- upvalues: u1 (copy)
        u1:Destroy();
    end);
end;

return function(u3, p4) -- Line: 23
    -- upvalues: Debris (copy), SfxManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), TweenService (copy), VfxManager (copy)
    local Character = p4.Character;
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 0.5);
    local Head = Character:FindFirstChild("Head", 0.5);
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u5 = workspace:GetServerTimeNow() - p4.TimeSent;
    local Duration = p4.Duration;
    local u6 = Character.Name .. script.Parent.Name .. script.Name;

    if p4.Task ~= "Cutscene" then
        if p4.Task == "Cleanup" and Debris:FindFirstChild(u6) then
            Debris:FindFirstChild(u6):SetAttribute("Active", nil);
        end;

        return;
    end;

    local u7 = {};

    if Debris:FindFirstChild(u6) then
        Debris:FindFirstChild(u6):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = u6;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(Duration - u5, function() -- Line: 47
        -- upvalues: Folder (copy), Debris (ref), u6 (copy)
        if Folder ~= nil and Debris:FindFirstChild(u6) then
            Folder:SetAttribute("Active", nil);
        end;
    end);
    local u8 = SfxManager:playSound({
        Sound = "BBZ Gambler Awakening Cutscene",
        Parent = workspace
    });
    local u9 = 0;
    local u10 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u10 = RunService.RenderStepped:Connect(function(p11) -- Line: 58
        -- upvalues: u3 (copy), u10 (ref), u9 (ref), u5 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u3.MovementController.States.Ability == false then
            u10:Disconnect();

            return;
        end;

        if u9 <= 0 then
            u9 = p11 * 60 - u5 * u5;
        end;

        u9 = u9 + (p11 * 60 - u5);
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
    task.delay(Duration - u5, function() -- Line: 77
        -- upvalues: u10 (ref)
        if u10 then
            u10:Disconnect();
        end;
    end);
    local DepthOfField = game.Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    DepthOfField.FocusDistance = 0;
    DepthOfField.FarIntensity = 1;
    local u13 = nil;
    task.delay(0.31666666666666665 - u5, function() -- Line: 91
        -- upvalues: Folder (copy), u13 (ref), TweenService (ref), DepthOfField (copy), u5 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u13 = TweenService:Create(DepthOfField, TweenInfo.new(1.3666666666666667 - u5, Enum.EasingStyle.Linear), {
            FocusDistance = 2.6,
            InFocusRadius = 35,
            NearIntensity = 0.75
        });
        u13:Play();
    end);
    local ColorCorrection = game.Lighting:FindFirstChild("ColorCorrection");
    local Brightness = ColorCorrection.Brightness;
    ColorCorrection.Brightness = 0;
    local u14 = script.Camera_VFX:Clone();
    u14:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u14.Parent = Folder;
    u14.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(CamRig.camera, u14.PrimaryPart);
    local u15 = script.Head:Clone();
    u15.CFrame = Head.CFrame;
    u15.Parent = Folder;
    Essentials:Weld(u15, Head);
    local u16 = script.CutsceneVFX:Clone();
    u16:PivotTo(HumanoidRootPart.CFrame);
    u16.Parent = Folder;
    VfxManager.Enable(u16.EnviornmentVFX.AuraBACKGROUND, true);
    VfxManager.Enable(u16.Part1.PurpleAura, true);
    VfxManager.Enable(u16.Part1.Beams, true);
    VfxManager.Enable(u14.camera, true);
    task.delay(1.6833333333333333 - u5, function() -- Line: 129
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u15.EyeSparkle);
    end);
    task.delay(3.033333333333333 - u5, function() -- Line: 135
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u15, true);
        task.wait(0.05);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u15.Emit);
    end);
    task.delay(5.066666666666666 - u5, function() -- Line: 147
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), u15 (copy), u14 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u16.Part1.PurpleAura, false);
        VfxManager.Enable(u16.Part1.Beams, false);
        VfxManager.Enable(u15, false);
        task.wait(0.4166666666666667);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Part1.TransitionEmit);
        VfxManager.Enable(u16.Part2.GreenAura, true);
        VfxManager.Enable(u16.Part2.BackgroundMoney, true);
        VfxManager.Enable(u14.CamLines, true);
    end);
    task.delay(5.233333333333333 - u5, function() -- Line: 163
        -- upvalues: Folder (copy), TweenService (ref), u16 (copy), u5 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u16.EnviornmentVFX.Sphere, TweenInfo.new(0.23333333333333334 - u5, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
        TweenService:Create(u16.EnviornmentVFX.Sphere2, TweenInfo.new(0.23333333333333334 - u5, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
    end);

    local function v17() -- Line: 170
        -- upvalues: u7 (copy), Folder (copy), VfxManager (ref), u16 (copy), u13 (ref), u8 (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), ColorCorrection (copy), Brightness (copy)
        for _, v in u7 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);
            u16.EnviornmentVFX.Sphere.Transparency = 1;
            u16.EnviornmentVFX.Sphere2.Transparency = 1;
        end;

        if u13 then
            u13:Pause();
        end;

        if u8 then
            VfxManager.DestroyEffect(u8, 2);
        end;

        DepthOfField.FarIntensity = FarIntensity;
        DepthOfField.FocusDistance = FocusDistance;
        DepthOfField.InFocusRadius = InFocusRadius;
        DepthOfField.NearIntensity = NearIntensity;
        ColorCorrection.Brightness = Brightness;
    end;

    table.insert(u7, Folder.AttributeChanged:Connect(v17));
    table.insert(u7, Folder.Destroying:Connect(v17));
end;