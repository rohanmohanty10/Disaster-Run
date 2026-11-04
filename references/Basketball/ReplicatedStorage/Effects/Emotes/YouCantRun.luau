 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
require(ReplicatedStorage.Controllers.UIController);
local Debris = workspace:FindFirstChild("Debris");
local _ = game.Players.LocalPlayer;

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

return function(u5, p6) -- Line: 45
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), BeamOnly (copy), VfxManager (copy), ParticleOnly (copy)
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
    task.delay(7.333 - u9, function() -- Line: 84
        -- upvalues: u11 (ref)
        u11:Disconnect();
    end);
    local u14 = {};
    local u15 = {};

    if Debris:FindFirstChild(v7) then
        Debris:FindFirstChild(v7):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v7;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(7.333, function() -- Line: 100
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Cyber CrushingVictim cutscene",
        Parent = workspace
    }).TimePosition = u9;
    local ColorCorrection = game.Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u16 = script.Camera_VFX:Clone();
    u16:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u16.Parent = Folder;
    Essentials:Weld(u16.PrimaryPart, CamRig.CamPart);
    local u17 = script.Cutscene_VFX:Clone();
    u17:PivotTo(HumanoidRootPart.CFrame);
    u17.Parent = Folder;
    BeamOnly(u16.camatmo, true);
    task.delay(0.083 - u9, function() -- Line: 138
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.firststep);
    end);
    task.delay(0.45 - u9, function() -- Line: 145
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.step2);
    end);
    task.delay(0.75 - u9, function() -- Line: 152
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.step3);
    end);
    task.delay(1.117 - u9, function() -- Line: 159
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.step4);
    end);
    task.delay(1.45 - u9, function() -- Line: 166
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.step5);
    end);
    task.delay(2.05 - u9, function() -- Line: 173
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.step6);
    end);
    task.delay(2.4 - u9, function() -- Line: 180
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.questionmark);
    end);
    task.delay(2.667 - u9, function() -- Line: 187
        -- upvalues: Folder (copy), ParticleOnly (ref), u16 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u16.camstart, true);
        task.wait(15);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u16.camstart, false);
    end);
    task.delay(2.967 - u9, function() -- Line: 201
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.land);
    end);
    task.delay(4.25 - u9, function() -- Line: 208
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.land);
    end);
    task.delay(5.283 - u9, function() -- Line: 215
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.land);
    end);
    task.delay(6 - u9, function() -- Line: 222
        -- upvalues: Folder (copy), BeamOnly (ref), u16 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u16.camatmo, false);
        BeamOnly(u16.camatmo2, true);
        task.wait(4);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u16.camatmo2, false);
    end);
    task.delay(6.483 - u9, function() -- Line: 239
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.land);
    end);

    local function v20() -- Line: 246
        -- upvalues: u14 (ref), Folder (copy), VfxManager (ref), u15 (ref), ColorCorrection (copy), Color3_fromRGB_ret (copy)
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
                elseif descendant:IsA("SpotLight") or (descendant:IsA("SurfaceLight") or descendant:IsA("PointLight")) then
                    descendant.Brightness = 0;
                end;
            end;
        end;

        for _, v in u15 do
            local v18, v19 = unpack(v);
            v18.Transparency = v19;
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        u14 = nil;
        u15 = nil;
    end;

    table.insert(u14, Folder.AttributeChanged:Connect(v20));
    table.insert(u14, Folder.Destroying:Connect(v20));
end;