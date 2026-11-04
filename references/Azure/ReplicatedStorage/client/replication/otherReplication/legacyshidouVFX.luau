 

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("CollectionService");
local Lighting = game:GetService("Lighting");
local SoundService = game:GetService("SoundService");
game:GetService("TextService");
game:GetService("ContentProvider");
game:GetService("StarterGui");
local v1 = {};
local _ = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local Color = Lighting.Atmosphere.Color;
local Density = Lighting.Atmosphere.Density;
local _ = Lighting.Brightness;
local _ = Lighting.ClockTime;
local _ = Lighting.Ambient;
local _ = Lighting.ExposureCompensation;
local _ = Lighting.Bloom.Threshold;
local _ = Lighting.EnvironmentDiffuseScale;
local _ = Lighting.EnvironmentSpecularScale;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local _ = Lighting.Bloom.Threshold;
local raycast = require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.util.Util);
local mainreplication = require(script.Parent.Parent.mainreplication);
require(script.Parent.Parent.TekrinnDialogue);
require(ReplicatedStorage.util.UwUEffects);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);

function v1.legacyshidoushockwave(p2) -- Line: 49
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy), TweenService (copy)
    local v3 = p2.HumanoidRootPart or p2.PrimaryPart;
    mainreplication.bigshockwave(v3);
    local v4 = ReplicatedStorage.Resources.Legacy.shidou.dhEffects:Clone();
    v4.Parent = p2;
    v4:PivotTo(v3.CFrame * CFrame.new(0, 0, -25));
    v4.End.Mesh.Scale = Vector3.new(3.179, 0, 0);
    TweenService:Create(v4.End.Mesh, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Scale = Vector3.new(3.179, 1.072, 1.037)
    }):Play();
    TweenService:Create(v4.End.Decal, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Transparency = 1
    }):Play();
    TweenService:Create(v4.End, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        CFrame = v4.End.CFrame * CFrame.Angles(1.3962634015954636, 0, 0)
    }):Play();
    TweenService:Create(v4.End4, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = Vector3.new(80, 0, 0)
    }):Play();
    TweenService:Create(v4.End3, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = Vector3.new(50, 0, 0)
    }):Play();
    TweenService:Create(v4.End2, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = Vector3.new(80, 0, 0)
    }):Play();
    TweenService:Create(v4.Twirl, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = Vector3.new(15.359, 50, 15.92),
        Transparency = 1,
        CFrame = v4.Twirl.CFrame * CFrame.Angles(0, -0.4174478504920037, 0)
    }):Play();
    task.delay(2, v4.Destroy, v4);
end;

function v1.legacyformlessHit(p5) -- Line: 71
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    mainreplication.Emit(p5.HumanoidRootPart or p5.PrimaryPart, ReplicatedStorage.Resources.Legacy.shidou.normalkick2, 5, CFrame.new(0, 0, -4));
    mainreplication.cameraShake(20, 2, 15);
    mainreplication.fov(false, 120);
    mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 5;
    task.wait(0.05);
    ColorCorrectionEffect.Contrast = -1;
    task.wait(0.05);
    ColorCorrectionEffect.Contrast = -2;
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2), {
        Contrast = 0
    }):Play();
    task.wait(0.5);
    ColorCorrectionEffect:Destroy();
end;

