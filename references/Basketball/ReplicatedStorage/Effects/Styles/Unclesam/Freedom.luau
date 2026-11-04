 
 

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
    -- upvalues: Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), LocalPlayer (copy), Debris (copy), SfxManager (copy), VfxManager (copy), ReplicatedStorage (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p2.Char;
    local u3 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    local Head = Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local v4 = p2.passedTime or 0;
    local u5 = workspace:GetServerTimeNow() - p2.TimeSent + v4;
    local v6 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v7 = p2.Task == "Cleanup" and Debris:FindFirstChild(v6);

        if v7 then
            v7:SetAttribute("Active", nil);
        end;

        return;
    end;

    task.delay(0.7, function() -- Line: 34
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            { u3, "This is a full court declaration!", 2.8 }
        });
    end);
    task.delay(7.8, function() -- Line: 44
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Soldier", "Move, move, move!", 1.2 } });
    end);
    task.delay(15.7, function() -- Line: 54
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            { u3, "<animation style=\"glitch\">FIRE, BOYS!</animation>", 1 }
        });
    end);
    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 67
        -- upvalues: u1 (copy), u9 (ref), u8 (ref), u5 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u9:Disconnect();

            return;
        end;

        if u8 <= 0 then
            u8 = p10 * 60 * u5;
        end;

        u8 = u8 + p10 * 60;
        local v11 = script_Fov[math.ceil(u8)];

        if v11 ~= nil then
            if math.ceil(u8) >= #script_Fov then
                u9:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v11, p10 * 6);
        end;
    end);
    task.delay(23.667 - u5, function() -- Line: 86
        -- upvalues: u9 (ref)
        u9:Disconnect();
    end);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u12 = {};
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u13 = nil;
    local u14 = nil;
    local u15 = nil;

    if Debris:FindFirstChild(v6) then
        Debris:FindFirstChild(v6):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v6;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(23.667, function() -- Line: 118
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u16 = SfxManager:playSound({
        Sound = "BBZ UncSam FullCourtDec",
        Parent = workspace
    });
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v17 = child:Clone();
            v17.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v17.Parent = Model;
            Essentials:Weld(v17, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v17, false);
        end;
    end;

    local Folder2 = Instance.new("Folder");
    Folder2.Parent = Folder;

    for i = 1, 3 do
        local v18 = workspace:FindFirstChild("Player" .. i);
        local v19;

        if v18 then
            local Model2 = Instance.new("Model");
            Model2.Parent = Folder2;
            v19 = i;

            for _, child in script.EnemySweat:GetChildren() do
                if v18:FindFirstChild(child.Name) then
                    local v20 = child:Clone();
                    v20.CFrame = v18:FindFirstChild(child.Name).CFrame;
                    v20.Parent = Model2;
                    Essentials:Weld(v20, v18:FindFirstChild(child.Name));
                    VfxManager.Enable(v20, false);
                end;
            end;
        else
            v19 = i;
        end;
    end;

    local u21 = script.Camera_VFX:Clone();
    u21:PivotTo(CamRig:FindFirstChild("CamPart").CFrame);
    u21.Parent = Folder;
    u21.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u21.PrimaryPart, CamRig.camera);
    local u22 = script.HeadAura:Clone();
    u22.CFrame = Head.CFrame;
    u22.Parent = Folder;
    Essentials:Weld(u22, Head);
    local u23 = script.Cutscene_VFX:Clone();
    u23:PivotTo(HumanoidRootPart.CFrame);
    u23.Parent = Folder;
    local u24 = ReplicatedStorage.Assets.VFX.Vignette:Clone();
    u24.Parent = PlayerGui;
    u24.Enabled = true;
    local Vignette = u24.Vignette;
    local Vignette1 = u24.Vignette1;
    Vignette.ImageTransparency = 0;
    Vignette1.ImageTransparency = 0;
    task.delay(20.683 - u5, function() -- Line: 188
        -- upvalues: Folder (copy), Vignette (copy), Vignette1 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette.ImageTransparency = 1;
        Vignette1.ImageTransparency = 1;
    end);
    local Sphere1 = u23.Background.Sphere1;
    Sphere1.Transparency = 1;
    task.delay(9.767 - u5, function() -- Line: 199
        -- upvalues: Folder (copy), Sphere1 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        task.wait(1.616);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Sphere1.Transparency = 1;
        task.wait(1.467);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
        end;
    end);
    VfxManager.Enable(Model, true);
    task.delay(0.1 - u5, function() -- Line: 222
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy), Folder2 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.EmitBreath);
        VfxManager.Enable(Folder2, true);
    end);
    task.delay(0.45 - u5, function() -- Line: 231
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.EmitBreath);
    end);
    local u25 = script.GUI:Clone();
    task.delay(2.3 - u5, function() -- Line: 240
        -- upvalues: u25 (copy), LocalPlayer (ref)
        u25.Parent = LocalPlayer.PlayerGui;
    end);
    task.delay(4.5 - u5, function() -- Line: 244
        -- upvalues: u25 (copy)
        u25:Destroy();
    end);
    task.delay(4.167 - u5, function() -- Line: 248
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, child in workspace:GetChildren() do
            if child.Name == "UltHeli" then
                VfxManager.Enable(child, true);
            end;
        end;

        VfxManager.Enable(u21.DunkCameraHorizontal, true);
        VfxManager.Enable(u21.PassCamera1, true);
    end);
    task.delay(6.25 - u5, function() -- Line: 265
        -- upvalues: Folder (copy), VfxManager (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, child in workspace:GetChildren() do
            if child.Name == "UltHeli" then
                VfxManager.Enable(child, false);
            end;
        end;
    end);
    task.delay(6.467 - u5, function() -- Line: 275
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.Footsteps);
    end);
    task.delay(7.783 - u5, function() -- Line: 283
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.Footsteps);
    end);
    task.delay(9.767 - u5, function() -- Line: 290
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u23.Background, true);
        VfxManager.Enable(u21.DunkCameraHorizontal, false);
        VfxManager.Enable(u21.PassCamera1, false);
    end);
    task.delay(11.35 - u5, function() -- Line: 299
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u23.Background, false);
    end);
    task.delay(12.883 - u5, function() -- Line: 306
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u23.Background, true);
        VfxManager.Enable(u21.DunkCameraHorizontal, true);
        VfxManager.Enable(u21.PassCamera1, true);
    end);
    task.delay(15.283 - u5, function() -- Line: 316
        -- upvalues: Folder (copy), VfxManager (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, child in workspace:GetChildren() do
            if child.Name == "UltHeli" then
                VfxManager.Enable(child, true);
            end;
        end;

        local UltNuk = workspace:FindFirstChild("UltNuk");

        if UltNuk then
            VfxManager.Enable(UltNuk, true);
        end;
    end);
    task.delay(16.867 - u5, function() -- Line: 333
        -- upvalues: Folder (copy), Vignette1 (copy), game_Lighting (copy), u13 (ref), TweenService (ref), u14 (ref), u15 (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(255, 109, 25);
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 109, 25);
        game_Lighting.ColorCorrection.Brightness = 0.75;
        u13 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u13:Play();
        u14 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u14:Play();
        u15 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u15:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(18.033 - u5, function() -- Line: 355
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u21.DunkCameraHorizontal, false);
        VfxManager.Enable(u21.PassCamera1, false);
        VfxManager.Enable(u23.Background2, true);
    end);
    task.delay(18.65 - u5, function() -- Line: 364
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u23.Space, true);
    end);
    task.delay(20.167 - u5, function() -- Line: 371
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Emit);
    end);
    task.delay(21.75 - u5, function() -- Line: 378
        -- upvalues: Folder (copy), Vignette1 (copy), game_Lighting (copy), u13 (ref), TweenService (ref), u14 (ref), u15 (ref), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(255, 109, 25);
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 109, 25);
        game_Lighting.ColorCorrection.Brightness = 0.75;
        u13 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u13:Play();
        u14 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u14:Play();
        u15 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u15:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u23.Bomb);
    end);

    local function v26() -- Line: 400
        -- upvalues: u12 (ref), Folder (copy), VfxManager (ref), u13 (ref), u14 (ref), u15 (ref), u16 (copy), u24 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy)
        for _, v in u12 do
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

        if u13 then
            u13:Pause();
        end;

        if u14 then
            u14:Pause();
        end;

        if u15 then
            u15:Pause();
        end;

        if u16 then
            VfxManager.DestroyEffect(u16, 2);
        end;

        if u24 then
            u24:Destroy();
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        u12 = nil;
    end;

    table.insert(u12, Folder.AttributeChanged:Connect(v26));
    table.insert(u12, Folder.Destroying:Connect(v26));
end;