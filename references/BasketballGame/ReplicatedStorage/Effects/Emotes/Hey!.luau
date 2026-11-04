 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local LightingController = require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
require(ReplicatedStorage.Controllers.UIController);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

local function ParticleOnly(p1: userdata, p2: boolean) -- Line: 19
    if p1 == nil then
        return;
    end;

    if p2 == nil then
        p2 = false;
    end;

    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = p2;
        end;
    end;
end;

local function BeamOnly(p3: userdata, p4: boolean) -- Line: 32
    if p3 == nil then
        return;
    end;

    if p4 == nil then
        p4 = false;
    end;

    for _, descendant in p3:GetDescendants() do
        if descendant:IsA("Beam") then
            descendant.Enabled = p4;
        end;
    end;
end;

return function(u5, p6) -- Line: 46
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), LocalPlayer (copy), Debris (copy), VfxManager (copy), TweenService (copy), LightingController (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p6.Char;

    if not game.Players:FindFirstChild(Char.Name) then
        game.Players:GetPlayerFromCharacter(Char);
    end;

    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Char:FindFirstChild("BALL", true);
    local v7 = Char.Name .. script.Parent.Name .. script.Name;

    if p6.Task ~= "Cutscene" then
        local v8 = p6.Task == "Cleanup" and Debris:FindFirstChild(v7);

        if v8 then
            v8:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u9 = workspace:GetServerTimeNow() - p6.previousTime + p6.passedTime;
    local u10 = 0;
    local u11 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u11 = RunService.RenderStepped:Connect(function(p12) -- Line: 65
        -- upvalues: u5 (copy), u11 (ref), u10 (ref), u9 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u5.MovementController.States.Ability == false then
            u11:Disconnect();

            return;
        end;

        if u10 <= 0 then
            u10 = p12 * 60 * u9;
        end;

        u10 = u10 + p12 * 60;
        local v13 = script_Fov[math.ceil(u10)];

        if v13 ~= nil then
            if math.ceil(u10) >= #script_Fov then
                u11:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v13, p12 * 6);
        end;
    end);
    task.delay(2.75 - u9, function() -- Line: 84
        -- upvalues: u11 (ref)
        u11:Disconnect();
    end);
    LocalPlayer:FindFirstChild("PlayerGui");
    local u14 = {};
    local game_Lighting = game.Lighting;
    game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u15 = nil;
    local u16 = nil;

    if Debris:FindFirstChild(v7) then
        Debris:FindFirstChild(v7):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v7;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(2.75, function() -- Line: 114
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u17 = script.Camera_VFX:Clone();
    u17:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u17.Parent = Folder;
    u17.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u17.PrimaryPart, CamRig.camera);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local u18 = child:Clone();
            u18.CFrame = Char:FindFirstChild(child.Name).CFrame;
            u18.Parent = Model;
            Essentials:Weld(u18, Char:FindFirstChild(child.Name));
            VfxManager.Enable(u18, false);
            task.delay(29, function() -- Line: 139
                -- upvalues: u18 (copy)
                u18:Destroy();
            end);
        end;
    end;

    local u19 = script.Cutscene_VFX:Clone();
    u19:PivotTo(HumanoidRootPart.CFrame);
    u19.Parent = Folder;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 1;
    Highlight.Parent = Char;
    task.delay(0.167 - u9, function() -- Line: 162
        -- upvalues: Folder (copy), game_Lighting (copy), u15 (ref), TweenService (ref), u16 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u19 (copy), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 23, 66);
        u15 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u15:Play();
        u16 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u16:Play();
        VfxManager.Emit(u19.ballgrab);
        VfxManager.Enable(u17.CameraAtmosphere, true);
        VfxManager.Emit(u19.step1);
    end);
    task.delay(0.433 - u9, function() -- Line: 181
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u17.CameraAtmosphere, false);
        VfxManager.Enable(u19.Laugh, true);
    end);
    task.delay(1.65 - u9, function() -- Line: 189
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u19.Laugh, false);
    end);

    local function v20() -- Line: 196
        -- upvalues: u14 (ref), Folder (copy), VfxManager (ref), u15 (ref), u16 (ref), Highlight (copy), LightingController (ref)
        for _, v in u14 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);

            for _, descendant in Folder:GetDescendants() do
                if descendant:IsA("Part") or (descendant:IsA("MeshPart") or descendant:IsA("Texture")) then
                    descendant.Transparency = 1;
                elseif descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("SurfaceLight")) then
                    descendant:Destroy();
                end;
            end;
        end;

        if u15 then
            u15:Pause();
        end;

        if u16 then
            u16:Pause();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        LightingController:ResetLighting(0.001);
        u14 = nil;
    end;

    table.insert(u14, Folder.AttributeChanged:Connect(v20));
    table.insert(u14, Folder.Destroying:Connect(v20));
end;