function v1.legacyformless(u6) -- Line: 95
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy), TweenService (copy), Players (copy), Lighting (copy), RunService (copy)
    local u7 = u6.HumanoidRootPart or u6.PrimaryPart;
    mainreplication.Emit(u6.Head, ReplicatedStorage.Resources.Legacy.shidou.eemit, 3);
    task.delay(0.2, function() -- Line: 127
        -- upvalues: ReplicatedStorage (ref), u6 (copy), u7 (copy), TweenService (ref), Players (ref), mainreplication (ref), Lighting (ref), RunService (ref)
        local v8 = ReplicatedStorage.Resources.Legacy.shidou.dhEffects:Clone();
        v8.Parent = u6;
        v8:PivotTo(CFrame.new(u7.Position, u7.Position + u7.CFrame.LookVector) * CFrame.new(0, 5, -10) * CFrame.Angles(0.5235987755982988, 0, 0));
        v8.End.Mesh.Scale = Vector3.new(3.179, 0, 0);
        TweenService:Create(v8.End.Mesh, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Scale = Vector3.new(3.179, 1.072, 1.037)
        }):Play();
        TweenService:Create(v8.End.Decal, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        TweenService:Create(v8.End, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = v8.End.CFrame * CFrame.Angles(1.3962634015954636, 0, 0)
        }):Play();
        TweenService:Create(v8.End4, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(80, 0, 0)
        }):Play();
        TweenService:Create(v8.End3, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(50, 0, 0)
        }):Play();
        TweenService:Create(v8.End2, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(80, 0, 0)
        }):Play();
        TweenService:Create(v8.Twirl, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(15.359, 50, 15.92),
            Transparency = 1,
            CFrame = v8.Twirl.CFrame * CFrame.Angles(0, -0.4174478504920037, 0)
        }):Play();
        task.delay(2, v8.Destroy, v8);
        task.spawn(function() -- Line: 144
            -- upvalues: Players (ref), u7 (ref), mainreplication (ref), Lighting (ref), TweenService (ref)
            if Players.LocalPlayer:DistanceFromCharacter(u7.Position) <= 50 then
                mainreplication.cameraShake(15, 2, 4);
                mainreplication.fov(false, 30);
                mainreplication.fov(true, 70, 0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
                local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
                ColorCorrectionEffect.Parent = Lighting;
                ColorCorrectionEffect.Contrast = 5;
                task.wait(0.05);
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2), {
                    Contrast = 0
                }):Play();
                task.wait(0.2);
                ColorCorrectionEffect:Destroy();
            end;
        end);

        if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u6) then
            return;
        end;

        mainreplication.destroyPosition(u6);
        local BodyPosition = Instance.new("BodyPosition");
        BodyPosition.P = 12500;
        BodyPosition.MaxForce = Vector3.new(30000, 30000, 30000);
        BodyPosition.D = 300;
        BodyPosition.Parent = u7;
        TweenService:Create(BodyPosition, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            P = 2500,
            D = 500
        }):Play();
        local v10 = RunService.PreRender:Connect(function(p9) -- Line: 175
            -- upvalues: BodyPosition (copy), u7 (ref)
            BodyPosition.Position = u7.CFrame.LookVector * 6 + u7.CFrame.UpVector * 3 + u7.Position;
        end);
        task.delay(0.4, v10.Disconnect, v10);
        task.delay(0.4, BodyPosition.Destroy, BodyPosition);
    end);
end;

