 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
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
local LocalPlayer = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 19
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), ReplicatedStorage (copy), VfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p2.Char;
    local v3 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    local Head = Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Char:FindFirstChild("BALL", true);
    local u4 = p2.passedTime or 0;
    local v5 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v6 = p2.Task == "Cleanup" and Debris:FindFirstChild(v5);

        if v6 then
            v6:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 38
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), u4 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * u4;
        end;

        u7 = u7 + p9 * 60;
        local v10 = script_Fov[math.ceil(u7)];

        if v10 ~= nil then
            if math.ceil(u7) >= #script_Fov then
                u8:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v10, p9 * 6);
        end;
    end);
    task.delay(16 - u4, function() -- Line: 57
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);
    local u11 = {};
    local u12 = {};

    if Debris:FindFirstChild(v5) then
        Debris:FindFirstChild(v5):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v5;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(16, function() -- Line: 73
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u13 = SfxManager:playSound({
        Sound = "BBZ Switcher duo barrage",
        Parent = workspace
    });
    local ColorCorrection = game.Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u14 = ReplicatedStorage.Assets.VFX.Vignette:Clone();
    u14.Parent = PlayerGui;
    u14.Enabled = true;
    local _ = u14.Vignette;
    local Vignette1 = u14.Vignette1;
    local v15 = workspace:FindFirstChild((`{v3.Name}_Stand`));
    local EnemyChar = p2.EnemyChar;
    local v16 = script.HeadVFX:Clone();
    v16.CFrame = Head.CFrame;
    v16.Parent = Folder;
    VfxManager.Enable(v16, false);
    Essentials:Weld(v16, Head);
    local v17 = script.Stand:Clone();
    v17.CFrame = v15:FindFirstChild("Head").CFrame;
    v17.Parent = Folder;
    VfxManager.Enable(v17, false);
    Essentials:Weld(v17, v15:FindFirstChild("Head"));
    local v18 = script.EnemyHead:Clone();
    v18.CFrame = EnemyChar:FindFirstChild("Head").CFrame;
    v18.Parent = Folder;
    VfxManager.Enable(v18, false);
    Essentials:Weld(v18, EnemyChar:FindFirstChild("Head"));
    local u19 = script.Camera_VFX:Clone();
    u19:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u19.Parent = Folder;
    Essentials:Weld(u19.PrimaryPart, CamRig.CamPart);
    local u20 = script.Cutscene_VFX:Clone();
    u20:PivotTo(HumanoidRootPart.CFrame);
    u20.Parent = Folder;
    local u21 = script.BALL:Clone();
    u21.CFrame = BALL.CFrame;
    u21.Parent = Folder;
    Essentials:Weld(u21, BALL);
    VfxManager.Enable(u21, false);
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = Char;
    local Highlight2 = Instance.new("Highlight");
    Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight2.FillColor = Color3.fromRGB(255, 0, 0);
    Highlight2.FillTransparency = 1;
    Highlight2.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight2.OutlineTransparency = 0;
    Highlight2.Parent = v15;
    local Highlight3 = Instance.new("Highlight");
    Highlight3.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight3.FillColor = Color3.fromRGB(255, 0, 0);
    Highlight3.FillTransparency = 1;
    Highlight3.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight3.OutlineTransparency = 0;
    Highlight3.Parent = EnemyChar;
    u20.Sphere1.Transparency = 1;
    u20.blmack.Transparency = 1;
    local u22 = nil;
    local u23 = nil;
    local u24 = nil;
    local u25 = nil;
    local u26 = nil;

    for _, child in u20.blmack:GetChildren() do
        if child:IsA("Part") then
            child.Transparency = 1;
        end;
    end;

    VfxManager.Enable(u19.DunkCameraSparks, true);
    VfxManager.Enable(u20.PinkBG, true);
    VfxManager.Enable(u19.Atmosphere.YippyInk, true);
    VfxManager.Enable(u19.Atmosphere.black, true);
    VfxManager.Enable(u19.Atmosphere.glaresandstuff, true);
    task.delay(1.033 - u4, function() -- Line: 181
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy), u19 (copy), ColorCorrection (copy), u24 (ref), TweenService (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u20, false);
        VfxManager.Enable(u19, false);
        VfxManager.Enable(u20.Background, true);
        ColorCorrection.Brightness = -1;
        u24 = TweenService:Create(ColorCorrection, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {
            Brightness = -0.015
        });
        u24:Play();
    end);
    task.delay(1.75 - u4, function() -- Line: 196
        -- upvalues: Folder (copy), ColorCorrection (copy), u22 (ref), TweenService (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ColorCorrection.Brightness = -1;
        task.wait(0.2);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u22 = TweenService:Create(ColorCorrection, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {
            Brightness = -0.015
        });
        u22:Play();
    end);
    task.delay(1.783 - u4, function() -- Line: 211
        -- upvalues: Folder (copy), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u20.Background.Att.STar2.Enabled = true;
        u20.Background.Att.Star1.Enabled = true;
        u20.Background.Att.Star102.Enabled = true;
    end);
    task.delay(2.85 - u4, function() -- Line: 220
        -- upvalues: Folder (copy), Vignette1 (copy), VfxManager (ref), u20 (copy), u19 (copy), u21 (copy), ColorCorrection (copy), u23 (ref), TweenService (ref), Color3_fromRGB_ret (copy), u25 (ref), u26 (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(113, 47, 255);
        VfxManager.Enable(u20, false);
        VfxManager.Enable(u19, false);
        VfxManager.Enable(u19.FakeCamera1, true);
        VfxManager.Enable(u21, true);
        ColorCorrection.TintColor = Color3.fromRGB(113, 47, 255);
        ColorCorrection.Brightness = 0.75;
        u23 = TweenService:Create(ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u23:Play();
        u25 = TweenService:Create(ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u25:Play();
        u26 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u26:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(3.4 - u4, function() -- Line: 246
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Jumps.Jumps);
    end);
    task.delay(3.817 - u4, function() -- Line: 253
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Dribbles.Dribble);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.TP1);
    end);
    task.delay(4.483 - u4, function() -- Line: 267
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Dribbles.Dribble2);
    end);
    task.delay(4.617 - u4, function() -- Line: 274
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Jumps.Jumps2);
    end);
    task.delay(4.867 - u4, function() -- Line: 281
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Dribbles.Dribble2);
    end);
    task.delay(5.567 - u4, function() -- Line: 288
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Catches.Catch);
    end);
    task.delay(5.583 - u4, function() -- Line: 295
        -- upvalues: Folder (copy), u20 (copy), u12 (ref), Vignette1 (copy), VfxManager (ref), ColorCorrection (copy), u23 (ref), TweenService (ref), Color3_fromRGB_ret (copy), u25 (ref), u26 (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u20.Sphere1.Transparency = 0;
        local MapFolder = workspace:FindFirstChild("MapFolder");

        if MapFolder == nil then
            MapFolder = workspace:FindFirstChild("Map2");
        end;

        for _, v in { workspace.Courts2, MapFolder } do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("MeshPart") or (descendant:IsA("Part") or descendant:IsA("Decal")) then
                    table.insert(u12, { descendant, descendant.Transparency });
                    descendant.Transparency = 1;
                end;
            end;

            if workspace:FindFirstChild("Barriers") and workspace:FindFirstChild("Barriers"):FindFirstChild("Ground") then
                local v27 = { workspace:FindFirstChild("Barriers"):FindFirstChild("Ground"), workspace:FindFirstChild("Barriers"):FindFirstChild("Ground").Transparency };
                table.insert(u12, v27);
                workspace:FindFirstChild("Barriers"):FindFirstChild("Ground").Transparency = 1;
            end;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(113, 47, 255);
        VfxManager.Enable(u20.Court, true);
        ColorCorrection.TintColor = Color3.fromRGB(113, 47, 255);
        ColorCorrection.Brightness = 0.75;
        u23 = TweenService:Create(ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u23:Play();
        u25 = TweenService:Create(ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u25:Play();
        u26 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u26:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(5.933 - u4, function() -- Line: 342
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Dribbles.Dribble3);
    end);
    task.delay(6.2 - u4, function() -- Line: 349
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Dribbles.Dribble3);
    end);
    task.delay(6.533 - u4, function() -- Line: 356
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Dribbles.Dribble3);
    end);
    task.delay(6.65 - u4, function() -- Line: 363
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Scared);
    end);
    task.delay(6.917 - u4, function() -- Line: 370
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u20.AuraPink2, true);
    end);
    task.delay(7.667 - u4, function() -- Line: 377
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Trip);
    end);
    task.delay(8.1 - u4, function() -- Line: 384
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u19.Atmosphere.CAM2Shading, true);
        VfxManager.Enable(u19.Atmosphere.gold, true);
        VfxManager.Enable(u19.DunkCameraHorizontal, true);
    end);
    task.delay(8.25 - u4, function() -- Line: 393
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Hits.Hit);
    end);
    task.delay(8.33 - u4, function() -- Line: 400
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u20.Barrage, true);
        VfxManager.Enable(u20.AuraPink2, false);
    end);
    task.delay(8.683 - u4, function() -- Line: 408
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Hits.Hit);
    end);
    task.delay(9.2 - u4, function() -- Line: 415
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Hits.Hit2);
    end);
    task.delay(9.2 - u4, function() -- Line: 422
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Hits.Hit2);
    end);
    task.delay(9.667 - u4, function() -- Line: 429
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Hits.Hit3);
    end);
    task.delay(10.25 - u4, function() -- Line: 436
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u20.Barrage, false);
        VfxManager.Enable(u20.FasterBarrage, true);
    end);
    task.delay(11.567 - u4, function() -- Line: 444
        -- upvalues: Folder (copy), u12 (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, v in u12 do
            local v28, v29 = unpack(v);
            v28.Transparency = v29;
        end;
    end);
    task.delay(11.6 - u4, function() -- Line: 454
        -- upvalues: Folder (copy), u20 (copy), VfxManager (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u20.Sphere1.Transparency = 1;
        VfxManager.Enable(u20.FasterBarrage, false);
        VfxManager.Enable(u20.Spin, true);
    end);
    task.delay(12.867 - u4, function() -- Line: 463
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Catches.Catch2);
        VfxManager.Enable(u20.Spin, false);
    end);
    task.delay(12.95 - u4, function() -- Line: 471
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u20, false);
        VfxManager.Enable(u19, false);
        VfxManager.Enable(u19.Atmosphere.CAM2Shading, true);
    end);
    task.delay(14.383 - u4, function() -- Line: 481
        -- upvalues: Folder (copy), Highlight2 (copy), TweenService (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Highlight2.OutlineTransparency = 1;
        TweenService:Create(Highlight2, TweenInfo.new(0.40000000000000036, Enum.EasingStyle.Linear), {
            OutlineTransparency = 0
        }):Play();
    end);
    task.delay(14.417 - u4, function() -- Line: 490
        -- upvalues: Folder (copy), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u20.blmack.Transparency = 0;
        u20.Sphere1.Transparency = 0;

        for _, child in u20.blmack:GetChildren() do
            if child:IsA("Part") then
                child.Transparency = 0;
            end;
        end;
    end);
    task.delay(14.4 - u4, function() -- Line: 503
        -- upvalues: Folder (copy), ColorCorrection (copy), u24 (ref), TweenService (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ColorCorrection.Brightness = -1;
        task.wait(0.2);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u24 = TweenService:Create(ColorCorrection, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {
            Brightness = -0.015
        });
        u24:Play();
        ColorCorrection.Saturation = 0.3;
    end);
    task.delay(14.433 - u4, function() -- Line: 521
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u19.Atmosphere.black, true);
        VfxManager.Enable(u19.Atmosphere.glaresandstuff, true);
        VfxManager.Enable(u19.Atmosphere.wind, true);
        VfxManager.Enable(u20.MainPart, true);
        VfxManager.Enable(u19.Atmosphere.CAM2Shading, false);
        VfxManager.Enable(u19.Atmosphere.YippyInk2, true);
    end);

    local function v32() -- Line: 533
        -- upvalues: u11 (ref), Folder (copy), VfxManager (ref), u12 (ref), Highlight (copy), Highlight3 (copy), Highlight2 (copy), u24 (ref), u22 (ref), u23 (ref), u25 (ref), u26 (ref), u13 (copy), u14 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy)
        for _, v in u11 do
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

        for _, v in u12 do
            local v30, v31 = unpack(v);
            v30.Transparency = v31;
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if Highlight3 then
            Highlight3:Destroy();
        end;

        if Highlight2 then
            Highlight2:Destroy();
        end;

        if u24 then
            u24:Pause();
        end;

        if u22 then
            u22:Pause();
        end;

        if u23 then
            u23:Pause();
        end;

        if u25 then
            u25:Pause();
        end;

        if u26 then
            u26:Pause();
        end;

        if u13 then
            VfxManager.DestroyEffect(u13, 2);
        end;

        if u14 then
            u14:Destroy();
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        u11 = nil;
        u12 = nil;
    end;

    table.insert(u11, Folder.AttributeChanged:Connect(v32));
    table.insert(u11, Folder.Destroying:Connect(v32));
end;