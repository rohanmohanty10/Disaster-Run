 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local UIController = require(ReplicatedStorage.Controllers.UIController);
require(ReplicatedStorage.Shared.Utility.Trove);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local LocalPlayer = game.Players.LocalPlayer;

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v.ClassName == "ParticleEmitter" then
            v.Enabled = p2 or false;
        end;
    end;
end;

function EmitAll(p3: table)
    for _, v in next, p3 do
        if v.ClassName == "ParticleEmitter" then
            if v:GetAttribute("EmitDelay") then
                task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 26
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            else
                v:Emit(v:GetAttribute("EmitCount"));
            end;
        end;
    end;
end;

local function scaleDown(p4, p5) -- Line: 38
    for _, v in p4 do
        if v:IsA("ParticleEmitter") then
            local v6 = v;
            local v7 = {};

            for _, v2 in v.Size.Keypoints do
                local v8;

                if v2.Envelope then
                    v8 = v2.Envelope / 15 or nil;
                else
                    v8 = nil;
                end;

                if v8 ~= v8 then
                    v8 = nil;
                end;

                table.insert(v7, NumberSequenceKeypoint.new(v2.Time, v2.Value / 15, v8));
            end;

            v6.Size = NumberSequence.new(v7);
            v6.Speed = NumberRange.new(v6.Speed.Min / 15, v6.Speed.Max / 15);
        elseif v:IsA("Attachment") then
            v.Position = v.Position / 15;

            if v.Position ~= v.Position then
                v.Position = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("BasePart") then
            v.Position = p5.CFrame.Position + (v.Position - p5.CFrame.Position) / 15;

            if v.Position ~= v.Position then
                v.Position = p5.CFrame.Position;
            end;

            v.Size = v.Size / 15;

            if v.Size ~= v.Size then
                v.Size = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("Beam") then
            v.Width0 = v.Width0 / 15;
            v.Width1 = v.Width1 / 15;
        end;
    end;
end;

