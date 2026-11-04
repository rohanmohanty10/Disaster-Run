 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local Zone = require(ReplicatedStorage.Effects.Base.Zone);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 19
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), Knit (copy), Zone (copy), LocalPlayer (copy), Debris (copy), SfxManager (copy), VfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p2.Char;

    if not game.Players:FindFirstChild(Char.Name) then
        game.Players:GetPlayerFromCharacter(Char);
    end;

    local Char2 = p2.Char2;
    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Char:FindFirstChild("BALL", true);
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local v4 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 39
        -- upvalues: u7 (ref), u6 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if not workspace:FindFirstChild("CamRig") then
            u7:Disconnect();

            return;
        end;

        if u6 <= 0 then
            u6 = p8 * 60 * u3;
        end;

        u6 = u6 + p8 * 60;
        local v9 = script_Fov[math.ceil(u6)];

        if v9 ~= nil then
            if math.ceil(u6) >= #script_Fov then
                u7:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v9, p8 * 6);
        end;
    end);
    local Controller = Knit.GetController("CameraController");
    local Controller2 = Knit.GetController("MovementController");
    Controller:SetShiftlock(false);
    Controller2.States.NoWalk = true;
    Zone(p1, {
        Hide = true,
        Time = 9.033,
        Char = Char
    });
    Zone(p1, {
        Hide = true,
        Time = 9.033,
        Char = p2.Char2
    });
    task.delay(9.033 - u3, function() -- Line: 69
        -- upvalues: u7 (ref), Controller2 (copy), Controller (copy)
        u7:Disconnect();
        Controller2.States.NoWalk = false;
        Controller:SetShiftlock(true);
    end);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u10 = {};
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u11 = nil;
    local u12 = nil;
    local u13 = nil;

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(9.033, function() -- Line: 103
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u14 = SfxManager:playSound({
        Sound = "BBZ star cutscene staralley",
        Parent = workspace
    });
    local u15 = script.Camera_VFX:Clone();
    u15:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u15.Parent = Folder;
    u15.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(CamRig.camera, u15.PrimaryPart);
    local u16 = script.BALL:Clone();
    u16.CFrame = BALL.CFrame;
    u16.Parent = Folder;
    Essentials:Weld(u16, BALL);
    local u17 = script.Vignette:Clone();
    u17.Parent = PlayerGui;
    u17.Enabled = true;
    local _ = u17.Vignette;
    local Vignette1 = u17.Vignette1;
    local Model = Instance.new("Model");
    Model.Parent = Folder;
    local u18 = {};

    for _, child in script.StarAura.AuraFX:GetChildren() do
        if Char2:FindFirstChild(child.Name) then
            local v19 = child:Clone();
            v19.CFrame = Char2:FindFirstChild(child.Name).CFrame;
            v19.Parent = Model;
            Essentials:Weld(v19, Char2:FindFirstChild(child.Name));
            VfxManager.Enable(v19, false);
        end;
    end;

    local Model2 = Instance.new("Model");
    Model2.Parent = Folder;

    for _, child in script.PhantomAura.AuraFX:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v20 = child:Clone();
            v20.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v20.Parent = Model2;
            Essentials:Weld(v20, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v20, false);
        end;
    end;

    local u21 = script.Cutscene_VFX:Clone();
    u21:PivotTo(HumanoidRootPart.CFrame);
    u21.Parent = Folder;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(27, 53, 140);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = Char;
    VfxManager.Enable(Model, true);
    VfxManager.Enable(Model2, true);
    VfxManager.Enable(u16.BlueEnable, true);
    task.delay(0.483 - u3, function() -- Line: 178
        -- upvalues: Folder (copy), Vignette1 (copy), game_Lighting (copy), u11 (ref), TweenService (ref), u12 (ref), u13 (ref), VfxManager (ref), u15 (copy), u21 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(61, 87, 255);
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(61, 87, 255);
        game_Lighting.ColorCorrection.Brightness = 0.75;
        u11 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u11:Play();
        u12 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u12:Play();
        u13 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u13:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u15.BlueImpact);
        VfxManager.Enable(u21.Enable, true);
    end);
    task.delay(1.05 - u3, function() -- Line: 200
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u15.FakeCamera1, true);
    end);
    task.delay(3.05 - u3, function() -- Line: 206
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u21.Jump);
    end);
    task.delay(4.85 - u3, function() -- Line: 212
        -- upvalues: Folder (copy), u18 (ref), Vignette1 (copy), ColorCorrection (copy), u11 (ref), TweenService (ref), u12 (ref), u13 (ref), VfxManager (ref), u15 (copy), u21 (copy), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local MapFolder = workspace:FindFirstChild("MapFolder");

        if MapFolder == nil then
            MapFolder = workspace:FindFirstChild("Map2");
        end;

        for _, v in { workspace.Courts2, MapFolder } do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("MeshPart") or (descendant:IsA("Part") or descendant:IsA("Decal")) then
                    table.insert(u18, { descendant, descendant.Transparency });
                    descendant.Transparency = 1;
                end;
            end;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(113, 47, 255);
        ColorCorrection.TintColor = Color3.fromRGB(113, 47, 255);
        ColorCorrection.Brightness = 0.75;
        u11 = TweenService:Create(ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u11:Play();
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u12:Play();
        u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u13:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u15.CamImpact);
        VfxManager.Enable(u21.Enable, false);
        VfxManager.Enable(u16, true);
        VfxManager.Enable(u16.BlueEnable, false);
        VfxManager.Enable(u15.CamAtmosphere2, true);
        VfxManager.Enable(u15.DunkCameraSparks, true);
        VfxManager.Enable(u15.FakeCamera1, false);
    end);
    task.delay(7.15 - u3, function() -- Line: 257
        -- upvalues: Folder (copy), u18 (ref), VfxManager (ref), u15 (copy), u21 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, v in u18 do
            local v22, v23 = unpack(v);
            v22.Transparency = v23;
        end;

        u18 = nil;
        VfxManager.Enable(u15, false);
        VfxManager.Emit(u21.Dunk);
    end);

    local function v26() -- Line: 271
        -- upvalues: u10 (ref), Folder (copy), VfxManager (ref), u11 (ref), u12 (ref), u13 (ref), u17 (copy), Highlight (copy), u18 (ref), u14 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy)
        for _, v in u10 do
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

        if u11 then
            u11:Pause();
        end;

        if u12 then
            u12:Pause();
        end;

        if u13 then
            u13:Pause();
        end;

        if u17 then
            u17:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u18 then
            for _, v in u18 do
                local v24, v25 = unpack(v);
                v24.Transparency = v25;
            end;
        end;

        if u14 then
            VfxManager.DestroyEffect(u14, 2);
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        u10 = nil;
    end;

    table.insert(u10, Folder.AttributeChanged:Connect(v26));
    table.insert(u10, Folder.Destroying:Connect(v26));
end;