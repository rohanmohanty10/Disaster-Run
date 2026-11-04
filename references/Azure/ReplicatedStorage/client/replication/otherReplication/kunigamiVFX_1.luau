 
 

game:GetService("CollectionService");
game:GetService("ContentProvider");
local Debris = game:GetService("Debris");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("ServerStorage");
local SoundService = game:GetService("SoundService");
game:GetService("TextService");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local Color = Lighting.Atmosphere.Color;
local Density = Lighting.Atmosphere.Density;
local Decay = Lighting.Atmosphere.Decay;
local Haze = Lighting.Atmosphere.Haze;
local Glare = Lighting.Atmosphere.Glare;
local Offset = Lighting.Atmosphere.Offset;
local GeographicLatitude = Lighting.GeographicLatitude;
local Brightness = Lighting.Brightness;
local ClockTime = Lighting.ClockTime;
local Ambient = Lighting.Ambient;
local OutdoorAmbient = Lighting.OutdoorAmbient;
local ExposureCompensation = Lighting.ExposureCompensation;
local Threshold = Lighting.Bloom.Threshold;
local _ = Lighting.EnvironmentDiffuseScale;
local _ = Lighting.EnvironmentSpecularScale;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local Threshold2 = Lighting.Bloom.Threshold;
local Intensity = Lighting.Bloom.Intensity;
local Size = Lighting.Bloom.Size;
local MeshEmit2 = require(ReplicatedStorage.MeshEmit2);
local MeshEmitter = require(ReplicatedStorage.client.replication.MeshEmitter);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local Temp = require(ReplicatedStorage.Temp);
local VfxHandler = require(ReplicatedStorage.VfxHandler);
local Welder = require(ReplicatedStorage.Welder);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local xamillmesh = require(script.Parent.aikuVFX.xamillmesh);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local camerasreplication = require(script.Parent.camerasreplication);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local trove = require(ReplicatedStorage.forum.trove);
local Util = require(ReplicatedStorage.util.Util);
local KatUtil = require(ReplicatedStorage.util.KatUtil);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local v1 = {};
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local _ = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local BackgroundHighlight = require(script.Parent.Parent.BackgroundHighlight);

function v1.characterImage(p2) -- Line: 99
    -- upvalues: BackgroundHighlight (copy)
    BackgroundHighlight(p2);
end;

local u3 = {};

local function GetVFX(p4: userdata, p5: userdata, p6: number, p7: boolean) -- Line: 103
    -- upvalues: Debris (copy), u3 (copy)
    local v8 = p5:Clone();
    local v9 = p5.Parent:FindFirstChild(p5:GetAttribute("WeldName") and p5:GetAttribute("WeldName") or p5.Name .. "Weld");

    if v9 then
        local v10 = v9:Clone();
        v10.Parent = v8;
        v10.Part0 = p4;
        v10.Part1 = v8;
    end;

    if p6 then
        Debris:AddItem(v8, p6);
    end;

    if p7 then
        u3[v8.Name] = p5;
    end;

    v8.Parent = p4;

    return v8;
end;

function GrabSavedVFX(p11: string)
    -- upvalues: u3 (copy)
    return u3[p11];
end;

local function CreateVFXTimeline(p12: userdata, p13: table, u14: function, p15: number) -- Line: 126
    -- upvalues: GetVFX (copy)
    for i, v in p13 do
        if u14 and not u14() then
            local v16 = v;
            local v17 = i;

            for _, child in p12:GetChildren() do
                if child.Name == v17 then
                    v16:Destroy();
                end;
            end;

            return;
        end;

        local u18 = GetVFX(p12, i, p15 or 5);

        for _, v2 in v do
            task.delay(v2, function() -- Line: 140
                -- upvalues: u18 (copy), u14 (copy)
                task.spawn(function() -- Line: 141
                    -- upvalues: u18 (ref), u14 (ref)
                    for _, descendant in u18:GetDescendants() do
                        if not u14() then
                            break;
                        end;

                        if descendant:IsA("ParticleEmitter") then
                            descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        end;
                    end;
                end);
            end);
        end;
    end;
end;

local function emit(p19: userdata, p20: boolean?, p21: boolean?) -- Line: 156
    for _, descendant in p19:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            if p20 and not string.find(descendant.Name, "grass") then
                descendant.LockedToPart = true;
            end;

            if descendant:GetAttribute("EmitDelay") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 164
                    -- upvalues: descendant (copy)
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 10);
                end);
            else
                descendant:Emit(descendant:GetAttribute("EmitCount") or 10);
            end;
        end;
    end;
end;

function v1.kunigamilandpush(p22) -- Line: 174
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), RunService (copy)
    local u23 = p22.HumanoidRootPart or p22.PrimaryPart;
    local u24, u25 = mainreplication.bodyVelocity(u23, 110, 0.35, nil, nil, true, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0.5));
    mainreplication.Emit(u23, ReplicatedStorage.Resources.Dashre, 3, CFrame.new(0, 0, -5));
    local u26 = ReplicatedStorage.Resources.rundasheff:Clone();
    u26.main.Weld.Part0 = u23;
    u26.Parent = workspace.Effects;

    if Util.canshiftcolor(LocalPlayer, p22) then
        vfxUtil.LeanTowardsColor(u26, p22:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p22:GetAttribute("CustomAlpha") or 0.985);
    end;

    u26.Air.Size = Vector3.new(4.998, 0.503, 4.998);
    u26.Air.Transparency = 0.8;
    local Air = u26.main.Air;
    Air.C0 = Air.C0 * CFrame.new(0, -15, 0);
    TweenService:Create(u26.main.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
        C0 = u26.main.Air.C0 * CFrame.new(0, 15, 0)
    }):Play();
    TweenService:Create(u26.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
        Size = Vector3.new(17.136, 1.132, 16.878),
        Transparency = 1
    }):Play();
    u26.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
    u26.Wind1.Transparency = 0.9;
    TweenService:Create(u26.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
        Size = Vector3.new(19.108, 11.452, 11.292),
        Transparency = 1
    }):Play();
    task.delay(0.15, function() -- Line: 219
        -- upvalues: u26 (copy), TweenService (ref)
        u26.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
        u26.Wind1.Transparency = 0.9;
        TweenService:Create(u26.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Size = Vector3.new(19.108, 11.452, 11.292),
            Transparency = 1
        }):Play();
    end);
    u26.End.Size = Vector3.new(5, 1, 5);
    u26.End.Transparency = 0.65;
    local End = u26.main.End;
    End.C0 = End.C0 * CFrame.new(0, 0, 0);
    TweenService:Create(u26.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
        C0 = u26.main.End.C0 * CFrame.new(0, -15, 0)
    }):Play();
    TweenService:Create(u26.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
        Size = Vector3.new(12.999, 2.766, 12.999),
        Transparency = 1
    }):Play();
    task.delay(0.15, function() -- Line: 253
        -- upvalues: u26 (copy), TweenService (ref)
        u26.End.Size = Vector3.new(5, 1, 5);
        u26.End.Transparency = 0.65;
        local End2 = u26.main.End;
        End2.C0 = End2.C0 * CFrame.new(0, 15, 0);
        TweenService:Create(u26.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            C0 = u26.main.End.C0 * CFrame.new(0, -15, 0)
        }):Play();
        TweenService:Create(u26.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            Size = Vector3.new(12.999, 2.766, 12.999),
            Transparency = 1
        }):Play();
    end);
    u26.A.Size = Vector3.new(14.29, 4.752, 5.444);
    u26.A.Mesh.Scale = Vector3.new(0.308, 0.158, 0.175);
    u26.main.A.C0 = CFrame.new(-0.077, -0.717, 1) * CFrame.Angles(0.4363323129985824, -1.5707963267948966, 0);
    u26.A.Decal.Transparency = 0.9;
    TweenService:Create(u26.main.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
        C0 = u26.main.A.C0 * CFrame.new(5, 0, 0) * CFrame.Angles(-0.4363323129985824, 0, 0)
    }):Play();
    TweenService:Create(u26.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
        Size = Vector3.new(33.166, 4.752, 5.443)
    }):Play();
    TweenService:Create(u26.A.Mesh, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
        Scale = Vector3.new(0.715, 0.303, 0.315)
    }):Play();
    TweenService:Create(u26.A.Decal, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
        Transparency = 1
    }):Play();
    task.delay(2, u26.Destroy, u26);
    local u27 = nil;
    u27 = RunService.RenderStepped:Connect(function(p28) -- Line: 301
        -- upvalues: u24 (copy), u27 (ref), u23 (copy), u25 (copy)
        if u24 and u24:IsDescendantOf(game) then
            u24.Velocity = u23.CFrame.LookVector * u25.Value;

            return;
        end;

        u27:Disconnect();
    end);
    task.delay(1, u27.Disconnect, u27);
end;

