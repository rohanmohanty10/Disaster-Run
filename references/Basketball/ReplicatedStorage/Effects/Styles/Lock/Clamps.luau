 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

local function Destroy_Effect(u1: userdata, p2: number) -- Line: 17
    task.delay(p2, function() -- Line: 18
        -- upvalues: u1 (copy)
        u1:Destroy();
    end);
end;

local function NewHighlight() -- Line: 22
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.new(1, 0, 0);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 0;

    return Highlight;
end;

return function(u3, p4) -- Line: 36
    -- upvalues: RunService (copy), Essentials (copy), Debris (copy), LocalPlayer (copy), SfxManager (copy), NewHighlight (copy), VfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Character = p4.Character;

    if not game.Players:FindFirstChild(Character.Name) then
        game.Players:GetPlayerFromCharacter(Character);
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    local u5 = workspace:GetServerTimeNow() - p4.TimeSent;
    local v6 = Character.Name .. script.Parent.Name .. script.Name;

    if p4.Task == "Own" then
        local script_Fov = require(script.Fov);
        local u7 = 0;
        local u8 = nil;
        local FieldOfView = workspace_CurrentCamera.FieldOfView;
        u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 55
            -- upvalues: u3 (copy), u8 (ref), u7 (ref), u5 (copy), script_Fov (copy), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
            if u3.MovementController.States.Ability == false then
                u8:Disconnect();

                return;
            end;

            if u7 <= 0 then
                u7 = p9 * 60 * u5;
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
        task.delay(9, function() -- Line: 74
            -- upvalues: u8 (ref)
            if u8 then
                u8:Disconnect();
            end;
        end);

        if Debris:FindFirstChild(v6) then
            Debris:FindFirstChild(v6):Destroy();
        end;

        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
        local u11 = {};
        local u12 = {};
        local Folder = Instance.new("Folder");
        Folder.Name = v6;
        Folder.Parent = Debris;
        Folder:SetAttribute("Active", true);
        task.delay(13.917, function() -- Line: 90
            -- upvalues: Folder (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            Folder:SetAttribute("Active", nil);
        end);
        local u13 = SfxManager:playSound({
            Sound = "lock awak move 1 variant",
            Parent = workspace
        });
        local u14 = script.Vignette:Clone();
        u14.Parent = PlayerGui;
        u14.Enabled = false;
        local Vignette = u14.Vignette;
        local Vignette1 = u14.Vignette1;
        local u15 = script.Camera_VFX:Clone();
        u15:PivotTo(CamRig:FindFirstChild("camera").CFrame);
        u15.Parent = Folder;
        u15.PrimaryPart.CFrame = CamRig.camera.CFrame;
        Essentials:Weld(CamRig.camera, u15.PrimaryPart);
        local u16 = script.Cutscene_VFX:Clone();
        u16:PivotTo(HumanoidRootPart.CFrame);
        u16.Parent = Folder;
        local u17 = NewHighlight();
        u17.Parent = Character;
        local game_Lighting = game.Lighting;
        local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
        local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
        local u18 = nil;
        local u19 = nil;
        local Atmosphere = game_Lighting:FindFirstChild("Atmosphere");
        local Density = Atmosphere.Density;
        local Color = Atmosphere.Color;
        local u20 = nil;
        u17.OutlineColor = Color3.fromRGB(0, 0, 0);
        task.delay(0.15 - u5, function() -- Line: 136
            -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Emit(u16.Dribble_0);
        end);
        task.delay(0.7 - u5, function() -- Line: 142
            -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Emit(u16.Dribble_1);
        end);
        task.delay(1 - u5, function() -- Line: 149
            -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), u15 (copy), u18 (ref), TweenService (ref), game_Lighting (copy), u14 (copy), Vignette (copy), Vignette1 (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Emit(u16.Dribble_1);
            VfxManager.Enable(u15.CameraAtmosphere, true);
            VfxManager.Enable(u15.DunkCamera, true);
            u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.215, Enum.EasingStyle.Sine), {
                Saturation = -0.5
            });
            u18:Play();
            u14.Enabled = true;
            TweenService:Create(Vignette, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
                ImageTransparency = 0
            }):Play();
            TweenService:Create(Vignette1, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
                ImageTransparency = 0.75
            }):Play();
        end);
        task.delay(1.333 - u5, function() -- Line: 167
            -- upvalues: Folder (copy), ColorCorrection (copy), game_Lighting (copy), VfxManager (ref), u15 (copy), u16 (copy), Vignette1 (copy), TweenService (ref), Vignette (copy), u18 (ref)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            ColorCorrection.Saturation = 0.3;
            ColorCorrection.TintColor = Color3.fromRGB(109, 41, 255);
            game_Lighting.ColorCorrection.Brightness = 0.35;
            VfxManager.Enable(u15.CameraAtmosphere, false);
            VfxManager.Enable(u15.DunkCamera, false);
            VfxManager.Emit(u16.Poke);
            Vignette1.ImageColor3 = Color3.fromRGB(89, 38, 255);
            TweenService:Create(Vignette, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
                ImageTransparency = 1
            }):Play();
            TweenService:Create(Vignette1, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
                ImageTransparency = 0,
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
            u18 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
                Brightness = -0.015,
                TintColor = Color3.fromRGB(255, 255, 255)
            });
            u18:Play();
        end);
        task.delay(1.467 - u5, function() -- Line: 186
            -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), ColorCorrection (copy), game_Lighting (copy), Vignette1 (copy), Vignette (copy), TweenService (ref), u18 (ref), u19 (ref)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Emit(u16.Rejection);
            ColorCorrection.TintColor = Color3.fromRGB(255, 48, 48);
            game_Lighting.ColorCorrection.Brightness = 0;
            Vignette1.ImageColor3 = Color3.fromRGB(255, 83, 83);
            Vignette.ImageTransparency = 0;
            TweenService:Create(Vignette, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
                ImageTransparency = 1
            }):Play();
            TweenService:Create(Vignette1, TweenInfo.new(1.355, Enum.EasingStyle.Sine), {
                ImageTransparency = 1,
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
            u18 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
                TintColor = Color3.fromRGB(255, 255, 255)
            });
            u18:Play();
            u19 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
                Brightness = -0.015
            });
            u19:Play();
        end);
        task.delay(2.217 - u5, function() -- Line: 205
            -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Emit(u16.Dribble_2);
        end);
        task.delay(2.85 - u5, function() -- Line: 211
            -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Emit(u16.Dribble_2);
        end);
        task.delay(3.117 - u5, function() -- Line: 217
            -- upvalues: Folder (copy), VfxManager (ref), u15 (copy), u18 (ref), TweenService (ref), ColorCorrection (copy), Vignette (copy), Vignette1 (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Enable(u15.CameraAtmosphere, true);
            VfxManager.Enable(u15.DunkCamera, true);
            u18 = TweenService:Create(ColorCorrection, TweenInfo.new(0.215, Enum.EasingStyle.Sine), {
                Saturation = -0.5
            });
            u18:Play();
            TweenService:Create(Vignette, TweenInfo.new(0.655, Enum.EasingStyle.Quad), {
                ImageTransparency = 0
            }):Play();
            TweenService:Create(Vignette1, TweenInfo.new(0.655, Enum.EasingStyle.Quad), {
                ImageTransparency = 0
            }):Play();
        end);
        task.delay(3.467 - u5, function() -- Line: 231
            -- upvalues: Folder (copy), ColorCorrection (copy), VfxManager (ref), u16 (copy), u15 (copy), Vignette1 (copy), Vignette (copy), TweenService (ref), u18 (ref), u19 (ref)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            ColorCorrection.Saturation = 0.3;
            ColorCorrection.TintColor = Color3.fromRGB(119, 28, 255);
            ColorCorrection.Brightness = 1;
            VfxManager.Emit(u16.Poke2);
            VfxManager.Emit(u16.Movement);
            VfxManager.Enable(u15.CameraAtmosphere, false);
            VfxManager.Enable(u15.DunkCamera, false);
            Vignette1.ImageColor3 = Color3.fromRGB(97, 35, 255);
            Vignette.ImageTransparency = 0;
            TweenService:Create(Vignette1, TweenInfo.new(1.1, Enum.EasingStyle.Sine), {
                ImageTransparency = 1,
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
            u18 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
                TintColor = Color3.fromRGB(255, 255, 255)
            });
            u18:Play();
            u19 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
                Brightness = -0.015
            });
            u19:Play();
        end);
        task.delay(4.1 - u5, function() -- Line: 257
            -- upvalues: Folder (copy), TweenService (ref), Vignette (copy), Vignette1 (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            TweenService:Create(Vignette, TweenInfo.new(1, Enum.EasingStyle.Quint), {
                ImageTransparency = 1
            }):Play();
            TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Quint), {
                ImageTransparency = 1
            }):Play();
        end);
        task.delay(4.833 - u5, function() -- Line: 264
            -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), ColorCorrection (copy), game_Lighting (copy), u18 (ref), TweenService (ref), u19 (ref)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Emit(u16.FallFX);
            ColorCorrection.TintColor = Color3.fromRGB(255, 62, 62);
            game_Lighting.ColorCorrection.Brightness = 0.35;
            u18 = TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
                TintColor = Color3.fromRGB(255, 255, 255)
            });
            u18:Play();
            u19 = TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
                Brightness = -0.015
            });
            u19:Play();
        end);
        task.delay(5.15 - u5, function() -- Line: 278
            -- upvalues: Folder (copy), Vignette (copy), VfxManager (ref), u15 (copy), TweenService (ref), Vignette1 (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            Vignette.ImageColor3 = Color3.fromRGB(0, 0, 0);
            VfxManager.Enable(u15.PassCamera1, true);
            TweenService:Create(Vignette, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
                ImageTransparency = 0
            }):Play();
            TweenService:Create(Vignette1, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
                ImageTransparency = 0
            }):Play();
        end);
        task.delay(5.917 - u5, function() -- Line: 288
            -- upvalues: Folder (copy), ColorCorrection (copy), Vignette1 (copy), TweenService (ref), u20 (ref), Atmosphere (copy), u18 (ref), game_Lighting (copy), u19 (ref), VfxManager (ref), u15 (copy), u16 (copy), Character (copy), Essentials (ref), u12 (copy), BALL (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            ColorCorrection.TintColor = Color3.fromRGB(121, 43, 255);
            ColorCorrection.Brightness = 1;
            Vignette1.ImageColor3 = Color3.fromRGB(65, 48, 255);
            TweenService:Create(Vignette1, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
            u20 = TweenService:Create(Atmosphere, TweenInfo.new(0.255, Enum.EasingStyle.Linear), {
                Density = 0.421,
                Color = Color3.fromRGB(115, 72, 207)
            });
            u20:Play();
            u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
                TintColor = Color3.fromRGB(255, 255, 255)
            });
            u18:Play();
            u19 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
                Brightness = -0.015
            });
            u19:Play();
            VfxManager.Enable(u15.PassCamera1, false);
            VfxManager.Enable(u16.LineGroundFlame, true);
            VfxManager.Emit(u16.Catch);

            for _, child in script.AuraBodyWelds:GetChildren() do
                if Character:FindFirstChild(child.Name) then
                    local v21 = child:Clone();
                    v21.CFrame = Character:FindFirstChild(child.Name).CFrame;
                    v21.Parent = Folder;
                    Essentials:Weld(v21, Character:FindFirstChild(child.Name));
                    VfxManager.Enable(v21, true);
                    table.insert(u12, v21);
                end;
            end;

            local v22 = script.Weld_2:Clone();
            v22.CFrame = BALL.CFrame;
            v22.Parent = Folder;
            Essentials:Weld(v22, BALL);
            VfxManager.Enable(v22, true);
        end);
        task.delay(7.233 - u5, function() -- Line: 331
            -- upvalues: Folder (copy), u20 (ref), TweenService (ref), Atmosphere (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            u20 = TweenService:Create(Atmosphere, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
                Density = 0.419,
                Color = Color3.fromRGB(0, 0, 0)
            });
            u20:Play();
        end);
        task.delay(8.7 - u5, function() -- Line: 338
            -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Enable(Folder, false);

            if u14 then
                u14:Destroy();
            end;
        end);

        local function v23() -- Line: 347
            -- upvalues: u11 (ref), Folder (copy), VfxManager (ref), u18 (ref), u19 (ref), u20 (ref), u14 (copy), u13 (copy), u17 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), Atmosphere (copy), Density (copy), Color (copy)
            for _, v in u11 do
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

            if u19 then
                u19:Pause();
            end;

            if u20 then
                u20:Pause();
            end;

            if u14 then
                u14:Destroy();
            end;

            if u13 then
                VfxManager.DestroyEffect(u13, 2);
            end;

            if u17 then
                u17:Destroy();
            end;

            ColorCorrection.TintColor = Color3_fromRGB_ret;
            ColorCorrection.Contrast = 0.2;
            ColorCorrection.Saturation = 0.3;
            ColorCorrection.Brightness = -0.015;
            Atmosphere.Density = Density;
            Atmosphere.Color = Color;
            u11 = nil;
        end;

        table.insert(u11, Folder.AttributeChanged:Connect(v23));
        table.insert(u11, Folder.Destroying:Connect(v23));

        return;
    end;

    if p4.Task ~= "Enemy" then
        local v24 = p4.Task == "Cleanup" and Debris:FindFirstChild(v6);

        if v24 then
            v24:SetAttribute("Active", nil);
        end;

        return;
    end;

    local script_Fov2 = require(script.Fov2);
    local u25 = 0;
    local u26 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u26 = RunService.RenderStepped:Connect(function(p27) -- Line: 403
        -- upvalues: u3 (copy), u26 (ref), u25 (ref), u5 (copy), script_Fov2 (copy), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u3.MovementController.States.Ability == false then
            u26:Disconnect();

            return;
        end;

        if u25 <= 0 then
            u25 = p27 * 60 * u5;
        end;

        u25 = u25 + p27 * 60;
        local v28 = script_Fov2[math.ceil(u25)];

        if v28 ~= nil then
            if math.ceil(u25) >= #script_Fov2 then
                u26:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v28, p27 * 6);
        end;
    end);
    task.delay(10, function() -- Line: 422
        -- upvalues: u26 (ref)
        if u26 then
            u26:Disconnect();
        end;
    end);

    if Debris:FindFirstChild(v6) then
        Debris:FindFirstChild(v6):Destroy();
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u29 = {};
    local u30 = {};
    local Folder = Instance.new("Folder");
    Folder.Name = v6;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(13.917, function() -- Line: 438
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u31 = SfxManager:playSound({
        Sound = "lock awak move 1",
        Parent = workspace
    });
    local u32 = script.Vignette:Clone();
    u32.Parent = PlayerGui;
    u32.Enabled = false;
    local Vignette = u32.Vignette;
    local Vignette1 = u32.Vignette1;
    local u33 = script.Camera_VFX:Clone();
    u33:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u33.Parent = Folder;
    u33.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(CamRig.camera, u33.PrimaryPart);
    local u34 = script.Cutscene_VFX:Clone();
    u34:PivotTo(HumanoidRootPart.CFrame);
    u34.Parent = Folder;
    local u35 = nil;
    local u36 = NewHighlight();
    u36.Parent = Character;
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u37 = nil;
    local u38 = nil;
    local Atmosphere = game_Lighting:FindFirstChild("Atmosphere");
    local Density = Atmosphere.Density;
    local Color = Atmosphere.Color;
    local u39 = nil;
    u36.OutlineColor = Color3.fromRGB(0, 0, 0);
    task.delay(0.15 - u5, function() -- Line: 487
        -- upvalues: Folder (copy), VfxManager (ref), u34 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u34.Dribble_0);
    end);
    task.delay(0.7 - u5, function() -- Line: 493
        -- upvalues: Folder (copy), VfxManager (ref), u34 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u34.Dribble_1);
    end);
    task.delay(1 - u5, function() -- Line: 500
        -- upvalues: Folder (copy), VfxManager (ref), u34 (copy), u33 (copy), u37 (ref), TweenService (ref), game_Lighting (copy), u32 (copy), Vignette (copy), Vignette1 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u34.Dribble_1);
        VfxManager.Enable(u33.CameraAtmosphere, true);
        VfxManager.Enable(u33.DunkCamera, true);
        u37 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.215, Enum.EasingStyle.Sine), {
            Saturation = -0.5
        });
        u37:Play();
        u32.Enabled = true;
        TweenService:Create(Vignette, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.75
        }):Play();
    end);
    task.delay(1.333 - u5, function() -- Line: 518
        -- upvalues: Folder (copy), ColorCorrection (copy), game_Lighting (copy), VfxManager (ref), u33 (copy), u34 (copy), Vignette1 (copy), TweenService (ref), Vignette (copy), u37 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        ColorCorrection.Saturation = 0.3;
        ColorCorrection.TintColor = Color3.fromRGB(109, 41, 255);
        game_Lighting.ColorCorrection.Brightness = 0.35;
        VfxManager.Enable(u33.CameraAtmosphere, false);
        VfxManager.Enable(u33.DunkCamera, false);
        VfxManager.Emit(u34.Poke);
        Vignette1.ImageColor3 = Color3.fromRGB(89, 38, 255);
        TweenService:Create(Vignette, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            ImageTransparency = 0,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        u37 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u37:Play();
    end);
    task.delay(1.483 - u5, function() -- Line: 537
        -- upvalues: Folder (copy), VfxManager (ref), u34 (copy), ColorCorrection (copy), game_Lighting (copy), Vignette1 (copy), Vignette (copy), TweenService (ref), u37 (ref), u38 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u34.Rejection);
        ColorCorrection.TintColor = Color3.fromRGB(255, 48, 48);
        game_Lighting.ColorCorrection.Brightness = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(255, 83, 83);
        Vignette.ImageTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(1.355, Enum.EasingStyle.Sine), {
            ImageTransparency = 1,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        u37 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u37:Play();
        u38 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u38:Play();
    end);
    task.delay(2.217 - u5, function() -- Line: 556
        -- upvalues: Folder (copy), VfxManager (ref), u34 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u34.Dribble_2);
    end);
    task.delay(2.85 - u5, function() -- Line: 563
        -- upvalues: Folder (copy), VfxManager (ref), u34 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u34.Dribble_2);
    end);
    task.delay(3.117 - u5, function() -- Line: 569
        -- upvalues: Folder (copy), VfxManager (ref), u33 (copy), u37 (ref), TweenService (ref), ColorCorrection (copy), Vignette (copy), Vignette1 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u33.CameraAtmosphere, true);
        VfxManager.Enable(u33.DunkCamera, true);
        u37 = TweenService:Create(ColorCorrection, TweenInfo.new(0.215, Enum.EasingStyle.Sine), {
            Saturation = -0.5
        });
        u37:Play();
        TweenService:Create(Vignette, TweenInfo.new(0.655, Enum.EasingStyle.Quad), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.655, Enum.EasingStyle.Quad), {
            ImageTransparency = 0
        }):Play();
    end);
    task.delay(3.467 - u5, function() -- Line: 583
        -- upvalues: Folder (copy), ColorCorrection (copy), VfxManager (ref), u34 (copy), u33 (copy), Vignette1 (copy), Vignette (copy), TweenService (ref), u37 (ref), u38 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        ColorCorrection.Saturation = 0.3;
        ColorCorrection.TintColor = Color3.fromRGB(119, 28, 255);
        ColorCorrection.Brightness = 1;
        VfxManager.Emit(u34.Poke2);
        VfxManager.Emit(u34.Movement);
        VfxManager.Enable(u33.CameraAtmosphere, false);
        VfxManager.Enable(u33.DunkCamera, false);
        Vignette1.ImageColor3 = Color3.fromRGB(97, 35, 255);
        Vignette.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(1.1, Enum.EasingStyle.Sine), {
            ImageTransparency = 1,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        u37 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u37:Play();
        u38 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u38:Play();
    end);
    task.delay(4.1 - u5, function() -- Line: 609
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy), Vignette1 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(1, Enum.EasingStyle.Quint), {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Quint), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(4.833 - u5, function() -- Line: 616
        -- upvalues: Folder (copy), VfxManager (ref), u34 (copy), ColorCorrection (copy), game_Lighting (copy), u37 (ref), TweenService (ref), u38 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u34.FallFX);
        ColorCorrection.TintColor = Color3.fromRGB(255, 62, 62);
        game_Lighting.ColorCorrection.Brightness = 0.35;
        u37 = TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u37:Play();
        u38 = TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u38:Play();
    end);
    task.delay(5.15 - u5, function() -- Line: 630
        -- upvalues: Folder (copy), Vignette (copy), VfxManager (ref), u33 (copy), TweenService (ref), Vignette1 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette.ImageColor3 = Color3.fromRGB(0, 0, 0);
        VfxManager.Enable(u33.PassCamera1, true);
        TweenService:Create(Vignette, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
    end);
    task.delay(5.917 - u5, function() -- Line: 640
        -- upvalues: Folder (copy), ColorCorrection (copy), Vignette1 (copy), TweenService (ref), u39 (ref), Atmosphere (copy), u37 (ref), game_Lighting (copy), u38 (ref), VfxManager (ref), u33 (copy), u34 (copy), Character (copy), Essentials (ref), u30 (copy), u35 (ref), BALL (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        ColorCorrection.TintColor = Color3.fromRGB(121, 43, 255);
        ColorCorrection.Brightness = 1;
        Vignette1.ImageColor3 = Color3.fromRGB(65, 48, 255);
        TweenService:Create(Vignette1, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        u39 = TweenService:Create(Atmosphere, TweenInfo.new(0.255, Enum.EasingStyle.Linear), {
            Density = 0.421,
            Color = Color3.fromRGB(115, 72, 207)
        });
        u39:Play();
        u37 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u37:Play();
        u38 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u38:Play();
        VfxManager.Enable(u33.PassCamera1, false);
        VfxManager.Enable(u34.LineGroundFlame, true);
        VfxManager.Emit(u34.Catch);

        for _, child in script.AuraBodyWelds:GetChildren() do
            if Character:FindFirstChild(child.Name) then
                local v40 = child:Clone();
                v40.CFrame = Character:FindFirstChild(child.Name).CFrame;
                v40.Parent = Folder;
                Essentials:Weld(v40, Character:FindFirstChild(child.Name));
                VfxManager.Enable(v40, true);
                table.insert(u30, v40);
            end;
        end;

        u35 = script.Weld:Clone();
        u35.CFrame = BALL.CFrame;
        u35.Parent = Folder;
        Essentials:Weld(u35, BALL);
        VfxManager.Enable(u35, true);
    end);
    task.delay(7.233 - u5, function() -- Line: 681
        -- upvalues: Folder (copy), u39 (ref), TweenService (ref), Atmosphere (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u39 = TweenService:Create(Atmosphere, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
            Density = 0.419,
            Color = Color3.fromRGB(0, 0, 0)
        });
        u39:Play();
    end);
    task.delay(7.783 - u5, function() -- Line: 688
        -- upvalues: Folder (copy), u30 (copy), VfxManager (ref), u34 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, v in u30 do
            VfxManager.Enable(v, false);
        end;

        VfxManager.Enable(u34.LineGroundFlame, false);
    end);
    task.delay(8.25 - u5, function() -- Line: 699
        -- upvalues: Folder (copy), u35 (ref), VfxManager (ref), u34 (copy), ColorCorrection (copy), u37 (ref), TweenService (ref), u38 (ref), Vignette1 (copy), Vignette (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        if u35 then
            VfxManager.Enable(u35, false);
        end;

        VfxManager.Emit(u34.DunkEffect);
        ColorCorrection.TintColor = Color3.fromRGB(119, 28, 255);
        ColorCorrection.Brightness = 1;
        u37 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u37:Play();
        u38 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u38:Play();
        Vignette1.ImageColor3 = Color3.fromRGB(65, 48, 255);
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageTransparency = 1,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(9.317 - u5, function() -- Line: 724
        -- upvalues: Folder (copy), VfxManager (ref), u32 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(Folder, false);

        if u32 then
            u32:Destroy();
        end;
    end);

    local function v41() -- Line: 735
        -- upvalues: u29 (ref), Folder (copy), VfxManager (ref), u37 (ref), u38 (ref), u39 (ref), u32 (copy), u31 (copy), u36 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), Atmosphere (copy), Density (copy), Color (copy)
        for _, v in u29 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);
        end;

        if u37 then
            u37:Pause();
        end;

        if u38 then
            u38:Pause();
        end;

        if u39 then
            u39:Pause();
        end;

        if u32 then
            u32:Destroy();
        end;

        if u31 then
            VfxManager.DestroyEffect(u31, 2);
        end;

        if u36 then
            u36:Destroy();
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        u29 = nil;
    end;

    table.insert(u29, Folder.AttributeChanged:Connect(v41));
    table.insert(u29, Folder.Destroying:Connect(v41));
end;