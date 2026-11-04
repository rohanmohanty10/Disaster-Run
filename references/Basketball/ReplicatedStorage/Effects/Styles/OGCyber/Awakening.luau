 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
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
local CyberpunkText = require(ReplicatedStorage.Shared.Functions.CyberpunkText);
local Debris = workspace:FindFirstChild("Debris");
local _ = game.Players.LocalPlayer;

local function ParticleOnly(p1: userdata, p2: boolean) -- Line: 20
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

local function BeamOnly(p3: userdata, p4: boolean) -- Line: 33
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

return function(u5, p6) -- Line: 47
    -- upvalues: CyberpunkText (copy), Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), VfxManager (copy), ParticleOnly (copy), BeamOnly (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p6.Char;
    local u7 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    Char:FindFirstChild("Head");
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

    task.spawn(CyberpunkText, script.CyberText.Newbie);
    task.delay(2.3, function() -- Line: 63
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "I made it this far, can\'t call me a newbie anymore!", 3.3 }
        });
    end);
    task.delay(11.2, function() -- Line: 73
        -- upvalues: CyberpunkText (ref)
        CyberpunkText(script.CyberText.BigLeague);
    end);
    task.delay(19.2, function() -- Line: 77
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "I got this!", 1.5 }
        });
    end);
    local u10 = workspace:GetServerTimeNow() - p6.previousTime + p6.passedTime;
    local u11 = 0;
    local u12 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u12 = RunService.RenderStepped:Connect(function(p13) -- Line: 92
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
    task.delay(22.333 - u10, function() -- Line: 111
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
    task.delay(22.333, function() -- Line: 127
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
        Sound = "BBZ Cyber Awakening",
        Parent = workspace
    });
    local ColorCorrection = game.Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v18 = child:Clone();
            v18.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v18.Parent = Model;
            Essentials:Weld(v18, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v18, false);
        end;
    end;

    local u19 = script.Camera_VFX:Clone();
    u19:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u19.Parent = Folder;
    Essentials:Weld(u19.PrimaryPart, CamRig.CamPart);
    local u20 = script.Cutscene_VFX:Clone();
    u20:PivotTo(HumanoidRootPart.CFrame);
    u20.Parent = Folder;
    task.delay(1.983 - u10, function() -- Line: 178
        -- upvalues: Folder (copy), ParticleOnly (ref), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u19.middlecam, true);
        task.wait(15);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u19.middlecam, false);
    end);
    task.delay(2.067 - u10, function() -- Line: 192
        -- upvalues: Folder (copy), BeamOnly (ref), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u19.camatmo.glaresandstuff, true);
        task.wait(4.7);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u19.camatmo.glaresandstuff, false);
    end);
    task.delay(8.05 - u10, function() -- Line: 206
        -- upvalues: Folder (copy), ParticleOnly (ref), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u19.camstart, true);
        task.wait(1.5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u19.camstart, false);
    end);
    task.delay(8.15 - u10, function() -- Line: 220
        -- upvalues: Folder (copy), ParticleOnly (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u20.laugh, true);
        task.wait(1.5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u20.laugh, false);
    end);
    task.delay(13.383 - u10, function() -- Line: 234
        -- upvalues: Folder (copy), ParticleOnly (ref), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u19.camatmo, true);
        task.wait(4);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u19.camatmo, false);
    end);
    task.delay(16.9 - u10, function() -- Line: 248
        -- upvalues: Folder (copy), ParticleOnly (ref), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u19.camtra, true);
        task.wait(1);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u19.camtra, false);
    end);
    task.delay(17.6 - u10, function() -- Line: 262
        -- upvalues: Folder (copy), ParticleOnly (ref), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u19.camstart, true);
        task.wait(5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u19.camstart, false);
    end);
    task.delay(17.85 - u10, function() -- Line: 276
        -- upvalues: Folder (copy), BeamOnly (ref), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u19.camatmo2.glaresandstuff, true);
        task.wait(5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u19.camatmo2.glaresandstuff, false);
    end);
    task.delay(18 - u10, function() -- Line: 290
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u20, false);
    end);
    task.delay(18.3 - u10, function() -- Line: 297
        -- upvalues: Folder (copy), BeamOnly (ref), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u19.glitchcam, true);
        task.wait(5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u19.glitchcam, false);
    end);
    task.delay(18.433 - u10, function() -- Line: 311
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy), Model (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.startup);
        task.wait(0.03333333333333333);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(Model, true);
        task.wait(5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(Model, false);
    end);

    local function v23() -- Line: 332
        -- upvalues: u15 (ref), Folder (copy), VfxManager (ref), u16 (ref), u17 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy)
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
            local v21, v22 = unpack(v);
            v21.Transparency = v22;
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
    end;

    table.insert(u15, Folder.AttributeChanged:Connect(v23));
    table.insert(u15, Folder.Destroying:Connect(v23));
end;