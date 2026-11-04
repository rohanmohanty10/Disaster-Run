 
 

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
local LocalPlayer = game.Players.LocalPlayer;

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
    -- upvalues: Effects (copy), CyberpunkText (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), VfxManager (copy), LocalPlayer (copy), ParticleOnly (copy)
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

    task.delay(1.1, function() -- Line: 62
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "UrghAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHH!", 3.5 }
        });
    end);
    task.delay(5.7, function() -- Line: 72
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "I\'m sorry we can\'t go to the next chapter together...", 2.8 }
        });
    end);
    local u10 = nil;
    task.delay(22.4, function() -- Line: 83
        -- upvalues: u10 (ref), CyberpunkText (ref)
        u10 = CyberpunkText(script.CyberText.Safe, true);
    end);
    local u11 = workspace:GetServerTimeNow() - p6.previousTime + p6.passedTime;
    local u12 = 0;
    local u13 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u13 = RunService.RenderStepped:Connect(function(p14) -- Line: 92
        -- upvalues: u5 (copy), u13 (ref), u12 (ref), u11 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u5.MovementController.States.Ability == false then
            u13:Disconnect();

            return;
        end;

        if u12 <= 0 then
            u12 = p14 * 60 * u11;
        end;

        u12 = u12 + p14 * 60;
        local v15 = script_Fov[math.ceil(u12)];

        if v15 ~= nil then
            if math.ceil(u12) >= #script_Fov then
                u13:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v15, p14 * 6);
        end;
    end);
    task.delay(25 - u11, function() -- Line: 111
        -- upvalues: u13 (ref)
        u13:Disconnect();
    end);
    local u16 = {};
    local u17 = {};

    if Debris:FindFirstChild(v8) then
        Debris:FindFirstChild(v8):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v8;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(25, function() -- Line: 127
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u18 = SfxManager:playSound({
        Sound = "BBZ Cyber Awakening CyberPsycho cutscene",
        Parent = workspace
    });
    u18.TimePosition = u11;
    local ColorCorrection = game.Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u19 = script.HeadVFX:Clone();
    u19.CFrame = Head.CFrame;
    u19.Parent = Folder;
    VfxManager.Enable(u19, false);
    Essentials:Weld(u19, Head);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v20 = child:Clone();
            v20.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v20.Parent = Model;
            Essentials:Weld(v20, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v20, false);
        end;
    end;

    local u21 = script.Camera_VFX:Clone();
    u21:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u21.Parent = Folder;
    Essentials:Weld(u21.PrimaryPart, CamRig.CamPart);
    local u22 = script.Cutscene_VFX:Clone();
    u22:PivotTo(HumanoidRootPart.CFrame);
    u22.Parent = Folder;
    local u23 = script.Blackout:Clone();
    u23.Parent = LocalPlayer.PlayerGui;
    VfxManager.Enable(Model, true);
    task.delay(1.4 - u11, function() -- Line: 188
        -- upvalues: u23 (copy)
        u23.Enabled = false;
    end);
    task.delay(5 - u11, function() -- Line: 192
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(Model, false);
    end);
    task.delay(0.016666666666666666 - u11, function() -- Line: 199
        -- upvalues: Folder (copy), ParticleOnly (ref), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u21.glitchcam.middlecam, true);
        task.wait(5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u21.glitchcam.middlecam, false);
    end);
    task.delay(0.03333333333333333 - u11, function() -- Line: 213
        -- upvalues: Folder (copy), ParticleOnly (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u22.enviro.dysfunction, true);
        task.wait(5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u22.enviro.dysfunction, false);
    end);
    task.delay(4.083 - u11, function() -- Line: 227
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.smokeemit);
    end);
    task.delay(5.167 - u11, function() -- Line: 234
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.dysemit);
    end);
    task.delay(5.7 - u11, function() -- Line: 241
        -- upvalues: Folder (copy), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u23.Enabled = true;
    end);
    task.delay(5.8 - u11, function() -- Line: 248
        -- upvalues: Folder (copy), ParticleOnly (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u22.smokeenable, true);
        task.wait(5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u22.smokeenable, false);
    end);
    task.delay(9.83 - u11, function() -- Line: 263
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.smokeemit2);
        u23:Destroy();
    end);
    task.delay(13.75 - u11, function() -- Line: 272
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.eyesemit);
    end);
    task.delay(14.455 - u11, function() -- Line: 279
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.firststep);
    end);
    task.delay(15.833 - u11, function() -- Line: 286
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.secondstep);
    end);
    task.delay(17 - u11, function() -- Line: 294
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.thirdstep);
    end);
    task.delay(18 - u11, function() -- Line: 301
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.fourthstep);
    end);
    task.delay(20.833 - u11, function() -- Line: 308
        -- upvalues: Folder (copy), ParticleOnly (ref), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u21.camtra, true);
        task.wait(0.3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u21.camtra, false);
    end);
    task.delay(20.833 - u11, function() -- Line: 323
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19);
    end);

    local function v26() -- Line: 330
        -- upvalues: u16 (ref), Folder (copy), VfxManager (ref), u17 (ref), u18 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), u10 (ref)
        for _, v in u16 do
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
                    descendant.Enabled = false;
                end;
            end;
        end;

        for _, v in u17 do
            local v24, v25 = unpack(v);
            v24.Transparency = v25;
        end;

        if u18 then
            VfxManager.DestroyEffect(u18, 2);
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        u16 = nil;
        u17 = nil;

        if u10 then
            u10:Destroy();
        end;
    end;

    table.insert(u16, Folder.AttributeChanged:Connect(v26));
    table.insert(u16, Folder.Destroying:Connect(v26));
end;