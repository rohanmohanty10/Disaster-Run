 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.Part_Icles);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.LightingController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 20
    -- upvalues: SfxManager (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), VfxManager (copy)
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

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local u6 = workspace:FindFirstChild(script.Name .. "Fish1");
    local u7 = workspace:FindFirstChild(script.Name .. "Fish2");
    local u8 = workspace:FindFirstChild(script.Name .. "Fish3");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    SfxManager:playSound({
        Sound = script.Sound,
        Parent = workspace
    }).TimePosition = u3;
    local u9 = 0;
    local u10 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u10 = RunService.RenderStepped:Connect(function(p11) -- Line: 44
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
    task.delay(6.35 - u3, function() -- Line: 66
        -- upvalues: u10 (ref)
        u10:Disconnect();
    end);
    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(6.35 - u3, function() -- Line: 75
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
    local u14 = script.Camera_VFX:Clone();
    u14:PivotTo(CamRig.camera.CFrame);
    u14.Parent = Folder;
    Essentials:Weld(u14.PrimaryPart, CamRig.camera);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v15 = Character:FindFirstChild(child.Name);

        if v15 then
            local v16 = child:Clone();
            v16.CFrame = v15.CFrame;
            v16.Parent = Model;
            Essentials:Weld(v16, v15);
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u17 = script.Vignette:Clone();
    u17.Parent = PlayerGui;
    u17.Enabled = true;
    local Vignette = u17.Vignette;
    local _ = u17.Vignette1;
    Vignette.ImageTransparency = 0;
    task.spawn(function() -- Line: 113
        -- upvalues: Folder (copy), u13 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), Model (copy), u14 (copy), u6 (copy), u7 (copy), u8 (copy), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u13.Background1.Sphere.Transparency = 0;
        u13.Background1.Part.Transparency = 0;
        TweenService:Create(u13.Background1.Sphere, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 0.75
        }):Play();
        TweenService:Create(u13.Background1.Part, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 0.75
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 2);
        VfxManager.Enable(Model, true);
        VfxManager.Enable(u13.AuraForBeginning, true);
        VfxManager.Enable(u14, true);

        if u6 then
            VfxManager.Enable(u6, true);
        end;

        if u7 then
            VfxManager.Enable(u7, true);
        end;

        if u8 then
            VfxManager.Enable(u8, true);
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(1.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
    end);
    local u18 = {};

    local function v19() -- Line: 149
        -- upvalues: u18 (ref), Folder (copy), u17 (copy)
        for _, v in pairs(u18) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u17 then
            u17:Destroy();
        end;

        u18 = nil;
    end;

    table.insert(u18, Folder.AttributeChanged:Connect(v19));
    table.insert(u18, Folder.Destroying:Connect(v19));
end;