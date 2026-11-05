  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local EnumsModule = require(PathShortcuts.EnumsModule);
local TableUtil = require(Knit.Util.TableUtil);
local ClientAssets = PathShortcuts.ClientAssets;
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local SoundGroups = require(ReplicatedStorage.ReplicatedModules:WaitForChild("SoundGroups"));
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
Knit.OnStart():andThen(function() -- Line: 20
    -- upvalues: PathShortcuts (copy), u1 (ref), u2 (ref), Knit (copy), u3 (ref), u4 (ref)
    u1 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    u2 = Knit.GetService("EffectService");
    u3 = Knit.GetService("QuoteService");
    u4 = Knit.GetService("MoveIndicatorService");
end);
local u5 = Random.new();
local v6 = {
    {
        SoundId = "rbxassetid://108294917943547",
        SoundVolume = 5,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "HUH!?",
                ScaleTime = 0.25
            } }
    },
    {
        SoundId = "rbxassetid://88082306309016",
        SoundVolume = 5,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "Imbecile!",
                ScaleTime = 0.5
            } }
    },
    {
        SoundId = "rbxassetid://114120616671501",
        SoundVolume = 5,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "This is nothing!",
                ScaleTime = 0.65
            } }
    },
    {
        SoundId = "rbxassetid://76544507518992",
        SoundVolume = 5,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "Is that your best!?",
                ScaleTime = 0.75
            } }
    },
    {
        SoundId = "rbxassetid://120709886535219",
        SoundVolume = 5,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "As I thought...",
                ScaleTime = 0.65
            } }
    },
    {
        SoundId = "rbxassetid://72496665791656",
        SoundVolume = 5,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "Pest.",
                ScaleTime = 0.3
            } }
    },
    {
        SoundId = "rbxassetid://139248096939843",
        SoundVolume = 5,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "Useless!",
                ScaleTime = 0.4
            } }
    },
    {
        SoundId = "rbxassetid://115472297873479",
        SoundVolume = 5,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "What!?",
                ScaleTime = 0.35
            } }
    },
    {
        SoundId = "rbxassetid://75801279347938",
        SoundVolume = 5,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "Wha-?",
                ScaleTime = 0.35
            } }
    },
    {
        SoundId = "rbxassetid://87336690133493",
        SoundVolume = 5,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "*devious laughter*",
                ScaleTime = 0.5
            } }
    },
    {
        SoundId = "rbxassetid://119865610508862",
        SoundVolume = 5,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "Wh-What? What\'s going on!?",
                ScaleTime = 1
            } }
    },
    {
        SoundId = "rbxassetid://115884309999949",
        SoundVolume = 5,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "Taste my power!",
                ScaleTime = 1
            } }
    },
    {
        SoundId = "rbxassetid://89014289823726",
        SoundVolume = 5,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "All will tremble before me!",
                ScaleTime = 1
            } }
    },
    {
        SoundId = 80976052665911,
        SoundVolume = 4,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "Hue hue hue hue Hue hue hue hue hue hue Hue hue hue hue hue Hue hue hue hue hue hue",
                ScaleTime = 4.25
            } }
    }
};

local function QuoteCallback(p7, p8) -- Line: 203
    -- upvalues: Players (copy), ParticleHandler (copy), EffectsHandler (copy)
    if not p8 then
        return;
    end;

    local LocalPlayer = Players.LocalPlayer;

    if Players:GetPlayerFromCharacter(p7) ~= LocalPlayer then
        local Settings = LocalPlayer:FindFirstChild("Settings");

        if Settings and (Settings:FindFirstChild("QuoteScreenEffects") and not Settings:FindFirstChild("QuoteScreenEffects").Value) then
            return;
        end;
    end;

    local v9 = p8.FullQuote[1];
    local v10 = p7:GetAttribute("Awakening");
    local v11 = p7:GetAttribute("HyperForm") or p7:GetAttribute("Awakening") and p7:GetAttribute("Posing");
    local v12 = nil;
    local v13 = Players:GetPlayerFromCharacter(p7);
    local v14 = v11 and Color3.new(0.75, 0.75, 0.75) or (v10 and Color3.fromRGB(255, 195, 42) or Color3.fromRGB(48, 103, 255));
    local v15, v16;

    if v13 and (v13.Data.Skin:GetAttribute("UnusualHueId") == 72 and not v11) then
        v14 = Color3.fromRGB(255, 8, 20);
        v15 = true;
        v16 = 85258329171861;
    else
        v15 = false;
        v16 = v11 and 89747046619130 or (v10 and not v11 and 139132869716498 or 123159557308101);
    end;

    if v13 and (v13.Data.Skin:GetAttribute("UnusualHueId") and (v13.Data.Skin:GetAttribute("UnusualHueId") ~= 72 and not v11)) then
        v14 = ParticleHandler.HSVShift(v14, ParticleHandler.GetUnusualHSVData({
            Player = v13,
            Character = p7
        }));
        v12 = v10 and 92097222768354 or 82337190164910;
    end;

    local v17, v18, _ = v14:ToHSV();
    EffectsHandler.CallEffect("Q_RADIAL", {
        Origin = p7.HumanoidRootPart.CFrame,
        Distance = p7:GetAttribute("InCombat") and 20 or 55,
        Effect = {
            {
                Effect = "SMBZDialogue",
                Arguments = {
                    {
                        Speed = 1.5,
                        Character = p7,
                        Text = string.upper(v9.Quote),
                        ScaleTime = v9.ScaleTime,
                        Image = v16,
                        Image2 = v12,
                        Image2Color = v14,
                        Endlag = v9.ScaleTime + 0.35,
                        TextProperties = {
                            Font = v15 and Enum.Font.Antique or "rbxassetid://12187360881",
                            TextStrokeColor3 = v14,
                            TextColor3 = Color3.fromHSV(v17, v18, 0.275)
                        }
                    }
                }
            }
        }
    });
end;

for _, v in v6 do
    v.ClientCallback = QuoteCallback;
end;

local v19 = TableUtil.Extend(v6, {
    {
        SoundId = "rbxassetid://95953700213838",
        SoundVolume = 4,
        PlaybackRegionsEnabled = true,
        YieldSound = true,
        Visible = true,
        PlaybackRegion = NumberRange.new(0, 3),
        FullQuote = { {
                Quote = "You\'re too slow...",
                ScaleTime = 1.5
            } }
    },
    {
        SoundId = "rbxassetid://95953700213838",
        SoundVolume = 4,
        PlaybackRegionsEnabled = true,
        YieldSound = true,
        Visible = true,
        PlaybackRegion = NumberRange.new(3.22, 600000),
        FullQuote = { {
                Quote = "Want to try again?",
                ScaleTime = 1.5
            } }
    },
    {
        SoundId = "rbxassetid://138184569672617",
        SoundVolume = 4,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "How about I give you a head start?",
                ScaleTime = 1.5
            } }
    },
    {
        SoundId = "rbxassetid://98862833984324",
        SoundVolume = 4,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "Found you :)",
                ScaleTime = 2
            } }
    },
    {
        SoundId = "rbxassetid://107165426293347",
        SoundVolume = 4,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "Ready for round 2?",
                ScaleTime = 1.75
            } }
    },
    {
        SoundId = "rbxassetid://86391272538196",
        SoundVolume = 4,
        PlaybackRegionsEnabled = true,
        YieldSound = true,
        Visible = true,
        PlaybackRegion = NumberRange.new(0, 6.821),
        FullQuote = { {
                Quote = "So many souls to play with... so little time...",
                ScaleTime = 3
            } }
    },
    {
        SoundId = "rbxassetid://116893355258863",
        SoundVolume = 4,
        YieldSound = true,
        Visible = true,
        FullQuote = { {
                Quote = "*demonic laughter*",
                ScaleTime = 0.65
            } }
    }
});

