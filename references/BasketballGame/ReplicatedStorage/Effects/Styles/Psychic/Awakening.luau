 
 

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
    -- upvalues: Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), VfxManager (copy), BeamOnly (copy), ParticleOnly (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p6.Char;
    local u7 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    local Head = Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Char:FindFirstChild("BALL", true);
    local v8 = Char.Name .. script.Parent.Name .. script.Name;

    if p6.Task ~= "Cutscene" then
        local v9 = p6.Task == "Cleanup" and Debris:FindFirstChild(v8);

        if v9 then
            v9:SetAttribute("Active", nil);
        end;

        return;
    end;

    task.delay(2, function() -- Line: 60
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "I should try a little harder...", 1.5 }
        });
    end);
    task.delay(4.8, function() -- Line: 70
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { "Friend", "Yo, buddy!", 1.2 },
            { u7, "Agh!", 0.5 }
        });
    end);
    local u10 = workspace:GetServerTimeNow() - p6.previousTime + p6.passedTime;
    local u11 = 0;
    local u12 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u12 = RunService.RenderStepped:Connect(function(p13) -- Line: 90
        -- upvalues: u5 (copy), u12 (ref), u11 (ref), u10 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u5.MovementController.States.Ability == false then
            u12:Disconnect();

            return;
        end;

        if u11 <= 0 then
            u11 = p13 * 60 * u10;
        end;

        u11 = u11 + p13 * 60;
        local v14 = script_Fov[math.ceil(u11)];

        if v14 ~= nil then
            if math.ceil(u11) >= #script_Fov then
                u12:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v14, p13 * 6);
        end;
    end);
    task.delay(16.717 - u10, function() -- Line: 109
        -- upvalues: u12 (ref)
        u12:Disconnect();
    end);
    local u15 = {};
    local u16 = {};

    if Debris:FindFirstChild(v8) then
        Debris:FindFirstChild(v8):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v8;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(16.717, function() -- Line: 125
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u17 = SfxManager:playSound({
        Sound = "BBZ Psychic awakening cutscene",
        Parent = HumanoidRootPart
    });
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u18 = script.Vignette:Clone();
    u18.Parent = PlayerGui;
    u18.Enabled = true;
    local Vignette = u18.Vignette;
    local _ = u18.Vignette1;
    local MobVignette = u18.MobVignette;
    local _ = u18.FlatColor;
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local Model = Instance.new("Model");
    Model.Parent = Folder;
    local u19 = nil;
    local u20 = nil;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v21 = child:Clone();
            v21.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v21.Parent = Model;
            Essentials:Weld(v21, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v21, false);
        end;
    end;

    local u22 = script.Camera_VFX:Clone();
    u22:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u22.Parent = Folder;
    Essentials:Weld(u22.PrimaryPart, CamRig.camera);
    local u23 = script.Cutscene_VFX:Clone();
    u23:PivotTo(HumanoidRootPart.CFrame);
    u23.Parent = Folder;
    local u24 = script.Head:Clone();
    u24.CFrame = Head.CFrame;
    u24.Parent = Folder;
    Essentials:Weld(u24, Head);
    local PsychicAntenna = Char:FindFirstChild("PsychicAntenna");

    if PsychicAntenna ~= nil then
        PsychicAntenna.Handle.LocalTransparencyModifier = 1;
    end;

    local Sphere = u23.Sphere;
    VfxManager.Enable(u22.camstart, true);
    task.delay(7 - u10, function() -- Line: 198
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u22.camstart, false);
    end);
    task.delay(3.4 - u10, function() -- Line: 206
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.questionmark);
    end);
    task.delay(4.617 - u10, function() -- Line: 213
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.CamTrans2);
    end);
    task.delay(4.783 - u10, function() -- Line: 220
        -- upvalues: Folder (copy), BeamOnly (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u23.background, true);
        task.wait(1.3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u23.background, false);
    end);
    task.delay(4.8 - u10, function() -- Line: 234
        -- upvalues: Folder (copy), ParticleOnly (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u23.background, true);
        task.wait(1.3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u23.background, false);
    end);
    task.delay(4.817 - u10, function() -- Line: 248
        -- upvalues: Folder (copy), BeamOnly (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u22.camglareflower, true);
        task.wait(1.3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u22.camglareflower, false);
    end);
    u23.Dome["inverted sphere"].Transparency = 1;
    u23.Dome.Part.Transparency = 1;
    task.delay(4.85 - u10, function() -- Line: 265
        -- upvalues: Folder (copy), u23 (copy), HumanoidRootPart (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u23.Dome["inverted sphere"].Transparency = 0;
        u23.Dome.Part.Transparency = 0;
        u23.Dome["inverted sphere"].CFrame = HumanoidRootPart.CFrame * CFrame.new(0.37605857849121094, 2.341657876968384, 19.56069564819336) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
        u23.Dome.Part.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.03933429718017578, -3.459683895111084, 19.493885040283203) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
    end);
    task.delay(5.967 - u10, function() -- Line: 276
        -- upvalues: Folder (copy), TweenService (ref), u23 (copy), HumanoidRootPart (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u23.Dome["inverted sphere"], TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(0.37605857849121094, -20.97843360900879, 19.56069564819336) * CFrame.fromEulerAnglesYXZ(-0, 0, 0)
        }):Play();
        TweenService:Create(u23.Dome.Part, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(0.03933429718017578, -21.368515014648438, 19.493885040283203) * CFrame.fromEulerAnglesYXZ(-0, 0, 0)
        }):Play();
    end);
    task.delay(6.383 - u10, function() -- Line: 289
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.chocolate);
    end);
    task.delay(7.05 - u10, function() -- Line: 296
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(Model, true);
    end);
    task.delay(7.3 - u10, function() -- Line: 303
        -- upvalues: Folder (copy), Sphere (copy), TweenService (ref), game_Lighting (copy), u19 (ref), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Sphere.Transparency = 0.9;
        TweenService:Create(Sphere, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Transparency = 1
        }):Play();
        game_Lighting.ColorCorrection.Brightness = 0.35;
        u19 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u19:Play();
        VfxManager.Emit(u23.Hit1);
    end);
    task.delay(7.383 - u10, function() -- Line: 318
        -- upvalues: Folder (copy), Sphere (copy), TweenService (ref), game_Lighting (copy), u20 (ref), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Sphere.Transparency = 0.9;
        TweenService:Create(Sphere, TweenInfo.new(0.955, Enum.EasingStyle.Sine), {
            Transparency = 1
        }):Play();
        game_Lighting.ColorCorrection.Brightness = 0.35;
        u20 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u20:Play();
        VfxManager.Emit(u23.Hit1);
    end);
    task.delay(7.733 - u10, function() -- Line: 333
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.fallground);
    end);
    task.delay(8.167 - u10, function() -- Line: 340
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.ballhit);
    end);
    task.delay(9.05 - u10, function() -- Line: 347
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy), Model (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u23.characterlines, true);
        VfxManager.Enable(Model, false);
        task.delay(3, function() -- Line: 354
            -- upvalues: Folder (ref), VfxManager (ref), u23 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Enable(u23.characterlines, false);
        end);
    end);
    task.delay(10.367 - u10, function() -- Line: 362
        -- upvalues: Folder (copy), ParticleOnly (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u22.camtra, true);
        task.wait(0.3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u22.camtra, false);
    end);
    task.delay(12.1 - u10, function() -- Line: 376
        -- upvalues: Folder (copy), ParticleOnly (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u22.camtra, true);
        task.wait(0.3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u22.camtra, false);
    end);
    task.delay(12.25 - u10, function() -- Line: 390
        -- upvalues: Folder (copy), ParticleOnly (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u22.camstart, true);
        task.wait(5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u22.camstart, false);
    end);
    task.delay(13.033 - u10, function() -- Line: 404
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy), Vignette (copy), TweenService (ref), game_Lighting (copy), u19 (ref), Color3_fromRGB_ret (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.angry);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.angryshatter);
        Vignette.ImageColor3 = Color3.fromRGB(255, 28, 28);
        TweenService:Create(Vignette, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 44, 44);
        game_Lighting.ColorCorrection.Contrast = 1;
        game_Lighting.ColorCorrection.Brightness = 0.6;
        u19 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2,
            TintColor = Color3_fromRGB_ret
        });
        u19:Play();
    end);
    task.delay(14.133 - u10, function() -- Line: 430
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.antenahit);
    end);
    task.delay(14.567 - u10, function() -- Line: 437
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy), MobVignette (copy), TweenService (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.antenahit);
        MobVignette.ImageTransparency = 0;
        TweenService:Create(MobVignette, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(15 - u10, function() -- Line: 447
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy), MobVignette (copy), TweenService (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.antenahit);
        MobVignette.ImageTransparency = 0;
        TweenService:Create(MobVignette, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(15.4 - u10, function() -- Line: 458
        -- upvalues: Folder (copy), ParticleOnly (ref), Model (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(Model, true);
        task.wait(3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(Model, false);
    end);
    task.delay(15.417 - u10, function() -- Line: 472
        -- upvalues: Folder (copy), ParticleOnly (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u22.camtra, true);
        task.wait(0.2);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u22.camtra, false);
    end);
    task.delay(15.45 - u10, function() -- Line: 486
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy), u24 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.antenahitreal);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.auraemit);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u24);
    end);

    local function v27() -- Line: 507
        -- upvalues: u18 (copy), u15 (ref), Folder (copy), VfxManager (ref), u16 (ref), u19 (ref), u20 (ref), u17 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), Char (copy)
        if u18 then
            u18:Destroy();
        end;

        for _, v in u15 do
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

        for _, v in u16 do
            local v25, v26 = unpack(v);
            v25.Transparency = v26;
        end;

        if u19 then
            u19:Pause();
        end;

        if u20 then
            u20:Pause();
        end;

        if u17 then
            VfxManager.DestroyEffect(u17, 2);
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        u15 = nil;
        u16 = nil;
        local PsychicAntenna2 = Char:FindFirstChild("PsychicAntenna");

        if PsychicAntenna2 ~= nil then
            PsychicAntenna2.Handle.LocalTransparencyModifier = 0;
        end;
    end;

    table.insert(u15, Folder.AttributeChanged:Connect(v27));
    table.insert(u15, Folder.Destroying:Connect(v27));
end;