function v1.legacydragonheader(u11) -- Line: 187
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy), raycast (copy), TweenService (copy), RunService (copy), Players (copy), Lighting (copy)
    local u12 = u11.HumanoidRootPart or u11.PrimaryPart;
    mainreplication.Emit(u11.Head, ReplicatedStorage.Resources.Legacy.shidou.eemit, 3);
    local u13 = ReplicatedStorage.Resources.Legacy.shidou.dhWing:Clone();
    u13.Weld.Part0 = u11.Torso;
    u13.Parent = u11;
    local u14 = nil;
    task.delay(0.4333333333333333, function() -- Line: 223
        -- upvalues: u14 (ref), ReplicatedStorage (ref), u12 (copy), u11 (copy), raycast (ref), TweenService (ref), RunService (ref), u13 (copy), Players (ref), mainreplication (ref), Lighting (ref)
        u14 = ReplicatedStorage.Resources.Legacy.shidou.Gasterblaser:Clone();
        u14.Root.Root.Part0 = u12;
        u14.Parent = u11;
        local v15 = raycast(u12.Position, u12.CFrame.LookVector * 60, nil, { workspace.map, workspace.map.barriar });
        local v16;

        if v15 then
            v16 = CFrame.new(v15.Position, v15.Position + u12.CFrame.LookVector);
        else
            v16 = u12.CFrame + u12.CFrame.LookVector * 60;
        end;

        local u17 = v16 + u12.CFrame.UpVector * 22;
        local v18 = ReplicatedStorage.Resources.Legacy.shidou.dhEffects:Clone();
        v18.Parent = u11;
        v18:PivotTo(CFrame.new(u12.Position, u12.Position + u17.LookVector) * CFrame.new(0, 10, -50) * CFrame.Angles(0.3490658503988659, 0, 0));
        v18.End.Mesh.Scale = Vector3.new(3.179, 0, 0);
        TweenService:Create(v18.End.Mesh, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Scale = Vector3.new(3.179, 1.072, 1.037)
        }):Play();
        TweenService:Create(v18.End.Decal, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        TweenService:Create(v18.End, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = v18.End.CFrame * CFrame.Angles(1.3962634015954636, 0, 0)
        }):Play();
        TweenService:Create(v18.End4, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(80, 0, 0)
        }):Play();
        TweenService:Create(v18.End3, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(50, 0, 0)
        }):Play();
        TweenService:Create(v18.End2, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(80, 0, 0)
        }):Play();
        TweenService:Create(v18.Twirl, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = Vector3.new(15.359, 50, 15.92),
            Transparency = 1,
            CFrame = v18.Twirl.CFrame * CFrame.Angles(0, -0.4174478504920037, 0)
        }):Play();
        task.delay(2, v18.Destroy, v18);
        local u20 = RunService.PreRender:Connect(function(p19) -- Line: 276
            -- upvalues: u12 (ref), u17 (ref)
            u12.CFrame = u12.CFrame:Lerp(u17, p19 * 10);
        end);
        task.delay(0.25, function() -- Line: 282
            -- upvalues: u13 (ref), u20 (ref)
            u13:Destroy();
            u20:Disconnect();
        end);

        for _, descendant in ipairs(u14:GetDescendants()) do
            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(0.5), {
                    Transparency = 1
                }):Play();
            end;
        end;

        if Players.LocalPlayer:DistanceFromCharacter(u12.Position) <= 50 then
            mainreplication.cameraShake(15, 2, 4);
            mainreplication.fov(false, 120);
            mainreplication.fov(true, 70, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Parent = Lighting;
            ColorCorrectionEffect.Contrast = 5;
            task.wait(0.05);
            ColorCorrectionEffect.Contrast = -1;
            task.wait(0.05);
            ColorCorrectionEffect.Contrast = -2;
            TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.2), {
                Contrast = 0
            }):Play();
            task.wait(0.5);
            ColorCorrectionEffect:Destroy();
        end;
    end);
    task.wait(1.5833333730697632);

    if u14 then
        u14:Destroy();
    end;
end;

