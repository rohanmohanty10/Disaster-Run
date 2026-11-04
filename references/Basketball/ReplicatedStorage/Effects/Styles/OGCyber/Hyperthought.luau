 
 

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
local UIController = require(ReplicatedStorage.Controllers.UIController);
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

local function createClone(p5: userdata) -- Line: 45
    p5.Archivable = true;
    local v6 = p5:Clone();
    v6.Parent = workspace.Debris;
    local v7 = ({
        Color3.fromRGB(66, 252, 255),
        Color3.fromRGB(65, 141, 255),
        Color3.fromRGB(255, 248, 43),
        Color3.fromRGB(255, 200, 61)
    })[math.random(1, 4)];

    for _, descendant in v6:GetDescendants() do
        if descendant:IsA("Script") or (descendant:IsA("LocalScript") or (descendant:IsA("Highlight") or descendant:IsA("Sound"))) then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;

            if descendant:GetAttribute("Invis") and (descendant.Name ~= "BALL" and descendant.Name ~= "Model") then
                descendant.Transparency = 0;
            end;
        elseif descendant:IsA("Humanoid") then
            descendant.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
            descendant:Destroy();
        end;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = v7;
    Highlight.FillTransparency = 0.5;
    Highlight.OutlineColor = v7;
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = v6;
    Highlight.Enabled = true;

    return v6;
end;

local function poseClone(p8, p9) -- Line: 96
    for _, child in p8:GetChildren() do
        local v10 = p9:FindFirstChild(child.Name);

        if child:IsA("BasePart") and (v10 and v10:IsA("BasePart")) then
            child.CFrame = v10.CFrame;
        end;
    end;
end;

