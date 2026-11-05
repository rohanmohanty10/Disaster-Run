  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
local ReplicatedRoot = ReplicatedStorage.ReplicatedRoot;
require(ReplicatedStorage.ReplicatedModules.Types);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.StatsHandler);
require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local Signal = require(ReplicatedStorage.ReplicatedRoot.Libraries.Classes.Signal);
task.wait(0.25);
require(ReplicatedRoot.Services.CombatService);
local LocalPlayer = Players.LocalPlayer;

local function _(p1, p2) -- Line: 25
    return Random.new():NextNumber(p1, p2);
end;

local function TweenCallback(p3, p4, u5, p6, p7, p8, p9, p10, p11) -- Line: 29
    -- upvalues: TweenService (copy)
    local v12 = TweenService:Create(p3, TweenInfo.new(p6 or 0.5, p7 or Enum.EasingStyle.Quad, p8 or Enum.EasingDirection.Out, p9 or 0, p10 or false, p11 or 0), p4);
    v12.Completed:Connect(function() -- Line: 39
        -- upvalues: u5 (copy)
        if u5 then
            u5();
        end;
    end);
    v12:Play();
end;

local function RandomPointOnSphere(p13) -- Line: 45
    local v14 = 2 * math.random() - 1;
    local v15 = 6.283185307179586 * math.random();
    local v16 = math.sqrt(1 - v14 * v14);
    local v17 = p13 * v16 * math.cos(v15);
    local v18 = p13 * v16 * math.sin(v15);

    return Vector3.new(v17, v18, p13 * v14);
end;

local function Get2DNoiseOffset(p19, p20, p21, p22) -- Line: 58
    local v23 = math.noise(p19 * p21, p20 * p21);
    local v24 = math.noise((p19 + 1000) * p21, (p20 + 1000) * p21);

    return Vector2.new(v23, v24) * p22;
end;

function InvLerp(p25, p26, p27)
    return (p27 - p25) / (p26 - p25);
end;

