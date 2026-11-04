 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Knit = require(ReplicatedStorage.Packages.Knit);
local LocalPlayer = game.Players.LocalPlayer;

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v.ClassName == "ParticleEmitter" then
            v.Enabled = p2 or false;
        end;
    end;
end;

function EmitAll(p3: table)
    local v4 = 0;

    for _, v in next, p3 do
        if v.ClassName == "ParticleEmitter" then
            if v:GetAttribute("EmitDelay") then
                task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 27
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            else
                v:Emit(v:GetAttribute("EmitCount"));
            end;

            local v5 = (v:GetAttribute("EmitDelay") or 0) + v.Lifetime.Max;
            v4 = math.max(v4, v5);
        end;
    end;

    return v4;
end;

local function Destroy_Effect(u6: userdata, p7: number) -- Line: 41
    task.delay(p7, function() -- Line: 42
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);
end;

return function(p8, p9) -- Line: 47
    -- upvalues: LocalPlayer (copy), TweenService (copy), VfxManager (copy), SfxManager (copy), Essentials (copy), RunService (copy), Knit (copy)
    local Player = p9.Player;

    if not (Player or (p9.Locker or p9.Preview)) then
        warn("No plr for Cursed beam");

        return;
    end;

    local u10 = script.CursedBeam:Clone();
    u10.Parent = workspace.Debris;
    u10:PivotTo(p9.CFrame);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");

    if p9.Preview then
        for _, descendant in u10:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                local v11 = descendant;
                local v12 = {};

                for _, v in descendant.Size.Keypoints do
                    local v13;

                    if v.Envelope then
                        v13 = v.Envelope / 10 or nil;
                    else
                        v13 = nil;
                    end;

                    if v13 ~= v13 then
                        v13 = nil;
                    end;

                    table.insert(v12, NumberSequenceKeypoint.new(v.Time, v.Value / 10, v13));
                end;

                v11.Size = NumberSequence.new(v12);
                v11.Speed = NumberRange.new(v11.Speed.Min / 10, v11.Speed.Max / 10);
            elseif descendant:IsA("Attachment") then
                descendant.Position = descendant.Position / 10;

                if descendant.Position ~= descendant.Position then
                    descendant.Position = Vector3.new(0, 0, 0);
                end;
            elseif descendant:IsA("BasePart") then
                descendant.Position = p9.CFrame.Position + (descendant.Position - p9.CFrame.Position) / 10;

                if descendant.Position ~= descendant.Position then
                    descendant.Position = p9.CFrame.Position;
                end;

                descendant.Size = descendant.Size / 10;

                if descendant.Size ~= descendant.Size then
                    descendant.Size = Vector3.new(0, 0, 0);
                end;
            elseif descendant:IsA("Beam") then
                descendant.Width0 = descendant.Width0 / 10;
                descendant.Width1 = descendant.Width1 / 10;
            end;
        end;

        local game_Lighting = game.Lighting;
        local ExposureCompensation = game_Lighting.ExposureCompensation;
        local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
        local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
        local Bloom = game_Lighting:FindFirstChild("Bloom");
        local Intensity = Bloom.Intensity;
        local Size = Bloom.Size;
        local Threshold = Bloom.Threshold;
        local u14 = script.Vignette:Clone();
        u14.Parent = PlayerGui;
        u14.Enabled = true;
        local Vignette = u14.Vignette;
        local Vignette1 = u14.Vignette1;
        ColorCorrection.Brightness = 0.75;
        ColorCorrection.Contrast = 1.25;
        ColorCorrection.Saturation = -1;
        ColorCorrection.TintColor = Color3.fromRGB(46, 84, 255);
        local u15 = TweenService:Create(ColorCorrection, TweenInfo.new(0.085, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2,
            Saturation = 0.3
        });
        u15:Play();
        local u16 = TweenService:Create(ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            TintColor = Color3_fromRGB_ret
        });
        u16:Play();
        local Bloom2 = game_Lighting.Bloom;
        Bloom2.Intensity = 1.5;
        Bloom2.Threshold = 1.65;
        local u17 = TweenService:Create(Bloom2, TweenInfo.new(2, Enum.EasingStyle.Linear), {
            Intensity = Intensity,
            Threshold = Threshold
        });
        u17:Play();
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 13;
        BlurEffect.Parent = game_Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        Vignette1.ImageColor3 = Color3.fromRGB(28, 70, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(2, Enum.EasingStyle.Sine), {
            ImageTransparency = 1,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        Vignette.ImageTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(2, Enum.EasingStyle.Linear), {
            ImageTransparency = 1
        }):Play();
        game_Lighting.ExposureCompensation = -0.75;
        local u18 = TweenService:Create(game_Lighting, TweenInfo.new(0.833, Enum.EasingStyle.Linear), {
            ExposureCompensation = -0.5
        });
        u18:Play();
        local u19 = nil;
        u18.Completed:Connect(function() -- Line: 163
            -- upvalues: u18 (copy), u19 (ref), TweenService (ref), game_Lighting (copy), ExposureCompensation (copy)
            u18:Destroy();
            u19 = TweenService:Create(game_Lighting, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                ExposureCompensation = ExposureCompensation
            });
            u19:Play();
        end);
        task.delay(4, function() -- Line: 169
            -- upvalues: u14 (copy), u15 (copy), u16 (copy), u18 (copy), u17 (copy), u19 (ref), ColorCorrection (copy), Color3_fromRGB_ret (copy), Bloom2 (copy), Intensity (copy), Size (copy), Threshold (copy), game_Lighting (copy), ExposureCompensation (copy)
            if u14 then
                u14:Destroy();
            end;

            if u15 then
                u15:Pause();
            end;

            if u16 then
                u16:Pause();
            end;

            if u18 then
                u18:Pause();
            end;

            if u17 then
                u17:Pause();
            end;

            if u19 then
                u19:Pause();
            end;

            ColorCorrection.TintColor = Color3_fromRGB_ret;
            ColorCorrection.Contrast = 0.2;
            ColorCorrection.Saturation = 0.3;
            ColorCorrection.Brightness = -0.015;
            Bloom2.Intensity = Intensity;
            Bloom2.Size = Size;
            Bloom2.Threshold = Threshold;
            game_Lighting.ExposureCompensation = ExposureCompensation;
        end);
    end;

    task.delay(8, function() -- Line: 42
        -- upvalues: u10 (copy)
        u10:Destroy();
    end);
    VfxManager.Enable(u10.Enables.PillarBeam.Start, true);

    for _, child in u10.Enables.PillarBeam.Start.SSJBeams:GetChildren() do
        if child:IsA("Beam") then
            local Width0 = child.Width0;
            local Width1 = child.Width1;
            child.Width0 = 0;
            child.Width1 = 0;
            TweenService:Create(child, TweenInfo.new(0.125, Enum.EasingStyle.Linear), {
                Width0 = Width0,
                Width1 = Width1
            }):Play();
        end;
    end;

    local v20 = u10.Enables.PillarBeam.Start.CFrame * CFrame.new(85 / (p9.Preview and 10 or 1), 0, 0);
    TweenService:Create(u10.Enables.PillarBeam.End, TweenInfo.new(0.125, Enum.EasingStyle.Linear), {
        CFrame = v20
    }):Play();
    VfxManager.Emit(u10.Emit);
    VfxManager.Enable(u10.Enabling, true);
    task.delay(4, function() -- Line: 227
        -- upvalues: u10 (copy), VfxManager (ref)
        if u10.Parent then
            VfxManager.Enable(u10.Enabling, false);
        end;
    end);
    local PointLight = u10.Emit.Impact.SpotLight.PointLight;
    u10.Emit.Impact.SpotLight.PointLight.Enabled = true;
    TweenService:Create(PointLight, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
        Brightness = 0,
        Range = 60
    }):Play();
    task.wait(0.125);
    local v21, v22, u23;

    if p9.Locker or p9.Preview then
        v21 = nil;
        v22 = nil;
        u23 = nil;
    else
        local Character = Player.Character;
        v22 = Character:FindFirstChild("HumanoidRootPart");
        SfxManager:playSound({
            Sound = "Energy BeamAura",
            Parent = v22
        });
        u23 = script.AuraModel:Clone();
        u23:PivotTo(v22.CFrame);
        local Highlight = Instance.new("Highlight");
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        Highlight.OutlineColor = Color3.new(1, 1, 1);
        Highlight.OutlineTransparency = 0;
        Highlight.FillColor = Color3.new(1, 0, 0);
        Highlight.FillTransparency = 0.5;
        Highlight.Parent = u23;
        u23.Parent = workspace;
        Essentials:Weld(u23.PrimaryPart, v22);
        VfxManager.Enable(u23, true);
        task.delay(3.5, function() -- Line: 42
            -- upvalues: u23 (copy)
            u23:Destroy();
        end);
        v21 = Character:FindFirstChild("Highlight");
        v21.OutlineColor = Color3.fromRGB(255, 255, 255);
        local game_Lighting = game.Lighting;
        local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
        local DepthOfField = game_Lighting.DepthOfField;
        TweenService:Create(DepthOfField, TweenInfo.new(0.355, Enum.EasingStyle.Quint), {
            FarIntensity = 1
        }):Play();
        local ColorCorrection = game_Lighting.ColorCorrection;
        local v24 = TweenService:Create(ColorCorrection, TweenInfo.new(0.067, Enum.EasingStyle.Linear), {
            Brightness = 0.2
        });
        v24:Play();
        v24.Completed:Connect(function() -- Line: 286
            -- upvalues: TweenService (ref), ColorCorrection (copy), DepthOfField (copy), Color3_fromRGB_ret (copy)
            TweenService:Create(ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Quint), {
                Brightness = 0.1,
                Saturation = 0.5,
                TintColor = Color3.fromRGB(169, 196, 255)
            }):Play();
            task.wait(1.2);
            TweenService:Create(DepthOfField, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
                FarIntensity = 0.1
            }):Play();
            TweenService:Create(ColorCorrection, TweenInfo.new(0.567, Enum.EasingStyle.Linear), {
                Brightness = -0.015,
                Saturation = 0.3,
                TintColor = Color3_fromRGB_ret
            }):Play();
        end);
        local Bloom = game_Lighting.Bloom;
        Bloom.Intensity = 2;
        Bloom.Threshold = 0.5;
        TweenService:Create(Bloom, TweenInfo.new(2.5, Enum.EasingStyle.Back), {
            Intensity = 0.2,
            Threshold = 2.35
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 12;
        TweenService:Create(BlurEffect, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        task.delay(0.855, function() -- Line: 42
            -- upvalues: BlurEffect (copy)
            BlurEffect:Destroy();
        end);
    end;

    for _, child in u10.Enables.WindBeamsAndMeshes.WindBeams:GetChildren() do
        if child:IsA("Beam") then
            local Width0 = child.Width0;
            local Width1 = child.Width1;
            child.Width0 = 0;
            child.Width1 = 0;
            TweenService:Create(child, TweenInfo.new(0.125, Enum.EasingStyle.Linear), {
                Width0 = Width0,
                Width1 = Width1
            }):Play();
        end;
    end;

    VfxManager.Enable(u10.Enables, true);
    local u25 = 0;
    local os_clock_ret = os.clock();
    u10.Enables.WindBeamsAndMeshes.Meshes.Twirl.Transparency = 0;
    u10.Enables.WindBeamsAndMeshes.Meshes.Twirl2.Transparency = 0;
    u10.Enables.WindBeamsAndMeshes.Meshes.TwirlingBlack.Transparency = 0.5;
    local u26 = nil;
    u26 = RunService.Heartbeat:Connect(function() -- Line: 326
        -- upvalues: u10 (copy), u26 (ref), u25 (ref), os_clock_ret (copy), TweenService (ref)
        if not u10:FindFirstChild("Enables") then
            u26:Disconnect();

            return;
        end;

        u25 = os.clock() - os_clock_ret;
        local Twirl = u10.Enables.WindBeamsAndMeshes.Meshes.Twirl;
        Twirl.CFrame = Twirl.CFrame * CFrame.Angles(0, 0.17453292519943295, 0);
        local Twirl2 = u10.Enables.WindBeamsAndMeshes.Meshes.Twirl2;
        Twirl2.CFrame = Twirl2.CFrame * CFrame.Angles(0, 0.17453292519943295, 0);
        local TwirlingBlack = u10.Enables.WindBeamsAndMeshes.Meshes.TwirlingBlack;
        TwirlingBlack.CFrame = TwirlingBlack.CFrame * CFrame.Angles(0, 0.17453292519943295, 0);

        if u25 >= 1.5 then
            u26:Disconnect();

            for _, child in pairs(u10.Enables.WindBeamsAndMeshes.Meshes:GetChildren()) do
                if child:IsA("MeshPart") then
                    TweenService:Create(child, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
                        Transparency = 1
                    }):Play();
                end;
            end;
        end;
    end);
    task.wait(1.5);
    VfxManager.Emit(u10.Emits);
    VfxManager.Enable(u10.Enables, false);

    for _, child in u10.Enables.PillarBeam.Start.SSJBeams:GetChildren() do
        if child:IsA("Beam") then
            TweenService:Create(child, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
                Width0 = 0,
                Width1 = 0
            }):Play();
        end;
    end;

    if not (p9.Preview or p9.Locker) then
        if v21 then
            v21.OutlineColor = Color3.fromRGB(0, 0, 0);
        end;

        local u27 = script.AuraEmit:Clone();
        u27.CFrame = v22.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0);
        u27.Parent = workspace;
        task.delay(3, function() -- Line: 42
            -- upvalues: u27 (copy)
            u27:Destroy();
        end);
        VfxManager.Emit(u27);
        VfxManager.Enable(u23, false);
    end;

    Knit.GetController("LightingController"):ResetLighting(0.5);
end;