function v1.legacyshidouawk(p21) -- Line: 322
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), TweenService (copy), mainreplication (copy), PlayerGui (copy), soundUtil (copy), SoundService (copy), Color (copy), Density (copy)
    local v22 = p21.HumanoidRootPart or p21.PrimaryPart;
    local _ = p21.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local v23 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v23.Parent = Lighting;
    v23.TintColor = Color3.fromRGB(255, 163, 247);
    v23.Brightness = -1;
    TweenService:Create(v23, TweenInfo.new(0.15), {
        Brightness = 0
    }):Play();
    task.delay(0.15, v23.Destroy, v23);
    mainreplication.sceneEnabled(true);
    local u24 = ReplicatedStorage.Resources.Legacy.shidou.awkEffects:Clone();
    u24:PivotTo(v22.CFrame);
    u24.Parent = p21;
    local v25 = ReplicatedStorage.Resources.darkscreen:Clone();
    v25.Parent = PlayerGui;
    local v26 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v26.Parent = Lighting;
    v26.FarIntensity = 0;
    TweenService:Create(v26, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.Legacy.shidou.awake_1, SoundService);
    mainreplication.cutscene(v22, CFrame.new(Vector3.new(0, 0, 0)), 4.8, ReplicatedStorage.Resources.Legacy.shidou.awkFOV);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 163, 247);
    ColorCorrectionEffect.Parent = Lighting;
    Atmosphere.Color = Color3.fromRGB(255, 0, 132);
    Atmosphere.Density = 0.7;
    task.delay(0.1666666666666667, function() -- Line: 359
        -- upvalues: u24 (copy)
        for _, descendant in ipairs(u24.slam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.116666666666667, function() -- Line: 366
        -- upvalues: u24 (copy)
        for _, descendant in ipairs(u24.spin:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.683333333333333, function() -- Line: 373
        -- upvalues: ColorCorrectionEffect (copy), Atmosphere (copy), Color (ref), Density (ref), u24 (copy)
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
        Atmosphere.Color = Color;
        Atmosphere.Density = Density;

        for _, descendant in ipairs(u24.line:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(2.85, function() -- Line: 384
        -- upvalues: ColorCorrectionEffect (copy), Atmosphere (copy), u24 (copy)
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 163, 247);
        Atmosphere.Color = Color3.fromRGB(255, 0, 132);
        Atmosphere.Density = 0.7;

        for _, descendant in ipairs(u24.line2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u24.bgAura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.wait(4.8);
    Atmosphere.Color = Color;
    Atmosphere.Density = Density;
    ColorCorrectionEffect:Destroy();
    v25:Destroy();
    v26:Destroy();
    mainreplication.sceneEnabled(false);
    u24:Destroy();
    local v27 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v27.Parent = Lighting;
    v27.Brightness = 1;
    task.wait(0.2);
    TweenService:Create(v27, TweenInfo.new(0.4), {
        Brightness = 0
    }):Play();
    task.delay(0.4, v27.Destroy, v27);
    mainreplication.fov(false, 15);
    mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function v1.legacybigbangdrive(u28) -- Line: 437
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), PlayerGui (copy), TweenService (copy), soundUtil (copy), SoundService (copy), Density (copy), Color (copy), vfxUtil (copy), Debris (copy)
    local u29 = u28.HumanoidRootPart or u28.PrimaryPart;
    local Torso = u28.Torso;
    local Atmosphere = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local u30 = ReplicatedStorage.Resources.Legacy.shidou.allbigbangEffects:Clone();
    u30:PivotTo(u29.CFrame);
    u30.Parent = u28;
    local v31 = ReplicatedStorage.Resources.darkscreen:Clone();
    v31.Parent = PlayerGui;
    local v32 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v32.Parent = Lighting;
    v32.FarIntensity = 0;
    TweenService:Create(v32, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.Legacy.shidou.bigbangdrive, SoundService);
    mainreplication.cutscene(u29, CFrame.new(Vector3.new(0, 0, 0)), 19.816667556762695, ReplicatedStorage.Resources.Legacy.shidou.FOV, true);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.fromRGB(181, 223, 255);
    ColorCorrectionEffect.Parent = Lighting;
    Atmosphere.Color = Color3.fromRGB(121, 122, 145);
    Atmosphere.Density = Density;
    local u33 = nil;
    mainreplication.Emit(Torso, ReplicatedStorage.Resources.Legacy.shidou.shire, 3.433333333333333);
    task.delay(3.433333333333333, function() -- Line: 470
        -- upvalues: Atmosphere (copy), u30 (copy), TweenService (ref), ColorCorrectionEffect (copy), mainreplication (ref), Torso (copy), ReplicatedStorage (ref), u33 (ref), u28 (copy)
        Atmosphere.Color = Color3.fromRGB(115, 93, 145);
        Atmosphere.Density = 0.5;
        u30.win1:Destroy();

        for _, descendant in ipairs(u30.win2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        local v34 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.833333333333334), {
            Brightness = 0.3
        });
        v34:Play();
        task.wait(0.833333333333334);
        v34:Destroy();
        mainreplication.Emit(Torso, ReplicatedStorage.Resources.Legacy.shidou.shire, 6.899999999999997);
        u33 = ReplicatedStorage.Resources.Legacy.shidou.Wing:Clone();
        u33.Weld.Part0 = Torso;
        u33.Parent = u28;

        for _, descendant in ipairs(u33:GetDescendants()) do
            if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;

                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(25);
                else
                    descendant.Width0 = 3;
                    descendant.Width1 = 50;
                    TweenService:Create(descendant, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Width0 = 1,
                        Width1 = 7
                    }):Play();
                end;
            end;
        end;

        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 120, 215);
        ColorCorrectionEffect.Brightness = 0.5;
        ColorCorrectionEffect.Contrast = 15;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Brightness = 0,
            TintColor = Color3.fromRGB(181, 223, 255)
        }):Play();
        task.wait(0.1);
        ColorCorrectionEffect.Contrast = -5;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Contrast = 0
        }):Play();
    end);
    task.delay(3.25, function() -- Line: 520
        -- upvalues: mainreplication (ref), u29 (copy), ReplicatedStorage (ref)
        mainreplication.raycastEffect(u29, ReplicatedStorage.Resources.jumpsmoke, 3);
    end);
    local u35 = nil;
    task.delay(10.33333333333333, function() -- Line: 525
        -- upvalues: u30 (copy), u33 (ref), ColorCorrectionEffect (copy), Atmosphere (copy), u35 (ref), ReplicatedStorage (ref), u28 (copy)
        u30.win2:Destroy();

        if u33 then
            u33:Destroy();
        end;

        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 90, 90);
        Atmosphere.Color = Color3.fromRGB(102, 0, 0);
        Atmosphere.Density = 0.5;

        for _, descendant in ipairs(u30.win3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                descendant:Emit(3);
            end;
        end;

        u30.UFWSkyroom.Size = Vector3.new(60, 60, 60);
        u35 = ReplicatedStorage.Resources.Legacy.shidou.eye:Clone();
        u35.Weld.Part0 = u28.Head;
        u35.Parent = u28;
    end);
    task.delay(12.41666666666667, function() -- Line: 548
        -- upvalues: u35 (ref), u30 (copy), ColorCorrectionEffect (copy), Atmosphere (copy)
        if u35 then
            u35:Destroy();
        end;

        u30.UFWSkyroom:Destroy();
        u30.win3:Destroy();

        for _, descendant in ipairs(u30.AA2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(355);
            end;
        end;

        ColorCorrectionEffect.TintColor = Color3.fromRGB(183, 249, 255);
        Atmosphere.Color = Color3.fromRGB(200, 215, 255);
        Atmosphere.Density = 0.4;
    end);
    task.delay(16.35, function() -- Line: 566
        -- upvalues: u30 (copy), ColorCorrectionEffect (copy), Atmosphere (copy), Color (ref), Density (ref)
        u30.AA2:Destroy();
        ColorCorrectionEffect.Contrast = 0;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
        Atmosphere.Color = Color;
        Atmosphere.Density = Density;
    end);
    task.delay(15.66666666666667, function() -- Line: 575
        -- upvalues: u30 (copy), ColorCorrectionEffect (copy)
        for _, descendant in ipairs(u30.normalkick:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        ColorCorrectionEffect.Contrast = -5;
        task.wait(0.1);
        ColorCorrectionEffect.Contrast = 15;
    end);
    task.delay(16.35, function() -- Line: 586
        -- upvalues: u30 (copy)
        u30.normalkick:Destroy();
    end);
    local u36 = nil;
    task.delay(16.76666666666667, function() -- Line: 591
        -- upvalues: u36 (ref), vfxUtil (ref), u28 (copy), u30 (copy), ColorCorrectionEffect (copy), TweenService (ref)
        u36 = vfxUtil.highlight(u28, {
            Name = "Highlight",
            Enabled = true,
            FillTransparency = 0.550000012,
            OutlineTransparency = 0,
            DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
            FillColor = Color3.new(0.847058892, 0.960784376, 1),
            OutlineColor = Color3.new(1, 0, 0.917647123)
        });

        for _, descendant in ipairs(u30.normalkick2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        ColorCorrectionEffect.Contrast = 15;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            TintColor = Color3.fromRGB(255, 83, 224)
        }):Play();
        task.wait(0.1);
        ColorCorrectionEffect.Contrast = -15;
        task.wait(0.1);
        ColorCorrectionEffect.Contrast = 5;
    end);
    task.delay(17.55, function() -- Line: 617
        -- upvalues: u36 (ref), ColorCorrectionEffect (copy), Atmosphere (copy), Color (ref), Density (ref)
        if u36 then
            u36:Destroy();
        end;

        ColorCorrectionEffect.Contrast = 0;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
        Atmosphere.Color = Color;
        Atmosphere.Density = Density;
    end);
    task.delay(18.36666666666667, function() -- Line: 627
        -- upvalues: ReplicatedStorage (ref), u28 (copy), Debris (ref), ColorCorrectionEffect (copy), TweenService (ref)
        for _, descendant in ipairs(ReplicatedStorage.Resources.Legacy.shidou.bw:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                local v37 = descendant:Clone();
                v37.Parent = u28.Head;
                Debris:AddItem(v37, 1.45000089009602);
            end;
        end;

        ColorCorrectionEffect.TintColor = Color3.fromRGB(240, 35, 255);
        ColorCorrectionEffect.Contrast = 255;
        task.wait(0.1);
        ColorCorrectionEffect.Contrast = 25;
        task.wait(0.05);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Contrast = -3
        }):Play();
    end);
    task.wait(19.816667556762695);
    v31:Destroy();
    ColorCorrectionEffect:Destroy();
    v32:Destroy();
    mainreplication.sceneEnabled(false);
    local v38 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v38.Parent = Lighting;
    v38.Brightness = 1;
    task.wait(0.5);
    TweenService:Create(v38, TweenInfo.new(0.5), {
        Brightness = 0
    }):Play();
    task.delay(0.5, v38.Destroy, v38);
    mainreplication.fov(false, 15);
    mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function v1.legacydragondrive(u39) -- Line: 678
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), TweenService (copy), mainreplication (copy), PlayerGui (copy), soundUtil (copy), SoundService (copy), Color (copy), Density (copy)
    local v40 = u39.HumanoidRootPart or u39.PrimaryPart;
    local Torso = u39.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local v41 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v41.Parent = Lighting;
    v41.Brightness = -1;
    TweenService:Create(v41, TweenInfo.new(0.15), {
        Brightness = 0
    }):Play();
    task.delay(0.15, v41.Destroy, v41);
    mainreplication.sceneEnabled(true);
    local v42 = ReplicatedStorage.Resources.Legacy.shidou.eyeLight:Clone();
    v42.Weld.Part0 = u39.Head;
    v42.Parent = u39;
    local u43 = ReplicatedStorage.Resources.Legacy.shidou.ddEffects:Clone();
    u43:PivotTo(v40.CFrame);
    u43.Parent = u39;
    local v44 = ReplicatedStorage.Resources.darkscreen:Clone();
    v44.Parent = PlayerGui;
    local v45 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v45.Parent = Lighting;
    v45.FarIntensity = 0;
    TweenService:Create(v45, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.Legacy.shidou.ddsound, SoundService);
    mainreplication.cutscene(v40, CFrame.new(Vector3.new(0, 0, 0)), 7.766666666666667, ReplicatedStorage.Resources.Legacy.shidou.ddFOV);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 202, 234);
    ColorCorrectionEffect.Contrast = 0.3;
    ColorCorrectionEffect.Parent = Lighting;
    local u46 = nil;
    task.delay(1.55, function() -- Line: 717
        -- upvalues: u46 (ref), ReplicatedStorage (ref), Torso (copy), u39 (copy), u43 (copy), Atmosphere (copy)
        u46 = ReplicatedStorage.Resources.Legacy.shidou.ddWing:Clone();
        u46.Weld.Part0 = Torso;
        u46.Parent = u39;

        for _, descendant in ipairs(u43.bgAura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        Atmosphere.Color = Color3.fromRGB(179, 126, 168);
        Atmosphere.Density = 0.37;
    end);
    task.delay(0.05, function() -- Line: 732
        -- upvalues: u43 (copy)
        for _, descendant in ipairs(u43.slam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.8833333333333333, function() -- Line: 739
        -- upvalues: u43 (copy)
        for _, descendant in ipairs(u43.jump:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4.95, function() -- Line: 746
        -- upvalues: ReplicatedStorage (ref), u39 (copy), u46 (ref), u43 (copy), ColorCorrectionEffect (copy), TweenService (ref)
        local v47 = ReplicatedStorage.Resources.Legacy.shidou.line:Clone();
        v47.Parent = u39["Right Leg"];
        task.wait(0.3666666666666667);
        v47:Destroy();

        if u46 then
            u46:Destroy();
        end;

        for _, descendant in ipairs(u43.hit1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        ColorCorrectionEffect.Contrast = 67;
        task.wait(0.05);
        ColorCorrectionEffect.Contrast = 15;
        task.wait(0.1);
        ColorCorrectionEffect.Contrast = -5;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5), {
            Contrast = 0.5
        }):Play();
    end);
    task.delay(6.633333333333333, function() -- Line: 772
        -- upvalues: u43 (copy)
        for _, descendant in ipairs(u43.hit2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(7.066666666666667, function() -- Line: 779
        -- upvalues: u43 (copy)
        for _, descendant in ipairs(u43.hit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.wait(7.766666666666667);
    Atmosphere.Color = Color;
    Atmosphere.Density = Density;
    ColorCorrectionEffect:Destroy();
    v42:Destroy();
    v44:Destroy();
    v45:Destroy();
    mainreplication.sceneEnabled(false);
    u43:Destroy();
    local v48 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v48.Parent = Lighting;
    v48.Brightness = 1;
    task.wait(0.2);
    TweenService:Create(v48, TweenInfo.new(0.4), {
        Brightness = 0
    }):Play();
    task.delay(0.4, v48.Destroy, v48);
    mainreplication.fov(false, 15);
    mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

return v1;