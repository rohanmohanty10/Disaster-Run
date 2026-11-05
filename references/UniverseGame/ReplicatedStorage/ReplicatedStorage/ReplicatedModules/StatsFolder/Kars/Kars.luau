  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("RunService");
game:GetService("UserInputService");
game:GetService("Players");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local u1 = nil;
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 16
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), PathShortcuts (copy), u3 (ref)
    u1 = Knit.GetService("MoveInputService");
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local TableUtil = require(Knit.Util.TableUtil);
local _ = ReplicatedStorage.Remotes.Output;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local TagService = require(PathShortcuts.ReplicatedModules.Independent.TagService);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AnimationHandler = require(ReplicatedStorage.ReplicatedModules.AnimationHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Common = require(script.Common);

local function CreateMultiIndicator(p4) -- Line: 40
    local v5 = {};

    for i, v in pairs(p4) do
        if i ~= "Overrides" then
            table.insert(v5, {
                InputText = "%s",
                Visible = true,
                Group = i,
                Name = v,
                DisplayName = v,
                CooldownName = v,
                ActiveName = v
            });
        end;
    end;

    if p4.Overrides then
        for _, v in ipairs(v5) do
            for i, v2 in pairs(p4.Overrides) do
                v[i] = v2;
            end;
        end;
    end;

    return v5;
end;

local v6 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Misc/Hits/Light",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v7 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Misc/Hits/Heavy",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};

