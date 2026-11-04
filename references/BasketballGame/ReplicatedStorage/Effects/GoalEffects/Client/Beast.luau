 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

local function scaleDown(p1, p2) -- Line: 15
    for _, v in p1 do
        if v:IsA("ParticleEmitter") then
            local v3 = v;
            local v4 = {};

            for _, v2 in v.Size.Keypoints do
                local v5;

                if v2.Envelope then
                    v5 = v2.Envelope / 10 or nil;
                else
                    v5 = nil;
                end;

                if v5 ~= v5 then
                    v5 = nil;
                end;

                table.insert(v4, NumberSequenceKeypoint.new(v2.Time, v2.Value / 10, v5));
            end;

            v3.Size = NumberSequence.new(v4);
            v3.Speed = NumberRange.new(v3.Speed.Min / 10, v3.Speed.Max / 10);
        elseif v:IsA("Attachment") then
            v.Position = v.Position / 10;

            if v.Position ~= v.Position then
                v.Position = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("BasePart") then
            v.Position = p2.CFrame.Position + (v.Position - p2.CFrame.Position) / 10;

            if v.Position ~= v.Position then
                v.Position = p2.CFrame.Position;
            end;

            v.Size = v.Size / 10;

            if v.Size ~= v.Size then
                v.Size = Vector3.new(0, 0, 0);
            end;
        elseif v:IsA("Beam") then
            v.Width0 = v.Width0 / 10;
            v.Width1 = v.Width1 / 10;
            v.CurveSize0 = v.CurveSize0 / 10;
            v.CurveSize1 = v.CurveSize1 / 10;
        end;
    end;
end;

return function(p6, p7) -- Line: 60
    -- upvalues: LocalPlayer (copy), VfxManager (copy), TweenService (copy), Debris (copy), scaleDown (copy)
    local CFrame2 = p7.CFrame;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local _ = p7.Player.Character;

    if not p7.Preview then
        local u8 = script.Vignette:Clone();
        u8.Parent = PlayerGui;
        u8.Enabled = true;
        VfxManager.DestroyEffect(u8, 4);
        local _ = u8.Vignette;
        local Vignette1 = u8.Vignette1;
        task.delay(3.65, function() -- Line: 75
            -- upvalues: u8 (copy)
            u8:Destroy();
        end);
        local game_Lighting = game.Lighting;
        game_Lighting:FindFirstChild("ColorCorrection");
        local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
        task.delay(0.7, function() -- Line: 88
            -- upvalues: Vignette1 (ref), game_Lighting (copy), TweenService (ref), Color3_fromRGB_ret (copy)
            Vignette1.ImageColor3 = Color3.fromRGB(255, 66, 69);
            game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 66, 69);
            game_Lighting.ColorCorrection.Brightness = 0.75;
            TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                TintColor = Color3_fromRGB_ret
            }):Play();
            TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
                Saturation = 0.3
            }):Play();
            TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
                Brightness = -0.015
            }):Play();
            TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
        end);
    end;

    local u9 = script.BEAST:Clone();
    u9:PivotTo(CFrame2 * CFrame.Angles(0, p7.Preview and 0 or 1.5707963267948966, 0));
    u9.Parent = Debris;

    if p7.Preview then
        scaleDown(u9:GetDescendants(), p7);
    end;

    u9.emote.AnimationController:LoadAnimation(u9.emote.Animation):Play();
    TweenService:Create(u9.emote.Sphere, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
        Transparency = 0
    }):Play();
    VfxManager.Emit(u9.Dunk);
    task.delay(0.067, function() -- Line: 117
        -- upvalues: VfxManager (ref), u9 (copy)
        VfxManager.Enable(u9.emote, true);
        VfxManager.Enable(u9.emote.Sphere.Part, false);
    end);
    task.delay(0.7, function() -- Line: 122
        -- upvalues: VfxManager (ref), u9 (copy)
        task.wait(0.016666666666666666);
        VfxManager.Enable(u9.emote, true);
        VfxManager.Enable(u9.Enabled, true);
        VfxManager.Emit(u9.Impact);
    end);
    task.delay(2.15, function() -- Line: 130
        -- upvalues: VfxManager (ref), u9 (copy)
        VfxManager.Enable(u9.emote, false);
    end);
    task.delay(2.5, function() -- Line: 134
        -- upvalues: VfxManager (ref), u9 (copy)
        VfxManager.Enable(u9.emote, true);
        VfxManager.Emit(u9.Impact);
    end);
    task.delay(3.35, function() -- Line: 139
        -- upvalues: TweenService (ref), u9 (copy)
        TweenService:Create(u9.emote.Sphere, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
    end);
    task.delay(3.65, function() -- Line: 143
        -- upvalues: VfxManager (ref), u9 (copy)
        VfxManager.Enable(u9, false);
        VfxManager.DestroyEffect(u9, 2);
    end);
end;