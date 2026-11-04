 
 

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
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

local function Destroy_Effect(u1: userdata, p2: number) -- Line: 18
    task.delay(p2, function() -- Line: 19
        -- upvalues: u1 (copy)
        u1:Destroy();
    end);
end;

return function(u3, p4) -- Line: 24
    -- upvalues: ReplicatedStorage (copy), Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), LocalPlayer (copy), VfxManager (copy), TweenService (copy), SfxManager (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p4.Char;
    local u5 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    local Char2 = p4.Char;
    local HumanoidRootPart = Char2:FindFirstChild("HumanoidRootPart");
    Char2:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    local BALL = Char2:FindFirstChild("BALL", true);
    local u6 = workspace:GetServerTimeNow() - p4.TimeSent;
    local v7 = Char.Name .. script.Parent.Name .. script.Name;

    if p4.Task ~= "Cutscene" then
        local v8 = p4.Task == "Cleanup" and Debris:FindFirstChild(v7);

        if v8 then
            v8:SetAttribute("Active", nil);
        end;

        return;
    end;

    task.delay(2.8, function() -- Line: 42
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "I\'ll never pass the ball!", 3.2 }
        });
    end);
    local u9 = 0;
    local u10 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u10 = RunService.RenderStepped:Connect(function(p11) -- Line: 51
        -- upvalues: u3 (copy), u10 (ref), u9 (ref), u6 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u3.MovementController.States.Ability == false then
            u10:Disconnect();

            return;
        end;

        if u9 <= 0 then
            u9 = p11 * 60 * u6;
        end;

        u9 = u9 + p11 * 60;
        local v12 = script_Fov[math.ceil(u9)];

        if v12 ~= nil then
            if math.ceil(u9) >= #script_Fov then
                u10:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v12, p11 * 6);
        end;
    end);
    task.delay(8, function() -- Line: 70
        -- upvalues: u10 (ref)
        if u10 then
            u10:Disconnect();
        end;
    end);

    if Debris:FindFirstChild(v7) then
        Debris:FindFirstChild(v7):Destroy();
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u13 = {};
    local Folder = Instance.new("Folder");
    Folder.Name = v7;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    VfxManager.DestroyEffect(Folder, 7.617);
    local u14 = script.Vignette:Clone();
    u14.Parent = PlayerGui;
    u14.Enabled = false;
    local u15 = script.Weld:Clone();
    u15.CFrame = BALL.CFrame;
    u15.Parent = Folder;
    Essentials:Weld(u15, BALL);
    VfxManager.Enable(u15, true);
    local u16 = script.Cutscene_VFX:Clone();
    u16:PivotTo(HumanoidRootPart.CFrame);
    u16.Parent = Folder;
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u17 = nil;
    task.delay(0.517 - u6, function() -- Line: 110
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dribbles.Dribble_0);
    end);
    task.delay(0.783 - u6, function() -- Line: 117
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dribbles.Dribble_1);
    end);
    task.delay(1.1 - u6, function() -- Line: 122
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dribbles.Dribble_2);
    end);
    task.delay(1.5 - u6, function() -- Line: 127
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), u15 (copy), ColorCorrection (copy), u17 (ref), TweenService (ref), u14 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dribbles.Dribble_3);

        for _, descendant in pairs(u15:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name ~= "Black" then
                descendant.Color = ColorSequence.new(Color3.fromRGB(206, 43, 43));
            end;
        end;

        ColorCorrection.TintColor = Color3.fromRGB(255, 61, 61);
        u17 = TweenService:Create(ColorCorrection, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u17:Play();
        u14.Enabled = true;

        for _, descendant in pairs(u14:GetDescendants()) do
            if descendant:IsA("ImageLabel") then
                descendant.ImageColor3 = Color3.fromRGB(179, 53, 53);
                descendant.ImageTransparency = 0;
                TweenService:Create(descendant, TweenInfo.new(1.5), {
                    ImageTransparency = 1
                }):Play();
            end;
        end;
    end);
    task.delay(1.983 - u6, function() -- Line: 153
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16[" Nani?"]);
    end);
    task.delay(2.75 - u6, function() -- Line: 160
        -- upvalues: Folder (copy), u15 (copy), VfxManager (ref), u16 (copy), u14 (copy), TweenService (ref), u17 (ref), game_Lighting (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, descendant in pairs(u15:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name ~= "Black" then
                descendant.Color = ColorSequence.new(Color3.fromRGB(33, 67, 50));
            end;
        end;

        VfxManager.Emit(u16.Grab);

        for _, descendant in pairs(u14:GetDescendants()) do
            if descendant:IsA("ImageLabel") then
                descendant.ImageColor3 = Color3.fromRGB(58, 179, 114);
                descendant.ImageTransparency = 0;
                TweenService:Create(descendant, TweenInfo.new(1.5), {
                    ImageTransparency = 1
                }):Play();
            end;
        end;

        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2,
            Saturation = 0.3,
            TintColor = Color3.fromRGB(112, 255, 176)
        });
        u17:Play();
        task.delay(0.445, function() -- Line: 185
            -- upvalues: Folder (ref), u17 (ref), TweenService (ref), game_Lighting (ref)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
                Brightness = -0.015,
                Contrast = 0.2,
                Saturation = 0.3,
                TintColor = Color3.fromRGB(255, 255, 255)
            });
            u17:Play();
        end);
    end);
    task.delay(3.433 - u6, function() -- Line: 196
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dribbles.Dribble_4);
    end);
    task.delay(3.867 - u6, function() -- Line: 202
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u16.InfDribble, true);
    end);
    task.delay(5.083 - u6, function() -- Line: 208
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u16.InfDribble, false);
    end);
    task.delay(5.267 - u6, function() -- Line: 214
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), u17 (ref), TweenService (ref), ColorCorrection (copy), u15 (copy), u14 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dust);
        u17 = TweenService:Create(ColorCorrection, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
            Saturation = -1
        });
        u17:Play();

        for _, descendant in pairs(u15:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u14:GetDescendants()) do
            if descendant:IsA("ImageLabel") then
                descendant.ImageColor3 = Color3.fromRGB(0, 0, 0);
                descendant.ImageTransparency = 0;
                TweenService:Create(descendant, TweenInfo.new(10), {
                    ImageTransparency = 1
                }):Play();
            end;
        end;
    end);
    task.delay(6.133 - u6, function() -- Line: 237
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.IDK);
    end);
    task.delay(7.617 - u6, function() -- Line: 245
        -- upvalues: Folder (copy), u17 (ref), TweenService (ref), game_Lighting (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.01, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2,
            Saturation = 0.3,
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u17:Play();
    end);
    local u18 = SfxManager:playSound({
        Sound = "Chuck awakening",
        Parent = workspace
    });

    local function v19() -- Line: 255
        -- upvalues: u13 (ref), Folder (copy), VfxManager (ref), u17 (ref), u14 (copy), u18 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy)
        for _, v in u13 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);
        end;

        if u17 then
            u17:Pause();
        end;

        if u14 then
            u14:Destroy();
        end;

        if u18 then
            u18:Destroy();
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        u13 = nil;
    end;

    table.insert(u13, Folder.AttributeChanged:Connect(v19));
    table.insert(u13, Folder.Destroying:Connect(v19));
end;