return {
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Passive = {
                Visible = true,
                Priority = 2
            },
            Universal = {
                Visible = true,
                Priority = 1
            }
        },
        MovesInfo = {
            ["Pillarmen Regeneration"] = {
                State = "Passive",
                Description = "The user passively heals 1.5x quicker than the average human",
                MoveCapCount = false
            },
            ["Supernatural Regeneration"] = {
                Description = "A regeneration move",
                DefaultKeybind = "Q+",
                Unlocked = true
            },
            ["Rush Attack"] = {
                DefaultKeybind = "MouseButton1",
                Equipped = true,
                MoveCapCount = false
            },
            Block = {
                DefaultKeybind = "F",
                Equipped = true,
                MoveCapCount = false
            },
            ["Superhuman Agility"] = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false,
                Description = "Dash in the direction you are moving with superhuman speeds"
            },
            ["Sonic Blink"] = {
                DefaultKeybind = "V",
                Equipped = true,
                Description = "Flash in the direction you\'re moving, traveling so fast that it leaves an afterimage in your initial position."
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            ["Light Dancer"] = {
                DefaultKeybind = "Q",
                LevelRequirement = 75,
                Description = "Vibrate your blades with intense speeds, greatly enhancing stats and senses. Whilst in this mode, you are able to view the meter bar of any target within according range. Some of the attacks also grant an \'aftercut\' effect"
            },
            ["Ricochet Storm"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Unleash a gleaming barrage of vibrant slashes. While in Light Dancer, the barrage deflects projectiles."
            },
            ["Heart & Saber"] = {
                DefaultKeybind = "R+",
                LevelRequirement = 20,
                Description = "Lunge forward, and grab the neck of the target, before finishing off with a final strike."
            },
            ["\"Come forth, Wamuu!\""] = {
                DefaultKeybind = "Y",
                LevelRequirement = 35,
                Description = "Enlist the help of a fellow pillar man, Wamuu, to manipulate the elements in order to form a miniature tornado, slicing anyone caught within"
            },
            ["Supersonic Kick"] = {
                DefaultKeybind = "T",
                LevelRequirement = 15,
                Description = "Charge up, before dealing a devastating sweep forward."
            },
            ["Lotus Grip"] = {
                DefaultKeybind = "T+",
                LevelRequirement = 50,
                Description = "Kick the target high into the air, proceeding to catch the target mid-air before driving them into the ground."
            },
            ["\"I always win!\""] = {
                DefaultKeybind = "G",
                LevelRequirement = 70,
                Description = "Initiate a counter stance, and when provoked, use a random victim as bait and swiftly traverse behind the target before entrapping them in a range of rapid slashes and dealing a final blow."
            },
            ["Blinding Blades"] = {
                LevelRequirement = 40,
                DefaultKeybind = "B",
                Description = "Shine light throughout your blinds, stunning nearby opponents."
            },
            ["Pillarmen Takedown"] = {
                LevelRequirement = 95,
                DefaultKeybind = "H+",
                Description = "Catch the target in a grab, before enlisting the help of the other pillar men to simultaneously pounce on the target"
            },
            ["Visceral Animosity"] = {
                LevelRequirement = 45,
                DefaultKeybind = "H",
                Description = "Wildly spin forward, unleashing devastating slashes in all directions."
            },
            ["\"Dry your tears, Esidisi!"] = {
                LevelRequirement = 30,
                DefaultKeybind = "Y+",
                Description = "Enlist the help of a fellow pillar man, Asi Disi, to deal a cascade of boiling blood directed towards the target."
            },
            ["Brilliant Bone Blades"] = {
                DefaultKeybind = "Z",
                Unlocked = true,
                Description = "Choose to either visually reveal your arm blades or not. (ONLY VISUAL)"
            },
            ["Cross Reaver"] = {
                Unlocked = true,
                DefaultKeybind = "R",
                Description = "Form an X shape made of slashes in front of you, inflicting a bombardment of slashes upon any target caught within."
            }
        }
    },
    Animations = {
        Action = {
            ["Supernatural Regeneration"] = 14181919108,
            ["Supernatural Regeneration Loop"] = 14181921902,
            ["Dodge 1"] = 18212444865,
            ["Dodge 2"] = 18212448831,
            ["Dodge 3"] = 18212450057,
            ["Bone Blade Activation"] = 18199974768,
            ["LMB-1"] = 13212558386,
            ["LMB-2"] = 13212563938,
            ["LMB-3"] = 13212566468,
            ["LMB-4"] = 13212568506,
            PoseTransition = 10373588196,
            PoseIdle = 10373590219,
            BladesPoseTransition = 18258993579,
            BladesPoseIdle = 18258996382,
            EisidisiPoseTransition = 18259003565,
            EisidisiPoseIdle = 18259001653,
            WamuuPoseTransition = 18259005607,
            WamuuPoseIdle = 18259007933,
            ["Visceral Animosity"] = 13207791864,
            ["Brilliant Bone Blades"] = 18260413642,
            ["Ricochet Storm"] = 10858574405,
            ["Cross Slice"] = 13769634441,
            ["Arm Bash Leap"] = 13772729280,
            ["Arm Bash User"] = 13772739281,
            ["Arm Bash Victim"] = 13772735484,
            ["Aerial Assault"] = 13857456626,
            ["Stun Locked"] = 13857738336,
            ["Thrusting Kick"] = 13862332712,
            ["Light Dancer"] = 17653518082,
            ["Eisidisi Light Dancer"] = 17653524658,
            ["Wamuu Light Dancer"] = 17653523069,
            ["Lotus Grip Attempt"] = 18169719742,
            ["Lotus Grip Player"] = 18211424221,
            ["Lotus Grip Enemy"] = 18169730818,
            ["Lotus Grip Player Spin"] = 18211428015,
            ["Lotus Grip Enemy Spin"] = 18211418987,
            Wamuu = 14187677670,
            Eisidisi = 16780743243,
            ["Eisidisi Lunge"] = 18244124356,
            ["Supersonic Dropkick"] = 10253568916,
            ["Sonic Blitz Startup"] = 18202002802,
            ["Sonic Blitz"] = 18202013559,
            ["Lacerative Lunge Start"] = 14606101348,
            ["Lacerative Lunge Run Loop"] = 14606109283,
            ["Lacerative Lunge Miss"] = 14606116219,
            ["Lacerative Lunge Attacker"] = 14606123455,
            ["Lacerative Lunge Enemy"] = 14606101348,
            ForwardDash1 = 16731260577,
            ForwardDash2 = 16731262071,
            BackwardDash = 16731258517,
            LeftDash = 16731263558,
            RightDash = 16731264589,
            ["Counter Input"] = 18249802365,
            ["Counter Loop"] = 18249804506,
            ["Counter Victim"] = 18249790684,
            ["Counter Player"] = 18249800587,
            ["Counter Decoy"] = 18249809172,
            ["Beatdown Startup Player"] = 18272521537,
            ["Beatdown Startup Wamuu"] = 18272537071,
            ["Beatdown Startup Eisidisi"] = 18272533889,
            ["Beatdown Camera"] = 18272390123,
            ["Beatdown Player"] = 18272399553,
            ["Beatdown Victim"] = 18272395790,
            ["Beatdown Eisidisi"] = 18272397613,
            ["Beatdown Wamuu"] = 18272401008
        },
        Movement = {
            ["BoneBlades-Walk"] = 10023136479,
            ["BoneBlades-Run"] = 10023208024,
            Walk = 18199878103,
            Run = 18199888373
        },
        Idle = {
            ["BoneBlades-Idle"] = 10023130672,
            Idle = 18199875239
        }
    },
    Sounds = {
        ["Supernatural Regeneration Voiceline"] = {
            SoundId = 14255013395,
            Volume = 0
        },
        ["Supernatural Regeneration SFX"] = {
            SoundId = 14255013487,
            Looped = true,
            Volume = 1
        },
        ["Sonic Blink"] = {
            SoundId = 18256644046,
            Volume = 1
        },
        ["Superhuman Agility"] = {
            SoundId = 18256645198,
            Volume = 1
        },
        ["Visceral Animosity SFX"] = {
            SoundId = 18303447799,
            Volume = 1
        },
        ["Visceral Animosity Voice"] = {
            SoundId = 13610546480,
            Volume = 1.5
        },
        ["Ground Slam"] = {
            SoundId = 18303447374,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 13610545312,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 13610545239,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 13610545165,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 13610545055,
            Volume = 1
        },
        ["LMB-1SFX"] = {
            SoundId = 18303446879,
            Volume = 1
        },
        ["LMB-2SFX"] = {
            SoundId = 18303448853,
            Volume = 1
        },
        ["LMB-3SFX"] = {
            SoundId = 18303446673,
            Volume = 1
        },
        ["LMB-4SFX"] = {
            SoundId = 18303447576,
            Volume = 1
        },
        ["Dropkick Voiceline"] = {
            SoundId = 14187497484,
            Volume = 1
        },
        ["Dropkick SFX"] = {
            SoundId = 14187497626,
            Volume = 1
        },
        ["Arm Bash SFX"] = {
            SoundId = 14187497177,
            Volume = 1
        },
        ["Arm Bash Voiceline"] = {
            SoundId = 14187497286,
            Volume = 1
        },
        ["Arm Bash Hit SFX"] = {
            SoundId = 14187497792,
            Volume = 1
        },
        ["Arm Bash Hit Voiceline"] = {
            SoundId = 14187497394,
            Volume = 1
        },
        ["Cross Slice SFX"] = {
            SoundId = 18303450373,
            Volume = 1
        },
        ["Cross Slice Voiceline"] = {
            SoundId = 14187497286,
            Volume = 1
        },
        ["Ricochet Storm Voiceline"] = {
            SoundId = 14321229524,
            Volume = 1
        },
        ["Ricochet Storm SFX"] = {
            SoundId = 18303452240,
            Volume = 1
        },
        ["Wamuu User Summon Voiceline"] = {
            SoundId = 14321229091,
            Volume = 1
        },
        ["Tornado SFX"] = {
            SoundId = 14321229264,
            Volume = 1
        },
        ["Wamuu SFX"] = {
            SoundId = 14321229636,
            Volume = 1
        },
        ["Wamuu Voiceline"] = {
            SoundId = 14321230228,
            Volume = 1
        },
        PoseMusic1 = {
            SoundId = 14321230160,
            Volume = 1,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 0.68
                }
            }
        },
        PoseMusic2 = {
            SoundId = 14321824412,
            Volume = 1,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 0.74
                }
            }
        },
        ["Lotus Grip Startup SFX"] = {
            SoundId = 18256643510,
            Volume = 1.25
        },
        ["Lotus Grip Startup Voiceline"] = {
            SoundId = 18256643252,
            Volume = 1.25
        },
        ["Lotus Grip SFX"] = {
            SoundId = 18256643788,
            Volume = 1.25
        },
        ["Lotus Grip Voiceline"] = {
            SoundId = 18256644249,
            Volume = 1.25
        },
        ["Lotus Grip Slam"] = {
            SoundId = 18256643024,
            Volume = 1.25
        },
        ["Bone Blade Equip"] = {
            SoundId = 18256645420,
            Volume = 1
        },
        ["Light Dancer Voiceline"] = {
            SoundId = 18256644555,
            Volume = 1.25
        },
        ["Light Dancer SFX"] = {
            SoundId = 18256644977,
            Volume = 1.25
        },
        ["Light Dancer Ambience"] = {
            SoundId = 18256645756,
            Volume = 1
        },
        ["Light Dancer Music"] = {
            SoundId = 18256645420,
            Volume = 0
        },
        ["Light Dancer End"] = {
            SoundId = 18256645951,
            Volume = 1
        },
        MeterUp2 = {
            SoundId = 18256646190,
            Volume = 1
        },
        MeterUp4 = {
            SoundId = 18256644769,
            Volume = 1
        },
        ["Counter Attempt SFX"] = {
            SoundId = 18303450743,
            Volume = 1
        },
        ["Counter Attempt Voiceline"] = {
            SoundId = 18304359277,
            Volume = 1
        },
        ["Counter SFX"] = {
            SoundId = 18304360236,
            Volume = 1
        },
        ["Counter Voiceline"] = {
            SoundId = 18304360957,
            Volume = 1
        },
        ["Blind SFX"] = {
            SoundId = 18303451914,
            Volume = 1
        },
        ["Blind Voiceline"] = {
            SoundId = 18303451034,
            Volume = 1
        },
        ["Eisidisi Summon Voiceline"] = {
            SoundId = 18303449452,
            Volume = 1
        },
        ["Eisidisi Leap Voiceline"] = {
            SoundId = 18303449178,
            Volume = 1
        },
        ["Eisidisi Leap SFX"] = {
            SoundId = 18304358585,
            Volume = 1
        },
        ["Eisidisi Leap Slam"] = {
            SoundId = 18304358300,
            Volume = 1
        },
        ["Eisidisi Dash Voiceline"] = {
            SoundId = 18304359559,
            Volume = 1
        },
        ["Eisidisi Dash SFX"] = {
            SoundId = 18304359967,
            Volume = 1
        },
        ["Pose Pillarmen Reveal"] = {
            SoundId = 18363001156,
            Volume = 1
        },
        ["Beatdown Attempt Voiceline"] = {
            SoundId = 18363001483,
            Volume = 1
        },
        ["Beatdown Attempt SFX"] = {
            SoundId = 18363001692,
            Volume = 1
        },
        ["Beatdown Voiceline"] = {
            SoundId = 18363000882,
            Volume = 1
        },
        ["Beatdown SFX"] = {
            SoundId = 18363002029,
            Volume = 1
        }
    },
    Stats = {
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        ["Superhuman Agility"] = {
            Active = true,
            Actionable = {
                Stunned = true,
                Disabled = true,
                Ragdolled = true,
                Summoned = false,
                Active = {
                    Ignore = { "Block" }
                }
            },
            ClientActionable = {
                Stunned = true,
                Disabled = true,
                Summoned = false,
                Active = {
                    Ignore = { "Block", "Block_Client" }
                }
            },
            Cooldown = {
                Time = 1.5,
                Force = true,
                CooldownReduction = false
            },

            Invoke = function(p8) -- Line: 126, Name: Invoke
                -- upvalues: Knit (copy), TagService (copy), AnimationHandler (copy), Trove (copy)
                local v9 = Knit.GetController("CombatController");
                local v10 = Knit.GetController("PilotController");
                local v11 = Knit.GetService("MoveInputService");
                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;
                TagService:GetContainer(LocalPlayer);
                local Humanoid = Character:WaitForChild("Humanoid");
                local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
                local u12 = AnimationHandler.Get(Humanoid.Animator);
                local ActivePilot = v10.ActivePilot;

                if ActivePilot then
                    Humanoid = ActivePilot:FindFirstChild("Humanoid") or Humanoid;
                    HumanoidRootPart = ActivePilot:FindFirstChild("HumanoidRootPart") or HumanoidRootPart;
                end;

                LocalPlayer.Data.Ability:GetAttribute("AbilityName");
                local v13 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and -HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
                v11:FireInput(p8.RawInput);

                local function Lerp(p14, p15, p16) -- Line: 154
                    return p14 + (p15 - p14) * p16;
                end;

                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.Velocity = v13 * 100;
                BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                BodyVelocity.Parent = HumanoidRootPart;
                local AlignOrientation = Instance.new("AlignOrientation");
                AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
                AlignOrientation.Attachment0 = HumanoidRootPart.RootAttachment;
                AlignOrientation.RigidityEnabled = true;
                AlignOrientation.CFrame = HumanoidRootPart.CFrame;
                AlignOrientation.Parent = HumanoidRootPart;
                local v17 = HumanoidRootPart.CFrame:VectorToObjectSpace(v13);
                local v18 = math.atan2(v17.X, -v17.Z);
                local v19 = math.deg(v18) - 0.5;
                local v20 = math.ceil(v19);
                local v21 = v20 > 45 and v20 < 135 and "Right" or (v20 < -45 and v20 > -135 and "Left" or ((v20 <= -135 or v20 >= 135) and "Backward" or "Forward"));
                local v22;

                if v21 == "Forward" then
                    Character:SetAttribute("DashCounter", Character:GetAttribute("DashCounter") == 2 and 1 or (Character:GetAttribute("DashCounter") == 1 and 2 or 1));
                    v22 = Character:GetAttribute("DashCounter");
                else
                    v22 = "";
                end;

                local u23 = false;
                local v24 = Trove.new();
                local u25 = (ActivePilot and "Pilot" or "") .. v21 .. "Dash" .. v22;
                u12:PlayAnimation(u25, 0.9);
                v24:Add(v9.QuickstepInterrupted:Connect(function() -- Line: 199
                    -- upvalues: u23 (ref), u12 (copy), u25 (copy)
                    u23 = true;
                    u12:StopAnimation(u25, 0.9);
                end));
                local v26 = os.clock();

                while not u23 and os.clock() - v26 <= 0.35 do
                    local v27 = os.clock() - v26;
                    local v28 = math.abs(v27) / 0.35;
                    local v29 = 100 + -87.5 * math.clamp(v28, 0, 1);
                    BodyVelocity.Velocity = v13 * math.clamp(v29, 12.5, 100);
                    task.wait();
                end;

                BodyVelocity:Destroy();
                AlignOrientation:Destroy();

                if u23 then
                    local v30 = os.clock() - v26;
                    local v31 = math.abs(v30) / 0.35;
                    local v32 = math.clamp(v31, 0, 1);
                    local v33 = math.lerp(v32, 1, 0.5);
                    local v34 = math.min(v33, 1);
                    local v35 = math.lerp(100, 12.5, v34);
                    HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(v13.X * v35, HumanoidRootPart.AssemblyLinearVelocity.Y, v13.Z * v35);
                end;
            end
        },
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(u36, u37) -- Line: 228, Name: Transformer
                    -- upvalues: TableUtil (copy), u3 (ref), u2 (ref), Common (copy), ParticleHandler (copy)
                    local v38 = u36.Character:GetAttribute("BoneBlades");
                    local v39 = TableUtil.Copy(u36.Stats, true);
                    v39.PoseMusic = "PoseMusic" .. (v38 and 1 or 2);
                    u37:Add(function() -- Line: 234
                        -- upvalues: u37 (copy)
                        u37.DestroyPartsAddedAfter = true;
                    end);

                    if v38 then
                        v39.StartAnim = "BladesPoseTransition";
                        v39.LoopAnim = "BladesPoseIdle";
                        local Character = u36.Character;
                        local HumanoidRootPart = Character.HumanoidRootPart;
                        local Animator = u36.Animator;
                        task.delay(u36.SkinName and 0 or 2.7, function() -- Line: 247
                            -- upvalues: Character (copy), u3 (ref), u2 (ref), HumanoidRootPart (copy), u36 (copy), u37 (copy), Common (ref), ParticleHandler (ref), Animator (copy)
                            if Character and Character:GetAttribute("Posing") then
                                u3.PlaySound(Character, "Pose Pillarmen Reveal");
                                u2.FireAllClients("Emit Particle V3", {
                                    Path = "Particles/Misc/PoseShine",
                                    AutoSerialize = true,
                                    Origin = HumanoidRootPart.CFrame,
                                    Player = u36.Player
                                });

                                for i = 1, 2 do
                                    local u40 = i == 1 and "Wamuu" or "Eisidisi";
                                    local u41 = u37:Add(Common:GetPillarmanModel(u40, u36));
                                    u41.HumanoidRootPart.Anchored = false;
                                    u41.Parent = workspace.Effects;
                                    ParticleHandler.EnableAllParticles(u41, false);
                                    ParticleHandler.AttachTo(u41.HumanoidRootPart, {
                                        Part = HumanoidRootPart
                                    });
                                    local Animation = Animator:GetAnimation(u40 .. "PoseTransition").Animation;
                                    local u42 = u41:FindFirstChild("Humanoid") or u41:FindFirstChild("AnimationController");
                                    local v43 = u42.Animator:LoadAnimation(Animation);
                                    v43:Play();
                                    v43.Stopped:Connect(function() -- Line: 279
                                        -- upvalues: u41 (copy), Animator (ref), u40 (copy), u42 (copy)
                                        if u41:IsDescendantOf(game) then
                                            local Animation2 = Animator:GetAnimation(u40 .. "PoseIdle").Animation;
                                            u42.Animator:LoadAnimation(Animation2):Play();
                                        end;
                                    end);

                                    for _, descendant in u41:GetDescendants() do
                                        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                                            local Transparency = descendant.Transparency;
                                            descendant.Transparency = 1;

                                            if descendant.Name ~= "Cube.021" then
                                                game.TweenService:Create(descendant, TweenInfo.new(0.5), {
                                                    Transparency = Transparency
                                                }):Play();
                                            end;
                                        end;
                                    end;

                                    if u40 == "Wamuu" and u36.SkinName == "2099" then
                                        local v44 = Random.new();
                                        local FireAllClients = u2.FireAllClients;
                                        local v45 = {
                                            Path = "Particles/Misc/Websling",
                                            Duration = 0.6166666666666667,
                                            Model = u41
                                        };
                                        local Position = HumanoidRootPart.Position;
                                        local v46 = v44:NextNumber(-5, 5);
                                        local v47 = v44:NextNumber(11, 15);
                                        v45.Position = Position + Vector3.new(v46, v47, v44:NextNumber(-5, 5));
                                        v45.AbilityData = {
                                            AbilityName = "Kars",
                                            SkinName = "2099"
                                        };
                                        FireAllClients("Kars_2099String", v45);
                                    end;
                                end;
                            end;
                        end);
                    end;

                    return v39;
                end
            }
        },
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Actionable = {
                Summoned = false
            },
            AnimationTimed = true,
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = TableUtil.Reconcile({
                Speed = 1.4,
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB-1SFX" }, { 16, 20, "Attack" }, { 40, "End" } },
                Stun = {
                    Time = 0.65,
                    Priority = Enums.Stun.Medium
                },
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(8, 8, 8.5),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -4)
                },
                HitRemotes = { v6 },
                HitSounds = {
                    Hit = {
                        SoundId = 18303449817,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-2"] = TableUtil.Reconcile({
                Speed = 1.4,
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB-2SFX" }, { 16, 20, "Attack" }, { 40, "End" } },
                Stun = {
                    Time = 0.65,
                    Priority = Enums.Stun.Medium
                },
                HitSounds = {
                    Hit = {
                        SoundId = 18303448456,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-3"] = TableUtil.Reconcile({
                Speed = 1.4,
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB-3SFX" }, { 16, 20, "Attack" }, { 43, "End" } },
                Stun = {
                    Time = 0.65,
                    Priority = Enums.Stun.Medium
                },
                HitSounds = {
                    Hit = {
                        SoundId = 18303448105,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Speed = 1.6,
                Cooldown = 1,
                Damage = 16,
                Sequence = {
                    { 0, "PlayAnim", "LMB-4" },
                    { 0, "CreateTag", "MaxWalkSpeed", 6 },
                    { 0, "CreateTag", "MaxJumpPower", 0 },
                    { 0, "PlaySound", "LMB-4" },
                    { 0, "PlaySound", "LMB-4SFX" },
                    { 31, function(p48, p49, p50, p51) -- Line: 421
                            -- upvalues: u3 (ref), u2 (ref)
                            local AttackStats = p51.AttackStats;
                            local Player = p50.Player;
                            local Character = p50.Character;
                            local RootPart = p50.RootPart;
                            local v52 = u3.Hitbox({
                                Caster = Character,
                                Stats = AttackStats
                            });

                            for _, v in ipairs(v52) do
                                u3.Attack({
                                    Attacker = Character,
                                    Target = v.Character,
                                    Stats = AttackStats
                                });
                            end;

                            u3.PlaySound(Character, "Ground Slam");
                            u2.FireAllClients("Rock Debris", {
                                Lifetime = 1.5,
                                Size = Vector3.new(2.3, 2.3, 2.3),
                                Amount = 17,
                                Origin = RootPart.CFrame * AttackStats.Hitbox.Offset,
                                Radius = AttackStats.Hitbox.Size * 1.35
                            });
                            u2.FireAllClients("Flying Debris", {
                                Lifetime = 1.5,
                                Collision = true,
                                Size = 1.8,
                                Force = Vector3.new(20, 20, 20),
                                TweenDelay = 0.9,
                                Origin = RootPart.CFrame * AttackStats.Hitbox.Offset,
                                Tween = {
                                    Transparency = 1,
                                    Size = Vector3.new(0, 0, 0)
                                }
                            });
                            u2.FireAllClients("Emit Particle V3", {
                                Path = "Particles/Misc/LMBSlamGround",
                                AutoSerialize = true,
                                Origin = RootPart.CFrame * AttackStats.Hitbox.Offset * CFrame.new(0, -2.5, 0) * CFrame.Angles(0, 0, -1.5707963267948966),
                                Player = Player
                            });

                            if Player then
                                u2.FireClient(Player, "CameraShake", 5.5, 13, 0, 0.45, Vector3.new(0.25, 0.25, 0.25), Vector3.new(4, 1, 1), true);
                            end;
                        end },
                    { 42, function(p53, p54, p55) -- Line: 451
                        end }
                },
                HitRemotes = { v7 },
                HitSounds = {
                    Hit = {
                        SoundId = 13610545521,
                        Volume = 0
                    }
                },
                Block = {
                    Blockable = false,
                    BlockBreak = true,
                    PerfectBlockable = false
                },
                Hitbox = {
                    Type = "Magnitude",
                    RelativePart = "HumanoidRootPart",
                    Size = 8,
                    Debug = false,
                    Offset = CFrame.new(0, 0, -3)
                },
                Ragdoll = {
                    Time = 0.6
                },
                Stun = {
                    Time = 0.35,
                    Priority = Enums.Stun.Heavy
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Speed = 45,
                    Time = 0.1,
                    Velocity = Vector3.new(0, 25, 0)
                }
            }, BaseStatsModule.Rush_Attack_Finisher),
            BladeEffects = { "Left", "Right", "Right" },
            Callbacks = {
                PreAnim = function(p56, p57) -- Line: 508, Name: PreAnim
                    -- upvalues: u2 (ref)
                    local Character = p56.Character;
                    local v58 = p56.Stats.BladeEffects[p57.MoveState.Count];

                    if v58 then
                        u2.FireAllClients("Kars_Trail", {
                            Value = true,
                            Character = Character,
                            Blades = v58
                        });
                    end;

                    u2.FireAllClients("Kars_BoneBlades", Character, true);
                end,

                PostAnim = function(p59, p60) -- Line: 526, Name: PostAnim
                    -- upvalues: u2 (ref)
                    local Character = p59.Character;
                    local v61 = p59.Stats.BladeEffects[p60.MoveState.Count];

                    if v61 then
                        u2.FireAllClients("Kars_Trail", {
                            Value = false,
                            Character = Character,
                            Blades = v61
                        });
                    end;

                    u2.FireAllClients("Kars_BoneBlades", Character, false);
                end
            }
        },
        ["\"I always win!\""] = {
            Active = true,
            MaxTime = 90,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Slash = {
                Damage = 5,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    Unblockable = true
                },
                HitRemotes = {
                    v7,
                    {
                        Name = "Output",
                        Arguments = {
                            "FX",
                            "Blood Rays",
                            {
                                Part = "__Target",
                                Offset = CFrame.new(0, -1.25, 0),
                                TrailRange = NumberRange.new(6, 9)
                            }
                        }
                    }
                }
            },
            Cut = {
                Frequency = 3,
                Damage = 2,
                Priority = Enums.Intangible.Move,
                Hitbox = {
                    Size = 8,
                    Debug = false,
                    Offset = CFrame.new(0, 0, 0)
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    Unblockable = true
                }
            },
            Finisher = {
                LightDancer = true,
                Damage = 10,
                Priority = Enums.Intangible.Move,
                Ragdoll = {
                    Time = 1
                },
                Knockback = {
                    Speed = -60,
                    Time = 0.15,
                    Velocity = Vector3.new(0, 28, 0),
                    RelativeTowards = "Target"
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    Unblockable = true
                }
            }
        },
        ["Visceral Animosity"] = {
            Active = true,
            Distance = 25,
            Actionable = {
                Active = true
            },
            Meter = {
                RequiredAmount = 20,
                RemoveMeter = true
            },
            SlashTimings = { 35, 45, 54, 63, 70, 89 },
            Cooldown = {
                Time = 19,
                AfterMove = true
            },
            Slash = {
                Damage = 6,
                Meter = {
                    Amount = 0
                },
                Hitbox = {
                    Size = Vector3.new(16, 16, 16),
                    Debug = false,
                    Offset = CFrame.new(0, 0, 0)
                },
                Stun = {
                    Time = 0.75,
                    Priority = Enums.Stun.Medium
                },
                Block = {
                    Blockable = true,
                    PerfectBlockable = false,
                    BlockBreak = false
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Override = true,
                    Speed = 35,
                    Time = 0.2
                },
                HitRemotes = { v6 },
                HitSounds = {
                    Hit = {
                        SoundId = 18303447199,
                        Volume = 1
                    }
                }
            },
            FinalSlash = {
                Damage = 20,
                LightDancer = true,
                Meter = false,
                HitSounds = {
                    Hit = {
                        SoundId = 18303446463,
                        Volume = 1
                    }
                },
                Stun = {
                    Time = 0.75,
                    Priority = Enums.Stun.Medium
                },
                Ragdoll = {
                    Time = 1.5
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = true,
                    BlockBreak = true
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Speed = 35,
                    Time = 0.1,
                    Velocity = Vector3.new(0, 40, 0)
                },
                Hitbox = {
                    Type = "Magnitude",
                    RelativePart = "HumanoidRootPart",
                    Size = 14,
                    Offset = CFrame.new(0, 0, 0)
                }
            }
        },
        ["Brilliant Bone Blades"] = {
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 1,
                AfterMove = true
            }
        },
        ["Ricochet Storm"] = {
            Active = true,
            Length = 4,
            Damage = 1,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 8,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 8,
                Offset = CFrame.new(0, 0, -4.5)
            },
            HitRemotes = { v6 },
            HitSounds = {
                Hit = {
                    SoundId = 14321229160,
                    Volume = 0.7
                }
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            Stun = {
                Time = 0.7,
                Priority = Enums.Stun.Medium
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 1,
                Time = 0.1
            },
            Finisher = {
                LightDancer = true,
                Damage = 20,
                HitAnimations = "Default",
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(11, 9, 12),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -6)
                },
                Block = {
                    Blockable = false,
                    BlockBreak = true,
                    PerfectBlockable = false
                },
                Ragdoll = {
                    Time = 1.5
                },
                Stun = {
                    Time = 0.35,
                    Priority = Enums.Stun.Medium
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 64,
                    Time = 0.2
                },
                HitRemotes = { v7 },
                HitSounds = {
                    Hit = {
                        SoundId = 14321229709,
                        Volume = 1
                    }
                }
            }
        },
        ["Heart & Saber"] = {
            Active = true,
            Damage = 5,
            Actionable = {
                Active = true
            },
            Meter = {
                Amount = 0,
                RequiredAmount = 15
            },
            Cooldown = {
                Time = 18,
                AfterMove = true
            },
            Hitbox = {
                Size = Vector3.new(8, 8, 28),
                Debug = false,
                Offset = CFrame.new(0, 0, 0)
            },
            Block = {
                Blockable = false,
                PerfectBlockable = true,
                BlockBreak = true
            },
            Stun = {
                Time = 0.85
            },
            Punch = {
                Damage = 45,
                Meter = {
                    Amount = 0
                },
                Block = {
                    Unblockable = true,
                    BypassCounter = true
                },
                Stun = {
                    Time = 0.5
                },
                Ragdoll = {
                    Time = 0.7
                },
                HitRemotes = { v6 },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 50,
                    Velocity = Vector3.new(0, 25, 0),
                    Time = 0.12
                }
            }
        },
        ["Cross Reaver"] = {
            Active = true,
            Damage = 15,
            Actionable = {
                Active = true
            },
            HitSounds = {
                Hit = {
                    SoundId = 14187497932,
                    Volume = 1.4
                }
            },
            Ragdoll = {
                Time = 1.25
            },
            Knockback = {
                RelativePart = "Attacker",
                Override = true,
                Speed = 45,
                Time = 0.17
            },
            Block = {
                Blockable = false,
                PerfectBlockable = true,
                BlockBreak = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8.25, 14.3, 9.9),
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            Cooldown = {
                Time = 16,
                AfterMove = true
            },
            AfterSlashes = {
                Amount = 15,
                Lifetime = 0.5,
                Damage = 1.25,
                HitAnimations = "Default",
                Priority = Enums.Intangible.Counter,
                Block = {
                    Unblockable = true
                },
                Stun = {
                    Time = 0.3,
                    Priority = Enums.Stun.Medium
                },
                HitSounds = {
                    Hit = {
                        SoundId = 14187497932,
                        Volume = 0.3
                    }
                }
            }
        },
        ["Light Dancer"] = {
            Active = true,
            MaxNightVisionDistance = 50,
            Duration = 30,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 90,
                AfterMove = true
            },
            Meter = {
                RequiredLevel = 3,
                RemoveMeter = true
            },
            Indicators = CreateMultiIndicator({
                Universal = "Light Dancer"
            }),
            Aftercut = {
                Damage = 0.25,
                Amount = 20,
                Lifetime = 1.5,
                HitAnimations = "Default",
                Priority = Enums.Intangible.Quickstep,
                Block = {
                    Unblockable = true,
                    BypassCounter = true
                },
                HitRemotes = { v6 },
                HitSounds = {
                    Hit = {
                        SoundId = 13610546408,
                        Volume = 0.15
                    }
                }
            }
        },
        ["\"Dry your tears, Esidisi!"] = {
            Damage = 25,
            MaxRange = 50,
            LaunchMultiplier = 2,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 23,
                Manual = true,
                LaunchMultiplier = 1.5
            },
            Meter = {
                RequiredAmount = 20,
                Manual = true,
                MeterGain = 5,
                RemoveMeter = false
            },
            Knockback = {
                RelativeTowards = "Target",
                Speed = 25,
                Time = 0.1,
                Velocity = Vector3.new(0, 20, 0)
            },
            Ragdoll = {
                Time = 1
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false,
                BlockBreak = false
            },
            Hitbox = {
                Size = 19,
                Debug = false
            },
            HitRemotes = { {
                    Name = "Output",
                    Arguments = { "FX", "HitEffect V3", {
                            Attacker = "__Attacker",
                            Target = "__Target",
                            Path = "Particles/Misc/Hits/Splatter",
                            AutoSerialize = true,
                            LookAt = "Attacker"
                        } }
                } }
        },
        ["\"Come forth, Wamuu!\""] = {
            Actionable = {
                Active = true
            },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 37.5,
                Debug = false,
                Offset = CFrame.new(0, 0, 0)
            },
            Meter = {
                RequiredAmount = 30,
                RemoveMeter = false
            },
            Cooldown = {
                Time = 22,
                Manual = true
            },
            WindBurst = {
                Damage = 2,
                Meter = false,
                Knockback = {
                    RelativePart = "Target",
                    Time = 0.15,
                    Speed = 0,
                    Velocity = Vector3.new(0, 6, 0)
                },
                Stun = {
                    Time = 0.25,
                    Priority = Enums.Stun.Heavy
                },
                Block = {
                    Blockable = true,
                    PerfectBlockable = false,
                    BlockBreak = false
                },
                Hitbox = {
                    Size = Vector3.new(12, 16, 12),
                    Debug = false,
                    Offset = CFrame.new(0, 5.5, 0)
                },
                HitSounds = {
                    Hit = {
                        SoundId = 14321230294,
                        Volume = 1
                    }
                }
            }
        },
        ["Supersonic Kick"] = {
            Active = true,
            Distance = 25,
            Damage = 25,
            Priority = Enums.Intangible.Quickstep,
            Actionable = {
                Active = true,

                Check = function(p62) -- Line: 1172, Name: Check
                    if p62 then
                        p62 = p62:FindFirstChildOfClass("Humanoid");
                    end;

                    if p62 then
                        local v63;

                        if p62:GetState() == Enum.HumanoidStateType.Jumping then
                            v63 = false;
                        else
                            v63 = p62:GetState() ~= Enum.HumanoidStateType.Freefall;
                        end;

                        return v63;
                    end;
                end
            },
            Indicators = CreateMultiIndicator({
                Universal = "Supersonic Drop Kick"
            }),
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Hitbox = {
                Size = Vector3.new(10, 10, 8),
                Debug = false,
                Offset = CFrame.new(0, 0, 0)
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false,
                BlockBreak = false
            },
            Stun = {
                Time = 0.85
            },
            Ragdoll = {
                Time = 0.85
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 60,
                Time = 0.3,
                Velocity = Vector3.new(0, 20, 0)
            },
            HitSounds = {
                Hit = {
                    SoundId = 14187497104,
                    Volume = 1.4
                }
            },
            HitRemotes = { {
                    Name = "Output",
                    Arguments = { "FX", "HitEffect V3", {
                            Attacker = "__Attacker",
                            Target = "__Target",
                            Path = "Particles/Misc/Hits/Dropkick",
                            AutoSerialize = true,
                            LookAt = "Attacker"
                        } }
                } }
        },
        ["Lacerative Lunge"] = {
            Active = true,
            Speed = 40,
            Duration = 2,
            Damage = 7,
            Actionable = {
                Active = true
            },
            Hitbox = {
                Type = "Region3",
                Size = Vector3.new(10, 10, 10),
                HitboxType = "ClientHitbox",
                MaxDistance = 25,
                IgnoreNPCS = true,
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            Block = {
                Blockable = true,
                PerfectBlockable = true
            },
            Throw = {
                Damage = 25,
                Priority = Enums.Intangible.Move,
                Block = {
                    BypassCounter = true,
                    Unblockable = true
                },
                Stun = {
                    Time = 0.5
                },
                Ragdoll = {
                    Time = 0.5
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Speed = 30,
                    Time = 0.16,
                    Velocity = Vector3.new(0, 50, 0)
                }
            }
        },
        ["Lotus Grip"] = {
            Active = true,
            Damage = 15,
            UpwardDistance = 60,
            Speed = 125,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 24,
                AfterMove = true
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false,
                BlockBreak = true
            },
            Stun = {
                Time = 1
            },
            Meter = {
                RequiredAmount = 25
            },
            Hitbox = {
                Size = Vector3.new(10, 10, 10),
                Debug = false,
                Offset = CFrame.new(0, 0, -5)
            },
            Explosion = {
                Damage = 35,
                Meter = false,
                LightDancer = true,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                Ragdoll = {
                    Time = 2
                },
                Stun = {
                    Time = 2
                },
                Knockback = {
                    Override = true,
                    Speed = 40,
                    Time = 0.15,
                    Velocity = Vector3.new(0, 60, 0),
                    RelativeTowards = "Target"
                },
                Hitbox = {
                    Type = "Magnitude",
                    Size = 40,
                    Debug = false
                }
            }
        },
        Grab = {
            From = "Combat.Grab"
        },
        ["Supernatural Regeneration"] = {
            From = "Vampire OLD.Supernatural Regeneration",
            Heal = 2,
            HitRemotes = { {
                    Name = "Output",
                    Arguments = { "FX", "HitEffect V3", {
                            Attacker = "__Attacker",
                            Target = "__Target",
                            Path = "Particles/Misc/HealingTick",
                            AutoSerialize = true
                        } }
                } }
        },
        ["Sonic Blink"] = {
            From = "Cid Kagenou.Atomic: Flash"
        },
        ["Sonic Blitz"] = {
            Active = true,
            Frequency = 3,
            Damage = 3,
            Actionable = {
                Active = true
            },
            Hitbox = {
                Size = Vector3.new(30, 30, 30)
            },
            Stun = {
                Time = 0.5
            }
        },
        ["Blinding Blades"] = {
            Active = true,
            CheckPVPSafe = true,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 23.5,
                AfterMove = true
            },
            Meter = {
                RequiredAmount = 20
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            Hitbox = {
                Size = 20
            },
            Stun = {
                Time = 2.2
            },
            HitAnimations = { 17268173582 }
        },
        ["Pillarmen Takedown"] = {
            Active = true,
            CheckPVPSafe = true,
            Priority = Enums.Intangible.Quickstep,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 40,
                AfterMove = true
            },
            Meter = {
                RequiredAmount = 75
            },
            Hitbox = {
                Size = Vector3.new(25, 25, 25),
                Debug = false
            },
            Block = {
                Blockable = false,
                PerfectBlockable = false,
                BypassCounter = true
            },
            LightSlash = {
                Damage = 2,
                MinHealth = 1,
                Meter = false,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    Unblockable = true,
                    BypassCounter = true
                },
                HitRemotes = { v6 }
            },
            Punch = {
                Damage = 1.5,
                MinHealth = 1,
                Meter = false,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    Unblockable = true,
                    BypassCounter = true
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "HitEffect V3", {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                Path = "Particles/Misc/Hits/Beatdown",
                                AutoSerialize = true,
                                LookAt = "Attacker"
                            } }
                    } }
            },
            HeavyHit = {
                Damage = 5,
                MinHealth = 1,
                Meter = false,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    Unblockable = true,
                    BypassCounter = true
                },
                HitRemotes = { v7 }
            },
            EisidisiKick = {
                Damage = 7,
                MinHealth = 1,
                Meter = false,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    Unblockable = true,
                    BypassCounter = true
                },
                HitRemotes = {
                    {
                        Name = "Output",
                        Arguments = { "FX", "HitEffect V3", {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                Path = "Particles/Misc/Hits/Splatter",
                                AutoSerialize = true,
                                LookAt = "Attacker"
                            } }
                    },
                    {
                        Name = "Output",
                        Arguments = {
                            "FX",
                            "Blood Rays",
                            {
                                Part = "__Target",
                                SearchPart = "Torso",
                                Offset = CFrame.new(0, -1.25, 0),
                                TrailRange = NumberRange.new(6, 9)
                            }
                        }
                    }
                }
            },
            Finisher = {
                Damage = 35,
                Meter = false,
                Block = {
                    Unblockable = true,
                    BypassCounter = true
                },
                Ragdoll = {
                    Time = 1.5
                },
                HitRemotes = { v6 },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 55,
                    Velocity = Vector3.new(0, 25, 0),
                    Time = 0.15
                }
            }
        },
        ["Summon Vampires"] = {
            Radius = 8,
            Actionable = {
                Active = true,

                Check = function(p64) -- Line: 1632, Name: Check
                    return p64:GetAttribute("NPC");
                end
            },
            AmountPerPlayer = NumberRange.new(1, 3)
        },
        ["Thrusting Kick"] = {
            Active = true,
            Damage = 15,
            Actionable = {
                Active = true
            },
            Block = {
                Blockable = false,
                PerfectBlockable = true,
                BlockBreak = true
            },
            Stun = {
                Time = 0.75
            },
            Ragdoll = {
                Time = 0.75
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Velocity = Vector3.new(0, 77, 0),
                Time = 0.17
            },
            Hitbox = {
                Size = Vector3.new(8, 9, 7),
                Debug = false,
                Offset = CFrame.new(0, 0, -3)
            }
        },
        ["Aerial Assault"] = {
            Active = true,
            Damage = 25,
            Actionable = {
                Active = true
            },
            Priority = Enums.Intangible.Ragdoll,
            Meter = {
                Amount = 0,
                RequiredLevel = 1
            },
            Stun = {
                Time = 3,
                Priority = Enums.Stun.Heavy
            },
            Block = {
                Blockable = false,
                PerfectBlockable = true,
                BlockBreak = true
            }
        },
        Breaker = {
            From = "Combat.Breaker"
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
                    SoundId = "rbxassetid://14321823958",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Hmph.. ",
                            ScaleTime = 0.1
                        }, {
                            Quote = "You must be eliminated.",
                            ScaleTime = 1.15
                        } }
                }, {
                    SoundId = "rbxassetid://14321824530",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'ll settle this with my own hands.",
                            ScaleTime = 2.5
                        } }
                }, {
                    SoundId = "rbxassetid://14321824611",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "It\'s over.",
                            ScaleTime = 1.6
                        } }
                }, {
                    SoundId = "rbxassetid://14321824691",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Wing.. ",
                            ScaleTime = 0.35
                        }, {
                            Quote = "Wing... Wing... ",
                            ScaleTime = 0.25
                        }, {
                            Quote = "Wing...",
                            ScaleTime = 0.6
                        } }
                }, {
                    SoundId = "rbxassetid://14321824796",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "*laughs menacingly*"
                        } }
                } }
        }
    }
};