function v1.hitvar1(u29) -- Line: 313
    -- upvalues: ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), Players (copy), mainreplication (copy), Lighting (copy), TweenService (copy)
    local u30 = u29.HumanoidRootPart or u29.PrimaryPart;
    local u31 = ReplicatedStorage.Resources.kunigami.kunicloserangevar:Clone();
    u31.Parent = workspace.Effects;

    if Util.canshiftcolor(LocalPlayer, u29) then
        vfxUtil.LeanTowardsColor(u31, u29:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u29:GetAttribute("CustomAlpha") or 0.985);
    end;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u29) then
        mainreplication.fov(true, 60, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        mainreplication.springcamerashake(10, 20);
        local v32 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v32.Parent = Lighting;
        v32.TintColor = Color3.fromRGB(255, 133, 76);
        v32.Brightness = 0.4;
        v32.Contrast = 1;
        v32.Saturation = -0.5;
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 10;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.533, BlurEffect.Destroy, BlurEffect);
        TweenService:Create(v32, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(v32, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v32.Destroy, v32);
    end;

    local Bashed1 = u31.Bashed1;
    local Bashed2 = u31.Bashed2;
    Bashed1.CFrame = u30.CFrame * CFrame.new(0.884, -0.247, -0.554) * CFrame.Angles(0, 3.141592653589793, -1.5707963267948966);

    for _, descendant in pairs(Bashed1:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
        end;
    end;

    task.delay(0.533, function() -- Line: 357
        -- upvalues: Bashed2 (copy), u30 (copy), Players (ref), u29 (copy), mainreplication (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
        Bashed2.CFrame = u30.CFrame * CFrame.new(0.884, -0.247, -0.554) * CFrame.Angles(0, 3.141592653589793, -1.5707963267948966);

        for _, descendant in pairs(Bashed2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u29) then
            mainreplication.fov(false, 90);
            mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.springcamerashake(20, 30);
            local v33 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v33.Parent = Lighting;
            v33.TintColor = Color3.fromRGB(255, 133, 76);
            v33.Brightness = 0.4;
            v33.Contrast = 1;
            v33.Saturation = -0.5;
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 10;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            TweenService:Create(v33, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            TweenService:Create(v33, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v33.Destroy, v33);
        end;
    end);
    task.delay(5, function() -- Line: 391
        -- upvalues: u31 (copy)
        u31:Destroy();
    end);
end;

function v1.hitvar2(u34) -- Line: 398
    -- upvalues: ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), Players (copy), mainreplication (copy), Lighting (copy), TweenService (copy)
    local u35 = u34.HumanoidRootPart or u34.PrimaryPart;
    local u36 = ReplicatedStorage.Resources.kunigami.kunicloserangevar:Clone();
    u36.Parent = workspace.Effects;
    local u37 = ReplicatedStorage.Resources.kunigami.hitEffects.firsthit:Clone();
    u37.Parent = u35;

    for _, descendant in ipairs(u35.KunyRun:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    if Util.canshiftcolor(LocalPlayer, u34) then
        vfxUtil.LeanTowardsColor(u36, u34:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u34:GetAttribute("CustomAlpha") or 0.985);
    end;

    local KickVariant = u36.KickVariant;
    KickVariant.Parent = u35;
    local Initiate = u36.Initiate;
    Initiate.Parent = u34["Left Leg"];
    local Bashed1 = u36.Bashed1;
    u36.Bashed2.CFrame = u35.CFrame * CFrame.new(0.884, -0.247, -0.554) * CFrame.Angles(0, 3.141592653589793, -1.5707963267948966);
    Bashed1.CFrame = u35.CFrame * CFrame.new(0.884, -0.247, -0.554) * CFrame.Angles(0, 3.141592653589793, -1.5707963267948966);

    for _, descendant in pairs(Bashed1:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
        end;
    end;

    task.delay(0.25, function() -- Line: 433
        -- upvalues: u37 (copy), u35 (copy), Players (ref), u34 (copy), mainreplication (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
        u37.CFrame = u35.CFrame * CFrame.new(0.884, -0.247, -0.554) * CFrame.Angles(0, 3.141592653589793, -1.5707963267948966);

        for _, descendant in pairs(u37:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u34) then
            mainreplication.fov(true, 60, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            mainreplication.springcamerashake(20, 30);
            local v38 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v38.Parent = Lighting;
            v38.TintColor = Color3.fromRGB(255, 133, 76);
            v38.Brightness = 0.4;
            v38.Contrast = 1;
            v38.Saturation = -0.5;
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 10;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            TweenService:Create(v38, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            TweenService:Create(v38, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v38.Destroy, v38);
        end;
    end);
    task.delay(0.533, function() -- Line: 467
        -- upvalues: Initiate (copy)
        for _, descendant in pairs(Initiate:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.7330000000000001, function() -- Line: 475
        -- upvalues: KickVariant (copy), Players (ref), u34 (copy), mainreplication (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
        for _, descendant in pairs(KickVariant:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u34) then
            mainreplication.fov(false, 90);
            mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.springcamerashake(20, 30);
            local v39 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v39.Parent = Lighting;
            v39.TintColor = Color3.fromRGB(255, 133, 76);
            v39.Brightness = 0.4;
            v39.Contrast = 1;
            v39.Saturation = -0.5;
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 10;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            TweenService:Create(v39, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            TweenService:Create(v39, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v39.Destroy, v39);
        end;
    end);
    task.delay(5, function() -- Line: 509
        -- upvalues: u36 (copy), KickVariant (copy), Initiate (copy), u37 (copy)
        u36:Destroy();
        KickVariant:Destroy();
        Initiate:Destroy();
        u37:Destroy();
    end);
end;

function v1.kunigamihit(u40) -- Line: 518
    -- upvalues: ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), Players (copy), mainreplication (copy), Lighting (copy), TweenService (copy)
    local u41 = u40.HumanoidRootPart or u40.PrimaryPart;
    local u42 = ReplicatedStorage.Resources.kunigami.hitEffects:Clone();
    u42.Parent = workspace.Effects;

    if Util.canshiftcolor(LocalPlayer, u40) then
        vfxUtil.LeanTowardsColor(u42, u40:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u40:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in ipairs(u41.KunyRun:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u40) then
        mainreplication.fov(true, 60, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        mainreplication.springcamerashake(20, 30);
        local v43 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v43.Parent = Lighting;
        v43.TintColor = Color3.fromRGB(255, 133, 76);
        v43.Brightness = 0.4;
        v43.Contrast = 1;
        v43.Saturation = -0.5;
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 10;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.6, BlurEffect.Destroy, BlurEffect);
        TweenService:Create(v43, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(v43, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v43.Destroy, v43);
    end;

    local firsthit = u42.firsthit;
    firsthit.CFrame = u41.CFrame * CFrame.new(1.564, 0.281, 0);
    local shiney = u42.shiney;
    shiney.CFrame = u41.CFrame * CFrame.new(0.011, 0.423, 0);
    local lasthit = u42.lasthit;
    task.delay(0.1, function() -- Line: 564
        -- upvalues: mainreplication (ref), firsthit (copy), u41 (copy)
        mainreplication.cameraShake(11, 1, 7);
        firsthit.CFrame = u41.CFrame * CFrame.new(1.564, 0.281, 0);

        for _, descendant in pairs(firsthit.attachment1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.05, function() -- Line: 574
        -- upvalues: shiney (copy), u41 (copy)
        shiney.CFrame = u41.CFrame * CFrame.new(0.011, 0.423, 0);

        for _, descendant in pairs(shiney:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.083, function() -- Line: 583
        -- upvalues: lasthit (copy), u41 (copy)
        lasthit.CFrame = u41.CFrame * CFrame.new(1.675, -0.588, 0) * CFrame.Angles(0, 3.141592653589793, -1.5707963267948966);

        for _, descendant in pairs(lasthit.attachment3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.1, function() -- Line: 592
        -- upvalues: Players (ref), u40 (copy), mainreplication (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref), lasthit (copy)
        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u40) then
            mainreplication.fov(false, 90);
            mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.springcamerashake(20, 30);
            local v44 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v44.Parent = Lighting;
            v44.TintColor = Color3.fromRGB(255, 133, 76);
            v44.Brightness = 0.4;
            v44.Contrast = 1;
            v44.Saturation = -0.5;
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 10;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            TweenService:Create(v44, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            TweenService:Create(v44, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v44.Destroy, v44);
        end;

        for _, descendant in pairs(lasthit.attachment2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(5, function() -- Line: 625
        -- upvalues: u42 (copy)
        u42:Destroy();
    end);
end;

local u45 = { 7.5, 12.5, 15 };

function v1.kunigamicharge(u46, u47, p48) -- Line: 633
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TweenService (copy), u45 (copy), KatUtil (copy), Players (copy)
    local u49 = u46.HumanoidRootPart or u46.PrimaryPart;
    mainreplication.Emit(u49, ReplicatedStorage.Resources.Dashre, 3, CFrame.new(0, 0, -5));
    local u50 = ReplicatedStorage.Resources.rundasheff:Clone();
    u50.main.Weld.Part0 = u49;
    u50.Parent = workspace.Effects;

    if Util.canshiftcolor(LocalPlayer, u46) then
        vfxUtil.LeanTowardsColor(u50, u46:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u46:GetAttribute("CustomAlpha") or 0.985);
    end;

    u50.Air.Size = Vector3.new(4.998, 0.503, 4.998);
    u50.Air.Transparency = 0.8;
    local Air = u50.main.Air;
    Air.C0 = Air.C0 * CFrame.new(0, -15, 0);
    TweenService:Create(u50.main.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
        C0 = u50.main.Air.C0 * CFrame.new(0, 15, 0)
    }):Play();
    TweenService:Create(u50.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
        Size = Vector3.new(17.136, 1.132, 16.878),
        Transparency = 1
    }):Play();
    u50.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
    u50.Wind1.Transparency = 0.9;
    TweenService:Create(u50.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
        Size = Vector3.new(19.108, 11.452, 11.292),
        Transparency = 1
    }):Play();
    task.delay(0.15, function() -- Line: 680
        -- upvalues: u50 (copy), TweenService (ref)
        u50.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
        u50.Wind1.Transparency = 0.9;
        TweenService:Create(u50.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Size = Vector3.new(19.108, 11.452, 11.292),
            Transparency = 1
        }):Play();
    end);
    u50.End.Size = Vector3.new(5, 1, 5);
    u50.End.Transparency = 0.65;
    local End = u50.main.End;
    End.C0 = End.C0 * CFrame.new(0, 0, 0);
    TweenService:Create(u50.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
        C0 = u50.main.End.C0 * CFrame.new(0, -15, 0)
    }):Play();
    TweenService:Create(u50.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
        Size = Vector3.new(12.999, 2.766, 12.999),
        Transparency = 1
    }):Play();
    task.delay(0.15, function() -- Line: 714
        -- upvalues: u50 (copy), TweenService (ref)
        u50.End.Size = Vector3.new(5, 1, 5);
        u50.End.Transparency = 0.65;
        local End2 = u50.main.End;
        End2.C0 = End2.C0 * CFrame.new(0, 15, 0);
        TweenService:Create(u50.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            C0 = u50.main.End.C0 * CFrame.new(0, -15, 0)
        }):Play();
        TweenService:Create(u50.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            Size = Vector3.new(12.999, 2.766, 12.999),
            Transparency = 1
        }):Play();
    end);
    u50.A.Size = Vector3.new(14.29, 4.752, 5.444);
    u50.A.Mesh.Scale = Vector3.new(0.308, 0.158, 0.175);
    u50.main.A.C0 = CFrame.new(-0.077, -0.717, 1) * CFrame.Angles(0.4363323129985824, -1.5707963267948966, 0);
    u50.A.Decal.Transparency = 0.9;
    TweenService:Create(u50.main.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
        C0 = u50.main.A.C0 * CFrame.new(5, 0, 0) * CFrame.Angles(-0.4363323129985824, 0, 0)
    }):Play();
    TweenService:Create(u50.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
        Size = Vector3.new(33.166, 4.752, 5.443)
    }):Play();
    TweenService:Create(u50.A.Mesh, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
        Scale = Vector3.new(0.715, 0.303, 0.315)
    }):Play();
    TweenService:Create(u50.A.Decal, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
        Transparency = 1
    }):Play();
    task.delay(2, u50.Destroy, u50);
    local u51 = ReplicatedStorage.Resources.kunigami.KunyRun:Clone();
    u51.Parent = u49;

    for _, descendant in ipairs(u51:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
            task.delay(1.15, function() -- Line: 766
                -- upvalues: descendant (copy)
                descendant.Enabled = false;
            end);
        end;
    end;

    local u52 = 1 + (u45[p48] or 0) / 90;
    task.delay(1, function() -- Line: 775
        -- upvalues: ReplicatedStorage (ref), u49 (copy), u47 (copy), KatUtil (ref), u46 (copy), mainreplication (ref), u52 (copy)
        local u53 = ReplicatedStorage.Resources.kunigami.slideEffect:Clone();
        u53.Parent = u49;

        for _, descendant in ipairs(u53:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(0.5, function() -- Line: 782
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        if not u47 then
            local v54 = KatUtil.magnitude(u46);
            KatUtil.destroy_all_velocities(u46);
            mainreplication.bodyVelocity(u49, v54 * 1.3 * u52, 0.7, nil, nil, nil, TweenInfo.new(1.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
        end;

        task.delay(3, function() -- Line: 802
            -- upvalues: u53 (copy)
            u53:Destroy();
        end);
    end);
    mainreplication.bodyVelocity(u49, 70 * (u47 and 0.9 or 1.15) * u52, 1.7, true, nil, nil, TweenInfo.new(1.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
    task.delay(3, function() -- Line: 817
        -- upvalues: u51 (copy)
        u51:Destroy();
    end);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u46) then
        mainreplication.cameraShake(10, 1.5, 6);
        mainreplication.fov(false, 90);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    end;
end;

function v1.kunigamiWhiff(p55) -- Line: 827
    -- upvalues: Players (copy), mainreplication (copy), soundUtil (copy), ReplicatedStorage (copy), xamillmesh (copy), emit (copy), Lighting (copy), TweenService (copy)
    local u56 = p55.HumanoidRootPart or p55.PrimaryPart;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p55) then
        mainreplication.fov(true, 81, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        task.delay(0.25, function() -- Line: 832
            -- upvalues: mainreplication (ref)
            mainreplication.cameraShake(25, 0.8, 3, nil);
            mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        end);
    end;

    soundUtil:play(ReplicatedStorage.Resources.kunigami.sounds.grabazure, u56).TimePosition = 0.12;
    mainreplication.bodyVelocity(u56, 70, 0.4, true, nil, nil, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0));
    local u57 = ReplicatedStorage.Resources.kunigami.whiffEffect:Clone();
    local Weld = Instance.new("Weld");
    Weld.Part0 = u56;
    Weld.Part1 = u57;
    Weld.Parent = u57;
    task.delay(0.2, function() -- Line: 857
        -- upvalues: u57 (copy), u56 (copy), xamillmesh (ref), emit (ref)
        u57:PivotTo(u56.CFrame);
        u57.Parent = workspace.Effects;

        for _, descendant in u57:GetDescendants() do
            if descendant:IsA("MeshPart") and descendant.Parent.Name == "Mesh" then
                xamillmesh(descendant);
            end;
        end;

        emit(u57, true);
    end);
    mainreplication.Emit(u56, ReplicatedStorage.Resources.Dashre, 3, CFrame.new(0, 0, -3));
    mainreplication.rockFlakes(u56, 0.3);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p55) then
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 15;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.2, BlurEffect.Destroy, BlurEffect);
        local v58 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v58.Parent = Lighting;
        v58.TintColor = Color3.fromRGB(255, 140, 0);
        v58.Brightness = 0.2;
        v58.Contrast = 0.5;
        v58.Saturation = -0.2;
        TweenService:Create(v58, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(0.8, v58.Destroy, v58);
    end;

    task.delay(2.2, function() -- Line: 893
        -- upvalues: u57 (copy)
        u57:Destroy();
    end);
end;

function v1.kunigamiBankai(p59, p60) -- Line: 898
    -- upvalues: mainreplication (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), Lighting (copy), TweenService (copy), Welder (copy), workspace_CurrentCamera (copy), animationUtil (copy), RunService (copy), Temp (copy)
    local u61 = {};
    mainreplication.sceneEnabled(true);
    soundUtil:play(ReplicatedStorage.Resources.kunigami.bankai["ichigo sfx only"], SoundService);
    local u62 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    u62.Parent = Lighting;
    u62.TintColor = Color3.fromRGB(173, 212, 255);
    u62.Brightness = 0.4;
    u62.Contrast = 1.1;
    u62.Saturation = -0.2;
    u61[#u61 + 1] = u62;
    TweenService:Create(u62, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Brightness = 0.2,
        Contrast = 0.7,
        Saturation = 0.1,
        TintColor = Color3.fromRGB(180, 220, 255)
    }):Play();
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 20;
    BlurEffect.Parent = Lighting;
    u61[#u61 + 1] = BlurEffect;
    TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.5, function() -- Line: 930
        -- upvalues: TweenService (ref), u62 (copy), BlurEffect (copy)
        TweenService:Create(u62, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(BlurEffect, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.2, function() -- Line: 944
            -- upvalues: u62 (ref), BlurEffect (ref)
            u62:Destroy();
            BlurEffect:Destroy();
        end);
    end);
    local bankai = ReplicatedStorage.Resources.kunigami.bankai;
    local u63 = bankai.KuniBankaiVFXPack:Clone();
    u63:PivotTo(p59:GetPivot() * CFrame.new(0.5574843883514404, -2.525045394897461, 0.02512502670288086) * CFrame.Angles(0, 1.5707963267948966, 0));
    Welder:GroupWeld(p59, u63);
    u63.Parent = workspace.Effects;
    u61[#u61 + 1] = u63;
    mainreplication.fov(false, 28);
    local u64 = bankai.Export:Clone();
    u64:PivotTo(p59:GetPivot());
    u64.Parent = workspace.Effects;
    u64.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Resources.CutscenePack.KunigamiBankai.Animation):Play();
    u61[#u61 + 1] = u64;
    local Cam = u64.Cam;
    local CFrame2 = workspace_CurrentCamera.CFrame;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local u66 = game:GetService("RunService").Heartbeat:Connect(function(p65) -- Line: 976
        -- upvalues: u64 (copy), Cam (copy)
        for _, descendant in u64:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = false;
            end;
        end;

        workspace.CurrentCamera.CFrame = Cam.CFrame;
    end);
    animationUtil:loadAnimation(p59, ReplicatedStorage.Resources.CutscenePack.KunigamiBankai.Animation):Play();
    local u67 = bankai.SWORDS:Clone();
    u67:PivotTo(p59:GetPivot());
    u67.Parent = workspace.Effects;
    u67.Humanoid:LoadAnimation(ReplicatedStorage.Resources.CutscenePack.KunigamiBankai.SwordsAnimation):Play();
    local u68 = {};

    local function onFrameReached(p69: number, u70: function) -- Line: 1010
        -- upvalues: RunService (ref), u68 (copy)
        local u71 = tick();
        local u72 = nil;
        local u73 = p69 / 60;
        u72 = RunService.Stepped:Connect(function() -- Line: 1016
            -- upvalues: u71 (copy), u73 (copy), u70 (copy), u72 (ref)
            if u73 < tick() - u71 then
                u70();
                u72:Disconnect();
            end;
        end);
        u68[#u68 + 1] = u72;
    end;

    local function SpinBeams(u74: userdata, u75: any, p76: any) -- Line: 1026
        local TweenService2 = game:GetService("TweenService");
        local RunService2 = game:GetService("RunService");
        local Debris2 = game:GetService("Debris");
        u74.Parent = workspace.Effects;
        local v77 = p76 or u74.CFrame;

        for _, descendant in u74:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
                local u78 = {
                    Width0 = descendant.Width0,
                    Width1 = descendant.Width1,
                    TextureSpeed = descendant.TextureSpeed,
                    Brightness = descendant.Brightness,
                    LightEmission = descendant.LightEmission
                };
                local v79 = TweenService2:Create(descendant, TweenInfo.new(u75.Duration, Enum.EasingStyle[u75.Easing], Enum.EasingDirection[u75.EasingDirection]), u75.Properties);
                v79:Play();
                v79.Completed:Once(function() -- Line: 1058
                    -- upvalues: descendant (copy), u78 (copy)
                    descendant.Enabled = false;

                    for i, v in u78 do
                        descendant[i] = v;
                    end;
                end);
            end;
        end;

        TweenService2:Create(u74, TweenInfo.new(u75.Duration, Enum.EasingStyle[u75.Easing], Enum.EasingDirection[u75.EasingDirection]), {
            Position = (v77 * u75.Offset).Position
        }):Play();
        local u80 = 0;
        local u81 = nil;
        u81 = RunService2.Heartbeat:Connect(function(p82) -- Line: 1081
            -- upvalues: u74 (copy), u75 (copy), u80 (ref), u81 (ref)
            local v83 = u74;
            v83.CFrame = v83.CFrame * CFrame.Angles(0, 0, (math.rad(u75.RotationSpeed)));
            u80 = u80 + p82;

            if u80 > 5 and u81 then
                u81:Disconnect();
            end;
        end);
        Debris2:AddItem(u74, 5);
    end;

    local function u84() -- Line: 1095
        -- upvalues: u63 (copy)
        for _, descendant in ipairs(u63.vfx1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(5, function() -- Line: 1100
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end;

    local u85 = tick();
    local u86 = nil;
    local u87 = 0.21666666666666667;
    u86 = RunService.Stepped:Connect(function() -- Line: 1016
        -- upvalues: u85 (copy), u87 (copy), u84 (copy), u86 (ref)
        if u87 < tick() - u85 then
            u84();
            u86:Disconnect();
        end;
    end);
    u68[#u68 + 1] = u86;

    local function u89() -- Line: 1107
        -- upvalues: u63 (copy), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
        for _, descendant in ipairs(u63.vfx2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(2.5, function() -- Line: 1114
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        local v88 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v88.Parent = Lighting;
        v88.TintColor = Color3.fromRGB(255, 255, 255);
        v88.Brightness = 0.4;
        v88.Contrast = 1;
        v88.Saturation = -0.4;
        TweenService:Create(v88, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v88, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v88.Destroy, v88);
        TweenService:Create(game.Lighting, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            ExposureCompensation = -3
        }):Play();
    end;

    local u90 = tick();
    local u91 = nil;
    local u92 = 5.816666666666666;
    u91 = RunService.Stepped:Connect(function() -- Line: 1016
        -- upvalues: u90 (copy), u92 (copy), u89 (copy), u91 (ref)
        if u92 < tick() - u90 then
            u89();
            u91:Disconnect();
        end;
    end);
    u68[#u68 + 1] = u91;
    local ExposureCompensation2 = game.Lighting.ExposureCompensation;

    local function u94() -- Line: 1151
        -- upvalues: mainreplication (ref), u63 (copy), SpinBeams (copy)
        mainreplication.bright(0.35, 0.2);
        local beam2 = u63.beam2;
        local v93 = game.ReplicatedStorage.Resources.kunigami.bankai.assets.beam2:Clone();
        v93.Parent = workspace.Effects;
        v93.CFrame = beam2.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0);
        SpinBeams(v93, {
            RotationSpeed = 10.5,
            Rotation = true,
            Duration = 2.6,
            Easing = "Linear",
            EasingDirection = "Out",
            Properties = {
                Width0 = 0,
                Width1 = 0
            },
            Offset = CFrame.new(0, 0, 0)
        });
    end;

    local u95 = tick();
    local u96 = nil;
    local u97 = 5.833333333333333;
    u96 = RunService.Stepped:Connect(function() -- Line: 1016
        -- upvalues: u95 (copy), u97 (copy), u94 (copy), u96 (ref)
        if u97 < tick() - u95 then
            u94();
            u96:Disconnect();
        end;
    end);
    u68[#u68 + 1] = u96;

    local function u100() -- Line: 1175
        -- upvalues: u63 (copy), mainreplication (ref), TweenService (ref), ExposureCompensation2 (copy), SpinBeams (copy)
        local vfx2 = u63.vfx2;
        local v98 = game.ReplicatedStorage.Resources.kunigami.bankai.assets.vfx2beams:Clone();
        v98.Parent = workspace.Effects;
        v98.CFrame = vfx2.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0);
        task.spawn(function() -- Line: 1183
            -- upvalues: mainreplication (ref)
            task.wait(0.5);
            local v99 = tick();

            while tick() - v99 < 1 do
                mainreplication.springcamerashake(20, 20);
                mainreplication.bright(math.random() * 0.4, math.random() * 0.4);
                task.wait(math.random() * 0.2);
            end;
        end);
        task.delay(2.3, function() -- Line: 1193
            -- upvalues: TweenService (ref), ExposureCompensation2 (ref)
            TweenService:Create(game.Lighting, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                ExposureCompensation = ExposureCompensation2
            }):Play();
        end);
        SpinBeams(v98, {
            RotationSpeed = 0,
            Rotation = true,
            Duration = 2.8,
            Easing = "Linear",
            EasingDirection = "Out",
            Properties = {
                Width0 = 0,
                Width1 = 0
            },
            Offset = CFrame.new(0, 0, 0)
        });
    end;

    local u101 = tick();
    local u102 = nil;
    local u103 = 5.85;
    u102 = RunService.Stepped:Connect(function() -- Line: 1016
        -- upvalues: u101 (copy), u103 (copy), u100 (copy), u102 (ref)
        if u103 < tick() - u101 then
            u100();
            u102:Disconnect();
        end;
    end);
    u68[#u68 + 1] = u102;

    local function u111() -- Line: 1217
        -- upvalues: u63 (copy), mainreplication (ref)
        local TweenService2 = game:GetService("TweenService");
        local RunService2 = game:GetService("RunService");
        local beamslash1 = u63:WaitForChild("beamslash1");
        local Quad = Enum.EasingStyle.Quad;
        local Out = Enum.EasingDirection.Out;
        mainreplication.ultFlash(1, 1.5);
        (function(u104) -- Line: 1233, Name: playSlashEffect
            -- upvalues: TweenService2 (copy), Quad (copy), Out (copy), RunService2 (copy)
            local CFrame3 = u104.CFrame;
            local u105 = {};

            for _, descendant in ipairs(u104:GetDescendants()) do
                if descendant:IsA("Beam") then
                    u105[descendant] = {
                        Width0 = descendant.Width0,
                        Width1 = descendant.Width1
                    };
                    descendant.Width0 = 0;
                    descendant.Width1 = 0;
                    local v106 = TweenService2:Create(descendant, TweenInfo.new(0.1125, Quad, Out), {
                        Width0 = 4.35,
                        Width1 = 4.35
                    });
                    local u107 = TweenService2:Create(descendant, TweenInfo.new(0.1125, Quad, Out), {
                        Width0 = 0,
                        Width1 = 0
                    });
                    v106:Play();
                    v106.Completed:Connect(function() -- Line: 1264
                        -- upvalues: u107 (copy)
                        u107:Play();
                    end);
                end;
            end;

            local u108 = tick();
            local u109 = nil;
            u109 = RunService2.Heartbeat:Connect(function() -- Line: 1273
                -- upvalues: u108 (copy), u105 (copy), u104 (copy), CFrame3 (copy), u109 (ref)
                local v110 = tick() - u108;

                if v110 < 0.225 then
                    local math_rad_ret = math.rad(180 * (v110 / 0.225));
                    u104.CFrame = CFrame3 * CFrame.Angles(0, math_rad_ret, 0);

                    return;
                end;

                for i, v in pairs(u105) do
                    if i and i.Parent then
                        i.Width0 = v.Width0;
                        i.Width1 = v.Width1;
                    end;
                end;

                u104.CFrame = CFrame3;
                u109:Disconnect();
            end);
        end)(beamslash1);
    end;

    local u112 = tick();
    local u113 = nil;
    local u114 = 9.583333333333334;
    u113 = RunService.Stepped:Connect(function() -- Line: 1016
        -- upvalues: u112 (copy), u114 (copy), u111 (copy), u113 (ref)
        if u114 < tick() - u112 then
            u111();
            u113:Disconnect();
        end;
    end);
    u68[#u68 + 1] = u113;
    task.delay(11.6, function() -- Line: 1301
        -- upvalues: mainreplication (ref), workspace_CurrentCamera (ref), Temp (ref), u61 (copy), Cam (copy), u66 (ref), u67 (copy), CFrame2 (copy)
        mainreplication.fov(false, 70);
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        Temp.ClearTemp(u61);
        Cam:Destroy();
        u66:Disconnect();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(0.8, 0.8);
        u67:Destroy();
        task.defer(function() -- Line: 1312
            -- upvalues: workspace_CurrentCamera (ref), CFrame2 (ref)
            workspace_CurrentCamera.CFrame = CFrame2;
        end);
    end);
end;

function v1.leftyshotult(u115, p116) -- Line: 1318
    -- upvalues: soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), LocalPlayer (copy), actionUtil (copy), mainreplication (copy), VfxHandler (copy), Welder (copy), Util (copy), vfxUtil (copy), RunService (copy), MeshEmitter (copy), TekrinnDialogue (copy), Temp (copy)
    local HumanoidRootPart = u115.HumanoidRootPart;
    local _ = u115.Humanoid;
    local u117 = soundUtil:play(ReplicatedStorage.Resources.kunigami.kunigami_lefty, SoundService, {
        Character = u115
    });
    local Character = LocalPlayer.Character;

    if actionUtil.checkGK(Character) and not actionUtil.checksameTeam(Character, u115) then
        return;
    end;

    local u118 = {};
    mainreplication.sceneEnabled(true);
    local v119, _ = VfxHandler.PlayCutsceneLite(u115, ReplicatedStorage.Resources.CutscenePack.LeftyShot, nil, CFrame.new(0, 3, 0));
    local u120 = ReplicatedStorage.Resources.kunigami.LeftyShotPack:Clone();
    Welder:GroupWeld(u115, u120);
    u120.Parent = workspace.Effects;
    u118[#u118 + 1] = u120;
    local u121 = ReplicatedStorage.Resources.kunigami.Test1:Clone();
    u121:PivotTo(HumanoidRootPart.CFrame);
    u121.Parent = workspace.Effects;
    u118[#u118 + 1] = u121;

    if Util.canshiftcolor(LocalPlayer, u115) then
        vfxUtil.LeanTowardsColor({ u121, u120 }, u115:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u115:GetAttribute("CustomAlpha") or 0.985);
    end;

    u118[#u118 + 1] = RunService.RenderStepped:Connect(function() -- Line: 1355
        -- upvalues: u121 (copy), HumanoidRootPart (copy)
        u121:PivotTo(HumanoidRootPart.CFrame);
    end);
    local v122 = MeshEmitter.StartMeshEmitter(HumanoidRootPart, ReplicatedStorage.Resources.kunigami["Shot MeshEmitter"], nil, 20);
    u118[#u118 + 1] = v122;
    local HighlightBall = v122.HighlightBall;
    HighlightBall.Parent = u115.Ball;
    u118[#u118 + 1] = HighlightBall;
    local PointLightBall = v122.PointLightBall;
    PointLightBall.Parent = u115.Ball;
    u118[#u118 + 1] = PointLightBall;
    VfxHandler.CutsceneVictim(u115, p116, nil, ReplicatedStorage.Resources.kunigami.LeftyshotVictim, u118);
    VfxHandler.HideCharacters({ u115 }, u120);
    u118[#u118 + 1] = task.delay(0.85, function() -- Line: 1381
        -- upvalues: u120 (copy)
        for _, descendant in pairs(u120.Kunigami.HumanoidRootPart["1"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u120.Kunigami.Ball.e1:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    u118[#u118 + 1] = task.delay(0.8666666666666667, function() -- Line: 1394
        -- upvalues: ReplicatedStorage (ref), u121 (copy)
        local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
        local MeshEmit = require(ReplicatedStorage.MeshEmit);
        local flipbookmesh = require(ReplicatedStorage2:WaitForChild("flipbookmesh"));

        for _, descendant in u121.Test1:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, false, true, flipbookmesh, 0.05);
            end;
        end;
    end);
    u118[#u118 + 1] = task.delay(0.8833333333333333, function() -- Line: 1417
        -- upvalues: ReplicatedStorage (ref), u121 (copy)
        local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
        local MeshEmit = require(ReplicatedStorage.MeshEmit);
        local flipbookmesh = require(ReplicatedStorage2:WaitForChild("flipbookmesh"));

        for _, descendant in u121.Test2:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, false, true, flipbookmesh, 0.05);
            end;
        end;
    end);
    u118[#u118 + 1] = task.delay(0.9, function() -- Line: 1439
        -- upvalues: ReplicatedStorage (ref), u121 (copy)
        local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
        local MeshEmit = require(ReplicatedStorage.MeshEmit);
        local flipbookmesh = require(ReplicatedStorage2:WaitForChild("flipbookmesh"));

        for _, descendant in u121.Test3:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, false, true, flipbookmesh, 0.06);
            end;
        end;
    end);
    u118[#u118 + 1] = task.delay(0.9166666666666666, function() -- Line: 1461
        -- upvalues: ReplicatedStorage (ref), u121 (copy)
        local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
        local MeshEmit = require(ReplicatedStorage.MeshEmit);
        local flipbookmesh = require(ReplicatedStorage2:WaitForChild("flipbookmesh"));

        for _, descendant in u121.Test4:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, false, true, flipbookmesh, 0.05);
            end;
        end;
    end);
    u118[#u118 + 1] = task.delay(2.7666666666666666, function() -- Line: 1483
        -- upvalues: u120 (copy)
        for _, descendant in pairs(u120.Kunigami.HumanoidRootPart["2"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    u118[#u118 + 1] = task.delay(3.55, function() -- Line: 1490
        -- upvalues: u120 (copy)
        for _, descendant in pairs(u120.Kunigami.HumanoidRootPart["3"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    u118[#u118 + 1] = task.delay(6.5, function() -- Line: 1497
        -- upvalues: u120 (copy)
        for _, descendant in pairs(u120.Kunigami.HumanoidRootPart["4"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u120.Kunigami.Ball.e2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u120.ambience:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u120.ambience:GetDescendants()) do
            if descendant.ClassName == "Beam" then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u120.ambience:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    u118[#u118 + 1] = task.delay(7.883333333333334, function() -- Line: 1530
        -- upvalues: u120 (copy)
        for _, descendant in pairs(u120.ambience:GetDescendants()) do
            if descendant.ClassName == "Beam" then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u120.ambience:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u120.Kunigami.Ball.e2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    u118[#u118 + 1] = task.delay(8.15, function() -- Line: 1551
        -- upvalues: u120 (copy)
        for _, descendant in pairs(u120.Kunigami.HumanoidRootPart["5"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u120.Kunigami.Ball.e3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    u118[#u118 + 1] = task.delay(8.716666666666667, function() -- Line: 1564
        -- upvalues: u120 (copy)
        for _, descendant in pairs(u120.Kunigami.HumanoidRootPart["6"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u120.Kunigami.Ball.e3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    u118[#u118 + 1] = task.delay(8.733333333333333, function() -- Line: 1577
        -- upvalues: ReplicatedStorage (ref), u121 (copy)
        local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
        local MeshEmit = require(ReplicatedStorage.MeshEmit);
        local flipbookmesh = require(ReplicatedStorage2:WaitForChild("flipbookmesh"));

        for _, descendant in u121.Test21:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, false, true, flipbookmesh, 0.02);
            end;
        end;
    end);
    u118[#u118 + 1] = task.delay(8.75, function() -- Line: 1599
        -- upvalues: ReplicatedStorage (ref), u121 (copy)
        local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
        local MeshEmit = require(ReplicatedStorage.MeshEmit);
        local flipbookmesh = require(ReplicatedStorage2:WaitForChild("flipbookmesh"));

        for _, descendant in u121.Test22:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, false, true, flipbookmesh, 0.02);
            end;
        end;
    end);
    u118[#u118 + 1] = task.delay(8.766666666666667, function() -- Line: 1621
        -- upvalues: ReplicatedStorage (ref), u121 (copy)
        local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
        local MeshEmit = require(ReplicatedStorage.MeshEmit);
        local flipbookmesh = require(ReplicatedStorage2:WaitForChild("flipbookmesh"));

        for _, descendant in u121.Test23:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, false, true, flipbookmesh, 0.06);
            end;
        end;
    end);
    u118[#u118 + 1] = task.delay(1, function() -- Line: 1644
        -- upvalues: TekrinnDialogue (ref), u115 (copy), u117 (copy)
        TekrinnDialogue.Speak(u115, {
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Text = u117.Name == "Dub" and "There\'s a shot! Outside of my 28-meter range." or "A shot from outside my 28-meter range.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1.5);
    end);
    u118[#u118 + 1] = task.delay(2.45, function() -- Line: 1670
        -- upvalues: TekrinnDialogue (ref), u115 (copy)
        TekrinnDialogue.Speak(u115, {
            {
                Text = "Zeroing in on the sweet spot for a full power...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 2);
    end);
    u118[#u118 + 1] = task.delay(5.25, function() -- Line: 1698
        -- upvalues: TekrinnDialogue (ref), u115 (copy)
        TekrinnDialogue.Speak(u115, {
            {
                Text = "... technical shot",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 50)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                }
            }
        }, 1.3);
    end);
    u118[#u118 + 1] = task.delay(6.55, function() -- Line: 1726
        -- upvalues: TekrinnDialogue (ref), u115 (copy), u117 (copy)
        TekrinnDialogue.Speak(u115, {
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.02,
                Text = u117.Name == "Dub" and "That\'s what a " or "If I were a ",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Text = "superhero ",
                Bold = false,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 50)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.02,
                Text = u117.Name == "Dub" and "would do!" or "",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            }
        }, 2.1);
    end);
    u118[#u118 + 1] = task.delay(8.45, function() -- Line: 1797
        -- upvalues: TekrinnDialogue (ref), u115 (copy), u117 (copy)
        TekrinnDialogue.Speak(u115, {
            {
                Bold = true,
                Italic = false,
                TypeSpeed = 0.01,
                Text = u117.Name == "Dub" and "BLAST OFF!" or "THATS WHAT I\'D DO!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 50)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                }
            }
        }, 1);
    end);
    local u123 = ReplicatedStorage.Resources.kunigami.LeftyImpactFrame:Clone();
    u123.Parent = game.Players.LocalPlayer.PlayerGui;
    u118[#u118 + 1] = u123;
    u118[#u118 + 1] = task.delay(8.3, function() -- Line: 1829
        -- upvalues: u123 (copy), u118 (copy)
        local RunService2 = game:GetService("RunService");
        local TweenService2 = game:GetService("TweenService");
        local CanvasGroup = u123.CanvasGroup;
        local Children = CanvasGroup:GetChildren();
        local os_clock_ret = os.clock();
        local u124 = nil;
        local u125 = 0.999;
        u124 = RunService2.RenderStepped:Connect(function(p126) -- Line: 1844
            -- upvalues: os_clock_ret (copy), CanvasGroup (copy), Children (copy), u124 (ref), TweenService2 (copy), u125 (ref)
            local v127 = (os.clock() - os_clock_ret) * 24;
            local v128 = CanvasGroup:FindFirstChild((math.ceil(v127)));

            if not v128 or v128.Name == #Children then
                u124:Disconnect();
                TweenService2:Create(CanvasGroup[#Children], TweenInfo.new(0.1), {
                    ImageTransparency = 1
                }):Play();

                return;
            end;

            for _, v in pairs(Children) do
                if v:IsA("ImageLabel") then
                    v.ImageTransparency = 0.999;
                end;
            end;

            u125 = u125 - p126 / 0.1;
            v128.ImageTransparency = u125;
        end);
        u118[#u118 + 1] = u124;
    end);
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    vfxUtil.cutscene_ball(true);
    v119.Event:Connect(function() -- Line: 1870
        -- upvalues: vfxUtil (ref), ScreenDimmer (copy), Temp (ref), u118 (copy), mainreplication (ref)
        vfxUtil.cutscene_ball(false);
        ScreenDimmer:Destroy();
        Temp.ClearTemp(u118);
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
    end);
end;

function v1.getsugaTensho(p129, p130) -- Line: 1879
    -- upvalues: actionUtil (copy), LocalPlayer (copy), ReplicatedStorage (copy), mainreplication (copy), Lighting (copy), TweenService (copy), workspace_CurrentCamera (copy), RunService (copy), Temp (copy)
    local u131 = {};

    if actionUtil.checkGK(LocalPlayer.Character) then
        return;
    end;

    local getsuga = ReplicatedStorage.Resources.kunigami.getsuga;
    mainreplication.sceneEnabled(true);
    task.delay(0.5, function(p132, p133) -- Line: 1891, Name: cc
        -- upvalues: ReplicatedStorage (ref), Lighting (ref), u131 (copy), TweenService (ref), mainreplication (ref)
        local u134 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        u134.Parent = Lighting;
        u134.TintColor = p132 or Color3.fromRGB(255, 100, 100);
        u134.Brightness = 0.3;
        u134.Contrast = 1.2;
        u134.Saturation = p133 or -0.3;
        u131[#u131 + 1] = u134;
        TweenService:Create(u134, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Brightness = 0.1,
            Contrast = 0.8,
            TintColor = p132 or Color3.fromRGB(200, 50, 50)
        }):Play();
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 15;
        BlurEffect.Parent = Lighting;
        u131[#u131 + 1] = BlurEffect;
        TweenService:Create(BlurEffect, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.3, function() -- Line: 1917
            -- upvalues: mainreplication (ref), u134 (copy)
            mainreplication.bright(0.15, 0.16, Color3.fromRGB(255, 255, 255));
            u134:Destroy();
        end);
    end);
    task.delay(1.1, function() -- Line: 1924
        -- upvalues: mainreplication (ref)
        mainreplication.ultFlash(0.5, 0.5);
    end);
    mainreplication.fov(false, 30);
    local u135 = getsuga.Export:Clone();
    u135:PivotTo(p129:GetPivot());
    u135.Parent = workspace.Effects;
    local v136 = u135.Humanoid.Animator:LoadAnimation(getsuga.camball);
    v136:Play();
    v136.Looped = false;
    u131[#u131 + 1] = u135;
    local Cam = u135.Cam;
    local CFrame2 = workspace_CurrentCamera.CFrame;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local u138 = game:GetService("RunService").Heartbeat:Connect(function(p137) -- Line: 1942
        -- upvalues: u135 (copy), Cam (copy)
        for _, descendant in u135:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = false;
            end;
        end;

        workspace.CurrentCamera.CFrame = Cam.CFrame;
    end);
    local v139 = p129.Humanoid.Animator:LoadAnimation(getsuga.getsuga);
    v139:Play();
    v139.Looped = false;
    local u140 = getsuga.SWORDS:Clone();
    u140:PivotTo(p129:GetPivot());
    u140.Parent = workspace.Effects;
    local v141 = u140.Humanoid:LoadAnimation(getsuga.SwordsAnimation);
    v141:Play();
    v141.Looped = false;
    local u142 = {};

    local function _(p143: number, u144: function) -- Line: 1966
        -- upvalues: RunService (ref), u142 (copy)
        local u145 = tick();
        local u146 = nil;
        local u147 = p143 / 60;
        u146 = RunService.Stepped:Connect(function() -- Line: 1972
            -- upvalues: u145 (copy), u147 (copy), u144 (copy), u146 (ref)
            if u147 < tick() - u145 then
                u144();
                u146:Disconnect();
            end;
        end);
        u142[#u142 + 1] = u146;
    end;

    local EffectUtility = require(ReplicatedStorage.EffectUtility);
    local u148 = {
        "rbxassetid://92751618469180",
        "rbxassetid://75561386889452",
        "rbxassetid://129218886307405",
        "rbxassetid://139774802056686",
        "rbxassetid://130723564607560",
        "rbxassetid://89432418800256",
        "rbxassetid://139036132365109",
        "rbxassetid://96564762170891",
        "rbxassetid://100019427852586",
        "rbxassetid://75116780633475",
        "rbxassetid://120963108625816",
        "rbxassetid://104241218705071",
        "rbxassetid://73039714550050",
        "rbxassetid://108642127309386",
        "rbxassetid://73581423929932",
        "rbxassetid://106678297636016",
        "rbxassetid://80480012805635",
        "rbxassetid://106678297636016",
        "rbxassetid://85416158136914",
        "rbxassetid://90720061837187",
        "rbxassetid://131874536009400",
        "rbxassetid://128050901564168",
        "rbxassetid://123738473042993",
        "rbxassetid://93395452969957",
        "rbxassetid://108438010049709",
        "rbxassetid://86880787551913",
        "rbxassetid://135757280672682",
        "rbxassetid://77262735634742",
        "rbxassetid://100308980828687",
        "rbxassetid://128843703964023",
        "rbxassetid://123463142993562",
        "rbxassetid://104719193538021"
    };
    local MeshEmit22 = require(ReplicatedStorage.MeshEmit2);
    local u149 = getsuga.VFX:Clone();
    u149:PivotTo(u135:GetPivot() * CFrame.new(-0.045366883277893066, 3.1875734329223633, -0.7394618988037109));
    u149.Parent = workspace.Effects;
    local u150 = getsuga.Test1:Clone();
    u150:PivotTo(u135:GetPivot() * CFrame.new(-1.1401913166046143, 2.3569841384887695, -0.4389241337776184) * CFrame.Angles(0.022078415037728265, 2.98248843897799, 0.05201081170943102));
    u150.Parent = workspace.Effects;
    local u151 = getsuga.Test2:Clone();
    u151:PivotTo(u135:GetPivot() * CFrame.new(
        -0.602405787,
        2.09626818,
        -9.0100956,
        -0.826606989,
        0.542960286,
        0.148047686,
        -0.157085538,
        0.0300074406,
        -0.987128437,
        -0.540413558,
        -0.839225054,
        0.0604843423
    ));
    u151.Parent = workspace.Effects;
    local u152 = nil;

    local function u153() -- Line: 2053
        -- upvalues: u152 (ref), getsuga (copy), u135 (copy)
        u152 = getsuga.speedline:Clone();
        u152:PivotTo(u135:GetPivot() * CFrame.new(
            -3.29986763,
            10.7441826,
            2.366745,
            -0.287746251,
            0,
            0.95770669,
            0,
            1,
            0,
            -0.95770669,
            0,
            -0.287746251
        ));
        u152.Parent = workspace.Effects;
    end;

    local u154 = tick();
    local u155 = nil;
    local u156 = 2.6666666666666665;
    u155 = RunService.Stepped:Connect(function() -- Line: 1972
        -- upvalues: u154 (copy), u156 (copy), u153 (copy), u155 (ref)
        if u156 < tick() - u154 then
            u153();
            u155:Disconnect();
        end;
    end);
    u142[#u142 + 1] = u155;

    local function u157() -- Line: 2075
        -- upvalues: u152 (ref)
        if u152 then
            u152:Destroy();
            u152 = nil;
        end;
    end;

    local u158 = tick();
    local u159 = nil;
    local u160 = 3.4;
    u159 = RunService.Stepped:Connect(function() -- Line: 1972
        -- upvalues: u158 (copy), u160 (copy), u157 (copy), u159 (ref)
        if u160 < tick() - u158 then
            u157();
            u159:Disconnect();
        end;
    end);
    u142[#u142 + 1] = u159;

    local function u162() -- Line: 2082
        -- upvalues: ReplicatedStorage (ref), Lighting (ref), u131 (copy)
        local u161 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        u161.Parent = Lighting;
        u161.TintColor = Color3.fromRGB(255, 255, 255);
        u161.Brightness = 0;
        u161.Contrast = 1.2;
        u161.Saturation = -1;
        u131[#u131 + 1] = u161;
        task.delay(0.5, function() -- Line: 2091
            -- upvalues: u161 (copy)
            u161:Destroy();
        end);
    end;

    local u163 = tick();
    local u164 = nil;
    local u165 = 3.5;
    u164 = RunService.Stepped:Connect(function() -- Line: 1972
        -- upvalues: u163 (copy), u165 (copy), u162 (copy), u164 (ref)
        if u165 < tick() - u163 then
            u162();
            u164:Disconnect();
        end;
    end);
    u142[#u142 + 1] = u164;

    local function u166() -- Line: 2096
        -- upvalues: u149 (copy), EffectUtility (copy), u150 (copy), MeshEmit22 (copy), u148 (copy)
        EffectUtility.EmitAttachment(u149["1"]);

        for _, descendant in u150.Test1:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit22(descendant, false, true, u148, 0.01);
            end;
        end;
    end;

    local u167 = tick();
    local u168 = nil;
    local u169 = 0.6333333333333333;
    u168 = RunService.Stepped:Connect(function() -- Line: 1972
        -- upvalues: u167 (copy), u169 (copy), u166 (copy), u168 (ref)
        if u169 < tick() - u167 then
            u166();
            u168:Disconnect();
        end;
    end);
    u142[#u142 + 1] = u168;

    local function u170() -- Line: 2117
        -- upvalues: u150 (copy), MeshEmit22 (copy), u148 (copy)
        for _, descendant in u150:Clone().Test2:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit22(descendant, false, true, u148, 0.02);
            end;
        end;
    end;

    local u171 = tick();
    local u172 = nil;
    local u173 = 0.6666666666666666;
    u172 = RunService.Stepped:Connect(function() -- Line: 1972
        -- upvalues: u171 (copy), u173 (copy), u170 (copy), u172 (ref)
        if u173 < tick() - u171 then
            u170();
            u172:Disconnect();
        end;
    end);
    u142[#u142 + 1] = u172;

    local function u174() -- Line: 2133
        -- upvalues: u150 (copy), MeshEmit22 (copy), u148 (copy)
        for _, descendant in u150.Test2:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit22(descendant, false, true, u148, 0.02);
            end;
        end;
    end;

    local u175 = tick();
    local u176 = nil;
    local u177 = 0.6833333333333333;
    u176 = RunService.Stepped:Connect(function() -- Line: 1972
        -- upvalues: u175 (copy), u177 (copy), u174 (copy), u176 (ref)
        if u177 < tick() - u175 then
            u174();
            u176:Disconnect();
        end;
    end);
    u142[#u142 + 1] = u176;

    local function u178() -- Line: 2149
        -- upvalues: u150 (copy), MeshEmit22 (copy), u148 (copy)
        for _, descendant in u150.Test4:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit22(descendant, false, true, u148, 0.02);
            end;
        end;
    end;

    local u179 = tick();
    local u180 = nil;
    local u181 = 0.7;
    u180 = RunService.Stepped:Connect(function() -- Line: 1972
        -- upvalues: u179 (copy), u181 (copy), u178 (copy), u180 (ref)
        if u181 < tick() - u179 then
            u178();
            u180:Disconnect();
        end;
    end);
    u142[#u142 + 1] = u180;

    local function u183() -- Line: 2165
        -- upvalues: mainreplication (ref), u149 (copy), EffectUtility (copy), u135 (copy)
        mainreplication.bright(0.35, 0.2);
        local v182 = u149["2"];
        EffectUtility.EmitAttachment(v182);
        EffectUtility.EmitAttachment(v182);
        EffectUtility.EmitAttachment(v182);
        EffectUtility.ToggleAttachment(v182, true, 0.5);
        EffectUtility.EmitAttachment(v182);

        for _, descendant in pairs(u135.Ball.trailholder:GetDescendants()) do
            if descendant.ClassName == "Trail" then
                descendant.Enabled = true;
            end;
        end;
    end;

    local u184 = tick();
    local u185 = nil;
    local u186 = 1.1833333333333333;
    u185 = RunService.Stepped:Connect(function() -- Line: 1972
        -- upvalues: u184 (copy), u186 (copy), u183 (copy), u185 (ref)
        if u186 < tick() - u184 then
            u183();
            u185:Disconnect();
        end;
    end);
    u142[#u142 + 1] = u185;

    local function u187() -- Line: 2189
        -- upvalues: u151 (copy), MeshEmit22 (copy), u148 (copy)
        for _, descendant in u151.Test1:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit22(descendant, false, true, u148, 0.01);
            end;
        end;
    end;

    local u188 = tick();
    local u189 = nil;
    local u190 = 4.25;
    u189 = RunService.Stepped:Connect(function() -- Line: 1972
        -- upvalues: u188 (copy), u190 (copy), u187 (copy), u189 (ref)
        if u190 < tick() - u188 then
            u187();
            u189:Disconnect();
        end;
    end);
    u142[#u142 + 1] = u189;

    local function u191() -- Line: 2205
        -- upvalues: u151 (copy), MeshEmit22 (copy), u148 (copy)
        for _, descendant in u151.Test2:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit22(descendant, false, true, u148, 0.02);
            end;
        end;
    end;

    local u192 = tick();
    local u193 = nil;
    local u194 = 4.266666666666667;
    u193 = RunService.Stepped:Connect(function() -- Line: 1972
        -- upvalues: u192 (copy), u194 (copy), u191 (copy), u193 (ref)
        if u194 < tick() - u192 then
            u191();
            u193:Disconnect();
        end;
    end);
    u142[#u142 + 1] = u193;

    local function u195() -- Line: 2221
        -- upvalues: u151 (copy), MeshEmit22 (copy), u148 (copy)
        for _, descendant in u151.Test2:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit22(descendant, false, true, u148, 0.02);
            end;
        end;
    end;

    local u196 = tick();
    local u197 = nil;
    local u198 = 4.283333333333333;
    u197 = RunService.Stepped:Connect(function() -- Line: 1972
        -- upvalues: u196 (copy), u198 (copy), u195 (copy), u197 (ref)
        if u198 < tick() - u196 then
            u195();
            u197:Disconnect();
        end;
    end);
    u142[#u142 + 1] = u197;

    local function u199() -- Line: 2237
        -- upvalues: u151 (copy), MeshEmit22 (copy), u148 (copy)
        for _, descendant in u151.Test4:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit22(descendant, false, true, u148, 0.02);
            end;
        end;
    end;

    local u200 = tick();
    local u201 = nil;
    local u202 = 4.3;
    u201 = RunService.Stepped:Connect(function() -- Line: 1972
        -- upvalues: u200 (copy), u202 (copy), u199 (copy), u201 (ref)
        if u202 < tick() - u200 then
            u199();
            u201:Disconnect();
        end;
    end);
    u142[#u142 + 1] = u201;

    local function u203() -- Line: 2253
        -- upvalues: u135 (copy)
        for _, descendant in pairs(u135.Ball.trailholder:GetDescendants()) do
            if descendant.ClassName == "Trail" then
                descendant.Enabled = false;
            end;
        end;
    end;

    local u204 = tick();
    local u205 = nil;
    local u206 = 4.583333333333333;
    u205 = RunService.Stepped:Connect(function() -- Line: 1972
        -- upvalues: u204 (copy), u206 (copy), u203 (copy), u205 (ref)
        if u206 < tick() - u204 then
            u203();
            u205:Disconnect();
        end;
    end);
    u142[#u142 + 1] = u205;

    local function u209() -- Line: 2263
        -- upvalues: ReplicatedStorage (ref), Lighting (ref), u149 (copy), EffectUtility (copy)
        local u207 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        u207.Parent = Lighting;
        u207.TintColor = Color3.fromRGB(255, 255, 255);
        u207.Brightness = 1.5;
        u207.Contrast = -5;
        u207.Saturation = -1;
        task.delay(0.05, function() -- Line: 2271
            -- upvalues: u207 (copy)
            u207:Destroy();
        end);
        local v208 = u149["3"];
        EffectUtility.EmitAttachment(v208);
        EffectUtility.ToggleAttachment(v208, true, 0.5);
    end;

    local u210 = tick();
    local u211 = nil;
    local u212 = 3.5;
    u211 = RunService.Stepped:Connect(function() -- Line: 1972
        -- upvalues: u210 (copy), u212 (copy), u209 (copy), u211 (ref)
        if u212 < tick() - u210 then
            u209();
            u211:Disconnect();
        end;
    end);
    u142[#u142 + 1] = u211;

    local function u213() -- Line: 2281
        -- upvalues: u150 (copy), MeshEmit22 (copy), u148 (copy)
        for _, descendant in u150.Test1:GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit22(descendant, false, true, u148, 0.01);
            end;
        end;
    end;

    local u214 = tick();
    local u215 = nil;
    local u216 = 0.65;
    u215 = RunService.Stepped:Connect(function() -- Line: 1972
        -- upvalues: u214 (copy), u216 (copy), u213 (copy), u215 (ref)
        if u216 < tick() - u214 then
            u213();
            u215:Disconnect();
        end;
    end);
    u142[#u142 + 1] = u215;

    local function u217() -- Line: 2298
        -- upvalues: u149 (copy), EffectUtility (copy), u135 (copy)
        EffectUtility.EmitAttachment(u149["4"]);

        for _, descendant in pairs(u135.Ball.trailholder:GetDescendants()) do
            if descendant.ClassName == "Trail" then
                descendant.Enabled = true;
            end;
        end;
    end;

    local u218 = tick();
    local u219 = nil;
    local u220 = 4.233333333333333;
    u219 = RunService.Stepped:Connect(function() -- Line: 1972
        -- upvalues: u218 (copy), u220 (copy), u217 (copy), u219 (ref)
        if u220 < tick() - u218 then
            u217();
            u219:Disconnect();
        end;
    end);
    u142[#u142 + 1] = u219;

    local function u221() -- Line: 2313
        -- upvalues: u135 (copy), EffectUtility (copy)
        local Ball = u135.Ball;
        EffectUtility.EmitAttachment(Ball);
        EffectUtility.EmitAttachment(Ball);
        EffectUtility.ToggleAttachment(Ball, true, 0.5);
        EffectUtility.EmitAttachment(Ball);

        for _, descendant in pairs(u135.Ball.trailholder:GetDescendants()) do
            if descendant.ClassName == "Trail" then
                descendant.Enabled = true;
            end;
        end;
    end;

    local u222 = tick();
    local u223 = nil;
    local u224 = 1.7333333333333334;
    u223 = RunService.Stepped:Connect(function() -- Line: 1972
        -- upvalues: u222 (copy), u224 (copy), u221 (copy), u223 (ref)
        if u224 < tick() - u222 then
            u221();
            u223:Disconnect();
        end;
    end);
    u142[#u142 + 1] = u223;
    task.delay(5, function() -- Line: 2334
        -- upvalues: u152 (ref), u149 (copy), u150 (copy), u151 (copy), mainreplication (ref), workspace_CurrentCamera (ref), CFrame2 (copy), Temp (ref), u131 (copy), Cam (copy), u138 (ref), u140 (copy)
        if u152 then
            u152:Destroy();
        end;

        u149:Destroy();
        u150:Destroy();
        u151:Destroy();
        mainreplication.fov(false, 70);
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        task.defer(function() -- Line: 2345
            -- upvalues: workspace_CurrentCamera (ref), CFrame2 (ref)
            workspace_CurrentCamera.CFrame = CFrame2;
        end);
        Temp.ClearTemp(u131);
        Cam:Destroy();
        u138:Disconnect();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(0.5, 0.75);
        u140:Destroy();
    end);
end;

function v1.kunigamiAwakening(u225, p226) -- Line: 2359
    -- upvalues: mainreplication (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), VfxHandler (copy), Welder (copy), MeshEmitter (copy), RunService (copy), TekrinnDialogue (copy), Lighting (copy), Temp (copy), OutdoorAmbient (copy), GeographicLatitude (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), ClockTime (copy), Glare (copy), Haze (copy), Density (copy), Offset (copy), Color (copy), Decay (copy), Intensity (copy), Size (copy), Threshold2 (copy)
    local u227 = {};
    mainreplication.sceneEnabled(true);
    soundUtil:play(ReplicatedStorage.Resources.kunigami.kunigami_awk, SoundService, {
        Character = u225
    });
    local v228 = VfxHandler.CutsceneVictim(u225, u225, nil, ReplicatedStorage.Resources.kunigami.Char1, u227);
    local v229, _ = VfxHandler.PlayCutsceneLite(u225, ReplicatedStorage.Resources.CutscenePack.KunigamiAwk, nil, nil);
    local u230 = ReplicatedStorage.Resources.kunigami.KuniawkVFXPack:Clone();
    Welder:GroupWeld(u225, u230);
    u230.Parent = workspace.Effects;
    u227[#u227 + 1] = u230;
    local HumanoidRootPart = u225.HumanoidRootPart;
    local _ = u225.Humanoid;
    local v231 = MeshEmitter.StartMeshEmitter(HumanoidRootPart, ReplicatedStorage.Resources.kunigami["Kunigami Awaken MeshEmitter"], nil, 20);
    u227[#u227 + 1] = v231;
    u227[#u227 + 1] = task.delay(3.25, function() -- Line: 2385
        -- upvalues: ReplicatedStorage (ref), u227 (copy), RunService (ref), HumanoidRootPart (copy)
        local u232 = ReplicatedStorage.Resources.kunigami.KuniawkMap:Clone();
        u227[#u227 + 1] = RunService.RenderStepped:Connect(function() -- Line: 2387
            -- upvalues: u232 (copy), HumanoidRootPart (ref)
            u232:PivotTo(HumanoidRootPart.CFrame);
        end);
        u232.Parent = workspace.Effects;
        u227[#u227 + 1] = u232;
    end);

    for _, child in pairs(v228:GetChildren()) do
        if child:IsA("Clothing") then
            child:Destroy();
        end;
    end;

    for _, child in pairs(ReplicatedStorage.Resources.kunigami.clothes:GetChildren()) do
        child:Clone().Parent = v228;
    end;

    VfxHandler.CutsceneVictim(u225, p226, nil, ReplicatedStorage.Resources.kunigami.Char2, u227);
    VfxHandler.HideCharacters({ u225 }, u230);
    u227[#u227 + 1] = task.spawn(function() -- Line: 2409
        -- upvalues: u230 (copy)
        local effects = u230:WaitForChild("kunigami"):WaitForChild("effects");
        local chains = effects:WaitForChild("chains");

        for _, descendant in ipairs(chains:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        local aura = effects:WaitForChild("aura");

        for _, descendant in ipairs(aura:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(aura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(0.1, function() -- Line: 2435
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.Export.Head.flare:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(0.31666666666666665, function() -- Line: 2442
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.Export.Head.flare2:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(0.7166666666666667, function() -- Line: 2451
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.lineup1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(0.9, function() -- Line: 2459
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.lineup1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(0.9666666666666667, function() -- Line: 2467
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.pullup:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(2.4, function() -- Line: 2475
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.Export.Head.breath:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(3.316666666666667, function() -- Line: 2482
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.Export.HumanoidRootPart.s1:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(3.783333333333333, function() -- Line: 2489
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.Export.HumanoidRootPart.s2:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(4.35, function() -- Line: 2496
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.Export.HumanoidRootPart.s3:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(5.216666666666667, function() -- Line: 2503
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.Export.HumanoidRootPart.s4:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(5.966666666666667, function() -- Line: 2510
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.Export.HumanoidRootPart.s5:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(6.35, function() -- Line: 2517
        -- upvalues: u230 (copy)
        for _, descendant in ipairs(u230.KunigamiLightning["1"]["1"]:GetDescendants()) do
            if descendant:IsA("PointLight") then
                descendant.Enabled = true;
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(6.666666666666667, function() -- Line: 2526
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.Export.HumanoidRootPart["1"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(7.516666666666667, function() -- Line: 2533
        -- upvalues: u230 (copy)
        for _, descendant in ipairs(u230.KunigamiLightning["1"]["1"]:GetDescendants()) do
            if descendant:IsA("PointLight") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u230.KunigamiLightning["2"]["2"]:GetDescendants()) do
            if descendant:IsA("PointLight") then
                descendant.Enabled = true;
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(8.833333333333334, function() -- Line: 2550
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.Onlykzu.Head.Attachment:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(9.016666666666667, function() -- Line: 2558
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.Onlykzu["Right Arm"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(9.283333333333333, function() -- Line: 2566
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.Onlykzu["Right Arm"]:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(9.85, function() -- Line: 2574
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.Onlykzu.Head.Attachment:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(9.866666666666667, function() -- Line: 2582
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.Export.HumanoidRootPart["2"]:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u230.KunigamiLightning["2"]["2"]:GetDescendants()) do
            if descendant:IsA("PointLight") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u230.KunigamiLightning["3"]["3"]:GetDescendants()) do
            if descendant:IsA("PointLight") then
                descendant.Enabled = true;
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(9.883333333333333, function() -- Line: 2605
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.line2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(12.316666666666666, function() -- Line: 2613
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.Export.Head.eyeemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(12.5, function() -- Line: 2621
        -- upvalues: u230 (copy)
        for _, descendant in ipairs(u230.KunigamiLightning["3"]["3"]:GetDescendants()) do
            if descendant:IsA("PointLight") then
                descendant.Enabled = false;
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(12.733333333333333, function() -- Line: 2630
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.grow:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(15.183333333333334, function() -- Line: 2638
        -- upvalues: u230 (copy)
        for _, descendant in pairs(u230.grow:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(16.933333333333334, function() -- Line: 2646
        -- upvalues: u230 (copy)
        local effects = u230:WaitForChild("kunigami"):WaitForChild("effects");
        local chains = effects:WaitForChild("chains");

        for _, descendant in ipairs(chains:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        local aura = effects:WaitForChild("aura");

        for _, descendant in ipairs(aura:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(aura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    u227[#u227 + 1] = task.delay(0.71, function() -- Line: 2673
        -- upvalues: u227 (copy), TekrinnDialogue (ref), u225 (copy)
        u227[#u227 + 1] = TekrinnDialogue.Speak(u225, {
            {
                Text = "Don\'t look down..",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 2);
    end);
    u227[#u227 + 1] = task.delay(1.89, function() -- Line: 2694
        -- upvalues: u227 (copy), TekrinnDialogue (ref), u225 (copy)
        u227[#u227 + 1] = TekrinnDialogue.Speak(u225, {
            {
                Text = "Watch them go!",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 2);
    end);
    u227[#u227 + 1] = task.delay(3.16, function() -- Line: 2715
        -- upvalues: u227 (copy), TekrinnDialogue (ref), u225 (copy)
        u227[#u227 + 1] = TekrinnDialogue.Speak(u225, {
            {
                Text = "Don\'t you dare lower your head..",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 2
                }
            }
        }, 3);
    end);
    u227[#u227 + 1] = task.delay(5.05, function() -- Line: 2736
        -- upvalues: u227 (copy), TekrinnDialogue (ref), u225 (copy)
        u227[#u227 + 1] = TekrinnDialogue.Speak(u225, {
            {
                Text = ".. or you might as well quit now!",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 2
                }
            }
        }, 5);
    end);
    u227[#u227 + 1] = task.delay(7.24, function() -- Line: 2757
        -- upvalues: u227 (copy), TekrinnDialogue (ref)
        u227[#u227 + 1] = TekrinnDialogue.Speak("???", {
            {
                Text = "If you don\'t have what it takes to be the best striker in the world..",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 2
                }
            }
        }, 6, "", Color3.new(1, 1, 1));
    end);
    u227[#u227 + 1] = task.delay(10.62, function() -- Line: 2778
        -- upvalues: u227 (copy), TekrinnDialogue (ref)
        u227[#u227 + 1] = TekrinnDialogue.Speak("???", {
            {
                Text = ".. you won\'t survive Soccer Game.",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            }
        }, 3, "", Color3.new(1, 1, 1));
    end);
    Lighting.ClockTime = 5.1;
    Lighting.GeographicLatitude = -51;
    Lighting.ExposureCompensation = 0;
    Lighting.Ambient = Color3.fromRGB(0, 0, 0);
    Lighting.Brightness = 0;
    Lighting.Atmosphere.Glare = 0.1;
    Lighting.Atmosphere.Haze = 2.18;
    Lighting.Atmosphere.Density = 0.628;
    Lighting.Atmosphere.Offset = 0;
    Lighting.Atmosphere.Color = Color3.fromRGB(0, 0, 0);
    Lighting.Atmosphere.Decay = Color3.fromRGB(0, 0, 0);
    Lighting.Bloom.Intensity = 1;
    Lighting.Bloom.Size = 25;
    Lighting.Bloom.Threshold = 2;
    u227[#u227 + 1] = task.delay(0, function() -- Line: 2815
        -- upvalues: Lighting (ref)
        Lighting.OutdoorAmbient = Color3.fromRGB(161, 161, 161);
    end);
    u227[#u227 + 1] = task.delay(3.267, function() -- Line: 2818
        -- upvalues: Lighting (ref)
        Lighting.OutdoorAmbient = Color3.fromRGB(75, 25, 9);
    end);
    u227[#u227 + 1] = task.delay(15.133, function() -- Line: 2821
        -- upvalues: Lighting (ref)
        Lighting.OutdoorAmbient = Color3.fromRGB(161, 161, 161);
    end);
    local u233 = ReplicatedStorage.Resources.kunigami.ImpactFrame:Clone();
    u233.Parent = game.Players.LocalPlayer.PlayerGui;
    u227[#u227 + 1] = u233;
    u227[#u227 + 1] = task.delay(14, function() -- Line: 2828
        -- upvalues: ReplicatedStorage (ref), u233 (copy), u227 (copy)
        local RunService2 = game:GetService("RunService");
        local TweenService2 = game:GetService("TweenService");
        require(ReplicatedStorage.forum.Packet.Task);
        local CanvasGroup = u233.CanvasGroup;
        local Children = CanvasGroup:GetChildren();
        local os_clock_ret = os.clock();
        local u234 = nil;
        local u235 = 0.999;
        u234 = RunService2.RenderStepped:Connect(function(p236) -- Line: 2844
            -- upvalues: os_clock_ret (copy), CanvasGroup (copy), Children (copy), u234 (ref), TweenService2 (copy), u235 (ref)
            local v237 = (os.clock() - os_clock_ret) * 24;
            local v238 = CanvasGroup:FindFirstChild((math.ceil(v237)));

            if not v238 or v238.Name == #Children then
                u234:Disconnect();
                TweenService2:Create(CanvasGroup[#Children], TweenInfo.new(0.25), {
                    ImageTransparency = 1
                }):Play();

                return;
            end;

            for _, v in pairs(Children) do
                if v:IsA("ImageLabel") then
                    v.ImageTransparency = 0.999;
                end;
            end;

            u235 = u235 - p236 / 0.25;
            v238.ImageTransparency = u235;
        end);
        u227[#u227 + 1] = u234;
    end);
    v229.Event:Once(function(p239) -- Line: 2867
        -- upvalues: Temp (ref), u227 (copy), mainreplication (ref), Lighting (ref), OutdoorAmbient (ref), GeographicLatitude (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), ClockTime (ref), Glare (ref), Haze (ref), Density (ref), Offset (ref), Color (ref), Decay (ref), Intensity (ref), Size (ref), Threshold2 (ref)
        Temp.ClearTemp(u227);
        mainreplication.sceneEnabled(false);
        Lighting.OutdoorAmbient = OutdoorAmbient;
        Lighting.GeographicLatitude = GeographicLatitude;
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Lighting.ClockTime = ClockTime;
        Lighting.Atmosphere.Glare = Glare;
        Lighting.Atmosphere.Haze = Haze;
        Lighting.Atmosphere.Density = Density;
        Lighting.Atmosphere.Offset = Offset;
        Lighting.Atmosphere.Color = Color;
        Lighting.Atmosphere.Decay = Decay;
        Lighting.Bloom.Intensity = Intensity;
        Lighting.Bloom.Size = Size;
        Lighting.Bloom.Threshold = Threshold2;
        mainreplication.ultFlash(1);
    end);
end;

function v1.kunigamiSuplexImpact(p240, p241) -- Line: 2893
    -- upvalues: Players (copy), mainreplication (copy), ReplicatedStorage (copy), emit (copy), Lighting (copy), TweenService (copy)
    local v242 = p240.HumanoidRootPart or p240.PrimaryPart;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p240) or Players.LocalPlayer == Players:GetPlayerFromCharacter(p241) then
        mainreplication.cameraShake(40, 0.6, 5, nil);
        mainreplication.fov(false, 80);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    end;

    mainreplication.highlight(p240, Color3.fromRGB(255, 140, 0), 1);
    mainreplication.highlight(p241, Color3.fromRGB(255, 69, 0), 1.5);
    local v243 = ReplicatedStorage.Resources.kunigami.suplexImpact:Clone();
    v243:PivotTo(v242.CFrame * CFrame.new(0, 0, -1));
    v243.Parent = workspace.Effects;
    emit(v243);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p240) or Players.LocalPlayer == Players:GetPlayerFromCharacter(p241) then
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 20;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.35, BlurEffect.Destroy, BlurEffect);
        mainreplication.springcamerashake(20, 30);
        mainreplication.bright(0.25, 0.16, Color3.fromRGB(255, 255, 255));
    end;
end;

function v1.kunigamiThrowImpact(u244, p245) -- Line: 2938
    -- upvalues: Players (copy), mainreplication (copy), ReplicatedStorage (copy), xamillmesh (copy), emit (copy), Lighting (copy), TweenService (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy)
    local u246 = u244.HumanoidRootPart or u244.PrimaryPart;
    local v247 = p245.HumanoidRootPart or p245.PrimaryPart;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u244) or Players.LocalPlayer == Players:GetPlayerFromCharacter(p245) then
        mainreplication.cameraShake(15, 1.5, 4, nil);
        mainreplication.fov(false, 83);
        mainreplication.fov(true, 70, 1.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    end;

    mainreplication.highlight(u244, Color3.fromRGB(255, 140, 0), 0.8);
    mainreplication.highlight(p245, Color3.fromRGB(255, 86, 7), 1.2);
    local u248 = ReplicatedStorage.Resources.kunigami.throwImpact:Clone();
    u248:PivotTo(v247.CFrame);
    u248.Parent = workspace.Effects;

    for _, descendant in u248:GetDescendants() do
        if descendant:IsA("MeshPart") and descendant.Parent.Name == "Mesh" then
            xamillmesh(descendant);
        end;
    end;

    emit(u248);
    mainreplication.Emit(v247, ReplicatedStorage.Resources.normalkick, 4, CFrame.new(0, 0, 0));

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u244) then
        mainreplication.fov(true, 85, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 18;
        BlurEffect.Parent = Lighting;
        local v249 = ReplicatedStorage.Resources.DepthOfField:Clone();
        v249.Parent = Lighting;
        v249.FarIntensity = 0;
        TweenService:Create(v249, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FarIntensity = 1
        }):Play();
        task.delay(0.5, v249.Destroy, v249);
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.25, BlurEffect.Destroy, BlurEffect);
    end;

    task.spawn(function() -- Line: 2989
        -- upvalues: ReplicatedStorage (ref), u246 (copy), Util (ref), LocalPlayer (ref), u244 (copy), vfxUtil (ref), TweenService (ref), Players (ref), mainreplication (ref)
        task.wait(0.15);
        local u250 = ReplicatedStorage.Resources.rundasheff:Clone();
        u250.main.Weld.Part0 = u246;
        u250.Parent = workspace.Effects;

        if Util.canshiftcolor(LocalPlayer, u244) then
            vfxUtil.LeanTowardsColor(u250, u244:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u244:GetAttribute("CustomAlpha") or 0.985);
        end;

        u250.Air.Size = Vector3.new(7.497, 0.75450003, 7.497);
        u250.Air.Transparency = 0.6;
        local Air = u250.main.Air;
        Air.C0 = Air.C0 * CFrame.new(0, -15, 0);
        TweenService:Create(u250.main.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            C0 = u250.main.Air.C0 * CFrame.new(0, 15, 0)
        }):Play();
        TweenService:Create(u250.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Size = Vector3.new(17.136, 1.132, 16.878),
            Transparency = 1
        }):Play();
        u250.Wind1.Size = Vector3.new(4.4969997, 4.839, 3.8009999);
        u250.Wind1.Transparency = 0.7;
        TweenService:Create(u250.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Size = Vector3.new(19.108, 11.452, 11.292),
            Transparency = 1
        }):Play();
        task.delay(0.15, function() -- Line: 3031
            -- upvalues: u250 (copy), TweenService (ref)
            u250.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
            u250.Wind1.Transparency = 0.7;
            TweenService:Create(u250.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                Size = Vector3.new(19.108, 11.452, 11.292),
                Transparency = 1
            }):Play();
        end);
        u250.End.Size = Vector3.new(7.5, 1.5, 7.5);
        u250.End.Transparency = 0.55;
        local End = u250.main.End;
        End.C0 = End.C0 * CFrame.new(0, 0, 0);
        TweenService:Create(u250.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            C0 = u250.main.End.C0 * CFrame.new(0, -15, 0)
        }):Play();
        TweenService:Create(u250.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            Size = Vector3.new(12.999, 2.766, 12.999),
            Transparency = 1
        }):Play();
        task.delay(0.15, function() -- Line: 3065
            -- upvalues: u250 (copy), TweenService (ref)
            u250.End.Size = Vector3.new(5, 1, 5);
            u250.End.Transparency = 0.65;
            local End2 = u250.main.End;
            End2.C0 = End2.C0 * CFrame.new(0, 15, 0);
            TweenService:Create(u250.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                C0 = u250.main.End.C0 * CFrame.new(0, -15, 0)
            }):Play();
            TweenService:Create(u250.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                Size = Vector3.new(12.999, 2.766, 12.999),
                Transparency = 1
            }):Play();
        end);
        u250.A.Size = Vector3.new(21.435, 7.128, 8.165999);
        u250.A.Mesh.Scale = Vector3.new(0.462, 0.23700002, 0.2625);
        u250.main.A.C0 = CFrame.new(-0.077, -0.717, 1) * CFrame.Angles(0.4363323129985824, -1.5707963267948966, 0);
        u250.A.Decal.Transparency = 0.8;
        TweenService:Create(u250.main.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            C0 = u250.main.A.C0 * CFrame.new(5, 0, 0) * CFrame.Angles(-0.4363323129985824, 0, 0)
        }):Play();
        TweenService:Create(u250.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            Size = Vector3.new(33.166, 4.752, 5.443)
        }):Play();
        TweenService:Create(u250.A.Mesh, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            Scale = Vector3.new(0.715, 0.303, 0.315)
        }):Play();
        TweenService:Create(u250.A.Decal, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
        task.delay(2, u250.Destroy, u250);

        if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u244) then
            return;
        end;

        mainreplication.cameraShake(17, 0.4, 5, nil);
        mainreplication.fov(false, 85);
        mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        task.wait(0.05);
        mainreplication.bright(0.3, 0.13);
    end);
    task.delay(2.5, function() -- Line: 3145
        -- upvalues: u248 (copy)
        u248:Destroy();
    end);
end;

function v1.kunigamiKnockback(p251, p252) -- Line: 3150
    -- upvalues: Players (copy), mainreplication (copy), Debris (copy)
    local Character = Players.LocalPlayer.Character;

    if not Character then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    mainreplication.destroyVelocity(HumanoidRootPart);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000);
    BodyVelocity.Velocity = p251;
    BodyVelocity.Parent = HumanoidRootPart;
    Debris:AddItem(BodyVelocity, p252);
end;

function v1.kunigamiKnockbackNew(p253, p254, u255, p256, p257) -- Line: 3172
    -- upvalues: mainreplication (copy), RunService (copy), Debris (copy)
    if not p253 then
        return;
    end;

    local HumanoidRootPart = p253:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u258, u259 = mainreplication.bodyVelocity(HumanoidRootPart, p254, p256, nil, nil, true, TweenInfo.new(p257, Enum.EasingStyle.Quart, Enum.EasingDirection.Out));
    local u260 = nil;
    u260 = RunService.RenderStepped:Connect(function(p261) -- Line: 3184
        -- upvalues: u258 (copy), u260 (ref), mainreplication (ref), HumanoidRootPart (copy), u255 (copy), u259 (copy)
        if u258 and u258:IsDescendantOf(game) then
            u258.Velocity = mainreplication.fixVelocity(HumanoidRootPart, u255 * u259.Value, u255);

            return;
        end;

        u260:Disconnect();
    end);
    mainreplication.rockFlakes(HumanoidRootPart, 0.8);
    Debris:AddItem(u258, p256);
    task.delay(p256, u260.Disconnect, u260);
end;

function v1.kunigamiLeftyShot(p262) -- Line: 3198
    -- upvalues: ReplicatedStorage (copy), emit (copy), xamillmesh (copy), Players (copy), mainreplication (copy)
    if not p262.HumanoidRootPart then
        local _ = p262.PrimaryPart;
    end;

    local v263 = p262:FindFirstChild("Left Leg");

    if not v263 then
        return;
    end;

    local v264 = ReplicatedStorage.Resources.kunigami.lefty_initiate:Clone();
    local Weld = Instance.new("Weld");
    Weld.Part0 = v263;
    Weld.Part1 = v264;
    Weld.Parent = v264;
    v264.Parent = p262;
    emit(v264, true);
    task.delay(0.5, v264.Destroy, v264);

    for _, descendant in v264:GetDescendants() do
        if descendant:IsA("MeshPart") and descendant.Parent.Name == "Mesh" then
            xamillmesh(descendant);
        end;
    end;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p262) then
        mainreplication.fov(true, 45, 0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
        task.delay(0.49, function() -- Line: 3225
            -- upvalues: mainreplication (ref)
            mainreplication.fov(true, 70, 0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut);
        end);
    end;

    mainreplication.highlight(p262, Color3.fromRGB(255, 106, 0), 0.5);
end;

function v1.kunigamiLeftyImpact(p265) -- Line: 3233
    -- upvalues: Players (copy), mainreplication (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), KatUtil (copy), vfxUtil (copy)
    local v266 = p265.HumanoidRootPart or p265.PrimaryPart;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p265) then
        mainreplication.fov(false, 120);
        mainreplication.fov(true, 70, 1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.springcamerashake(30, 40);
        local v267 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v267.Parent = Lighting;
        v267.TintColor = Color3.fromRGB(255, 133, 76);
        v267.Brightness = 0.4;
        v267.Contrast = 1;
        v267.Saturation = -0.5;
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 10;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.533, BlurEffect.Destroy, BlurEffect);
        TweenService:Create(v267, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(v267, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v267.Destroy, v267);
    end;

    local v268 = ReplicatedStorage.Resources.kunigami.lefty_impact:Clone();
    v268.Weld.Part0 = v266;
    v268:PivotTo(v266.CFrame);
    v268.Parent = workspace.Effects;
    KatUtil.forge_emit(v268);
    vfxUtil.disposal(v268, 6);
    mainreplication.highlight(p265, Color3.fromRGB(255, 106, 0), 1);
end;

function v1.kunigamiHeroicWhiff(u269) -- Line: 3272
    -- upvalues: mainreplication (copy), Players (copy), Lighting (copy), TweenService (copy), ReplicatedStorage (copy), vfxUtil (copy), KatUtil (copy)
    local u270 = u269.HumanoidRootPart or u269.PrimaryPart;
    task.delay(0.3, function() -- Line: 3276
        -- upvalues: mainreplication (ref), u270 (copy)
        mainreplication.bodyVelocity(u270, 70, 0.3, true, "RightVector", nil, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0));
    end);
    task.delay(0.25, function() -- Line: 3281
        -- upvalues: Players (ref), u269 (copy), mainreplication (ref), Lighting (ref), TweenService (ref)
        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u269) then
            mainreplication.fov(true, 75, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.cameraShake(15, 0.5, 4, nil);
        end;

        mainreplication.highlight(u269, Color3.fromRGB(255, 69, 0), 0.8);

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u269) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 6;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.3, BlurEffect.Destroy, BlurEffect);
        end;
    end);
    local u271 = ReplicatedStorage.Resources.kunigami.heroic_clash.vfx.whiff:Clone();
    local Weld = Instance.new("Weld");
    Weld.Part0 = u270;
    Weld.Part1 = u271;
    Weld.Parent = u271;
    u271.Parent = workspace.Effects;
    local v272 = ReplicatedStorage.Resources.kunigami.heroic_clash.vfx.ArmTrail:Clone();
    v272.Weld.Part0 = u269["Left Arm"];
    v272.Parent = u269;
    local v273 = ReplicatedStorage.Resources.kunigami.heroic_clash.vfx.ArmTrail:Clone();
    v273.Weld.Part0 = u269["Right Arm"];
    v273.Parent = u269;
    vfxUtil.disposal(v272, 1);
    vfxUtil.disposal(v273, 1);
    task.delay(0.31666666666666665, function() -- Line: 3317
        -- upvalues: KatUtil (ref), u271 (copy)
        KatUtil.forge_emit(u271["1"]);
        KatUtil.forge_emit(u271["1.5"]);
    end);
    task.delay(0.6666666666666666, function() -- Line: 3322
        -- upvalues: KatUtil (ref), u271 (copy)
        KatUtil.forge_emit(u271["2"]);
    end);
    task.delay(2, function() -- Line: 3326
        -- upvalues: u271 (copy)
        u271:Destroy();
    end);
end;

function v1.kunigamiHeroicLoop(p274, p275) -- Line: 3331
    -- upvalues: Players (copy), mainreplication (copy), soundUtil (copy), ReplicatedStorage (copy)
    local v276 = p274.HumanoidRootPart or p274.PrimaryPart;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p274) or Players.LocalPlayer == Players:GetPlayerFromCharacter(p275) then
        mainreplication.fov(true, 57, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
        local u277 = true;
        local u278 = true;
        local u279 = true;

        local function intenseCameraShake() -- Line: 3344
            -- upvalues: u277 (ref), mainreplication (ref)
            if not u277 then
                return;
            end;

            mainreplication.springcamerashake(15, 15);
            task.delay(0.2, function() -- Line: 3351
                -- upvalues: u277 (ref), mainreplication (ref)
                if not u277 then
                    return;
                end;

                task.delay(0.15, function() -- Line: 3355
                    -- upvalues: u277 (ref), mainreplication (ref)
                    if not u277 then
                        return;
                    end;

                    mainreplication.springcamerashake(15, 15);
                end);
            end);
        end;

        local function randomFovEffects() -- Line: 3364
            -- upvalues: u278 (ref), mainreplication (ref)
            if not u278 then
                return;
            end;

            local math_random_ret = math.random(45, 65);
            local v280 = math.random(10, 30) / 100;
            mainreplication.fov(true, math_random_ret, v280, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut);
        end;

        local function brightEffects() -- Line: 3373
            -- upvalues: u279 (ref), mainreplication (ref)
            if not u279 then
                return;
            end;

            local v281 = math.random(5, 15) / 150;
            local v282 = math.random(8, 20) / 120;
            local v283 = { Color3.fromRGB(255, 255, 255) };
            local v284 = v283[math.random(1, #v283)];
            mainreplication.bright(v281, v282, v284);
        end;

        if u277 then
            mainreplication.springcamerashake(15, 15);
            task.delay(0.2, function() -- Line: 3351
                -- upvalues: u277 (ref), mainreplication (ref)
                if not u277 then
                    return;
                end;

                task.delay(0.15, function() -- Line: 3355
                    -- upvalues: u277 (ref), mainreplication (ref)
                    if not u277 then
                        return;
                    end;

                    mainreplication.springcamerashake(15, 15);
                end);
            end);
        end;

        brightEffects();
        task.delay(0.6, function() -- Line: 3390
            -- upvalues: u277 (ref), mainreplication (ref), randomFovEffects (copy), brightEffects (copy)
            if u277 then
                mainreplication.springcamerashake(15, 15);
                task.delay(0.2, function() -- Line: 3351
                    -- upvalues: u277 (ref), mainreplication (ref)
                    if not u277 then
                        return;
                    end;

                    task.delay(0.15, function() -- Line: 3355
                        -- upvalues: u277 (ref), mainreplication (ref)
                        if not u277 then
                            return;
                        end;

                        mainreplication.springcamerashake(15, 15);
                    end);
                end);
            end;

            randomFovEffects();
            brightEffects();
        end);
        task.delay(0.3, function() -- Line: 3396
            -- upvalues: randomFovEffects (copy)
            randomFovEffects();
        end);
        task.delay(0.9, function() -- Line: 3401
            -- upvalues: randomFovEffects (copy), brightEffects (copy)
            randomFovEffects();
            brightEffects();
        end);
        task.delay(1, function() -- Line: 3406
            -- upvalues: u277 (ref), u278 (ref), u279 (ref)
            u277 = false;
            u278 = false;
            u279 = false;
        end);
    end;

    p275:PivotTo(p274:GetPivot());
    soundUtil:play(ReplicatedStorage.Resources.kunigami.sounds.heroic_clash_land, v276);
    local u285 = ReplicatedStorage.Resources.kunigami.heroic_clash.vfx.loop:Clone();
    local Weld = Instance.new("Weld");
    Weld.Part0 = v276;
    Weld.Part1 = u285;
    Weld.Parent = u285;
    u285.Parent = workspace.Effects;

    for _, descendant in u285:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;

            if descendant:GetAttribute("EnableDuration") then
                task.delay(descendant:GetAttribute("EnableDuration"), function() -- Line: 3428
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        elseif descendant:IsA("Beam") then
            descendant.Enabled = true;
        end;
    end;

    mainreplication.highlight(p274, Color3.fromRGB(255, 140, 0), 1.2);
    mainreplication.highlight(p275, Color3.fromRGB(255, 69, 0), 1.2);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p274) or Players.LocalPlayer == Players:GetPlayerFromCharacter(p275) then
        mainreplication.bright(0.15, 0.1, Color3.fromRGB(255, 100, 0));
    end;

    task.delay(1.4, function() -- Line: 3447
        -- upvalues: u285 (copy)
        u285:Destroy();
    end);
end;

function v1.kunigamiHeroicUserWin(u286, u287) -- Line: 3452
    -- upvalues: Players (copy), mainreplication (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), vfxUtil (copy), KatUtil (copy)
    if typeof(u287) == "boolean" then
        u287 = nil;
    end;

    local v288 = u286.HumanoidRootPart or u286.PrimaryPart;

    if not (u287 and u287.HumanoidRootPart) and u287 then
        local _ = u287.PrimaryPart;
    end;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u286) or Players.LocalPlayer == Players:GetPlayerFromCharacter(u287) then
        mainreplication.fov(true, 50, 0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut);
        local v289 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v289.Parent = Lighting;
        v289.TintColor = Color3.fromRGB(255, 133, 76);
        v289.Brightness = 0.4;
        v289.Contrast = 1;
        v289.Saturation = -0.5;
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 6;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.533, BlurEffect.Destroy, BlurEffect);
        TweenService:Create(v289, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(v289, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v289.Destroy, v289);
    end;

    local u290 = ReplicatedStorage.Resources.kunigami.heroic_clash.vfx.user_success:Clone();
    u290.Weld.Part0 = v288;
    u290.Parent = workspace.Effects;
    vfxUtil.disposal(u290, 3);
    task.delay(0.2, function() -- Line: 3490
        -- upvalues: KatUtil (ref), u290 (copy)
        KatUtil.Enable(u290["1"], "ParticleEmitter", true);
        KatUtil.Enable(u290["1.5"], "ParticleEmitter", true);
    end);
    task.delay(0.5, function() -- Line: 3495
        -- upvalues: KatUtil (ref), u290 (copy), mainreplication (ref), u286 (copy), u287 (ref), Players (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
        KatUtil.Enable(u290["1"], "ParticleEmitter", false);
        KatUtil.Enable(u290["1.5"], "ParticleEmitter", false);
        KatUtil.Emit(u290["3"]);
        mainreplication.highlight(u286, Color3.fromRGB(255, 64, 0), 1.5);
        mainreplication.highlight(u287, Color3.fromRGB(255, 0, 0), 2);

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u286) or Players.LocalPlayer == Players:GetPlayerFromCharacter(u287) then
            local v291 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v291.Parent = Lighting;
            v291.TintColor = Color3.fromRGB(255, 133, 76);
            v291.Brightness = 0.4;
            v291.Contrast = 1;
            v291.Saturation = -0.5;
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 5;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            TweenService:Create(v291, TweenInfo.new(0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            TweenService:Create(v291, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v291.Destroy, v291);
            mainreplication.springcamerashake(12.5, 15);
            mainreplication.fov(false, 80);
            mainreplication.fov(true, 70, 0.65, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        end;
    end);
end;

function v1.kunigamiHeroicVictimWin(u292, u293) -- Line: 3528
    -- upvalues: Players (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), vfxUtil (copy), KatUtil (copy), mainreplication (copy)
    if typeof(u293) == "boolean" then
        u293 = nil;
    end;

    local v294 = u292.HumanoidRootPart or u292.PrimaryPart;

    if not (u293 and u293.HumanoidRootPart) and u293 then
        local _ = u293.PrimaryPart;
    end;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u292) or Players.LocalPlayer == Players:GetPlayerFromCharacter(u293) then
        local v295 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v295.Parent = Lighting;
        v295.TintColor = Color3.fromRGB(255, 133, 76);
        v295.Brightness = 0.4;
        v295.Contrast = 1;
        v295.Saturation = -0.5;
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 6;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.533, BlurEffect.Destroy, BlurEffect);
        TweenService:Create(v295, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(v295, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v295.Destroy, v295);
    end;

    local u296 = ReplicatedStorage.Resources.kunigami.heroic_clash.vfx.user_fail:Clone();
    u296.Weld.Part0 = v294;
    u296.Parent = workspace.Effects;
    vfxUtil.disposal(u296, 3);
    task.delay(0.15, function() -- Line: 3564
        -- upvalues: KatUtil (ref), u296 (copy), Players (ref), u292 (copy), u293 (ref), mainreplication (ref)
        KatUtil.Enable(u296["1"], "ParticleEmitter", true);
        KatUtil.Enable(u296["1.5"], "ParticleEmitter", true);

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u292) or Players.LocalPlayer == Players:GetPlayerFromCharacter(u293) then
            mainreplication.fov(false, 60);
            mainreplication.fov(true, 70, 0.66, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        end;
    end);
    task.delay(0.4, function() -- Line: 3574
        -- upvalues: KatUtil (ref), u296 (copy), mainreplication (ref), u293 (ref), u292 (copy)
        KatUtil.Enable(u296["1"], "ParticleEmitter", false);
        KatUtil.Enable(u296["1.5"], "ParticleEmitter", false);
        KatUtil.Emit(u296["3"]);
        mainreplication.highlight(u293, Color3.fromRGB(255, 255, 255), 1);
        mainreplication.highlight(u292, Color3.fromRGB(255, 0, 0), 1);
    end);
end;

function v1.kunigamiHeroicSuccess(p297, p298, p299) -- Line: 3584
    -- upvalues: Players (copy), mainreplication (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), KatUtil (copy), emit (copy)
    local v300;

    if typeof(p298) == "boolean" then
        v300 = nil;
    else
        v300 = p298;
        p298 = p299;
    end;

    local v301 = p297.HumanoidRootPart or p297.PrimaryPart;
    local v302 = v300 and v300.HumanoidRootPart;

    if not v302 then
        if v300 then
            v302 = v300.PrimaryPart;
        else
            v302 = v300;
        end;
    end;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p297) or Players.LocalPlayer == Players:GetPlayerFromCharacter(v300) then
        mainreplication.fov(true, 55, 0.13, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        local v303 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v303.Parent = Lighting;
        v303.TintColor = Color3.fromRGB(255, 133, 76);
        v303.Brightness = 0.4;
        v303.Contrast = 1;
        v303.Saturation = -0.5;
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 10;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.533, BlurEffect.Destroy, BlurEffect);
        TweenService:Create(v303, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(v303, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v303.Destroy, v303);
        mainreplication.springcamerashake(25, 25);
    end;

    if p298 then
        local u304 = ReplicatedStorage.Resources.kunigami.heroic_clash.vfx.user_success:Clone();
        local Weld = Instance.new("Weld");
        Weld.Part0 = v301;
        Weld.Part1 = u304;
        Weld.Parent = u304;
        u304.Parent = workspace.Effects;
        task.delay(0.2, function() -- Line: 3624
            -- upvalues: KatUtil (ref), u304 (copy)
            KatUtil.Enable(u304["1"], "ParticleEmitter", true);
            KatUtil.Enable(u304["1.5"], "ParticleEmitter", true);
        end);
        task.delay(0.2, function() -- Line: 3629
            -- upvalues: KatUtil (ref), u304 (copy)
            KatUtil.Enable(u304["1"], "ParticleEmitter", false);
            KatUtil.Enable(u304["1.5"], "ParticleEmitter", false);
            KatUtil.Emit(u304["3"]);
        end);
        mainreplication.highlight(p297, Color3.fromRGB(255, 64, 0), 1.5);
        mainreplication.highlight(v300, Color3.fromRGB(255, 0, 0), 2);
        task.delay(3, function() -- Line: 3640
            -- upvalues: u304 (copy)
            u304:Destroy();
        end);
    else
        local u305 = ReplicatedStorage.Resources.kunigami.heroic_clash.vfx.user_fail:Clone();
        local Weld = Instance.new("Weld");
        Weld.Part0 = v301;
        Weld.Part1 = u305;
        Weld.Parent = u305;
        u305.Parent = workspace.Effects;
        emit(u305, true, true);
        local u306;

        if v302 then
            u306 = ReplicatedStorage.Resources.kunigami.heroic_clash.vfx.user_success:Clone();
            local Weld2 = Instance.new("Weld");
            Weld2.Part0 = v302;
            Weld2.Part1 = u306;
            Weld2.Parent = u306;
            u306.Parent = workspace.Effects;
            task.delay(0.2, function() -- Line: 3662
                -- upvalues: KatUtil (ref), u306 (ref)
                KatUtil.Enable(u306["1"], "ParticleEmitter", true);
                KatUtil.Enable(u306["1.5"], "ParticleEmitter", true);
            end);
            task.delay(0.2, function() -- Line: 3667
                -- upvalues: KatUtil (ref), u306 (ref)
                KatUtil.Enable(u306["1"], "ParticleEmitter", false);
                KatUtil.Enable(u306["1.5"], "ParticleEmitter", false);
                KatUtil.Emit(u306["3"]);
            end);
        else
            u306 = nil;
        end;

        mainreplication.highlight(p297, Color3.fromRGB(255, 0, 0), 2);
        mainreplication.highlight(v300, Color3.fromRGB(0, 255, 0), 1.5);
        task.delay(3, function() -- Line: 3677
            -- upvalues: u305 (copy), u306 (ref)
            u305:Destroy();

            if u306 then
                u306:Destroy();
            end;
        end);
    end;

    if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(p297) then
        local _ = Players.LocalPlayer == Players:GetPlayerFromCharacter(v300);
    end;
end;

function v1.kunigamiHeroicKnockback(p307, p308) -- Line: 3709
    -- upvalues: Players (copy), mainreplication (copy), TweenService (copy), Debris (copy)
    local Character = Players.LocalPlayer.Character;

    if not Character then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    mainreplication.destroyVelocity(HumanoidRootPart);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(400000, 0, 400000);
    BodyVelocity.Velocity = p307;
    BodyVelocity.Parent = HumanoidRootPart;
    TweenService:Create(BodyVelocity, TweenInfo.new(p308, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Velocity = Vector3.new(0, 0, 0)
    }):Play();
    Debris:AddItem(BodyVelocity, p308);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(Character) then
        mainreplication.cameraShake(15, p308, 5, nil);
    end;
end;

function v1.kunigamiHeaderVelocity(p309: any, p310: any, p311: boolean?) -- Line: 3743
    -- upvalues: Players (copy), mainreplication (copy), TweenService (copy), Debris (copy)
    local Character = Players.LocalPlayer.Character;

    if not Character then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    mainreplication.destroyVelocity(HumanoidRootPart);

    if p311 then
        return;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000);
    BodyVelocity.Velocity = p309;
    BodyVelocity.Parent = HumanoidRootPart;
    TweenService:Create(BodyVelocity, TweenInfo.new(p310, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Velocity = Vector3.new(0, 0, 0)
    }):Play();
    Debris:AddItem(BodyVelocity, p310);
end;

function v1.kunigamiHeaderGroundStartup(p312: any, p313: boolean?) -- Line: 3777
    -- upvalues: soundUtil (copy), ReplicatedStorage (copy), Players (copy), mainreplication (copy), vfxUtil (copy), emit (copy), MeshEmit2 (copy)
    local v314 = p312.HumanoidRootPart or p312.PrimaryPart;

    if p313 then
        soundUtil:play(ReplicatedStorage.Resources.kunigami.sounds.jump_aerial, v314);
    else
        soundUtil:play(ReplicatedStorage.Resources.kunigami.sounds.jump_low, v314);
    end;

    if p313 then
        if Players.LocalPlayer == Players:GetPlayerFromCharacter(p312) then
            mainreplication.fov(false, 85);
            mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        end;

        mainreplication.highlight(p312, Color3.fromRGB(250, 157, 80), 0.8);
        local v315 = ReplicatedStorage.Resources.kunigami.header.effect:Clone();

        if v315 then
            v315.Anchored = false;
            local Weld = Instance.new("Weld");
            Weld.Part0 = v314;
            Weld.Part1 = v315;
            Weld.Parent = v315;
            v315.Parent = workspace.Effects;
            vfxUtil.disposal(v315, 4);
            emit(v315["1"]);
            local v316 = ReplicatedStorage.Resources.kunigami.header.Meshes2:Clone();
            v316:PivotTo(v314.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(p313 and 0 or 40), 0.5235987755982988, 0));
            v316.Parent = workspace.Effects;

            if not p313 then
                for _, descendant in v316:GetDescendants() do
                    if descendant.Name == "Start" then
                        MeshEmit2(descendant, true);
                    end;
                end;
            end;

            task.delay(4, v316.Destroy, v316);
        end;

        return;
    end;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p312) then
        mainreplication.fov(true, 55, 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        task.delay(0.25, function() -- Line: 3791
            -- upvalues: mainreplication (ref)
            mainreplication.fov(false, 85);
            mainreplication.fov(true, 70, 0.9, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        end);
    end;

    task.wait(0.265);
    local v317 = ReplicatedStorage.Resources.kunigami.header.effect:Clone();

    if v317 then
        v317.Anchored = false;
        local Weld = Instance.new("Weld");
        Weld.Part0 = v314;
        Weld.Part1 = v317;
        Weld.Parent = v317;
        v317.Parent = workspace.Effects;
        vfxUtil.disposal(v317, 4);
        emit(v317["1"]);
        local v318 = ReplicatedStorage.Resources.kunigami.header.Meshes2:Clone();
        v318:PivotTo(v314.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(p313 and 0 or 40), 0.5235987755982988, 0));
        v318.Parent = workspace.Effects;

        if not p313 then
            for _, descendant in v318:GetDescendants() do
                if descendant.Name == "Start" then
                    MeshEmit2(descendant, true);
                end;
            end;
        end;

        task.delay(4, v318.Destroy, v318);
    end;

    mainreplication.highlight(p312, Color3.fromRGB(250, 157, 80), 0.8);
end;

function v1.kunigamiHeaderAirStartup(p319) -- Line: 3881
    -- upvalues: Players (copy), mainreplication (copy), Lighting (copy), TweenService (copy), ReplicatedStorage (copy), xamillmesh (copy), emit (copy)
    local v320 = p319.HumanoidRootPart or p319.PrimaryPart;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p319) then
        mainreplication.fov(true, 75, 0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 8;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.4, BlurEffect.Destroy, BlurEffect);
    end;

    local u321 = ReplicatedStorage.Resources.kunigami.header.effect:Clone();

    if u321 then
        u321.Anchored = false;
        local Weld = Instance.new("Weld");
        Weld.Part0 = v320;
        Weld.Part1 = u321;
        Weld.Parent = u321;
        u321.Parent = workspace.Effects;

        for _, descendant in u321:GetDescendants() do
            if descendant:IsA("MeshPart") and descendant.Parent.Name == "Mesh" then
                xamillmesh(descendant);
            end;
        end;

        emit(u321);
        task.delay(3, function() -- Line: 3915
            -- upvalues: u321 (copy)
            u321:Destroy();
        end);
    end;

    mainreplication.highlight(p319, Color3.fromRGB(250, 98, 47), 0.8);
end;

function v1.kunigamiHeaderAirHit(p322) -- Line: 3927
    -- upvalues: Players (copy), mainreplication (copy), ReplicatedStorage (copy), emit (copy)
    local v323 = p322.HumanoidRootPart or p322.PrimaryPart;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p322) then
        mainreplication.fov(true, 60, 0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
        task.delay(0.15, function() -- Line: 3932
            -- upvalues: mainreplication (ref)
            mainreplication.fov(true, 70, 0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.springcamerashake(25, 30);
        end);
    end;

    local u324 = ReplicatedStorage.Resources.kunigami.header.air_clear_vfx:Clone();

    if u324 then
        u324:PivotTo(v323.CFrame * CFrame.new(0, 0, -4));
        u324.Parent = workspace.Effects;

        for _, descendant in u324:GetDescendants() do
            if descendant:IsA("MeshPart") then
                local _ = descendant.Parent.Name == "Mesh";
            end;
        end;

        emit(u324, true);
        task.delay(2.5, function() -- Line: 3952
            -- upvalues: u324 (copy)
            u324:Destroy();
        end);
    end;

    mainreplication.highlight(p322, Color3.fromRGB(250, 98, 47), 1);
    mainreplication.Emit(v323, ReplicatedStorage.Resources.normalkick, 5, CFrame.new(0, 0, -4));
end;

function v1.kunigamiHeaderGroundHit(p325) -- Line: 3961
    -- upvalues: soundUtil (copy), ReplicatedStorage (copy), Players (copy), mainreplication (copy), Lighting (copy), TweenService (copy), xamillmesh (copy), emit (copy)
    local v326 = p325.HumanoidRootPart or p325.PrimaryPart;
    soundUtil:play(ReplicatedStorage.Resources.kunigami.sounds.jump_low_hit, v326);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p325) then
        mainreplication.fov(false, 110);
        mainreplication.fov(true, 70, 0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.springcamerashake(25, 30);
        local v327 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v327.Parent = Lighting;
        v327.TintColor = Color3.fromRGB(255, 133, 76);
        v327.Brightness = 0.4;
        v327.Contrast = 1;
        v327.Saturation = -0.5;
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 12;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.533, BlurEffect.Destroy, BlurEffect);
        TweenService:Create(v327, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(v327, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v327.Destroy, v327);
    end;

    local u328 = ReplicatedStorage.Resources.kunigami.header.effect:Clone();

    if u328 then
        u328.Anchored = false;
        local Weld = Instance.new("Weld");
        Weld.Part0 = v326;
        Weld.Part1 = u328;
        Weld.Parent = u328;
        u328.Parent = workspace.Effects;

        for _, descendant in u328:GetDescendants() do
            if descendant:IsA("MeshPart") and descendant.Parent.Name == "Mesh" then
                xamillmesh(descendant);
            end;
        end;

        task.delay(0.08, function() -- Line: 4005
            -- upvalues: emit (ref), u328 (copy)
            emit(u328["2"]);
        end);
        task.delay(3, function() -- Line: 4009
            -- upvalues: u328 (copy)
            u328:Destroy();
        end);
    end;

    mainreplication.highlight(p325, Color3.fromRGB(250, 98, 47), 1);
    mainreplication.Emit(v326, ReplicatedStorage.Resources.normalkick, 5, CFrame.new(0, 0, -4));
end;

function v1.kunigamiStealing(u329, p330, p331) -- Line: 4019
    -- upvalues: Util (copy), ReplicatedStorage (copy), camerasreplication (copy), TweenService (copy), workspace_CurrentCamera (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), Lighting (copy), TekrinnDialogue (copy), CreateVFXTimeline (copy)
    local v332 = u329.HumanoidRootPart or u329.PrimaryPart;

    if not p330.HumanoidRootPart then
        local _ = p330.PrimaryPart;
    end;

    Util.MidDarkLighting();
    local u333 = ReplicatedStorage.Resources.kunigami.ScreenEffect:Clone();
    u333.Parent = camerasreplication.KimCamera(v332, ReplicatedStorage.Resources.kunigami.camerasteal, nil, CFrame.new(0, -3, 0)).Bone;
    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.3333333333333333), {
        FieldOfView = 50
    }):Play();
    mainreplication.sceneEnabled(true);
    mainreplication.ultFlash(1, 0.1);
    soundUtil:play(ReplicatedStorage.Resources.kunigami.kunysteal, SoundService);
    local u334 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    u334.Brightness = -0.1;
    u334.Contrast = 0.3;
    u334.Saturation = -0.1;
    u334.TintColor = Color3.fromRGB(255, 255, 255);
    u334.Parent = Lighting;
    task.delay(0.5, function() -- Line: 4042
        -- upvalues: TweenService (ref), u334 (copy)
        TweenService:Create(u334, TweenInfo.new(0.3), {
            TintColor = Color3.fromRGB(255, 108, 81)
        }):Play();
    end);
    task.delay(0.3333333333333333, function() -- Line: 4045
        -- upvalues: TekrinnDialogue (ref), u329 (copy)
        TekrinnDialogue.Speak(u329, {
            {
                Text = "Even for you...",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 108, 81)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 2.5
                }
            },
            {
                Text = " that was too forced!",
                Bold = true,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 108, 81)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 2.5
                }
            }
        }, 1.6);
    end);
    task.delay(0.8, function() -- Line: 4092
        -- upvalues: u333 (copy)
        u333.SEffect.ParticleEmitter.Enabled = true;
    end);
    CreateVFXTimeline(v332, {
        [ReplicatedStorage.Resources.kunigami.Steal1] = { 0.2 },
        [ReplicatedStorage.Resources.kunigami.Steal2] = { 0.8 }
    }, nil, 8);
    task.delay(1.3833333333333333, function() -- Line: 4107
        -- upvalues: mainreplication (ref), u333 (copy), u334 (copy), Util (ref)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 0.3);
        u333:Destroy();
        u334:Destroy();
        Util.ReturnLighting();
    end);
end;

function v1.kunigamiIntercept(u335) -- Line: 4116
    -- upvalues: camerasreplication (copy), ReplicatedStorage (copy), soundUtil (copy), SoundService (copy), CreateVFXTimeline (copy), Debris (copy)
    camerasreplication.KimCamera(u335.HumanoidRootPart or u335.PrimaryPart, ReplicatedStorage.Resources.kunigami.camera_intercept);
    soundUtil:play(ReplicatedStorage.Resources.kunigami["KUNIGAMI HEAD THE BALL AWAY"], SoundService);
    local u336 = ReplicatedStorage.Resources.kunigami.StarterOk:Clone();
    CreateVFXTimeline(u335.HumanoidRootPart, {
        [ReplicatedStorage.Resources.kunigami.EnderOk] = { 0.6666666666666666 }
    }, nil, 8);
    task.delay(0.15, function() -- Line: 4130
        -- upvalues: u336 (copy), u335 (copy)
        u336.Parent = u335.Head;
        u336.StarterOkWeld.Part0 = u336;
        u336.StarterOkWeld.Part1 = u335.Head;

        for _, descendant in u336:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.6666666666666666, function() -- Line: 4143
        -- upvalues: u336 (copy), Debris (ref)
        for _, descendant in u336:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        Debris:AddItem(u336, 2);
    end);
end;

function v1.KunigamiHeroTackleOk(p337, p338) -- Line: 4153
    -- upvalues: soundUtil (copy), ReplicatedStorage (copy), MeshEmit2 (copy), CreateVFXTimeline (copy)
    local u339 = p337.HumanoidRootPart or p337.PrimaryPart;

    if not p338.HumanoidRootPart then
        local _ = p338.PrimaryPart;
    end;

    soundUtil:play(ReplicatedStorage.Resources.kunigami.kunigamiSTEALER, u339);

    local function weirdmeshthing(p340: userdata) -- Line: 4159
        -- upvalues: u339 (copy), MeshEmit2 (ref)
        local v341 = p340:Clone();
        local v342 = p340.Start:FindFirstChildOfClass("Motor6D");
        v342.Part0 = u339;
        v342.Part1 = p340.Start;
        local v343 = p340.Start:FindFirstChildOfClass("Motor6D");
        v343.Part0 = u339;
        v343.Part1 = p340.End;
        MeshEmit2(v341.Start);
    end;

    task.delay(0, function() -- Line: 4174
        -- upvalues: ReplicatedStorage (ref), u339 (copy), MeshEmit2 (ref)
        local VFX1 = ReplicatedStorage.Resources.kunigami.MeshVFX.VFX1;
        local v344 = VFX1:Clone();
        local v345 = VFX1.Start:FindFirstChildOfClass("Motor6D");
        v345.Part0 = u339;
        v345.Part1 = VFX1.Start;
        local v346 = VFX1.Start:FindFirstChildOfClass("Motor6D");
        v346.Part0 = u339;
        v346.Part1 = VFX1.End;
        MeshEmit2(v344.Start);
    end);
    task.delay(0.6833333333333333, function() -- Line: 4178
        -- upvalues: ReplicatedStorage (ref), u339 (copy), MeshEmit2 (ref)
        local VFX1 = ReplicatedStorage.Resources.kunigami.MeshVFX2.VFX1;
        local v347 = VFX1:Clone();
        local v348 = VFX1.Start:FindFirstChildOfClass("Motor6D");
        v348.Part0 = u339;
        v348.Part1 = VFX1.Start;
        local v349 = VFX1.Start:FindFirstChildOfClass("Motor6D");
        v349.Part0 = u339;
        v349.Part1 = VFX1.End;
        MeshEmit2(v347.Start);
        local VFX2 = ReplicatedStorage.Resources.kunigami.MeshVFX2.VFX2;
        local v350 = VFX2:Clone();
        local v351 = VFX2.Start:FindFirstChildOfClass("Motor6D");
        v351.Part0 = u339;
        v351.Part1 = VFX2.Start;
        local v352 = VFX2.Start:FindFirstChildOfClass("Motor6D");
        v352.Part0 = u339;
        v352.Part1 = VFX2.End;
        MeshEmit2(v350.Start);
    end);
    CreateVFXTimeline(u339, {
        [ReplicatedStorage.Resources.kunigami.HEROTACKLLEGROUND] = { 0 },
        [ReplicatedStorage.Resources.kunigami.HEROTACKLLEVF] = { 0.6833333333333333 }
    }, nil, 8);
end;

function v1.kunigamicounterstart(u353) -- Line: 4193
    -- upvalues: mainreplication (copy), CreateVFXTimeline (copy), ReplicatedStorage (copy), RunService (copy)
    local u354 = u353.HumanoidRootPart or u353.PrimaryPart;
    mainreplication.cameraShake(35, 1.5, 6);
    CreateVFXTimeline(u354, {
        [ReplicatedStorage.Resources.kunigami.KunyRun] = { 0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1, 1.1, 1.2 },
        [ReplicatedStorage.Resources.kunigami.Slide] = { 1.3, 1.4, 1.5, 1.6 }
    }, function() -- Line: 4220
        -- upvalues: u353 (copy)
        return u353:GetAttribute("DeathCounter");
    end, 8);
    local u355, u356 = mainreplication.bodyVelocity(u354, 130, 1.7833333333333334, nil, nil, true, TweenInfo.new(5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 40));
    local u357 = nil;
    u357 = RunService.RenderStepped:Connect(function(p358) -- Line: 4227
        -- upvalues: u355 (copy), u357 (ref), u354 (copy), u356 (copy)
        if u355 and u355:IsDescendantOf(game) then
            u355.Velocity = u354.CFrame.LookVector * u356.Value;

            return;
        end;

        u357:Disconnect();
    end);
    task.delay(1.4833333333333334, u357.Disconnect, u357);
end;

local ShadowSoftness = Lighting.ShadowSoftness;
local ClockTime2 = Lighting.ClockTime;
local u359 = nil;

function v1.kunigamiHeroesLefty(u360) -- Line: 4243
    -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), trove (copy), Ambient (copy), OutdoorAmbient (copy), ShadowSoftness (copy), ClockTime2 (copy), GeographicLatitude (copy), ExposureCompensation (copy), TweenService (copy), Lighting (copy), MoonPropertyAnimator (copy), u359 (ref), Util (copy), TekrinnDialogue (copy)
    local OriginalLeftyShot = vfxUtil.getResources().kunigami.OriginalLeftyShot;
    local Root = vfxUtil.getRoot(u360);
    local workspace_CurrentCamera2 = workspace.CurrentCamera;
    workspace_CurrentCamera2.CameraType = Enum.CameraType.Scriptable;
    local CFrame2 = workspace_CurrentCamera2.CFrame;
    mainreplication.sceneEnabled(true);
    soundUtil:play(OriginalLeftyShot.SFX, soundUtil);
    local u361 = trove.new();
    u361:AttachToInstance(u360);
    u361:Add(function() -- Line: 4256
        -- upvalues: Ambient (ref), OutdoorAmbient (ref), ShadowSoftness (ref), ClockTime2 (ref), GeographicLatitude (ref), ExposureCompensation (ref), TweenService (ref), Lighting (ref), workspace_CurrentCamera2 (copy), mainreplication (ref)
        for i, v in {
            Ambient = Ambient,
            OutdoorAmbient = OutdoorAmbient,
            ShadowSoftness = ShadowSoftness,
            ClockTime = ClockTime2,
            GeographicLatitude = GeographicLatitude,
            ExposureCompensation = ExposureCompensation
        } do
            TweenService:Create(Lighting, TweenInfo.new(1), {
                [i] = v
            }):Play();
        end;

        workspace_CurrentCamera2.CameraType = Enum.CameraType.Custom;
        mainreplication.sceneEnabled(false);
    end);
    u361:Add(task.delay(14.467, function() -- Line: 4271
        -- upvalues: u361 (copy)
        u361:Destroy();
    end));
    local Ball = u360:WaitForChild("Ball", 1);

    if Ball then
        Ball.Size = Vector3.new(1.5, 1.5, 1.5);
        u361:Add(function() -- Line: 4278
            -- upvalues: Ball (copy)
            Ball.Size = Vector3.new(1.95, 1.95, 1.95);
        end);
    end;

    local v362 = u361:Add(vfxUtil.createVFX(OriginalLeftyShot.BallVFX, "default", Ball));
    local v363 = u361:Add(vfxUtil.createVFX(OriginalLeftyShot.RootVFX, "default", Root));
    local v364 = u361:Add(vfxUtil.createVFX(OriginalLeftyShot.HeadVFX, "default", u360:FindFirstChild("Head")));

    for _, child in OriginalLeftyShot.Lighting:GetChildren() do
        u361:Clone(child).Parent = Lighting;
    end;

    for i, v in {
        ShadowSoftness = 0.2,
        ClockTime = 6.154,
        GeographicLatitude = 56.955,
        ExposureCompensation = 0,
        Ambient = Color3.fromRGB(126, 126, 126),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    } do
        TweenService:Create(Lighting, TweenInfo.new(1), {
            [i] = v
        }):Play();
    end;

    local v365 = u361:Construct(MoonPropertyAnimator);
    v365:SetOriginalRoot(OriginalLeftyShot.RootVFX.CFrame);
    v365:SetRoot(Root);
    v365:LoadAndConvertSave(OriginalLeftyShot.Moon, {
        Ball = v362,
        HumanoidRootPart = v363,
        CurrentCamera = workspace_CurrentCamera2
    });
    v365:PlayAll();
    u361:Add(function() -- Line: 4314
        -- upvalues: workspace_CurrentCamera2 (copy), CFrame2 (copy)
        workspace_CurrentCamera2.CFrame = CFrame2;
        workspace_CurrentCamera2.FieldOfView = 70;
    end);

    if not u359 then
        u359 = require(OriginalLeftyShot.Compiled);
    end;

    for _, v in ipairs(u359) do
        u361:Add(task.delay(v[1] / 60, v[2], v363, v364, v362));
    end;

    u361:Add(Util.Preload(OriginalLeftyShot.ImpactFrame));
    u361:Add(task.delay(12.917, function() -- Line: 4326
        -- upvalues: Util (ref), OriginalLeftyShot (copy)
        Util.Gif(OriginalLeftyShot.ImpactFrame, 30);
    end));
    u361:Add(task.delay(11.533, function() -- Line: 4330
        -- upvalues: u361 (copy), OriginalLeftyShot (copy), Root (copy)
        local u366 = u361:Clone(OriginalLeftyShot.speedline);
        u366.CFrame = Root.CFrame:ToWorldSpace(OriginalLeftyShot.RootVFX.CFrame:ToObjectSpace(OriginalLeftyShot.speedline.CFrame));
        u366.Parent = workspace.Effects;
        u361:Add(task.delay(1.3670000000000009, function() -- Line: 4334
            -- upvalues: u361 (ref), u366 (copy)
            u361:Remove(u366);
        end));
    end));
    task.defer(function() -- Line: 4339
        -- upvalues: TekrinnDialogue (ref), u360 (copy)
        TekrinnDialogue.Speak(u360, {
            {
                Text = "What should I do?",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 2);
    end);
    u361:Add(task.delay(0.856, function() -- Line: 4358
        -- upvalues: TekrinnDialogue (ref), u360 (copy)
        TekrinnDialogue.Speak(u360, {
            {
                Text = "If this were my last game..",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 5
                }
            }
        }, 5);
    end));
    u361:Add(task.delay(3.107, function() -- Line: 4377
        -- upvalues: TekrinnDialogue (ref), u360 (copy)
        TekrinnDialogue.Speak(u360, {
            {
                Text = "Wait, yeah..",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 3
                }
            }
        }, 3);
    end));
    u361:Add(task.delay(4.351, function() -- Line: 4396
        -- upvalues: TekrinnDialogue (ref), u360 (copy)
        TekrinnDialogue.Speak(u360, {
            {
                Text = ".. that\'s right!",
                Bold = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 3
                }
            }
        }, 3);
    end));
    u361:Add(task.delay(5.35, function() -- Line: 4417
        -- upvalues: TekrinnDialogue (ref), u360 (copy)
        TekrinnDialogue.Speak(u360, {
            {
                Text = "A shot from outside my 28-meter range.",
                Italic = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 3
                }
            }
        }, 5);
    end));
    u361:Add(task.delay(7.648, function() -- Line: 4438
        -- upvalues: TekrinnDialogue (ref), u360 (copy)
        TekrinnDialogue.Speak(u360, {
            {
                Text = "Zeroing in on the sweet spot for a full-power..",
                Bold = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 3
                }
            }
        }, 4);
    end));
    u361:Add(task.delay(9.685, function() -- Line: 4459
        -- upvalues: TekrinnDialogue (ref), u360 (copy)
        TekrinnDialogue.Speak(u360, {
            {
                Text = ".. technical shot!",
                Italic = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = false,
                    Intensity = 3,
                    Lifetime = 3
                }
            }
        }, 4);
    end));
    u361:Add(task.delay(11.049, function() -- Line: 4480
        -- upvalues: TekrinnDialogue (ref), u360 (copy)
        TekrinnDialogue.Speak(u360, {
            {
                Text = "If I were a ",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Text = "superhero",
                Bold = false,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 50)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                }
            },
            {
                Text = "..",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1,
                    Lifetime = 1
                }
            }
        }, 4);
    end));
    u361:Add(task.delay(13.439, function() -- Line: 4548
        -- upvalues: TekrinnDialogue (ref), u360 (copy)
        TekrinnDialogue.Speak(u360, {
            {
                Text = "THAT\'S WHAT I\'D DO!",
                Bold = true,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 50)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1,
                    Lifetime = 1
                }
            }
        }, 0.9299999999999997);
    end));
end;

function v1.update_revenge_stacks(p367, p368, p369, p370) -- Line: 4570
    -- upvalues: vfxUtil (copy), trove (copy)
    local Revenge = vfxUtil.getResources().kunigami.Revenge;
    local _hotbar = vfxUtil.get_hotbar();

    if _hotbar then
        local Tspecialer = _hotbar.Backpack.Hotbar:FindFirstChild("Tspecialer");

        if Tspecialer then
            local RevengeStacks = Tspecialer:FindFirstChild("RevengeStacks");

            if not RevengeStacks then
                RevengeStacks = Revenge.RevengeStacks:Clone();
                RevengeStacks.Parent = Tspecialer;
            end;

            for i = 1, p370 do
                local v371 = RevengeStacks:FindFirstChild((`Card_{i}`));
                local v372;

                if v371 then
                    v371.Visible = i <= p368;
                    v372 = i;
                else
                    v372 = i;
                end;
            end;
        end;
    end;

    for _, v in p369 do
        if v.character and v.character:IsDescendantOf(workspace) then
            local RevengeBoard = v.character:FindFirstChild("RevengeBoard");

            if not RevengeBoard then
                local v373 = trove.new();
                v373:AttachToInstance(p367);
                RevengeBoard = v373:Clone(Revenge.RevengeBoard);
                RevengeBoard.Parent = v.character;
            end;

            local v374 = v;

            for i = 1, p370 do
                local v375 = RevengeBoard.Stacks:FindFirstChild((`Card_{i}`));
                local v376;

                if v375 then
                    v375.Visible = i <= v374.stacks;
                    v376 = i;
                else
                    v376 = i;
                end;
            end;
        end;
    end;
end;

function v1.jackhammer_landed(p377: userdata, p378: number) -- Line: 4614
    -- upvalues: vfxUtil (copy), ReplicatedStorage (copy), soundUtil (copy), mainreplication (copy)
    local Root = vfxUtil.getRoot(p377);
    local kunigami = ReplicatedStorage.Resources.kunigami;
    local v379 = kunigami.Jackhammer:Clone();
    v379.Join.Part0 = Root;
    v379.Parent = workspace.Effects;

    if p378 > 0 then
        for _, v in v379:QueryDescendants("ParticleEmitter") do
            v.TimeScale = 0;
            v.LightEmission = -10;
            v:Emit(1);
        end;

        local v380 = soundUtil:play(kunigami.JackhammerLoop, "default");
        mainreplication.hitstopflash(p378, 0.3);
        mainreplication.highlight(p377, Color3.new(1, 1, 1), p378, true, 0);
        soundUtil:play(kunigami.JackhammerHit, Root);
        task.wait(p378);
        v380:Destroy();

        for _, v in v379:QueryDescendants("ParticleEmitter") do
            v.TimeScale = 0.5;
            v.LightEmission = -1;
            v:Emit((v:GetAttribute("EmitCount") or 0) - 1);
        end;
    end;
end;

return v1;