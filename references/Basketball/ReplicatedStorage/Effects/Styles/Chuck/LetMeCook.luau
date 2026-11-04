 
 

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
    -- upvalues: ReplicatedStorage (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), LocalPlayer (copy), VfxManager (copy), TweenService (copy), SfxManager (copy)
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
    local u13 = {};
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
    local u14 = script.Vignette:Clone();
    u14.Parent = PlayerGui;
    u14.Enabled = false;
    local u15 = script.Weld:Clone();
    u15.CFrame = BALL.CFrame;
    u15.Parent = Folder;
    Essentials:Weld(u15, BALL);
    VfxManager.Enable(u15, true);
    local u16 = script.Camera_VFX:Clone();
    u16:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u16.Parent = Folder;
    u16.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(CamRig.camera, u16.PrimaryPart);
    local u17 = script.Cutscene_VFX:Clone();
    u17:PivotTo(HumanoidRootPart.CFrame);
    u17.Parent = Folder;
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u18 = nil;
    task.delay(0.317 - u5, function() -- Line: 121
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.Dribbles.Dribble_1);
    end);
    task.delay(0.583 - u5, function() -- Line: 127
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.Dribbles.Dribble_2);
    end);
    task.delay(0.85 - u5, function() -- Line: 133
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.Dribbles.Dribble_3);
    end);
    task.delay(1.117 - u5, function() -- Line: 139
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.Dribbles.Dribble_4);
    end);
    task.delay(1.467 - u5, function() -- Line: 145
        -- upvalues: Folder (copy), u17 (copy), TweenService (ref), VfxManager (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local Forb = u17.Forb;
        TweenService:Create(Forb, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            CFrame = Forb.CFrame * CFrame.new(0, 0, -5.5)
        }):Play();
        VfxManager.Enable(u17.InfDribble, true);
        task.delay(3, function() -- Line: 153
            -- upvalues: Folder (ref), TweenService (ref), Forb (copy), VfxManager (ref), u17 (ref)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            TweenService:Create(Forb, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                CFrame = Forb.CFrame * CFrame.new(0, 0, 5.5)
            }):Play();
            VfxManager.Enable(u17.InfDribble, false);
        end);
    end);
    task.delay(4.133 - u5, function() -- Line: 162
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u15, false);
    end);
    task.delay(4.617 - u5, function() -- Line: 168
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.IDK);
    end);
    task.delay(8.033 - u5, function() -- Line: 174
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy), u15 (copy), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.Jump);
        VfxManager.Enable(u15, true);
        VfxManager.Enable(u16.CameraLines, true);
    end);
    task.delay(8.683 - u5, function() -- Line: 182
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.Release);
    end);
    task.delay(9.067 - u5, function() -- Line: 188
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), u17 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u16.CameraLines, false);
        VfxManager.Emit(u17.Landing);
    end);
    task.delay(10.083 - u5, function() -- Line: 195
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy), Character (copy), Essentials (ref), u13 (copy), u14 (copy), TweenService (ref), u18 (ref), game_Lighting (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.Impact);
        VfxManager.Enable(u17.Impact_2, true);

        for _, child in script.TatlisBodyWelds:GetChildren() do
            if Character:FindFirstChild(child.Name) then
                local v19 = child:Clone();
                v19.CFrame = Character:FindFirstChild(child.Name).CFrame;
                v19.Parent = Folder;
                Essentials:Weld(v19, Character:FindFirstChild(child.Name));
                VfxManager.Enable(v19, true);
                table.insert(u13, v19);
            end;
        end;

        u14.Enabled = true;

        for _, descendant in pairs(u14:GetDescendants()) do
            if descendant:IsA("ImageLabel") then
                descendant.ImageColor3 = Color3.fromRGB(58, 179, 114);
                descendant.ImageTransparency = 0;
                TweenService:Create(descendant, TweenInfo.new(1.5), {
                    ImageTransparency = 1
                }):Play();
            end;
        end;

        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2,
            Saturation = 0.3,
            TintColor = Color3.fromRGB(112, 255, 176)
        });
        u18:Play();
        task.wait(0.445);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2,
            Saturation = 0.3,
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u18:Play();
    end);
    task.delay(11.8 - u5, function() -- Line: 239
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy), u13 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u17.Impact_2, false);

        for _, v in u13 do
            VfxManager.Enable(v, false);
        end;
    end);
    local u20 = SfxManager:playSound({
        Sound = "Chuck AWK SHOT WIn",
        Parent = workspace
    });

    local function v21() -- Line: 251
        -- upvalues: u12 (ref), Folder (copy), VfxManager (ref), u18 (ref), u14 (copy), u20 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy)
        for _, v in u12 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);
        end;

        if u18 then
            u18:Pause();
        end;

        if u14 then
            u14:Destroy();
        end;

        if u20 then
            u20:Destroy();
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        u12 = nil;
    end;

    table.insert(u12, Folder.AttributeChanged:Connect(v21));
    table.insert(u12, Folder.Destroying:Connect(v21));
end;