  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local _ = Players.LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
Knit.OnStart():andThen(function() -- Line: 16
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), u4 (ref), u5 (ref), PathShortcuts (copy), u3 (ref)
    u1 = Knit.GetService("MoveInputService");
    u2 = Knit.GetService("EffectService");
    u4 = Knit.GetService("RigService");
    u5 = Knit.GetService("TagService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
require(Knit.Util.TableUtil);
local _ = ReplicatedStorage["Client Assets"];
local _ = ReplicatedStorage.Remotes.Output;
require(PathShortcuts.BaseStatsModule);
require(ReplicatedStorage.ReplicatedModules.Enums);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local v6 = {
    Hit = {
        SoundId = 17478853864,
        Volume = 1.4
    }
};

return {
    Inherit = {
        AbilityName = "Mero"
    },
    Sounds = {
        ["PoseMusic-1"] = {
            SoundId = 17488667126,
            Volume = 1,
            Looped = true
        },
        ["PoseMusic-2"] = {
            SoundId = 17488667927,
            Volume = 1,
            Looped = true
        },
        ["PoseMusic-3"] = {
            SoundId = 17488668486,
            Volume = 1,
            Looped = true
        },
        ["Pose Loop SFX"] = {
            SoundId = 17488668623,
            Volume = 1,
            Looped = true
        },
        ["Pose Startup SFX"] = {
            SoundId = 17488667218,
            Volume = 1
        },
        ["Lovely Legwork Voiceline"] = {
            SoundId = 17478854122,
            Volume = 1.8
        },
        ["Lovely Legwork SFX"] = {
            SoundId = 17478854005,
            Volume = 1
        },
        ["Magna Voiceline"] = {
            SoundId = 17488667304,
            Volume = 1
        },
        ["Magna SFX"] = {
            SoundId = 16835043092,
            Volume = 1
        },
        ["Mellow Voiceline"] = {
            SoundId = 17210342186,
            Volume = 1
        },
        ["Mellow SFX"] = {
            SoundId = 16835045346,
            Volume = 1
        },
        ["Perfume Fever Voiceline"] = {
            SoundId = 17478853622,
            Volume = 1.3
        },
        ["Perfume Fever SFX"] = {
            SoundId = 17478853742,
            Volume = 1
        },
        ["Pistol Kiss Startup Voiceline"] = {
            SoundId = 17210344439,
            Volume = 1
        },
        ["Pistol Kiss Voiceline"] = {
            SoundId = 16835045820,
            Volume = 0
        },
        ["Pistol Kiss SFX"] = {
            SoundId = 16835045033,
            Volume = 1
        },
        ["Pistol Kiss Charging"] = {
            SoundId = 16835043507,
            Volume = 1
        },
        ["Pistol Kiss Charged Shot"] = {
            SoundId = 16835043212,
            Volume = 1
        },
        ["Pistol Kiss Uncharged Shot"] = {
            SoundId = 16835044082,
            Volume = 1
        },
        ["Pistol Kiss Wall Impact"] = {
            SoundId = 16841223259,
            Volume = 1
        },
        ["Pistol Kiss Charge Indicator"] = {
            SoundId = 16843849529,
            Volume = 1
        },
        ["Queen Stomp Startup Voiceline"] = {
            SoundId = 17478854306,
            Volume = 0
        },
        ["Queen Stomp Startup SFX"] = {
            SoundId = 16835046831,
            Volume = 1
        },
        ["Queen Stomp Voiceline"] = {
            SoundId = 17478853322,
            Volume = 1
        },
        ["Queen Stomp SFX"] = {
            SoundId = 16835046609,
            Volume = 1
        },
        Petrify = {
            SoundId = 16835043337,
            Volume = 1
        },
        Unpetrify = {
            SoundId = 16835044897,
            Volume = 1
        },
        ["Infatuation Voiceline"] = {
            SoundId = 17654943747,
            Volume = 2.5
        },
        ["Infatuation SFX"] = {
            SoundId = 16835047114,
            Volume = 0.85,
            RollOffMaxDistance = 200
        },
        ["Infatuation Release SFX"] = {
            SoundId = 16841224230,
            Volume = 1,
            RollOffMaxDistance = 200
        },
        ["Petrifying Burst SFX"] = {
            SoundId = 17488667404,
            Volume = 1
        },
        ["Petrifying Burst Shoot SFX"] = {
            SoundId = 17488668712,
            Volume = 1
        },
        ["Petrifying Burst Voiceline"] = {
            SoundId = 17210342852,
            Volume = 1
        },
        ["Petrifying Burst Land"] = {
            SoundId = 16844370526,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 17210343515,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 17210344606,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 17210343360,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 17210343015,
            Volume = 1
        },
        ["LMB-1SFX"] = {
            SoundId = 17654942272,
            Volume = 1
        },
        ["LMB-2SFX"] = {
            SoundId = 17654947268,
            Volume = 1
        },
        ["LMB-3SFX"] = {
            SoundId = 17654956084,
            Volume = 1
        },
        ["LMB-4SFX"] = {
            SoundId = 17654955370,
            Volume = 1
        },
        ["LMB-4Slam"] = {
            SoundId = 17654947274,
            Volume = 1
        },
        ["Heartless Startup Voiceline"] = {
            SoundId = 17210342420,
            Volume = 1
        },
        ["Heartless Startup SFX"] = {
            SoundId = 16846806925,
            Volume = 1
        },
        ["Heartless Voiceline"] = {
            SoundId = 17478853487,
            Volume = 1
        },
        ["Heartless SFX"] = {
            SoundId = 16846807436,
            Volume = 1
        },
        ["Cupid\'s Yumi Shoot SFX"] = {
            SoundId = 16901353377,
            Volume = 1
        },
        ["Cupid\'s Yumi SFX"] = {
            SoundId = 17488668888,
            Volume = 1
        },
        ["Cupid\'s Yumi Voiceline"] = {
            SoundId = 17488668796,
            Volume = 1
        },
        ["Cupid\'s Yumi Explode"] = {
            SoundId = 16901353666,
            Volume = 1
        }
    },
    Animations = {
        Movement = {
            Walk = 17478267145,
            Run = 17478264552
        },
        Idle = {
            Idle = 17478216370
        },
        Action = {
            PoseIdle = 17448954533,
            PoseTransition = 17448944319,
            CrewmatePose = 17449320712,
            ["LMB-1"] = 17478223939,
            ["LMB-2"] = 17478236923,
            ["LMB-3"] = 17478251810,
            ["LMB-4"] = 17478253500,
            ["Perfume Fever"] = 17478297751,
            ["Petrifying Burst"] = 17478310093,
            ["Cupid\'s Yumi"] = 17478319582,
            ["Pistol Kiss Start"] = 17617670819,
            ["Pistol Kiss Loop"] = 17617672893,
            ["Pistol Kiss End"] = 17617679836
        }
    },
    Stats = {
        Pose = {
            MusicAmount = 3,
            Callbacks = {
                PoseLoop = function(p7, p8) -- Line: 370, Name: PoseLoop
                    -- upvalues: u3 (ref), ParticleHandler (copy), TweenService (copy)
                    local _ = p7.Stats;
                    local _ = p7.Player;
                    local Character = p7.Character;
                    local _ = p7.RootPart;
                    local Trove = p8.Trove;
                    Trove:Add(u3.PlaySound(Character, "Pose Loop SFX"), "Stop");
                    local u9 = Trove:Construct(Instance, "IntValue");
                    u9.Parent = Character;

                    local function OnReset() -- Line: 386
                        -- upvalues: Character (copy), u9 (copy), ParticleHandler (ref), TweenService (ref)
                        for _, descendant in Character:GetDescendants() do
                            if descendant:IsA("ParticleEmitter") and descendant.Parent.Name ~= "ChefHatSigil" then
                                descendant.Enabled = false;
                                descendant:Clear();
                            end;
                        end;

                        task.delay(2.3666666666666667, function() -- Line: 396
                            -- upvalues: u9 (ref), Character (ref)
                            if not u9:IsDescendantOf(game) then
                                return;
                            end;

                            local Main = Character.HumanoidRootPart:FindFirstChild("Main");

                            if not Main then
                                return;
                            end;

                            if Main.Handle.CuttingBoard then
                                Main.Handle.CuttingBoard.Part.Attachment.Cut:Emit(1);
                            end;
                        end);
                        task.delay(4.933333333333334, function() -- Line: 414
                            -- upvalues: u9 (ref), Character (ref), ParticleHandler (ref), TweenService (ref)
                            if not u9:IsDescendantOf(game) then
                                return;
                            end;

                            local Main = Character.HumanoidRootPart:FindFirstChild("Main");

                            if not Main then
                                return;
                            end;

                            local Fire = Main.Handle.Model1.Fire;
                            ParticleHandler.EnableParticles(Fire, true);
                            local Smoke = Character["Left Arm"].Pan:FindFirstChild("Smoke");

                            if Smoke then
                                ParticleHandler.EnableParticles(Smoke, true);
                            end;

                            task.delay(10.9, function() -- Line: 433
                                -- upvalues: Fire (copy), ParticleHandler (ref), Smoke (copy)
                                if Fire and Fire:IsDescendantOf(game) then
                                    ParticleHandler.EnableParticles(Fire, false);
                                end;

                                if Smoke and Smoke:IsDescendantOf(game) then
                                    ParticleHandler.EnableParticles(Smoke, true);
                                end;
                            end);
                            local Meat = Character["Left Arm"]:FindFirstChild("Meat");

                            if Meat then
                                ParticleHandler.EnableParticles(Meat, true);
                            end;

                            local Meat1 = Character.HumanoidRootPart:FindFirstChild("Meat1", true);

                            if Meat1 then
                                ParticleHandler.EnableParticles(Meat1, true);
                            end;

                            for _, v in { 750 } do
                                task.delay((v - 296) / 60, function() -- Line: 458
                                    -- upvalues: u9 (ref), Character (ref), ParticleHandler (ref), TweenService (ref)
                                    if not u9:IsDescendantOf(game) then
                                        return;
                                    end;

                                    local Pan = Character["Left Arm"]:FindFirstChild("Pan");

                                    if Pan then
                                        ParticleHandler.Emit(Pan.FlameEmit, ParticleHandler.GenerateEmitInfo(Pan.FlameEmit));
                                        Pan.FlameEmit.PointLight.Brightness = 12;
                                        TweenService:Create(Pan.FlameEmit.PointLight, TweenInfo.new(0.5), {
                                            Brightness = 0
                                        }):Play();
                                    end;
                                end);
                            end;
                        end);
                        task.delay(7.283333333333333, function() -- Line: 478
                            -- upvalues: u9 (ref), Character (ref)
                            for _, v in { "SaltShaker", "Pepper Shaker" } do
                                if not u9:IsDescendantOf(game) then
                                    return;
                                end;

                                local u10 = Character["Right Arm"]:FindFirstChild(v);

                                if not u10 then
                                    return;
                                end;

                                u10.PrimaryPart.Attachment.SaltPepper.Enabled = true;
                                task.delay(1.25, function() -- Line: 491
                                    -- upvalues: u10 (copy)
                                    if u10:IsDescendantOf(game) then
                                        u10.PrimaryPart.Attachment.SaltPepper.Enabled = false;
                                    end;
                                end);
                            end;
                        end);
                        task.delay(12.083333333333334, function() -- Line: 501
                            -- upvalues: u9 (ref), Character (ref), ParticleHandler (ref)
                            if not u9:IsDescendantOf(game) then
                                return;
                            end;

                            local Bottle = Character["Right Arm"]:FindFirstChild("Bottle");

                            if not Bottle then
                                return;
                            end;

                            ParticleHandler.EnableParticles(Bottle, true);
                            task.delay(0.5, function() -- Line: 513
                                -- upvalues: Bottle (copy), ParticleHandler (ref)
                                if Bottle:IsDescendantOf(game) then
                                    ParticleHandler.EnableParticles(Bottle, false);
                                end;
                            end);
                        end);
                    end;

                    OnReset();
                    p8.AnimLoop.DidLoop:Connect(OnReset);
                end,

                PoseTransition = function(u11, p12) -- Line: 527, Name: PoseTransition
                    -- upvalues: AssetHandler (copy), TweenService (copy), ParticleHandler (copy), u5 (ref), u3 (ref)
                    local _ = u11.Stats;
                    local _ = u11.Player;
                    local Character = u11.Character;
                    local RootPart = u11.RootPart;
                    local Trove = p12.Trove;
                    local Tags = u11.Tags;
                    local Animator = u11.Animator;

                    for _, child in AssetHandler.GetAsset("Models/Pose", u11):GetChildren() do
                        if child:IsA("Folder") then
                            local v13 = Character[child.Name];

                            for _, child2 in child:GetChildren() do
                                local v14 = Trove:Clone(child2);
                                v14.Parent = v13;
                                local v15 = Trove:Add(v14:FindFirstChild("MainMotor6D", true));
                                v15.Name = v15.Parent.Name;
                                v15.Part0 = v13;
                                v15.Parent = v13;

                                for _, descendant in v14:GetDescendants() do
                                    if descendant:IsA("BasePart") then
                                        local Transparency = descendant.Transparency;
                                        descendant.Transparency = 1;
                                        TweenService:Create(descendant, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                            Transparency = Transparency
                                        }):Play();
                                    end;
                                end;
                            end;
                        end;
                    end;

                    task.delay(1.2333333333333334, function() -- Line: 568
                        -- upvalues: Character (copy), Trove (copy), AssetHandler (ref), u11 (copy), ParticleHandler (ref), RootPart (copy)
                        local Hat = Character["Right Arm"]:FindFirstChild("Hat");
                        local HandleHat = Character["Right Arm"]:FindFirstChild("HandleHat");

                        if Hat and HandleHat then
                            HandleHat.Part0 = Character.Head;
                            HandleHat.C0 = CFrame.new(0, 0.7, 0) * CFrame.Angles(3.141592653589793, 1.5707963267948966, 0);
                            Hat.Parent = Character.Head;
                            HandleHat.Parent = Character.Head;

                            for _, child in Character:GetChildren() do
                                if child:IsA("Accessory") and child.Handle:FindFirstChild("HatAttachment") then
                                    local Transparency = child.Handle.Transparency;
                                    child.Handle.Transparency = 1;
                                    Trove:Add(function() -- Line: 584
                                        -- upvalues: child (copy), Transparency (copy)
                                        child.Handle.Transparency = Transparency;
                                    end);
                                end;
                            end;

                            local v16 = Trove:Clone(AssetHandler.GetAsset("Models/Pose/HeadSigil", u11));
                            v16.Parent = Character;
                            ParticleHandler.AttachTo(v16, {
                                Part = RootPart,
                                Offset = CFrame.new(0, -3, 0)
                            });
                        end;
                    end);
                    Trove:Add(u5:Add(Tags, "NoRotate"));
                    u3.PlaySound(Character, "Pose SFX");
                    Trove:Add(function() -- Line: 605
                        -- upvalues: u3 (ref), Character (copy)
                        u3.StopSound(Character, "Pose SFX");
                    end);
                    local u17 = Trove:Clone(AssetHandler.GetAsset("Models/Pose/Crewmate", u11));
                    u17:PivotTo(RootPart.CFrame);
                    u17.Parent = workspace.Effects;
                    local v18 = Animator:GetAnimation("CrewmatePose");
                    local v19 = u17.Humanoid:LoadAnimation(v18.Animation);
                    v19:Play();
                    Trove:Connect(v19:GetMarkerReachedSignal("Travel"), function(p20) -- Line: 618
                        -- upvalues: u17 (copy), RootPart (copy), TweenService (ref)
                        local v21 = tonumber(p20);
                        u17.HumanoidRootPart.CFrame = RootPart.CFrame;

                        for _, descendant in u17:GetDescendants() do
                            if (descendant:IsA("BasePart") or descendant:IsA("Decal")) and (descendant.Name ~= "HumanoidRootPart" and (descendant.Parent.Name ~= "Meat" or v21 ~= 0)) then
                                if v21 == 0 then
                                    descendant.Transparency = 1;
                                end;

                                TweenService:Create(descendant, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                    Transparency = v21
                                }):Play();
                            end;
                        end;
                    end);
                    Trove:Connect(v19:GetMarkerReachedSignal("GrabMeat"), function() -- Line: 640
                        -- upvalues: u17 (copy), RootPart (copy)
                        u17["Right Arm"].Meat.Mesh1.Transparency = 0;
                        u17["Right Arm"].Meat.Mesh2.Transparency = 0;
                        RootPart.Main.Handle.Meat1.meat1.Transparency = 1;
                        RootPart.Main.Handle.Meat1.meat2.Transparency = 1;
                        task.delay(4, function() -- Line: 647
                            -- upvalues: RootPart (ref)
                            if RootPart and RootPart:FindFirstChild("Main") then
                                RootPart.Main.Handle.Meat1.meat1.Transparency = 0;
                                RootPart.Main.Handle.Meat1.meat2.Transparency = 0;
                            end;
                        end);
                    end);
                    Trove:Add(u3.PlaySound(Character, "Pose Startup SFX"), "Stop");
                end
            }
        },
        ["Perfume Fever"] = {
            HitSounds = v6
        },
        ["Lovely Legwork"] = {
            HitSounds = v6
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://17617821010",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'ll give you the main dish!",
                            ScaleTime = 1.5
                        } }
                }, {
                    SoundId = "rbxassetid://17617820789",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "It\'s about time. I\'m ready.",
                            ScaleTime = 1.5
                        } }
                }, {
                    SoundId = "rbxassetid://17617820561",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I got the prep work done, man.",
                            ScaleTime = 1.5
                        } }
                } }
        }
    }
};