return function(u11, p12) -- Line: 107
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), ReplicatedStorage (copy), VfxManager (copy), BeamOnly (copy), ParticleOnly (copy), UIController (copy), createClone (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p12.Char;

    if not game.Players:FindFirstChild(Char.Name) then
        game.Players:GetPlayerFromCharacter(Char);
    end;

    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Char:FindFirstChild("BALL", true);
    local v13 = Char.Name .. script.Parent.Name .. script.Name;

    if p12.Task ~= "Cutscene" then
        if p12.Task == "Cleanup" then
            local v14 = Debris:FindFirstChild(v13);

            if v14 then
                v14:SetAttribute("Active", nil);

                return;
            end;
        elseif p12.Task == "NoCutscene" then
            SfxManager:playSound({
                Sound = "BBZ Sandevistan Generic Activate",
                Parent = HumanoidRootPart
            });
            task.spawn(function() -- Line: 748
                -- upvalues: LocalPlayer (ref), ReplicatedStorage (ref), UIController (ref)
                local ScreenGui = Instance.new("ScreenGui");
                ScreenGui.Parent = LocalPlayer.PlayerGui;
                ScreenGui.IgnoreGuiInset = true;
                local v15 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
                v15.Parent = ScreenGui;
                UIController:PlayFlipbook(v15, "HyperthoughtCutsceneFrames", 0.016666666666666666);
                task.delay(0.08333333333333333, function() -- Line: 758
                    -- upvalues: ScreenGui (copy)
                    ScreenGui:Destroy();
                end);
            end);
            local Lighting = game:GetService("Lighting");
            local u16 = script.ColorCorrection:Clone();
            u16.Parent = Lighting;
            u16.Enabled = true;

            if Char then
                Char.Archivable = true;
            end;

            local u17 = {};
            local u18 = 0;
            task.spawn(function() -- Line: 779
                -- upvalues: HumanoidRootPart (copy), u18 (ref), createClone (ref), Char (copy), u17 (ref), u16 (copy), SfxManager (ref)
                local os_clock_ret = os.clock();

                while HumanoidRootPart.Parent ~= nil and os.clock() - os_clock_ret < 5 do
                    u18 = u18 + 1;
                    local v19 = createClone(Char);
                    table.insert(u17, v19);

                    if u18 > 14 then
                        u17[u18 - 14]:Destroy();
                    end;

                    task.wait(0.1);
                end;

                if Char then
                    Char.Archivable = false;
                end;

                if u16 then
                    u16:Destroy();
                end;

                SfxManager:playSound({
                    Sound = "BBZ Sandevistan Generic Recall + End",
                    Parent = HumanoidRootPart
                });

                for _, v in u17 do
                    if v then
                        v:Destroy();
                    end;

                    task.wait(0.01);
                end;

                u17 = nil;
            end);
        end;

        return;
    end;

    local u20 = workspace:GetServerTimeNow() - p12.previousTime + p12.passedTime;
    local u21 = 0;
    local u22 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u22 = RunService.RenderStepped:Connect(function(p23) -- Line: 127
        -- upvalues: u11 (copy), u22 (ref), u21 (ref), u20 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u11.MovementController.States.Ability == false then
            u22:Disconnect();

            return;
        end;

        if u21 <= 0 then
            u21 = p23 * 60 * u20;
        end;

        u21 = u21 + p23 * 60;
        local v24 = script_Fov[math.ceil(u21)];

        if v24 ~= nil then
            if math.ceil(u21) >= #script_Fov then
                u22:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v24, p23 * 6);
        end;
    end);
    task.delay(21.25 - u20, function() -- Line: 146
        -- upvalues: u22 (ref)
        u22:Disconnect();
    end);
    local u25 = {};
    local u26 = {};

    if Debris:FindFirstChild(v13) then
        Debris:FindFirstChild(v13):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v13;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(21.25, function() -- Line: 162
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u27 = SfxManager:playSound({
        Sound = "BBZ Cyber Awakening NOTSandevistan cutscene",
        Parent = workspace
    });
    u27.TimePosition = u20;
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u28 = ReplicatedStorage.Assets.VFX.Vignette:Clone();
    u28.Parent = PlayerGui;
    u28.Enabled = true;
    local _ = u28.Vignette;
    local _ = u28.Vignette1;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v29 = child:Clone();
            v29.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v29.Parent = Model;
            Essentials:Weld(v29, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v29, false);
        end;
    end;

    local u30 = script.Camera_VFX:Clone();
    u30:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u30.Parent = Folder;
    Essentials:Weld(u30.PrimaryPart, CamRig.CamPart);
    local u31 = script.Cutscene_VFX:Clone();
    u31:PivotTo(HumanoidRootPart.CFrame);
    u31.Parent = Folder;
    local u32 = script.BALL:Clone();
    u32.CFrame = BALL.CFrame;
    u32.Parent = Folder;
    Essentials:Weld(u32, BALL);
    VfxManager.Enable(u32, false);
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = Char;
    local u33 = script.ColorCorrection:Clone();
    u33.Parent = game_Lighting;
    local u34 = script.sandyimpactframe:Clone();
    u34.Parent = game_Lighting;
    local u35 = script.sky:Clone();
    u35.Parent = game_Lighting;
    u35.Enabled = true;
    task.delay(13.517 - u20, function() -- Line: 268
        -- upvalues: Folder (copy), u35 (copy), u33 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u35.Enabled = true;
        u33.Enabled = false;
    end);
    BeamOnly(u30.camatmo, true);
    task.delay(0.25 - u20, function() -- Line: 278
        -- upvalues: Folder (copy), VfxManager (ref), u31 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u31.startup);
    end);
    task.delay(0.317 - u20, function() -- Line: 285
        -- upvalues: Folder (copy), ParticleOnly (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.background, true);
        task.wait(1);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.background, false);
    end);
    task.delay(0.333 - u20, function() -- Line: 299
        -- upvalues: Folder (copy), VfxManager (ref), u32 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u32.emit);
    end);
    task.delay(1.067 - u20, function() -- Line: 306
        -- upvalues: Folder (copy), ParticleOnly (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.DunkCameraHorizontal, true);
        task.wait(0.3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.DunkCameraHorizontal, false);
    end);
    task.delay(1.183 - u20, function() -- Line: 321
        -- upvalues: Folder (copy), ParticleOnly (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.camstart, true);
        task.wait(3.5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.camstart, false);
    end);
    task.delay(1.3 - u20, function() -- Line: 335
        -- upvalues: Folder (copy), BeamOnly (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u30.camatmo, false);
    end);
    task.delay(2.4 - u20, function() -- Line: 342
        -- upvalues: Folder (copy), VfxManager (ref), u31 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u31.land);
    end);
    task.delay(3.33 - u20, function() -- Line: 349
        -- upvalues: Folder (copy), ParticleOnly (ref), u31 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u31.ennemiesaura, true);
        task.wait(3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u31.ennemiesaura, false);
    end);
    task.delay(4.5 - u20, function() -- Line: 363
        -- upvalues: Folder (copy), ParticleOnly (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.camstart, true);
        task.wait(0.5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.camstart, false);
    end);
    task.delay(4.85 - u20, function() -- Line: 377
        -- upvalues: Folder (copy), LocalPlayer (ref), ReplicatedStorage (ref), UIController (ref), u34 (copy), u35 (copy), u33 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Parent = LocalPlayer.PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        local v36 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v36.Parent = ScreenGui;
        UIController:PlayFlipbook(v36, "HyperthoughtCutsceneFrames", 0.03333333333333333);
        task.wait(0.16666666666666666);
        ScreenGui:Destroy();
        u34.Enabled = true;
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u35.Enabled = false;
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u33.Enabled = true;
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u34.Enabled = false;
    end);
    task.delay(7.967 - u20, function() -- Line: 415
        -- upvalues: Folder (copy), ParticleOnly (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.downcam, true);
        ParticleOnly(u30.middlecam, true);
        ParticleOnly(u30.upcam, true);
        task.wait(2);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.downcam, false);
        ParticleOnly(u30.middlecam, false);
        ParticleOnly(u30.upcam, false);
    end);
    local u37 = {};
    task.delay(8.017 - u20, function() -- Line: 435
        -- upvalues: Folder (copy), Char (copy), u31 (copy), HumanoidRootPart (copy), createClone (ref), u37 (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        if Char then
            Char.Archivable = true;
        end;

        u31:SetAttribute("Clone", true);
        task.spawn(function() -- Line: 447
            -- upvalues: HumanoidRootPart (ref), Folder (ref), u31 (ref), createClone (ref), Char (ref), u37 (ref)
            local os_clock_ret = os.clock();

            while HumanoidRootPart.Parent ~= nil and (os.clock() - os_clock_ret < 3.65 and (Folder ~= nil and (Folder:GetAttribute("Active") ~= nil and u31:GetAttribute("Clone") ~= nil))) do
                local v38 = createClone(Char);
                table.insert(u37, v38);
                task.wait(0.1);
            end;

            if Char then
                Char.Archivable = false;
            end;
        end);
    end);
    task.delay(8.2 - u20, function() -- Line: 478
        -- upvalues: Folder (copy), VfxManager (ref), u31 (copy), u32 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u31.Dribble1);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u32.emit);
    end);
    task.delay(8.333 - u20, function() -- Line: 491
        -- upvalues: Folder (copy), VfxManager (ref), u31 (copy), u32 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u31.Dribble2);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u32.emit);
    end);
    task.delay(8.733 - u20, function() -- Line: 504
        -- upvalues: Folder (copy), VfxManager (ref), u31 (copy), u32 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u31.Dribble3);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u32.emit);
    end);
    task.delay(8.733 - u20, function() -- Line: 517
        -- upvalues: Folder (copy), VfxManager (ref), u31 (copy), u32 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u31.Dribble4);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u32.emit);
    end);
    task.delay(9.383 - u20, function() -- Line: 530
        -- upvalues: Folder (copy), VfxManager (ref), u31 (copy), u32 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u31.Dribble5);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u32.emit);
    end);
    task.delay(9.933 - u20, function() -- Line: 543
        -- upvalues: Folder (copy), ParticleOnly (ref), u31 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u31.characterlines, true);
        task.wait(3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u31.characterlines, false);
    end);
    task.delay(11.65 - u20, function() -- Line: 557
        -- upvalues: Folder (copy), VfxManager (ref), u31 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u31.jump);
    end);
    task.delay(11.817 - u20, function() -- Line: 564
        -- upvalues: Folder (copy), ParticleOnly (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.camstart, true);
        task.wait(1.5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.camstart, false);
    end);
    task.delay(13.517 - u20, function() -- Line: 578
        -- upvalues: Folder (copy), u37 (ref), u31 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, v in u37 do
            if v then
                v:Destroy();
            end;
        end;

        u31:SetAttribute("Clone", nil);
    end);
    task.delay(14.033 - u20, function() -- Line: 591
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy), u31 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(Model, true);
        task.delay(0.016666666666666666, function() -- Line: 597
            -- upvalues: Folder (ref), VfxManager (ref), u31 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Emit(u31.TP);
        end);
        task.wait(2);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(Model, false);
    end);
    task.delay(16.717 - u20, function() -- Line: 612
        -- upvalues: Folder (copy), ParticleOnly (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.camstart, true);
        task.wait(5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.camstart, false);
    end);
    task.delay(18.6 - u20, function() -- Line: 626
        -- upvalues: Folder (copy), VfxManager (ref), u31 (copy), ParticleOnly (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u31.goalemit);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u31.enabledgoal, true);
        task.wait(3.5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u31.enabledgoal, false);
    end);

    local function v41() -- Line: 647
        -- upvalues: u25 (ref), Folder (copy), VfxManager (ref), u26 (ref), u37 (ref), Highlight (copy), u35 (copy), u34 (copy), u33 (copy), u27 (copy), u28 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy)
        for _, v in u25 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);

            for _, descendant in Folder:GetDescendants() do
                if descendant:IsA("Part") or (descendant:IsA("MeshPart") or (descendant:IsA("Texture") or (descendant:IsA("SpotLight") or (descendant:IsA("SurfaceLight") or descendant:IsA("PointLight"))))) then
                    descendant.Transparency = 1;
                end;
            end;
        end;

        for _, v in u26 do
            local v39, v40 = unpack(v);
            v39.Transparency = v40;
        end;

        for _, v in u37 do
            if v then
                v:Destroy();
            end;
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u35 then
            u35:Destroy();
        end;

        if u34 then
            u34:Destroy();
        end;

        if u33 then
            u33:Destroy();
        end;

        if u27 then
            VfxManager.DestroyEffect(u27, 2);
        end;

        if u28 then
            u28:Destroy();
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        u25 = nil;
        u26 = nil;
        u37 = nil;
    end;

    table.insert(u25, Folder.AttributeChanged:Connect(v41));
    table.insert(u25, Folder.Destroying:Connect(v41));
end;