for _, v in v19 do
    if not v.Callback then
        v.ClientCallback = QuoteCallback;
    end;
end;

local v20 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = ClientAssets["Soul Survivor"].Metallix.LightHit
        }
    }
};
local v21 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = ClientAssets["Soul Survivor"].Metallix.HeavyHit
        }
    }
};

return {
    Inherit = {
        AbilityName = "Soul Survivor"
    },
    Animations = {
        Action = {
            ["LMB-1"] = 116375437460893,
            ["LMB-2"] = 103248309601932,
            ["LMB-3"] = 118220808505245,
            ["LMB-4"] = 82133969041709,
            PrepareThyself = 111993730878404,
            Judgement = 130203377249589,
            Die = 99043090985627,
            Crush = 105141053701396,
            Weak = 86463833053868,
            PoseIdle = 131328586596541,
            PoseTransition = 81261180631345,
            ["Awaken-PoseIdle"] = 140209058927867,
            ["Awaken-PoseTransition"] = 138004005846238,
            ["Chaos Control"] = 104674486291386
        },
        Movement = {
            Walk = 113017884323029,
            Run = 7505927467
        },
        Idle = {
            Idle = 105600496268536,
            HyperIdle = 118195710850799
        }
    },
    Stats = {
        Pose = {
            MusicAmount = 3,
            Callbacks = {
                Transformer = function(p22) -- Line: 457, Name: Transformer
                    -- upvalues: Players (copy), TableUtil (copy), u5 (copy)
                    local Character = p22.Character;
                    local v23 = p22.Player or Players:GetPlayerFromCharacter(Character);
                    local Stats = p22.Stats;

                    if Character:GetAttribute("Awakening") then
                        Stats = TableUtil.Copy(p22.Stats, true);
                        Stats.MusicAmount = 3;
                        Stats.PoseMusic = "Awakening-PoseMusic";

                        if Character:GetAttribute("HyperForm") then
                            if u5:NextInteger(1, 3) == 1 then
                                Stats.MusicAmount = nil;
                                Stats.PoseMusic = "[MUTE]";
                                Character:SetAttribute("HyperMusicOn", true);
                            end;
                        else
                            Stats.StartAnim = "Awaken-PoseTransition";
                            Stats.LoopAnim = "Awaken-PoseIdle";
                        end;
                    end;

                    if v23 and (v23.Data.Skin:GetAttribute("UnusualHueId") == 72 and u5:NextInteger(1, 3) == 1) then
                        Stats = TableUtil.Copy(p22.Stats, true);
                        Stats.PoseMusic = "EXE-PoseMusic";

                        if Character:GetAttribute("Awakening") and not Character:GetAttribute("HyperForm") then
                            Stats.StartAnim = "Awaken-PoseTransition";
                            Stats.LoopAnim = "Awaken-PoseIdle";
                        end;
                    end;

                    if Character:GetAttribute("CanGoHyper") == false then
                        Character:SetAttribute("CanGoHyper", true);

                        return Stats;
                    end;

                    if Character:GetAttribute("CanGoHyper") == true then
                        Character:SetAttribute("CanGoHyper", false);
                    end;

                    return Stats;
                end,

                PoseTransition = function(u24) -- Line: 493, Name: PoseTransition
                    -- upvalues: Players (copy), u1 (ref), u2 (ref), ParticleHandler (copy), ClientAssets (copy), TweenService (copy)
                    local Character = u24.Character;
                    local u25 = u24.Player or Players:GetPlayerFromCharacter(Character);
                    local HumanoidRootPart = Character.HumanoidRootPart;
                    local Humanoid = Character.Humanoid;
                    local v26 = u1.FetchSound(Character, "Awakening");
                    local v27 = u1.GetSound(Character, "AwakeningAura");
                    local v28 = u1.GetSound(Character, "HyperAwakening");

                    if Character:GetAttribute("Awakening") and not (Character:GetAttribute("Awakening") and Character:GetAttribute("HyperForm")) then
                        if v26 and (Character:GetAttribute("Awakening") and not (Character:GetAttribute("AwakenPose") or Character:GetAttribute("HyperForm"))) then
                            v26:Pause();
                            Character:SetAttribute("AwakenPose", true);

                            if v27 then
                                v27:Pause();
                            end;

                            local u29 = ClientAssets["Soul Survivor"].Metallix.SuperMetallixBurstPose:Clone();
                            ParticleHandler.Unusualify(u29, {
                                Player = u25,
                                Character = Character
                            });
                            u29.Name = Character.Name .. "MetallixPoseAura";
                            u29.Parent = workspace.Effects;
                            u29.CFrame = CFrame.identity;
                            u29:SetAttribute("BypassTransparency", true);
                            local u30 = ClientAssets["Soul Survivor"].Metallix.MasterEmerald:Clone();
                            u30.Parent = workspace.Effects;
                            u30.Transparency = 1;
                            u30.CFrame = CFrame.identity;
                            u30.Name = Character.Name .. "MetallixMasterEmerald";
                            u1.PlaySound(Character, "Awakened-PoseSFX");
                            u24.Trove:Connect(Character.AncestryChanged, function(p31, p32) -- Line: 563
                                -- upvalues: u29 (copy), u30 (copy)
                                if not (p32 and p32:IsDescendantOf(game)) then
                                    if u29 then
                                        u29:Destroy();
                                    end;

                                    if u30 then
                                        u30:Destroy();
                                    end;
                                end;
                            end);
                            u24.Trove:Add(function() -- Line: 574
                                -- upvalues: u1 (ref), Character (copy), ParticleHandler (ref), u30 (copy), u2 (ref), TweenService (ref)
                                u1.StopSound(Character, "Awakened-PoseSFX");
                                u1.StopSound(Character, "Awakened-StanceAmbience");
                                ParticleHandler.EnableAllParticles(u30, false);
                                task.delay(1, u30.Destroy, u30);
                                u2.FireAllClients("HighlightObject", u30, {
                                    FillTransparency = 0,
                                    OutlineTransparency = 0,
                                    Lifetime = 0.35,
                                    Name = "EmeraldHighlight",
                                    Tween = true,
                                    Override = true,
                                    DepthMode = Enum.HighlightDepthMode.Occluded,
                                    FillColor = Color3.fromRGB(255, 255, 255),
                                    OutlineColor = Color3.fromRGB(255, 255, 255)
                                });
                                TweenService:Create(u30, TweenInfo.new(0.275), {
                                    Transparency = 1
                                }):Play();
                            end);
                            u24.Trove:Construct(u1.CreateSequence, Character, {
                                Name = "MetallixAwakenPose",
                                Speed = 1,
                                SequenceV3 = true,
                                Frames = {
                                    { 25, function() -- Line: 602
                                            -- upvalues: u1 (ref), Character (copy), u2 (ref), HumanoidRootPart (copy)
                                            u1.PlaySound(Character, "PoseTeleportSFX");
                                            u2.FireAllClients({
                                                {
                                                    Name = "SMBZTeleport",
                                                    Data = {
                                                        {
                                                            Speed = 1,
                                                            Character = Character,
                                                            Origin = HumanoidRootPart.CFrame
                                                        }
                                                    }
                                                },
                                                {
                                                    Name = "MetallixAwakenPose",
                                                    Data = {
                                                        {
                                                            Volume = 1.69,
                                                            Character = Character
                                                        }
                                                    }
                                                }
                                            });
                                        end },
                                    { 27, function() -- Line: 627
                                            -- upvalues: Humanoid (copy), u2 (ref), Character (copy)
                                            Humanoid.HipHeight = 5.5;
                                            u2.FireAllClients("MetallixAwakenPose", {
                                                Volume = 1.69,
                                                Character = Character
                                            });
                                        end },
                                    { 55, function() -- Line: 634
                                            -- upvalues: u2 (ref), Character (copy)
                                            u2.FireAllClients("HighlightObject", Character, {
                                                FillTransparency = 1,
                                                OutlineTransparency = 1,
                                                Lifetime = 0.35,
                                                Name = "MetallixHighlight",
                                                Tween = true,
                                                Reverse = true,
                                                Override = true,
                                                DepthMode = Enum.HighlightDepthMode.Occluded,
                                                FillColor = Color3.fromRGB(255, 255, 255),
                                                OutlineColor = Color3.fromRGB(255, 255, 255)
                                            });
                                        end },
                                    { 58, function() -- Line: 648
                                            -- upvalues: u1 (ref), Character (copy), u30 (copy), HumanoidRootPart (copy), Humanoid (copy), ParticleHandler (ref), u2 (ref)
                                            u1.PlaySound(Character, "Awakened-StanceAmbience");
                                            u30.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -Humanoid.HipHeight, 0);
                                            local v33 = ParticleHandler.AttachTo(u30, {
                                                Part = HumanoidRootPart,
                                                Offset = CFrame.new(0, u30.Size.Y + 0.525, 0)
                                            });
                                            v33.Name = "EmeraldWeld";
                                            v33.Parent = u30;
                                            u2.FireAllClients("HighlightObject", u30, {
                                                FillTransparency = 0,
                                                OutlineTransparency = 0,
                                                Lifetime = 0.5,
                                                Name = "EmeraldHighlight",
                                                Tween = true,
                                                Override = true,
                                                DepthMode = Enum.HighlightDepthMode.Occluded,
                                                FillColor = Color3.fromRGB(255, 255, 255),
                                                OutlineColor = Color3.fromRGB(255, 255, 255)
                                            });
                                            u30.Transparency = 0;
                                            ParticleHandler.EnableAllParticles(u30, true);
                                        end },
                                    { 60, function() -- Line: 673
                                            -- upvalues: u2 (ref), u25 (copy)
                                            u2.FireClient(u25, "FOV Modifier", {
                                                View = 50,
                                                TweenInformation = {
                                                    Speed = 0.5833333333333334,
                                                    EasingStyle = Enum.EasingStyle.Cubic
                                                }
                                            });
                                        end }
                                }
                            }):Play();
                        end;
                    else
                        local Torso = Character:FindFirstChild("Torso");

                        if Torso then
                            Torso = Torso:FindFirstChild("FlamesMoving", true);
                        end;

                        u1.PlaySound(Character, "PoseSFX");
                        task.delay(0.425, function() -- Line: 506
                            -- upvalues: Character (copy), u24 (copy), u1 (ref)
                            if Character and (Character:GetAttribute("Posing") and u24.Trove) then
                                u1.PlaySound(Character, "StanceAmbience");
                            end;
                        end);

                        if Torso then
                            u2.FireAllClients("Emit Particle V3", {
                                Clone = false,
                                Parent = false,
                                Destroy = false,
                                AutoSerialize = true,
                                Particle = Torso.ImpactBurst,
                                Player = u25
                            });

                            for _, descendant in Torso:GetDescendants() do
                                if (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail")) and descendant.Parent ~= Torso.ImpactBurst then
                                    descendant.Enabled = true;
                                end;
                            end;

                            u24.Trove:Add(function() -- Line: 526
                                -- upvalues: u1 (ref), Character (copy), ParticleHandler (ref), Torso (copy)
                                u1.StopSound(Character, "PoseSFX");
                                u1.StopSound(Character, "StanceAmbience");
                                ParticleHandler.EnableAllParticles(Torso, false);
                            end);
                        end;

                        if Character:GetAttribute("HyperForm") then
                            if not Character:GetAttribute("HyperMusicOn") then
                                v28:Pause();
                            end;

                            u2.FireAllClients("MetallixAwakenPose", {
                                Volume = 2.25,
                                Character = Character
                            });
                        end;
                    end;
                end,

                PoseLoop = function(p34) -- Line: 687, Name: PoseLoop
                    -- upvalues: Players (copy), u2 (ref), u5 (copy), ClientAssets (copy), ParticleHandler (copy), TableUtil (copy), RunService (copy)
                    local Character = p34.Character;
                    local u35 = p34.Player or Players:GetPlayerFromCharacter(Character);
                    local Humanoid = Character.Humanoid;
                    local HumanoidRootPart = Character.HumanoidRootPart;

                    if Character:GetAttribute("Awakening") and (Character:GetAttribute("Posing") and not Character:GetAttribute("HyperForm")) then
                        u2.FireClient(u35, "FOV Modifier", {
                            View = 100,
                            TweenInformation = {
                                Speed = 0.15,
                                EasingStyle = Enum.EasingStyle.Cubic
                            }
                        });
                        task.delay(0.16666666666666666, function() -- Line: 702
                            -- upvalues: u2 (ref), u35 (copy)
                            u2.FireClient(u35, "FOV Modifier", {
                                TweenInformation = {
                                    Speed = 0.16666666666666666,
                                    EasingStyle = Enum.EasingStyle.Cubic
                                }
                            });
                        end);
                        u2.FireAllClients({
                            {
                                Name = "Rock Debris",
                                Data = {
                                    {
                                        Lifetime = 1.65,
                                        Radius = 18,
                                        Origin = HumanoidRootPart.CFrame,
                                        Amount = u5:NextInteger(25, 30)
                                    }
                                }
                            },
                            {
                                Name = "Q_RADIAL",
                                Data = {
                                    {
                                        Distance = 50,
                                        Origin = HumanoidRootPart.CFrame,
                                        Effect = { {
                                                Effect = "Camera Shake Preset",
                                                Arguments = { "Explosion" }
                                            } }
                                    }
                                }
                            },
                            {
                                Name = "HighlightObject",
                                Data = {
                                    Character,
                                    {
                                        FillTransparency = 0,
                                        OutlineTransparency = 0,
                                        Lifetime = 0.35,
                                        Name = "MetallixHighlight",
                                        Tween = true,
                                        Override = true,
                                        DepthMode = Enum.HighlightDepthMode.Occluded,
                                        FillColor = Color3.fromRGB(255, 255, 255),
                                        OutlineColor = Color3.fromRGB(255, 255, 255)
                                    }
                                }
                            }
                        });
                        Character:SetAttribute("_HyperHook", true);
                        u2.FireAllClients("Emit Particle V3", {
                            AutoSerialize = true,
                            Origin = HumanoidRootPart.CFrame * CFrame.new(0, -2.25, 0),
                            Particle = ClientAssets["Soul Survivor"].Metallix.SuperMetallixPoseInit,
                            Player = u35
                        });
                        local u36 = workspace.Effects:FindFirstChild(Character.Name .. "MetallixPoseAura");
                        u36.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, Humanoid.HipHeight, 0);
                        local u37 = ParticleHandler.AttachTo(u36, {
                            Part = HumanoidRootPart,
                            Offset = CFrame.new(0, 2.25, 0)
                        });
                        ParticleHandler.EnableAllParticles(u36, true);
                        p34.Trove:Add(function() -- Line: 773
                            -- upvalues: u37 (copy), u36 (copy), ParticleHandler (ref)
                            if u37 then
                                u37:Destroy();
                                u36.Name = "DisappearingAura";
                                u36.Anchored = true;
                            end;

                            task.delay(ParticleHandler.EnableAllParticles(u36, false), u36.Destroy, u36);
                        end);
                        local v38 = workspace.Effects:FindFirstChild("MetallixAura" .. Character.Name);
                        local u39 = {};

                        for _, child in Character:GetChildren() do
                            if child:IsA("BasePart") and child:FindFirstChild("Container") then
                                for _, child2 in child.Container:GetChildren() do
                                    if child2:IsA("BasePart") then
                                        if child2:GetAttribute("Awakening") then
                                            table.insert(u39, child2);
                                            child2.Transparency = 0;
                                        else
                                            child2.Transparency = 1;
                                        end;
                                    end;
                                end;
                            end;
                        end;

                        local v40 = workspace.Effects:FindFirstChild(Character.Name .. "MetallixHair");

                        if v40 then
                            for _, child in v40:GetChildren() do
                                table.insert(u39, child:FindFirstChildOfClass("SpecialMesh"));
                            end;
                        end;

                        if v38 then
                            local v41 = {};

                            for _, descendant in v38:GetDescendants() do
                                if descendant:IsA("ParticleEmitter") or descendant:IsA("PointLight") then
                                    table.insert(v41, descendant);
                                end;
                            end;

                            u39 = TableUtil.Extend(u39, v41);
                            table.clear(v41);
                        end;

                        for _, descendant in u36:GetDescendants() do
                            if descendant:IsA("ParticleEmitter") and string.find(descendant.Name, "RGB") then
                                table.insert(u39, descendant);
                            end;
                        end;

                        if not Character:GetAttribute("CosmeticsOn") then
                            table.insert(u39, u36);
                        end;

                        task.spawn(function() -- Line: 827
                            -- upvalues: RunService (ref), u2 (ref), Character (copy), u39 (ref)
                            RunService.PostSimulation:Wait();
                            RunService.PreSimulation:Wait();
                            u2.FireAllClients("HyperColorScheme", {
                                Hook = "_HyperHook",
                                VertexMultiplier = 3,
                                Character = Character,
                                Objects = u39
                            });
                        end);
                    end;
                end,

                PoseEnd = function(p42) -- Line: 839, Name: PoseEnd
                    -- upvalues: Players (copy), u1 (ref), u2 (ref)
                    local Character = p42.Character;
                    local v43 = p42.Player or Players:GetPlayerFromCharacter(Character);
                    local HumanoidRootPart = Character.HumanoidRootPart;
                    local Humanoid = Character.Humanoid;
                    local v44 = u1.FetchSound(Character, "Awakening");
                    local v45 = u1.GetSound(Character, "AwakeningAura");
                    local v46 = u1.GetSound(Character, "HyperAwakening");
                    Character:SetAttribute("_HyperHook", nil);
                    u1.StopSound(Character, "StanceAmbience");
                    u1.StopSound(Character, "Awakened-StanceAmbience");

                    if Character:GetAttribute("AwakenPose") and (v44 and not Character:GetAttribute("HyperForm")) then
                        if Character:GetAttribute("Awakening") then
                            v44:Resume();

                            if v45 then
                                v45:Resume();
                            end;
                        end;

                        local v47 = workspace.Effects:FindFirstChild(Character.Name .. "MetallixMasterEmerald");

                        if v47 and v47:FindFirstChild("EmeraldWeld") then
                            v47.EmeraldWeld:Destroy();
                            v47.Anchored = true;
                        end;

                        if not (v43 and v43.Data.Skin:GetAttribute("UnusualHueId")) then
                            for _, child in Character:GetChildren() do
                                if child:IsA("BasePart") and child:FindFirstChild("Container") then
                                    for _, child2 in child.Container:GetChildren() do
                                        if child2:IsA("BasePart") then
                                            child2.Transparency = child2:FindFirstChildOfClass("SurfaceAppearance") and 1 or 0;
                                        end;
                                    end;
                                end;
                            end;
                        end;

                        u1.PlaySound(Character, "PoseTeleportSFX");
                        u2.FireAllClients("SMBZTeleport", {
                            Speed = 1.5,
                            Character = Character,
                            Origin = Character.Torso.CFrame
                        });
                        local HipHeight = Humanoid.HipHeight;
                        Humanoid.HipHeight = 0;
                        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -HipHeight / 1.25, 0);
                        u2.FireClient(v43, "FOV Modifier", {
                            TweenInformation = {
                                Speed = 0.16666666666666666,
                                EasingStyle = Enum.EasingStyle.Cubic
                            }
                        });
                    end;

                    if Character:GetAttribute("HyperForm") and Character:GetAttribute("Awakening") then
                        v46:Resume();
                    end;

                    Character:SetAttribute("AwakenPose", nil);
                    Character:SetAttribute("HyperMusicOn", nil);
                end
            }
        },
        ["Rush Attack"] = {
            Search = {
                Hitbox = {
                    Size = 35,
                    HitboxType = "ClientHitbox"
                }
            },
            ["LMB-1"] = {
                HitSounds = { {
                        SoundId = 110101130958420,
                        Volume = 2
                    } },
                HitRemotes = { v20 }
            },
            ["LMB-2"] = {
                HitSounds = { {
                        SoundId = 110101130958420,
                        Volume = 2
                    } },
                HitRemotes = { v20 }
            },
            ["LMB-3"] = {
                HitSounds = { {
                        SoundId = 110101130958420,
                        Volume = 2
                    } },
                HitRemotes = { v20 }
            },
            ["LMB-4"] = {
                HitSounds = { {
                        SoundId = 115492612910186,
                        Volume = 2
                    } },
                HitRemotes = { v21 }
            },
            Callbacks = {
                PreAnim = function(p48, p49) -- Line: 959, Name: PreAnim
                    -- upvalues: u1 (ref), u2 (ref)
                    local Stats = p48.Stats;
                    local Count = p49.MoveState.Count;
                    local _ = p48.Player;
                    local Character = p48.Character;
                    local RootPart = p48.RootPart;

                    if not Character:GetAttribute("HyperForm") then
                        return;
                    end;

                    if Count == 1 or Count == 4 then
                        local v50 = {};

                        for _, v in u1.Hitbox({
                            Caster = Character,
                            Stats = Stats.Search
                        }) do
                            local HumanoidRootPart = v.Character:FindFirstChild("HumanoidRootPart");
                            local v51 = v.Character:FindFirstChildOfClass("Humanoid");

                            if HumanoidRootPart and (v51 and (not v51 or v51.Health > 0)) then
                                table.insert(v50, {
                                    Character = v.Character,
                                    Part = HumanoidRootPart,
                                    Distance = (RootPart.Position - HumanoidRootPart.Position).Magnitude
                                });
                            end;
                        end;

                        table.sort(v50, function(p52, p53) -- Line: 988
                            return p52.Distance < p53.Distance;
                        end);
                        local v54 = v50[1];

                        if v54 then
                            local HumanoidRootPart = v54.Character:FindFirstChild("HumanoidRootPart");
                            local v55 = Vector3.new(RootPart.CFrame.Position.X, HumanoidRootPart.Position.Y, RootPart.CFrame.Position.Z);
                            local v56 = CFrame.lookAt(v55, HumanoidRootPart.Position);
                            local v57 = RaycastParams.new();
                            v57.FilterType = Enum.RaycastFilterType.Include;
                            v57.FilterDescendantsInstances = { workspace.Map };
                            local v58 = 6;
                            local v59 = u1.RaycastMap(HumanoidRootPart.Position, -v56.LookVector * v58);

                            if v59 then
                                v58 = (HumanoidRootPart.Position - v59.Position).Magnitude;
                            end;

                            u1.GetMetadata(Character);
                            local v60 = HumanoidRootPart.Position + -v56.LookVector * (v58 - 2);

                            if v54.Distance > 9 then
                                u1.PlaySound(p48.AbilityModel, "AwakeningTeleportSFX");
                                u2.FireAllClients("SMBZTeleport", {
                                    Speed = 1.5,
                                    Character = Character,
                                    Origin = RootPart.CFrame
                                });
                            end;

                            RootPart.CFrame = CFrame.lookAt(v60, HumanoidRootPart.Position);
                        end;
                    end;
                end
            }
        },
        ["Thy End Is Now"] = {
            VoicelineRange = 4,
            Hit = {
                HitSounds = { {
                        SoundId = 117893863805760,
                        Volume = 2
                    } },
                HitRemotes = { v20 }
            },
            Finisher = {
                HitSounds = { {
                        SoundId = 123851107928841,
                        Volume = 2
                    } },
                HitRemotes = { v21 }
            }
        },
        ["Prepare Thyself"] = {
            HitSounds = { {
                    SoundId = "",
                    Volume = 0
                } },
            HyperMode = {
                Burst = {
                    Damage = 15,
                    Priority = EnumsModule.Intangible.Quickstep,
                    Hitbox = {
                        Type = "Magnitude",
                        Size = 69,
                        Origin = CFrame.identity
                    },
                    Knockback = {
                        RelativeTowards = "Target",
                        Speed = 40,
                        Velocity = Vector3.new(0, 22.5, 0),
                        Time = 0.15
                    },
                    Ragdoll = {
                        Time = 1,
                        Override = true
                    },
                    Block = {
                        BypassCounter = true,
                        Blockable = true,
                        PerfectBlockable = false
                    }
                },
                Explosion = {
                    Damage = 45,
                    Priority = EnumsModule.Intangible.Quickstep,
                    Hitbox = {
                        Type = "Magnitude",
                        Size = 37.5,
                        Origin = CFrame.identity
                    },
                    Block = {
                        Unblockable = true,
                        BypassCounter = true,
                        Blockable = false,
                        PerfectBlockable = false,
                        BlockCancel = true,
                        PerfectBlockCancel = true
                    }
                }
            }
        },
        Uppercut = {
            VoicelineRange = 2,
            HitSounds = { {
                    SoundId = 131843489296229,
                    Volume = 2
                } },
            HitRemotes = { v20 }
        },
        Overhead = {
            Hit = {
                HitSounds = { {
                        SoundId = 119814764520418,
                        Volume = 2
                    } },
                HitRemotes = { v21 }
            }
        },
        Useless = {
            Attack = {
                HitSounds = { {
                        SoundId = 115884861622905,
                        Volume = 2
                    } },
                HitRemotes = { v21 }
            }
        },
        Judgement = {
            Hit = {
                HitSounds = { {
                        SoundId = 83165951984803,
                        Volume = 2
                    } },
                HitRemotes = { v21 }
            },
            Explosion = {
                HitRemotes = { v20 }
            }
        },
        Die = {
            Hit = {
                HitRemotes = { v21 }
            },
            Explosion = {
                HitRemotes = { v20 }
            }
        },
        Crush = {
            Hit = {
                HitRemotes = { v21 }
            },
            Explosion = {
                HitRemotes = { v20 }
            },
            Burst = {
                TrueDamage = true,
                Damage = 5,
                MinHealth = 1,
                IgnoreProcessing = true,
                Priority = EnumsModule.Intangible.Quickstep,
                Hitbox = {
                    Type = "Magnitude",
                    Size = 69
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Speed = 5,
                    Velocity = Vector3.new(0, 25, 0),
                    Time = 0.225
                },
                Ragdoll = {
                    Time = 1.5,
                    Intangible = false
                },
                StatusEffects = { {
                        ApplyTo = "Target",
                        Name = "Mangle",
                        Lifetime = 2,
                        Overrides = {
                            Lifetime = 2
                        }
                    } },
                Block = {
                    BypassCounter = true,
                    Blockable = true,
                    PerfectBlockable = false
                }
            }
        },
        Brutalize = {
            VoicelineRange = 2
        },
        Timestop = {
            Active = true,
            Actionable = {
                Active = true,
                Timestopped = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Sequence = {
                { 0, "PlayAnim", "Chaos Control" },
                { 0, "PlaySound", "Chaos Control" },
                { 0, "PlaySound", "Chaos Control Voiceline" },
                { 0, "CreateTag", "MaxWalkSpeed", 0 },
                { 0, "CreateTag", "MaxJumpPower", 0 },
                { 25, function(p61, p62, p63) -- Line: 1267
                        -- upvalues: ClientAssets (copy), SoundGroups (copy), ParticleHandler (copy), TweenService (copy)
                        local Character = p62.Character;
                        local Trove2 = p62.Trove;
                        local u64 = ClientAssets["Soul Survivor"].Metallix.ChaosEmerald:Clone();
                        SoundGroups:AssignSoundTag(u64.SFX);
                        u64.Parent = workspace.Effects;
                        local u65 = ParticleHandler.AttachTo(u64, {
                            Part = Character["Left Arm"],
                            Offset = (CFrame.new(0, -1.75, 0) * CFrame.Angles(0, 0, 3.141592653589793)):Inverse()
                        });
                        u64.SFX:Play();
                        Trove2:Add(function() -- Line: 1281
                            -- upvalues: u65 (copy), u64 (copy), ParticleHandler (ref), TweenService (ref)
                            if not u65 then
                                if u64 then
                                    u64:Destroy();
                                end;

                                return;
                            end;

                            u65:Destroy();
                            u64.Anchored = true;
                            ParticleHandler.DestroyByMaxLifetime(u64, ParticleHandler.EnableAllParticles(u64, false));
                            TweenService:Create(u64, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                Transparency = 1,
                                CFrame = CFrame.new(u64.Position) * CFrame.new(0, -1, 0)
                            }):Play();
                        end);
                    end },
                { 57, "Timestop" },
                { 90, "End" }
            },
            Meter = {
                RequiredLevel = 1,
                RemoveMeter = false
            },
            Timestop = {
                Time = 3.75,
                Size = 200,
                IgnoreCooldown = true,
                StopSounds = { "Chaos Control Stop" },
                ResumeSounds = { "Chaos Control Resume" },
                Callbacks = {
                    Stop = function(p66, p67) -- Line: 1315, Name: Stop
                        -- upvalues: u1 (ref), TweenService (copy)
                        if not p66.Character then
                            return;
                        end;

                        TweenService:Create(u1.GetSound(p66.Character, "HyperAwakening").Muffler, TweenInfo.new(1.75), {
                            HighGain = -45,
                            LowGain = 5,
                            MidGain = -30
                        }):Play();
                    end,

                    Resume = function(p68, p69) -- Line: 1325, Name: Resume
                        -- upvalues: u1 (ref), TweenService (copy)
                        if not p68.Character then
                            return;
                        end;

                        TweenService:Create(u1.GetSound(p68.Character, "HyperAwakening").Muffler, TweenInfo.new(1.5), {
                            HighGain = 0,
                            LowGain = 0,
                            MidGain = 0
                        }):Play();
                    end
                }
            }
        },
        ["Timestop Movement"] = {
            Time = 6,
            Actionable = {
                Timestopped = false
            },
            Meter = {
                RequiredLevel = 1,
                RemoveMeter = false
            }
        },
        HyperTeleport = {
            Distance = 20,
            WaitTime = 0.125,
            Active = true,
            Actionable = {
                Active = true
            },
            ClientActionable = {
                Active = true
            },
            Cooldown = {
                Time = 1.75
            },

            Invoke = function(p70) -- Line: 1364, Name: Invoke
                -- upvalues: Knit (copy), EffectsHandler (copy)
                local Character = p70.Character;
                local Stats = p70.Stats;
                local Humanoid = Character:WaitForChild("Humanoid");
                local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
                Knit.GetController("CombatController");
                Knit.GetController("MoveInputController");
                local v71 = Knit.GetService("MoveInputService");
                local v72 = RaycastParams.new();
                v72.FilterType = Enum.RaycastFilterType.Exclude;
                v72.FilterDescendantsInstances = { Character, workspace.Effects, workspace.ItemSpawns };
                local v73 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
                local Distance = Stats.Distance;
                local v74 = workspace:Raycast(HumanoidRootPart.Position, v73 * Distance, v72);

                if v74 then
                    Distance = (HumanoidRootPart.Position - v74.Position).Magnitude;
                end;

                local v75 = HumanoidRootPart.CFrame + CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart.Position + v73).LookVector.Unit * Distance;
                v71:FireInput(p70.RawInput, v75);
                EffectsHandler.Wait(Stats.WaitTime);
            end
        },
        WEAK = {
            Burst = {
                Priority = EnumsModule.Intangible.Quickstep,
                Hitbox = {
                    Type = "Magnitude",
                    Size = 100
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Speed = 65,
                    Velocity = Vector3.new(0, 25, 0),
                    Time = 0.225
                },
                Ragdoll = {
                    Time = 1.25,
                    Override = true
                },
                Block = {
                    Unblockable = true,
                    BypassCounter = true,
                    Blockable = false,
                    PerfectBlockable = false,
                    BlockCancel = true,
                    PerfectBlockCancel = true
                }
            }
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 107992870527395,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 73704024603947,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 122289958129416,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 114909678305843,
            Volume = 2
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 113144852743758,
            Volume = 4.25
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 117732061830051,
            Volume = 4.25
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 95842515881579,
            Volume = 4.25
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 84994110603986,
            Volume = 4.25
        },
        ThyEndIsNow = {
            SoundId = 78981788629420,
            Volume = 2
        },
        ["ThyEndIsNow-Swing-1"] = {
            SoundId = 86004810510739,
            Volume = 2.35
        },
        ["ThyEndIsNow-Swing-2"] = {
            SoundId = 86727146501031,
            Volume = 2.35
        },
        ["ThyEndIsNow-Swing-3"] = {
            SoundId = 91752534010721,
            Volume = 2.35
        },
        ["ThyEndIsNow-Swing-4"] = {
            SoundId = 123520546622292,
            Volume = 2.35
        },
        ["ThyEndIsNowVoiceline-1"] = {
            SoundId = 115116654056742,
            Volume = 4.25
        },
        ["ThyEndIsNowVoiceline-2"] = {
            SoundId = 72818633971056,
            Volume = 4.25
        },
        ["ThyEndIsNowVoiceline-3"] = {
            SoundId = 74563699081802,
            Volume = 4.25
        },
        ["ThyEndIsNowVoiceline-4"] = {
            SoundId = 70465381655782,
            Volume = 4.25
        },
        Die = {
            SoundId = 87356916548850,
            Volume = 2
        },
        ["Die Slam"] = {
            SoundId = 74867508665664,
            Volume = 2
        },
        ["DieVoiceline-1"] = {
            SoundId = 104300688125112,
            Volume = 4.25
        },
        ["DieVoiceline-2"] = {
            SoundId = 120052146166504,
            Volume = 4.25
        },
        Uppercut = {
            SoundId = 94939826139412,
            Volume = 2
        },
        ["UppercutVoiceline-1"] = {
            SoundId = 134674201052840,
            Volume = 4.25
        },
        ["UppercutVoiceline-2"] = {
            SoundId = 96950494909253,
            Volume = 4.25
        },
        Crush = {
            SoundId = 122137305083779,
            Volume = 2
        },
        ["Crush Explosion"] = {
            SoundId = 90887841466782,
            Volume = 2
        },
        CrushVoiceline = {
            SoundId = 137590919410054,
            Volume = 4.25
        },
        Judgement = {
            SoundId = 130983679456041,
            Volume = 2
        },
        ["JudgementVoiceline-1"] = {
            SoundId = 85890032877971,
            Volume = 4.25
        },
        ["JudgementVoiceline-2"] = {
            SoundId = 80851427076366,
            Volume = 4.25
        },
        PrepareThyself = {
            SoundId = 136637033905183,
            Volume = 2
        },
        ["PrepareThyself Projectile"] = {
            SoundId = 95467989626410,
            Volume = 2
        },
        ["PrepareThyselfVoiceline-1"] = {
            SoundId = 76586054880139,
            Volume = 4.25
        },
        ["PrepareThyselfVoiceline-2"] = {
            SoundId = 82078139314059,
            Volume = 4.25
        },
        UselessStartup = {
            SoundId = 89049886974891,
            Volume = 2
        },
        UselessStartupVoiceline = {
            SoundId = 75985714849163,
            Volume = 4.25
        },
        Useless = {
            SoundId = 78045919628732,
            Volume = 2
        },
        UselessVoiceline = {
            SoundId = 100474731262580,
            Volume = 4.25
        },
        Overhead = {
            SoundId = 85375732900437,
            Volume = 2
        },
        OverheadVoiceline = {
            SoundId = 105626536143189,
            Volume = 4.25
        },
        GrabVoiceline = {
            SoundId = 81902147511336,
            Volume = 4.25
        },
        GrabbedVoiceline = {
            SoundId = 91853583607756,
            Volume = 4.25
        },
        Brutalize = {
            SoundId = 102858996299147,
            Volume = 2
        },
        ["Brutalize Voiceline-1"] = {
            SoundId = 96426424567982,
            Volume = 4.25
        },
        ["Brutalize Voiceline-2"] = {
            SoundId = 131944563909316,
            Volume = 4.25
        },
        ["BrutalizeStartup Voiceline"] = {
            SoundId = 81902147511336,
            Volume = 4.25
        },
        BrutalizeStartup = {
            SoundId = 75208949010833,
            Volume = 2
        },
        PoseMusic = {
            SoundId = "",
            Volume = 1.75
        },
        ["Death-Voiceline"] = {
            SoundId = 88834539404449,
            Volume = 4.25
        },
        AwakeningAura = {
            SoundId = 131792210419754,
            Volume = 1,
            RollOffMaxDistance = 92.5,
            Looped = true
        },
        AwakeningEnd = {
            SoundId = 6089044492,
            Volume = 1.5
        },
        AwakeningVoiceline = {
            SoundId = 92228661058777,
            Volume = 5
        },
        Awakening = {
            SoundId = 115111414213347,
            Volume = 2,
            Looped = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(12.5, 600000),
            LoopRegion = NumberRange.new(13.341, 600000)
        },
        AwakeningSFX = {
            SoundId = 73751424060018,
            Volume = 2.25
        },
        ["Awakening-PoseMusic-1"] = {
            SoundId = 139898048681034,
            Volume = 3.75,
            Looped = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(28.176, 600000),
            LoopRegion = NumberRange.new(47.665, 600000)
        },
        ["Awakening-PoseMusic-2"] = {
            SoundId = 115111414213347,
            Volume = 3.75,
            Looped = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(13.341, 600000)
        },
        ["Awakening-PoseMusic-3"] = {
            SoundId = 133418879230667,
            Volume = 3.75,
            Looped = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(6.028, 600000)
        },
        ["PoseMusic-1"] = {
            SoundId = 132101213333979,
            Volume = 3.75,
            Looped = true,
            PlaybackRegionsEnabled = false,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["PoseMusic-2"] = {
            SoundId = 113451981884592,
            Volume = 3.75,
            Looped = true,
            PlaybackRegionsEnabled = false,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["PoseMusic-3"] = {
            SoundId = 118972828672135,
            Volume = 3.75,
            Looped = true,
            PlaybackRegionsEnabled = false,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["EXE-PoseMusic-1"] = {
            SoundId = 91960344770417,
            PlaybackSpeed = 1.25,
            Volume = 3.75,
            Looped = true
        },
        ["EXE-PoseMusic-2"] = {
            SoundId = 123265205134148,
            PlaybackSpeed = 1.25,
            Volume = 3.75,
            Looped = true
        },
        ["EXE-Awakening"] = {
            SoundId = 115623229050277,
            Volume = 2,
            Looped = true
        },
        AwakeningTeleportSFX = {
            SoundId = 253255625,
            Volume = 2.5,
            PlaybackSpeed = 0.885,
            PlaybackRegionsEnabled = false,
            PlaybackRegion = NumberRange.new(0, 0.15)
        },
        TeleportSFX = {
            SoundId = 253255625,
            Volume = 2.5,
            PlaybackSpeed = 0.885,
            PlaybackRegionsEnabled = false,
            PlaybackRegion = NumberRange.new(0, 0.15)
        },
        PoseTeleportSFX = {
            SoundId = 200633492,
            Volume = 2
        },
        ["Explosion-1"] = {
            SoundId = 165970126,
            Volume = 3
        },
        ["Explosion-2"] = {
            SoundId = 165970390,
            Volume = 3.25
        },
        MeterUp2 = {
            SoundId = 101522263076771,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 127732594782432,
            Volume = 2
        },
        PoseSFX = {
            SoundId = 105004178083183,
            Volume = 2
        },
        ["Awakened-PoseSFX"] = {
            SoundId = 85910523586065,
            Volume = 3.25
        },
        StanceAmbience = {
            SoundId = 75501984892839,
            Volume = 2,
            Looped = true
        },
        ["Awakened-StanceAmbience"] = {
            SoundId = 114946134189997,
            Volume = 3,
            Looped = true
        },
        ["Awakened-HugeBurst"] = {
            SoundId = 79443484276850,
            Volume = 5,
            PlaybackSpeed = 0.965,
            RollOffMaxDistance = 650,
            RollOffMinDistance = 50
        },
        HyperAwakening = {
            SoundId = 99430013199076,
            Volume = 2.9,
            RollOffMaxDistance = 175,
            Looped = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0, 189.198),
            LoopRegion = NumberRange.new(21.573, 189.198),
            SoundEffects = {
                EqualizerSoundEffect = {
                    Name = "Muffler",
                    HighGain = 0,
                    LowGain = 0,
                    MidGain = 0
                }
            }
        },
        ["Chaos Control"] = {
            SoundId = 97139746446772,
            Volume = 10,
            SoundEffects = {
                DistortionSoundEffect = {
                    Level = 0.425
                }
            }
        },
        ["Chaos Control Voiceline"] = {
            SoundId = 104969689065365,
            Volume = 6.25
        },
        ["Chaos Control Stop"] = {
            SoundId = 86903330503550,
            Volume = 10,
            SoundEffects = {
                DistortionSoundEffect = {
                    Level = 0.5
                }
            }
        },
        ["Chaos Control Resume"] = {
            SoundId = 101493591512049,
            Volume = 10,
            SoundEffects = {
                DistortionSoundEffect = {
                    Level = 0.5
                }
            }
        },
        ["Glass Break"] = {
            SoundId = 6737582452,
            Volume = 4,
            RollOffMaxDistance = 175,
            RollOffMinDistance = 50
        },
        ["Damage Absorption"] = {
            SoundId = 17621472655,
            PlaybackSpeed = 1.25,
            Volume = 3,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 0.8
                }
            }
        },
        ["Massive Explosion"] = {
            SoundId = 116805338775766,
            Volume = 5,
            RollOffMaxDistance = 450,
            RollOffMinDistance = 100
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            },
            EXE = {
                Visible = false
            }
        },
        Quotes = {
            Universal = v6,
            EXE = v19
        }
    },
    Metadata = {
        PostRig = function(p76) -- Line: 1882, Name: PostRig
            -- upvalues: RunService (copy), Trove (copy), ParticleHandler (copy), u3 (ref), u1 (ref), u5 (copy), u4 (ref)
            local Player = p76.Player;
            local Character = p76.Character;

            if not (RunService:IsServer() and Player) then
                return;
            end;

            local v77 = Trove.new();
            v77:AttachToInstance(Character);

            if Player.Data.Skin:GetAttribute("UnusualHueId") then
                for _, child in Character:GetChildren() do
                    if child:IsA("BasePart") and child:FindFirstChild("Container") then
                        for _, child2 in child.Container:GetChildren() do
                            if child2:IsA("MeshPart") then
                                child2.Transparency = child2:FindFirstChildOfClass("SurfaceAppearance") and not child2:GetAttribute("Awakening") and 0 or 1;
                            end;
                        end;

                        ParticleHandler.Unusualify(child.Container, {
                            IncludeParts = true,
                            Player = Player,
                            Character = Character
                        });
                    end;
                end;
            end;

            if Player.Data.Skin:GetAttribute("UnusualHueId") == 72 then
                Character:SetAttribute("EvilEXE", true);
                u3:SetGroupVisible(Player, "Universal", false);
                u3:SetGroupVisible(Player, "EXE", true);
                local u78 = u1.GetSound(Character, "TeleportSFX");
                local u79 = u1.GetSound(Character, "AwakeningTeleportSFX");
                local u80 = u1.GetSound(Character, "Awakening");
                local u81 = u1.GetSound(Character, "EXE-Awakening");
                local SoundId = u78.SoundId;
                local SoundId2 = u79.SoundId;
                local Volume = u80.Volume;

                local function ToggleGlitchTP(p82) -- Line: 1919
                    -- upvalues: u78 (copy), SoundId (copy), u79 (copy), SoundId2 (copy)
                    u78.SoundId = p82 and "rbxassetid://9040512492" or SoundId;
                    u78.PlaybackRegionsEnabled = p82;
                    u79.SoundId = p82 and "rbxassetid://9040512492" or SoundId2;
                    u79.PlaybackRegionsEnabled = p82;
                end;

                v77:Connect(u78.Ended, function() -- Line: 1928
                    -- upvalues: u81 (copy), u5 (ref), u78 (copy), SoundId (copy), u79 (copy), SoundId2 (copy)
                    local v83 = u81.IsPlaying and true or u5:NextInteger(1, 2) == 1;
                    u78.SoundId = v83 and "rbxassetid://9040512492" or SoundId;
                    u78.PlaybackRegionsEnabled = v83;
                    u79.SoundId = v83 and "rbxassetid://9040512492" or SoundId2;
                    u79.PlaybackRegionsEnabled = v83;
                end);
                v77:Connect(u80.Played, function() -- Line: 1933
                    -- upvalues: u5 (ref), u81 (copy), u78 (copy), u79 (copy), u80 (copy)
                    if u5:NextInteger(1, 4) == 1 then
                        u81:Play();
                        u78.SoundId = "rbxassetid://9040512492";
                        u78.PlaybackRegionsEnabled = true;
                        u79.SoundId = "rbxassetid://9040512492";
                        u79.PlaybackRegionsEnabled = true;
                        u80.Volume = 0;
                    end;
                end);
                v77:Connect(u80.Stopped, function() -- Line: 1940
                    -- upvalues: u81 (copy), u80 (copy), Volume (copy)
                    u81:Stop();
                    u80.Volume = Volume;
                end);
                v77:Connect(u80.Paused, function() -- Line: 1944
                    -- upvalues: u80 (copy), Volume (copy), u81 (copy)
                    if u80.Volume < Volume then
                        u81:Pause();
                    end;
                end);
                v77:Connect(u80.Resumed, function() -- Line: 1949
                    -- upvalues: u80 (copy), Volume (copy), u81 (copy)
                    if u80.Volume < Volume then
                        u81:Resume();
                    end;
                end);
            end;

            local function MoveVisiblity(p84) -- Line: 1956
                -- upvalues: u4 (ref), Player (copy)
                u4:SetStateVisible(Player, "Unlock", p84);
                u4:SetGroupVisible(Player, "Unlock", p84);
            end;

            if Player:FindFirstChild("PersonalUnlocker") then
                u4:SetStateVisible(Player, "Unlock", false);
                u4:SetGroupVisible(Player, "Unlock", false);
                task.delay(0.3, function() -- Line: 1964
                    -- upvalues: Character (copy), u4 (ref), Player (copy)
                    Character:SetAttribute("CanGoHyper", false);
                    u4:SetStateVisible(Player, "Unlock", true);
                    u4:SetGroupVisible(Player, "Unlock", true);
                end);
            end;

            v77:Connect(Player.ChildAdded, function(p85) -- Line: 1969
                -- upvalues: Character (copy), u4 (ref), Player (copy)
                if p85:IsA("ValueBase") and p85.Name == "PersonalUnlocker" then
                    Character:SetAttribute("CanGoHyper", false);
                    u4:SetStateVisible(Player, "Unlock", true);
                    u4:SetGroupVisible(Player, "Unlock", true);
                end;
            end);
            v77:Connect(Player.ChildRemoved, function(p86) -- Line: 1976
                -- upvalues: Character (copy), u4 (ref), Player (copy)
                if p86:IsA("ValueBase") and p86.Name == "PersonalUnlocker" then
                    Character:SetAttribute("CanGoHyper", nil);
                    u4:SetStateVisible(Player, "Unlock", false);
                    u4:SetGroupVisible(Player, "Unlock", false);
                end;
            end);
        end
    }
};