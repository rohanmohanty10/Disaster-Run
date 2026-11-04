 
 

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
local LocalPlayer = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

local function Destroy_Effect(u1: userdata, p2: number) -- Line: 18
    task.delay(p2, function() -- Line: 19
        -- upvalues: u1 (copy)
        u1:Destroy();
    end);
end;

return function(u3, p4) -- Line: 24
    -- upvalues: ReplicatedStorage (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), LocalPlayer (copy), VfxManager (copy), SfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Character = p4.Character;

    if not game.Players:FindFirstChild(Character.Name) then
        game.Players:GetPlayerFromCharacter(Character);
    end;

    local u5 = workspace:GetServerTimeNow() - p4.TimeSent;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Torso");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local _ = ReplicatedStorage.Basketball.Value;
    local BALL = Character:FindFirstChild("BALL", true);
    local v6 = Character.Name .. script.Parent.Name .. script.Name;

    if p4.Task ~= "Cutscene" then
        local v7 = p4.Task == "Cleanup" and Debris:FindFirstChild(v6);

        if v7 then
            v7:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 46
        -- upvalues: u3 (copy), u9 (ref), u8 (ref), u5 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u3.MovementController.States.Ability == false then
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
    task.delay(14, function() -- Line: 65
        -- upvalues: u9 (ref)
        if u9 then
            u9:Disconnect();
        end;
    end);

    if Debris:FindFirstChild(v6) then
        Debris:FindFirstChild(v6):Destroy();
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u12 = {};
    local Duration = p4.Duration;
    local Folder = Instance.new("Folder");
    Folder.Name = v6;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(Duration, function() -- Line: 83
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u13 = script.Vignette:Clone();
    u13.Parent = PlayerGui;
    u13.Enabled = false;
    local u14 = script.Weld:Clone();
    u14.CFrame = BALL.CFrame;
    u14.Parent = Folder;
    Essentials:Weld(u14, BALL);
    VfxManager.Enable(u14, true);
    local u15 = script.Camera_VFX:Clone();
    u15:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u15.Parent = Folder;
    u15.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(CamRig.camera, u15.PrimaryPart);
    local u16 = script.Cutscene_VFX:Clone();
    u16:PivotTo(HumanoidRootPart.CFrame);
    u16.Parent = Folder;
    local ColorCorrection = game.Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u17 = nil;
    local u18 = SfxManager:playSound({
        Sound = "Chuck awkshot loss fix (1)",
        Parent = workspace
    });
    task.delay(0.433 - u5, function() -- Line: 122
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dribbles.Dribble_1);
    end);
    task.delay(0.767 - u5, function() -- Line: 128
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dribbles.Dribble_2);
    end);
    task.delay(1.067 - u5, function() -- Line: 134
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dribbles.Dribble_3);
    end);
    task.delay(1.5 - u5, function() -- Line: 140
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dribbles.Dribble_4);
    end);
    task.delay(1.75 - u5, function() -- Line: 146
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dribbles.Dribble_5);
    end);
    task.delay(1.95 - u5, function() -- Line: 152
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dribbles.Dribble_6);
    end);
    task.delay(2.183 - u5, function() -- Line: 158
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dribbles.Dribble_7);
    end);
    task.delay(2.467 - u5, function() -- Line: 164
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dribbles.Dribble_8);
    end);
    task.delay(2.7 - u5, function() -- Line: 170
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dribbles.Dribble_9);
    end);
    task.delay(2.917 - u5, function() -- Line: 176
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dribbles.Dribble_10);
    end);
    task.delay(3.2 - u5, function() -- Line: 182
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dribbles.Dribble_11);
    end);
    task.delay(3.733 - u5, function() -- Line: 188
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dribbles.Dribble_12);
    end);
    task.delay(4.017 - u5, function() -- Line: 194
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Dribbles.Dribble_13);
    end);
    task.delay(4.133 - u5, function() -- Line: 200
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u14, false);
    end);
    task.delay(4.617 - u5, function() -- Line: 206
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.IDK);
    end);
    task.delay(8.033 - u5, function() -- Line: 212
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), u14 (copy), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Jump);
        VfxManager.Enable(u14, true);
        VfxManager.Enable(u15.CameraLines, true);
    end);
    task.delay(8.683 - u5, function() -- Line: 220
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Release);
    end);
    task.delay(9.067 - u5, function() -- Line: 226
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Landing);
        VfxManager.Enable(u15.CameraLines, false);
    end);
    task.delay(10.05 - u5, function() -- Line: 233
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), u14 (copy), u15 (copy), u17 (ref), TweenService (ref), ColorCorrection (copy), u13 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Impact);

        for _, descendant in pairs(u14:GetDescendants()) do
            if (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail")) and descendant.Name ~= "Black" then
                descendant.Color = ColorSequence.new(Color3.fromRGB(206, 43, 43));
            end;
        end;

        VfxManager.Enable(u15.camera, true);
        u17 = TweenService:Create(ColorCorrection, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u17:Play();
        u13.Enabled = true;

        for _, descendant in pairs(u13:GetDescendants()) do
            if descendant:IsA("ImageLabel") then
                descendant.ImageColor3 = Color3.fromRGB(179, 53, 53);
                descendant.ImageTransparency = 0;
                TweenService:Create(descendant, TweenInfo.new(1.5), {
                    ImageTransparency = 1
                }):Play();
            end;
        end;
    end);
    task.delay(11.617 - u5, function() -- Line: 261
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), u15 (copy), u17 (ref), TweenService (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Head_Impct);
        VfxManager.Enable(u15.camera, false);
        u17 = TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
            Saturation = -1
        });
        u17:Play();
        task.wait(0.3);
        u17 = TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u17:Play();
    end);
    task.delay(12.25 - u5, function() -- Line: 276
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), u17 (ref), TweenService (ref), u13 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Impact_2);
        VfxManager.Enable(u16.Dizzy, true);
        u17 = TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u17:Play();

        for _, descendant in pairs(u13:GetDescendants()) do
            if descendant:IsA("ImageLabel") then
                descendant.ImageColor3 = Color3.fromRGB(179, 53, 53);
                descendant.ImageTransparency = 0;
                TweenService:Create(descendant, TweenInfo.new(1), {
                    ImageTransparency = 1
                }):Play();
            end;
        end;
    end);
    task.delay(13.917 - u5, function() -- Line: 294
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u14, false);
        VfxManager.Enable(u16.Dizzy, false);
    end);

    local function v19() -- Line: 301
        -- upvalues: u12 (ref), Folder (copy), VfxManager (ref), u17 (ref), u13 (copy), u18 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy)
        for _, v in u12 do
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

        if u13 then
            u13:Destroy();
        end;

        if u18 then
            VfxManager.DestroyEffect(u18, 2);
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        u12 = nil;
    end;

    table.insert(u12, Folder.AttributeChanged:Connect(v19));
    table.insert(u12, Folder.Destroying:Connect(v19));
end;