return function(p9, p10) -- Line: 80
    -- upvalues: LocalPlayer (copy), Knit (copy), TweenService (copy), VfxManager (copy), ReplicatedStorage (copy), UIController (copy), SfxManager (copy), scaleDown (copy)
    if LocalPlayer.Team == game.Teams.Visitor and not p10.Locker then
        return;
    end;

    local Controller = Knit.GetController("MovementController");
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");

    if not p10.Preview then
        local Lighting = game:GetService("Lighting");
        local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
        local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
        local Atmosphere = Lighting:FindFirstChild("Atmosphere");
        local Color3_fromRGB_ret2 = Color3.fromRGB(202, 255, 251);
        local u11 = script.Vignette:Clone();
        u11.Parent = PlayerGui;
        u11.Enabled = true;
        local _ = u11.Vignette;
        local Vignette1 = u11.Vignette1;
        Vignette1.ImageColor3 = Color3.fromRGB(255, 26, 30);
        ColorCorrection.TintColor = Color3.fromRGB(0, 0, 0);
        ColorCorrection.Brightness = 0.35;
        TweenService:Create(ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        }):Play();
        TweenService:Create(ColorCorrection, TweenInfo.new(0.4, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        }):Play();
        TweenService:Create(ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        TweenService:Create(Atmosphere, TweenInfo.new(0.016666666666666666), {
            Haze = 10,
            Density = 0.45,
            Color = Color3.fromRGB(168, 21, 26)
        }):Play();
        local u12 = true;
        task.delay(0.15, function() -- Line: 121
            -- upvalues: Lighting (copy), TweenService (ref), VfxManager (ref), ColorCorrection (copy), Color3_fromRGB_ret (copy), Vignette1 (copy), LocalPlayer (ref), ReplicatedStorage (ref), u12 (ref), UIController (ref)
            local BlurEffect = Instance.new("BlurEffect", Lighting);
            BlurEffect.Size = 15;
            TweenService:Create(BlurEffect, TweenInfo.new(0.555, Enum.EasingStyle.Sine), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect, 0.555);
            TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
                Saturation = 0.3
            }):Play();
            task.delay(0.05, function() -- Line: 131
                -- upvalues: TweenService (ref), ColorCorrection (ref), Color3_fromRGB_ret (ref), Vignette1 (ref), LocalPlayer (ref), ReplicatedStorage (ref), u12 (ref), UIController (ref)
                TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
                    Brightness = -0.015,
                    TintColor = Color3_fromRGB_ret
                }):Play();
                TweenService:Create(Vignette1, TweenInfo.new(0.325, Enum.EasingStyle.Linear), {
                    ImageColor3 = Color3.fromRGB(0, 0, 0)
                }):Play();
                task.delay(0.355, function() -- Line: 135
                    -- upvalues: TweenService (ref), ColorCorrection (ref), LocalPlayer (ref), ReplicatedStorage (ref), u12 (ref), UIController (ref)
                    TweenService:Create(ColorCorrection, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                        Saturation = -1,
                        Brightness = -0.1,
                        Contrast = 1.2
                    }):Play();
                    local ScreenGui = Instance.new("ScreenGui");
                    ScreenGui.Parent = LocalPlayer.PlayerGui;
                    ScreenGui.IgnoreGuiInset = true;
                    local v13 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
                    v13.Parent = ScreenGui;
                    v13.ImageTransparency = 0.85;

                    while u12 == true do
                        UIController:PlayFlipbook(v13, "EmperorScreenLines", 0.03333333333333333);
                    end;

                    ScreenGui:Destroy();
                end);
            end);
        end);
        task.delay(1.167, function() -- Line: 155
            -- upvalues: TweenService (ref), Atmosphere (copy), Color3_fromRGB_ret2 (copy)
            TweenService:Create(Atmosphere, TweenInfo.new(0.03333333333333333), {
                Haze = 2.04,
                Density = 0.3,
                Color = Color3_fromRGB_ret2
            }):Play();
        end);
        task.delay(1.233, function() -- Line: 159
            -- upvalues: u12 (ref), Vignette1 (copy), ColorCorrection (copy), TweenService (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u11 (copy)
            u12 = false;
            Vignette1.ImageColor3 = Color3.fromRGB(255, 26, 30);
            ColorCorrection.TintColor = Color3.fromRGB(255, 26, 30);
            ColorCorrection.Brightness = 0.75;
            TweenService:Create(ColorCorrection, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                TintColor = Color3_fromRGB_ret
            }):Play();
            TweenService:Create(ColorCorrection, TweenInfo.new(0.4, Enum.EasingStyle.Sine), {
                Saturation = 0.3
            }):Play();
            TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
                Brightness = -0.015
            }):Play();
            TweenService:Create(ColorCorrection, TweenInfo.new(0.125, Enum.EasingStyle.Linear), {
                Contrast = 0.2
            }):Play();
            TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
            VfxManager.DestroyEffect(u11, 0.755);
        end);

        if LocalPlayer.Team ~= game.Teams.Visitor and LocalPlayer.Character ~= p10.Plr.Character then
            local EMPERORKNEELANIMATION = ReplicatedStorage.Assets.VFX.Emotes.EMPERORKNEELANIMATION;
            local Character = LocalPlayer.Character;

            if Character then
                local u14 = Character:FindFirstChild("Humanoid"):LoadAnimation(EMPERORKNEELANIMATION);
                u14:Play();
                Controller.States.Kneeling = true;
                task.delay(2, function() -- Line: 186
                    -- upvalues: Controller (copy), u14 (copy)
                    Controller.States.Kneeling = false;
                    u14:Stop();
                end);
            end;
        end;

        SfxManager:playSound({
            Sound = "EMP GOAL",
            Parent = workspace
        });
    end;

    local v15 = script.ConstellationGoal:Clone();
    v15.CFrame = p10.CFrame * CFrame.Angles(0, 3.141592653589793, 0);
    v15.Parent = workspace.Debris;

    if p10.Preview then
        scaleDown(v15:GetDescendants(), p10);
    end;

    VfxManager.Emit(v15);
    VfxManager.DestroyEffect(v15, 3);
    local u16 = script.Enabled:Clone();
    u16:PivotTo(p10.CFrame);
    u16.Parent = workspace.Debris;

    if p10.Preview then
        u16.Beams:Destroy();
        scaleDown(u16:GetDescendants(), p10);
    end;

    VfxManager.Enable(u16, true);
    task.delay(1.233, function() -- Line: 220
        -- upvalues: VfxManager (ref), u16 (copy)
        VfxManager.Enable(u16, false);
        VfxManager.DestroyEffect(u16, 3);
    end);
end;