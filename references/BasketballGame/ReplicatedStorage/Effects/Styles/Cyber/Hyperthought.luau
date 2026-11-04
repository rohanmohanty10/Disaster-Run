 
 

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
    local Color3_fromRGB_ret = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255));

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
    Highlight.FillColor = Color3_fromRGB_ret;
    Highlight.FillTransparency = 0.5;
    Highlight.OutlineColor = Color3_fromRGB_ret;
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = v6;
    Highlight.Enabled = true;

    return v6, Color3_fromRGB_ret;
end;

local function poseClone(p7, p8) -- Line: 90
    for _, child in p7:GetChildren() do
        local v9 = p8:FindFirstChild(child.Name);

        if child:IsA("BasePart") and (v9 and v9:IsA("BasePart")) then
            child.CFrame = v9.CFrame;
        end;
    end;
end;

return function(u10, p11) -- Line: 101
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), ReplicatedStorage (copy), VfxManager (copy), BeamOnly (copy), ParticleOnly (copy), UIController (copy), createClone (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p11.Char;

    if not game.Players:FindFirstChild(Char.Name) then
        game.Players:GetPlayerFromCharacter(Char);
    end;

    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Char:FindFirstChild("BALL", true);
    local v12 = Char.Name .. script.Parent.Name .. script.Name;

    if p11.Task ~= "Cutscene" then
        if p11.Task == "Cleanup" then
            local v13 = Debris:FindFirstChild(v12);

            if v13 then
                v13:SetAttribute("Active", nil);

                return;
            end;
        elseif p11.Task == "NoCutscene" then
            SfxManager:playSound({
                Sound = "BBZ Sandevistan Generic Activate",
                Parent = HumanoidRootPart
            });
            task.spawn(function() -- Line: 742
                -- upvalues: LocalPlayer (ref), ReplicatedStorage (ref), UIController (ref)
                local ScreenGui = Instance.new("ScreenGui");
                ScreenGui.Parent = LocalPlayer.PlayerGui;
                ScreenGui.IgnoreGuiInset = true;
                local v14 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
                v14.Parent = ScreenGui;
                UIController:PlayFlipbook(v14, "HyperthoughtCutsceneFrames", 0.016666666666666666);
                task.delay(0.08333333333333333, function() -- Line: 752
                    -- upvalues: ScreenGui (copy)
                    ScreenGui:Destroy();
                end);
            end);
            local Lighting = game:GetService("Lighting");
            local u15 = script.ColorCorrection:Clone();
            u15.Parent = Lighting;
            u15.Enabled = true;

            if Char then
                Char.Archivable = true;
            end;

            local u16 = {};
            local u17 = 0;
            task.spawn(function() -- Line: 773
                -- upvalues: HumanoidRootPart (copy), u17 (ref), createClone (ref), Char (copy), u16 (ref), u15 (copy), SfxManager (ref)
                local os_clock_ret = os.clock();

                while HumanoidRootPart.Parent ~= nil and os.clock() - os_clock_ret < 5 do
                    u17 = u17 + 1;
                    local v18, _ = createClone(Char);
                    table.insert(u16, v18);

                    if u17 > 14 then
                        u16[u17 - 14]:Destroy();
                    end;

                    task.wait(0.1);
                end;

                if Char then
                    Char.Archivable = false;
                end;

                if u15 then
                    u15:Destroy();
                end;

                SfxManager:playSound({
                    Sound = "BBZ Sandevistan Generic Recall + End",
                    Parent = HumanoidRootPart
                });

                for _, v in u16 do
                    if v then
                        v:Destroy();
                    end;

                    task.wait(0.01);
                end;

                u16 = nil;
            end);
        end;

        return;
    end;

    local u19 = workspace:GetServerTimeNow() - p11.previousTime + p11.passedTime;
    local u20 = 0;
    local u21 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u21 = RunService.RenderStepped:Connect(function(p22) -- Line: 121
        -- upvalues: u10 (copy), u21 (ref), u20 (ref), u19 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u10.MovementController.States.Ability == false then
            u21:Disconnect();

            return;
        end;

        if u20 <= 0 then
            u20 = p22 * 60 * u19;
        end;

        u20 = u20 + p22 * 60;
        local v23 = script_Fov[math.ceil(u20)];

        if v23 ~= nil then
            if math.ceil(u20) >= #script_Fov then
                u21:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v23, p22 * 6);
        end;
    end);
    task.delay(21.25 - u19, function() -- Line: 140
        -- upvalues: u21 (ref)
        u21:Disconnect();
    end);
    local u24 = {};
    local u25 = {};

    if Debris:FindFirstChild(v12) then
        Debris:FindFirstChild(v12):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v12;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(21.25, function() -- Line: 156
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u26 = SfxManager:playSound({
        Sound = "BBZ Cyber Awakening NOTSandevistan cutscene",
        Parent = workspace
    });
    u26.TimePosition = u19;
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u27 = ReplicatedStorage.Assets.VFX.Vignette:Clone();
    u27.Parent = PlayerGui;
    u27.Enabled = true;
    local _ = u27.Vignette;
    local _ = u27.Vignette1;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v28 = child:Clone();
            v28.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v28.Parent = Model;
            Essentials:Weld(v28, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v28, false);
        end;
    end;

    local u29 = script.Camera_VFX:Clone();
    u29:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u29.Parent = Folder;
    Essentials:Weld(u29.PrimaryPart, CamRig.CamPart);
    local u30 = script.Cutscene_VFX:Clone();
    u30:PivotTo(HumanoidRootPart.CFrame);
    u30.Parent = Folder;
    local u31 = script.BALL:Clone();
    u31.CFrame = BALL.CFrame;
    u31.Parent = Folder;
    Essentials:Weld(u31, BALL);
    VfxManager.Enable(u31, false);
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = Char;
    local u32 = script.ColorCorrection:Clone();
    u32.Parent = game_Lighting;
    local u33 = script.sandyimpactframe:Clone();
    u33.Parent = game_Lighting;
    local u34 = script.sky:Clone();
    u34.Parent = game_Lighting;
    u34.Enabled = true;
    task.delay(13.517 - u19, function() -- Line: 262
        -- upvalues: Folder (copy), u34 (copy), u32 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u34.Enabled = true;
        u32.Enabled = false;
    end);
    BeamOnly(u29.camatmo, true);
    task.delay(0.25 - u19, function() -- Line: 272
        -- upvalues: Folder (copy), VfxManager (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u30.startup);
    end);
    task.delay(0.317 - u19, function() -- Line: 279
        -- upvalues: Folder (copy), ParticleOnly (ref), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.background, true);
        task.wait(1);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.background, false);
    end);
    task.delay(0.333 - u19, function() -- Line: 293
        -- upvalues: Folder (copy), VfxManager (ref), u31 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u31.emit);
    end);
    task.delay(1.067 - u19, function() -- Line: 300
        -- upvalues: Folder (copy), ParticleOnly (ref), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.DunkCameraHorizontal, true);
        task.wait(0.3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.DunkCameraHorizontal, false);
    end);
    task.delay(1.183 - u19, function() -- Line: 315
        -- upvalues: Folder (copy), ParticleOnly (ref), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.camstart, true);
        task.wait(3.5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.camstart, false);
    end);
    task.delay(1.3 - u19, function() -- Line: 329
        -- upvalues: Folder (copy), BeamOnly (ref), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        BeamOnly(u29.camatmo, false);
    end);
    task.delay(2.4 - u19, function() -- Line: 336
        -- upvalues: Folder (copy), VfxManager (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u30.land);
    end);
    task.delay(3.33 - u19, function() -- Line: 343
        -- upvalues: Folder (copy), ParticleOnly (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.ennemiesaura, true);
        task.wait(3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.ennemiesaura, false);
    end);
    task.delay(4.5 - u19, function() -- Line: 357
        -- upvalues: Folder (copy), ParticleOnly (ref), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.camstart, true);
        task.wait(0.5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.camstart, false);
    end);
    task.delay(4.85 - u19, function() -- Line: 371
        -- upvalues: Folder (copy), LocalPlayer (ref), ReplicatedStorage (ref), UIController (ref), u33 (copy), u34 (copy), u32 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Parent = LocalPlayer.PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        local v35 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v35.Parent = ScreenGui;
        UIController:PlayFlipbook(v35, "HyperthoughtCutsceneFrames", 0.03333333333333333);
        task.wait(0.16666666666666666);
        ScreenGui:Destroy();
        u33.Enabled = true;
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u34.Enabled = false;
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u32.Enabled = true;
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u33.Enabled = false;
    end);
    task.delay(7.967 - u19, function() -- Line: 409
        -- upvalues: Folder (copy), ParticleOnly (ref), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.downcam, true);
        ParticleOnly(u29.middlecam, true);
        ParticleOnly(u29.upcam, true);
        task.wait(2);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.downcam, false);
        ParticleOnly(u29.middlecam, false);
        ParticleOnly(u29.upcam, false);
    end);
    local u36 = {};
    task.delay(8.017 - u19, function() -- Line: 429
        -- upvalues: Folder (copy), Char (copy), u30 (copy), HumanoidRootPart (copy), createClone (ref), u36 (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        if Char then
            Char.Archivable = true;
        end;

        u30:SetAttribute("Clone", true);
        task.spawn(function() -- Line: 441
            -- upvalues: HumanoidRootPart (ref), Folder (ref), u30 (ref), createClone (ref), Char (ref), u36 (ref)
            local os_clock_ret = os.clock();

            while HumanoidRootPart.Parent ~= nil and (os.clock() - os_clock_ret < 3.65 and (Folder ~= nil and (Folder:GetAttribute("Active") ~= nil and u30:GetAttribute("Clone") ~= nil))) do
                local v37 = createClone(Char);
                table.insert(u36, v37);
                task.wait(0.1);
            end;

            if Char then
                Char.Archivable = false;
            end;
        end);
    end);
    task.delay(8.2 - u19, function() -- Line: 472
        -- upvalues: Folder (copy), VfxManager (ref), u30 (copy), u31 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u30.Dribble1);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u31.emit);
    end);
    task.delay(8.333 - u19, function() -- Line: 485
        -- upvalues: Folder (copy), VfxManager (ref), u30 (copy), u31 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u30.Dribble2);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u31.emit);
    end);
    task.delay(8.733 - u19, function() -- Line: 498
        -- upvalues: Folder (copy), VfxManager (ref), u30 (copy), u31 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u30.Dribble3);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u31.emit);
    end);
    task.delay(8.733 - u19, function() -- Line: 511
        -- upvalues: Folder (copy), VfxManager (ref), u30 (copy), u31 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u30.Dribble4);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u31.emit);
    end);
    task.delay(9.383 - u19, function() -- Line: 524
        -- upvalues: Folder (copy), VfxManager (ref), u30 (copy), u31 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u30.Dribble5);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u31.emit);
    end);
    task.delay(9.933 - u19, function() -- Line: 537
        -- upvalues: Folder (copy), ParticleOnly (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.characterlines, true);
        task.wait(3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.characterlines, false);
    end);
    task.delay(11.65 - u19, function() -- Line: 551
        -- upvalues: Folder (copy), VfxManager (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u30.jump);
    end);
    task.delay(11.817 - u19, function() -- Line: 558
        -- upvalues: Folder (copy), ParticleOnly (ref), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.camstart, true);
        task.wait(1.5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.camstart, false);
    end);
    task.delay(13.517 - u19, function() -- Line: 572
        -- upvalues: Folder (copy), u36 (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, v in u36 do
            if v then
                v:Destroy();
            end;
        end;

        u30:SetAttribute("Clone", nil);
    end);
    task.delay(14.033 - u19, function() -- Line: 585
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(Model, true);
        task.delay(0.016666666666666666, function() -- Line: 591
            -- upvalues: Folder (ref), VfxManager (ref), u30 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Emit(u30.TP);
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
    task.delay(16.717 - u19, function() -- Line: 606
        -- upvalues: Folder (copy), ParticleOnly (ref), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.camstart, true);
        task.wait(5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.camstart, false);
    end);
    task.delay(18.6 - u19, function() -- Line: 620
        -- upvalues: Folder (copy), VfxManager (ref), u30 (copy), ParticleOnly (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u30.goalemit);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.enabledgoal, true);
        task.wait(3.5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u30.enabledgoal, false);
    end);

    local function v40() -- Line: 641
        -- upvalues: u24 (ref), Folder (copy), VfxManager (ref), u25 (ref), u36 (ref), Highlight (copy), u34 (copy), u33 (copy), u32 (copy), u26 (copy), u27 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy)
        for _, v in u24 do
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

        for _, v in u25 do
            local v38, v39 = unpack(v);
            v38.Transparency = v39;
        end;

        for _, v in u36 do
            if v then
                v:Destroy();
            end;
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u34 then
            u34:Destroy();
        end;

        if u33 then
            u33:Destroy();
        end;

        if u32 then
            u32:Destroy();
        end;

        if u26 then
            VfxManager.DestroyEffect(u26, 2);
        end;

        if u27 then
            u27:Destroy();
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        u24 = nil;
        u25 = nil;
        u36 = nil;
    end;

    table.insert(u24, Folder.AttributeChanged:Connect(v40));
    table.insert(u24, Folder.Destroying:Connect(v40));
end;