return function(p28) -- Line: 83
    -- upvalues: Trove (copy), Signal (copy), AssetHandler (copy), RandomPointOnSphere (copy), RunService (copy), EffectsHandler (copy), LocalPlayer (copy), Lighting (copy), TweenCallback (copy)
    local Character = p28.Character;

    if not (Character and Character.Parent) then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        local u29 = Trove.new();
        local u30 = {
            Step = 0,
            Trove = u29,
            SigilDestroyed = u29:Construct(Signal),
            Ended = u29:Construct(Signal)
        };
        u30.Trove:AttachToInstance(Character);
        local u31 = p28.Amount or 5;
        local u32 = p28.Time or 5;
        local u33 = p28.LookAtDuration or 0.5;
        local CurrentCamera = workspace.CurrentCamera;

        function u30.Summon(p34) -- Line: 107
            -- upvalues: AssetHandler (ref), HumanoidRootPart (copy), RandomPointOnSphere (ref), u30 (copy), u29 (copy), RunService (ref), u32 (copy), EffectsHandler (ref), CurrentCamera (copy), u33 (copy)
            local u35 = AssetHandler.CloneAsset("Universal/Interaction/Space/InsanitySigil");
            local u36 = HumanoidRootPart.Position + RandomPointOnSphere(100);
            u35.Position = u36;
            u35.Parent = workspace.Effects;
            local UI = u35:FindFirstChild("UI");
            u30.Trove:Add(u35);
            local u37 = 0;
            local u38 = 0;
            local u39 = nil;
            u39 = u29:Connect(RunService.Heartbeat, function(p40) -- Line: 121
                -- upvalues: u38 (ref), u32 (ref), u39 (ref), u35 (copy), u30 (ref), EffectsHandler (ref), CurrentCamera (ref), u37 (ref), u33 (ref), UI (copy), u36 (copy), HumanoidRootPart (ref)
                u38 = u38 + p40;

                if u32 <= u38 then
                    print("Ran out");
                    u39:Disconnect();
                    u35:Destroy();
                    u30.Ended:Fire("Failed");

                    if not table.isfrozen(u30) then
                        u30:Destroy();
                    end;

                    task.spawn(EffectsHandler.CallEffect, "Yuki_Vignette", {
                        LifeTime = 0.3,
                        Transparency = 0.3,
                        TweenIn = { 0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.In },
                        TweenOut = { 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut },
                        Size = UDim2.fromScale(1, 1),
                        Color = Color3.fromRGB(66, 198, 97),
                        Color2 = Color3.fromRGB(198, 68, 68)
                    });

                    return;
                end;

                local v41, v42 = CurrentCamera:WorldToScreenPoint(u35.Position);

                if v42 then
                    local ViewportSize = CurrentCamera.ViewportSize;
                    local v43 = ViewportSize / 2;
                    local v44 = ViewportSize * 0.4;
                    local v45 = v43 - v44;
                    local v46 = v43 + v44;

                    if v41.X >= v45.X and (v41.X <= v46.X and (v41.Y >= v45.Y and v41.Y <= v46.Y)) then
                        u37 = math.min(u37 + p40, u33);
                        local v47 = u38;
                        local v48 = math.noise(v47 * 25, 0);
                        local v49 = math.noise((v47 + 1000) * 25, 25000);
                        local v50 = Vector2.new(v48, v49) * (u37 * 1.5);
                        UI.Sigil.Size = UDim2.fromScale(0.8 + v50.X, 0.8 + v50.Y);
                    end;
                end;

                local v51 = math.clamp(u38 / u32, 0, 1);
                local v52 = InvLerp(0, u33, u37);
                local v53 = u38;
                local v54 = math.noise(v53 * 15, 0);
                local v55 = math.noise((v53 + 1000) * 15, 15000);
                local v56 = Vector2.new(v54, v55) * 0.025;
                UI.Sigil.Position = UDim2.fromScale(0.5 + v56.X, 0.5 + v56.Y);
                UI.Dark.Position = UDim2.fromScale(0.5 + v56.X, 0.5 + v56.Y);
                UI.Sigil.ImageTransparency = v52;
                UI.Dark.ImageTransparency = v52;
                UI.Sigil.Rotation = 0 - v56.X * 100;
                u35.Position = u36:Lerp(u36:Lerp(HumanoidRootPart.Position, 0.9), v51);

                if u33 <= u37 then
                    u39:Disconnect();
                    u39 = nil;
                    u35:Destroy();
                    local v57 = u30;
                    v57.Step = v57.Step + 1;
                    u30.SigilDestroyed:Fire(true);
                end;
            end);
        end;

        function u30.Run(p58) -- Line: 214
            -- upvalues: LocalPlayer (ref), HumanoidRootPart (copy), Lighting (ref), TweenCallback (ref), u30 (copy), EffectsHandler (ref), u31 (copy)
            LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson;
            HumanoidRootPart.Anchored = true;
            local _ = Lighting.Brightness;
            local Gameplay = LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("UI"):FindFirstChild("Gameplay");
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Name = "Insanity";
            ColorCorrectionEffect.Parent = Lighting;
            LocalPlayer:SetAttribute("NoAmbienceMusic", true);
            TweenCallback(ColorCorrectionEffect, {
                Brightness = -0.425
            }, nil, 0.55, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
            u30.Trove:Add(function() -- Line: 240
                -- upvalues: LocalPlayer (ref), HumanoidRootPart (ref), TweenCallback (ref), ColorCorrectionEffect (copy), Gameplay (copy)
                LocalPlayer:SetAttribute("NoAmbienceMusic", nil);
                LocalPlayer.CameraMode = Enum.CameraMode.Classic;
                HumanoidRootPart.Anchored = false;
                TweenCallback(ColorCorrectionEffect, {
                    Brightness = 0
                }, nil, 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
                task.delay(0.5, ColorCorrectionEffect.Destroy, ColorCorrectionEffect);
                Gameplay.Visible = true;
                print("Gone");
            end);
            local v59 = EffectsHandler.CallEffect("Ambience Music", {
                Sound = "rbxassetid://126658672223193",
                Volume = 0.45,
                TweenInfo = TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            });
            u30.Trove:Add(v59);
            u30.SigilDestroyed:Connect(function() -- Line: 269
                -- upvalues: EffectsHandler (ref), u30 (ref), u31 (ref)
                task.spawn(EffectsHandler.CallEffect, "Yuki_Vignette", {
                    LifeTime = 0.1,
                    Transparency = 0.5,
                    TweenIn = { 0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In },
                    TweenOut = { 0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out },
                    Size = UDim2.fromScale(1.25, 1.25),
                    Color = Color3.fromRGB(85, 255, 127)
                });
                EffectsHandler.CallEffect("Create Global Audio", {
                    Sound = "rbxassetid://130152122332170",
                    Volume = 0.6,
                    PlaybackSpeed = Random.new():NextNumber(0.95, 1.05)
                });

                if u31 > u30.Step then
                    u30:Summon();

                    return;
                end;

                u30.Ended:Fire("Won");
                u30:Destroy();
            end);
            u30:Summon();
            Gameplay.Visible = false;
            print("Running");
        end;

        function u30.Destroy(p60) -- Line: 302
            -- upvalues: u30 (copy)
            u30.Trove:Destroy();
            table.clear(u30);
            table.freeze(u30);
        end;

        return u30;
    end;
end;