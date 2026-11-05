  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(ReplicatedStorage.ReplicatedModules.KnitPackage.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local TagService = require(ReplicatedStorage.ReplicatedModules.Independent.TagService);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AnimationHandler = require(ReplicatedStorage.ReplicatedModules.AnimationHandler);
local Middleware = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Middleware);
local v1 = ReplicatedStorage["Client Assets"];
local GetHSVShift = ParticleHandler.GetHSVShift;
local u2 = nil;
local u3 = nil;
local u4 = nil;
Knit.OnStart():andThen(function() -- Line: 26
    -- upvalues: u2 (ref), Knit (copy), u3 (ref), u4 (ref), Middleware (copy)
    u2 = Knit.GetService("EffectService");
    u3 = Knit.GetService("MoveService");
    u4 = Middleware.GetMiddleware("CombatService");
end);
local v5 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v1.Universal.Universal_HitVFX,
            Color = Color3.fromRGB(142, 188, 203)
        }
    }
};
local v6 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v1.Universal.UniversalHeavyVFX,
            Offset = CFrame.Angles(0, 3.141592653589793, 0),
            Color = Color3.fromRGB(142, 188, 203)
        }
    }
};
local v7 = { {
        SoundId = 73674926969925,
        Volume = 1
    }, {
        SoundId = 135364455404951,
        Volume = 1
    } };

local function GetSheatheData(p8, p9, p10, p11) -- Line: 74
    if type(p10) == "table" then
        p10 = p10.Character;
    end;

    local _ = p10.HumanoidRootPart;

    return {
        YamatoRig = p10:FindFirstChild("YamatoRig_Motor6D", true),
        SheatheWeld = p10:FindFirstChild("SheatheBladeWeld", true),
        Blade = p10:FindFirstChild("YamatoRig", true)
    };
end;

local function Sheathe(p12, p13, p14, p15) -- Line: 89
    -- upvalues: GetSheatheData (copy)
    local v16 = GetSheatheData(p12, p13, p14, p15);
    v16.YamatoRig.Enabled = false;
    v16.YamatoRig.Part1 = nil;
    v16.SheatheWeld.Part1 = v16.Blade;
    v16.SheatheWeld.Enabled = true;
end;

local function Unsheathe(p17, p18, p19, p20) -- Line: 99
    -- upvalues: GetSheatheData (copy)
    local v21 = GetSheatheData(p17, p18, p19, p20);
    v21.SheatheWeld.Enabled = false;
    v21.SheatheWeld.Part1 = nil;
    v21.YamatoRig.Part1 = v21.Blade;
    v21.YamatoRig.Enabled = true;
end;

local function Orientation(p22, p23, p24) -- Line: 109
    return CFrame.fromOrientation(math.rad(p22), math.rad(p23), (math.rad(p24)));
end;

local function AirInvoke(p25) -- Line: 113
    -- upvalues: Knit (copy)
    local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid");
    Knit.GetController("MoveInputController");
    Knit.GetService("MoveInputService"):FireInput(p25.RawInput, Humanoid.FloorMaterial == Enum.Material.Air):expect();
end;

local function AirborneOnly(p26) -- Line: 124
    -- upvalues: Knit (copy)
    local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid");
    Knit.GetController("MoveInputController");
    local v27 = Knit.GetService("MoveInputService");
    local v28 = Humanoid.FloorMaterial == Enum.Material.Air;

    if not v28 then
        return;
    end;

    v27:FireInput(p26.RawInput, v28):expect();
end;

local u29 = nil;
local u30 = nil;
local u31 = nil;
local u32 = nil;

if RunService:IsServer() then
    task.spawn(function() -- Line: 140
        -- upvalues: u3 (ref), u29 (ref), u30 (ref), u31 (ref), u32 (ref)
        repeat
            task.wait();
        until u3;

        u3.LoadAbility("Vergil");
        local Vergil = u3.Moves.Vergil;
        u29 = Vergil.InstantJCFunc;
        u30 = Vergil.EnableInstantJC;
        u31 = Vergil.GetDoppelClone;
        u32 = Vergil.Float;
    end);
end;

local ComboA = ReplicatedStorage["Client Assets"].Assets.Abilities.Vergil.ComboA;
local u33 = CFrame.new(5, 0, 0);

return {
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Passive = {
                Visible = true,
                Priority = 3
            },
            Universal = {
                Visible = true,
                Priority = 1
            },
            SDT = {
                Visible = false,
                Priority = 2
            }
        },
        MovesInfo = {
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
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Instant Judgement Cut"] = {
                State = "Passive",
                Description = "Most of vergil moves can immediately follow up with a judgement cut if timed right",
                Equipped = true
            },
            Trick = {
                DefaultKeybind = "C+",
                Unlocked = true,
                Description = "Teleport to closest target marked by mirage blade or airborne, if you are airborne then immediately teleport to ground"
            },
            Barrage = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Hold to perform multiple sword slashes before finishing with a final strike"
            },
            ["Aerial Rave"] = {
                DefaultKeybind = "Q+",
                LevelRequirement = 25,
                Description = "Carve up an enemy with a spinning aerial combo, then send them crashing down with a mighty blow"
            },
            ["Aerial Cleave"] = {
                DefaultKeybind = "R+",
                LevelRequirement = 50,
                Description = "Gather your strength before descending on your target in a merciless falling attack"
            },
            ["Void Slash"] = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Slash at the area before you with tremendous speed, cleaving the air itself"
            },
            ["Judgement Cut"] = {
                DefaultKeybind = "Y",
                Unlocked = true,
                Description = "Unsheathe your sword with blinding speed and unleash a whirlwind of slashes"
            },
            ["Upper Slash"] = {
                DefaultKeybind = "V",
                Unlocked = true,
                Description = "Launch enemies with an upwards strike from Yamato"
            },
            ["Upper Slash 2"] = {
                DefaultKeybind = "V+",
                Unlocked = true,
                Description = "Launch enemies with an upwards strike from Yamato and follow the enemy skyward"
            },
            ["Rapid Slash"] = {
                DefaultKeybind = "T",
                Unlocked = true,
                Description = "Dash forward, relentlessly slashing everything in your path"
            },
            ["Rising Star"] = {
                DefaultKeybind = "T+",
                LevelRequirement = 75,
                Description = "Ascend while attacking enemies around you, lifting them off the ground"
            },
            ["Judgement Cut End"] = {
                DefaultKeybind = "G",
                LevelRequirement = 100,
                Description = "Slash your foes with such speed that you appear at multiple places at once"
            },
            SDT = {
                DefaultKeybind = "B",
                LevelRequirement = 200,
                Description = "Activate your demon form becoming empowered",
                IndicatorInfo = {
                    DisplayName = "Sin Devil Trigger"
                }
            },
            Doppelganger = {
                DefaultKeybind = "Z",
                LevelRequirement = 150,
                Description = "Create a clone of yourself, mimicking your movements"
            }
        }
    },
    Animations = {
        Action3 = {
            JCJitter = 82652315103708
        },
        Action2 = {
            Sheathe = 134218572299142,
            ["LMB-5"] = 140279415498237,
            JCRegular = 90510686442314
        },
        Action = {
            ["LMB-1"] = 78520755151104,
            ["LMB-2"] = 74175448586652,
            ["LMB-3"] = 87900452733167,
            ["LMB-4"] = 80155577698185,
            JCStartup = 110406175234083,
            BarrageStartup = 137146021358669,
            BarrageLoop = 112926014671776,
            BarrageFinisher = 139745022080131,
            VoidSlash = 124300582382949,
            RapidSlash = 101021173307916,
            RisingStar = 127081198314237,
            UpperSlash = 122974459198186,
            UpperSlash2 = 79687487203506,
            AerialRaveB = 74992668812681,
            AerialCleave = 80485107291132,
            JCE = 135916402788033,
            JCECamera = 125258870774585,
            PoseTransition = 103746772304708,
            PoseIdle = 105822787811645,
            PlasticPoseTransition = 93006903932544,
            PlasticPoseIdle = 135754566573213
        },
        Movement = {
            Run = 96985932543541,
            Walk = 118046089543218
        },
        Idle = {
            Idle = 137517610422479
        }
    },
    Stats = {
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            AnimationTimed = true,
            MaxCombo = 5,
            ComboTick = 1.5,
            JudgementCuts = 1,
            KeepArguments = true,
            Invoke = AirInvoke,
            ["LMB-1"] = TableUtil.Reconcile({
                Endlag = 0.3,
                Speed = 1.25,
                Stun = {
                    Time = 0.75,
                    StunDecay = true,
                    Priority = Enums.Stun.Medium
                },
                Sequence = {
                    {
                        0,
                        "Start",
                        {
                            Transformer = function(p34, p35, p36, p37) -- Line: 177, Name: Transformer
                                if p35.Character:GetAttribute("SDT") then
                                    p36.VoicelineFullName = p36.FullName .. "-SDT";
                                end;
                            end
                        }
                    },
                    { 0, function(p38, p39, p40, p41) -- Line: 183
                            -- upvalues: u29 (ref)
                            u29(p40, p38);
                        end },
                    { 15, function(p42, p43, p44, p45) -- Line: 188
                            -- upvalues: Knit (copy), ComboA (copy), GetHSVShift (copy), u31 (ref)
                            local v46 = Knit.GetService("EffectService");
                            local Player = p44.Player;
                            local _ = p45.AttackStats;
                            local _ = p44.Input;
                            local Character = p44.Character;
                            local _ = Character.HumanoidRootPart;
                            v46.FireAllClients("VergilComboA", {
                                DecalName = "SheatheSweepDecal1",
                                DecalTransparency = 0.25,
                                Player = Player,
                                Attacker = Character,
                                VFX = ComboA.ComboASheatheSweep1,
                                OrientationStart = CFrame.fromOrientation(-0.08726646259971647, -1.3089969389957472, 0),
                                OrientationGoal = CFrame.fromOrientation(0.08428194957880616, 2.0953550334817925, 0.022636920398366452),
                                HSVShift = GetHSVShift(p44)
                            });
                            local v47 = u31(Character);

                            if v47 then
                                v46.FireAllClients("VergilComboA", {
                                    DecalName = "SheatheSweepDecal1",
                                    DecalTransparency = 0.25,
                                    Player = Player,
                                    Attacker = v47,
                                    VFX = ComboA.ComboASheatheSweep1,
                                    OrientationStart = CFrame.fromOrientation(-0.08726646259971647, -1.3089969389957472, 0),
                                    OrientationGoal = CFrame.fromOrientation(0.08428194957880616, 2.0953550334817925, 0.022636920398366452),
                                    HSVShift = GetHSVShift(p44)
                                });
                            end;
                        end },
                    { 15, 23, "Attack" },
                    { 15, 23, function(p48, p49, p50, p51) -- Line: 219
                            -- upvalues: u31 (ref), TableUtil (copy), u33 (copy)
                            if not u31(p50.Character) then
                                return;
                            end;

                            local v52 = TableUtil.Copy(p51);
                            v52.AttackStats = TableUtil.Copy(v52.AttackStats, true);

                            if v52.AttackStats.Damage then
                                local AttackStats = v52.AttackStats;
                                AttackStats.Damage = AttackStats.Damage * 0.5;
                            end;

                            local Hitbox = v52.AttackStats.Hitbox;
                            Hitbox.Offset = Hitbox.Offset * u33;
                            v52.FullName = v52.FullName .. "_Doppel";
                            v52.Common.ParseAction(p48, p50, v52, "Attack");
                        end },
                    { 25, function(p53, p54, p55, p56) -- Line: 232
                            -- upvalues: u30 (ref)
                            p55.PlayerCache = {};

                            for i, _ in p53.Hit[p56.FullName] do
                                local v57 = game.Players:GetPlayerFromCharacter(i);

                                if v57 then
                                    table.insert(p55.PlayerCache, v57);
                                end;
                            end;

                            u30(p55);
                        end },
                    { 25, "End" }
                },
                HitRemotes = { v5 },
                HitSounds = {
                    Hit = {
                        SoundId = 122115667903719,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-2"] = TableUtil.Reconcile({
                Endlag = 0.3,
                Speed = 1.25,
                Stun = {
                    Time = 0.75,
                    StunDecay = true,
                    Priority = Enums.Stun.Medium
                },
                Sequence = {
                    {
                        0,
                        "Start",
                        {
                            Transformer = function(p58, p59, p60, p61) -- Line: 266, Name: Transformer
                                if p59.Character:GetAttribute("SDT") then
                                    p60.VoicelineFullName = p60.FullName .. "-SDT";
                                end;
                            end
                        }
                    },
                    { 0, function(p62, p63, p64, p65) -- Line: 272
                            -- upvalues: u29 (ref)
                            u29(p64, p62);
                        end },
                    { 12, function(p66, p67, p68, p69) -- Line: 277
                            -- upvalues: Knit (copy), ComboA (copy), GetHSVShift (copy), u31 (ref)
                            local v70 = Knit.GetService("EffectService");
                            local Player = p68.Player;
                            local _ = p69.AttackStats;
                            local _ = p68.Input;
                            local Character = p68.Character;
                            local _ = Character.HumanoidRootPart;
                            v70.FireAllClients("VergilComboA", {
                                DecalName = "SheatheSweepDecal1",
                                DecalTransparency = 0.25,
                                Player = Player,
                                Attacker = Character,
                                VFX = ComboA.ComboASheatheSweep2,
                                OrientationStart = CFrame.fromOrientation(0.18404496962280206, 1.2916658195234436, 2.9543362781433213),
                                OrientationGoal = CFrame.fromOrientation(-0.1297652298857784, -2.109282760912707, -2.913582840109254),
                                HSVShift = GetHSVShift(p68)
                            });
                            local v71 = u31(Character);

                            if v71 then
                                v70.FireAllClients("VergilComboA", {
                                    DecalName = "SheatheSweepDecal1",
                                    DecalTransparency = 0.25,
                                    Player = Player,
                                    Attacker = v71,
                                    VFX = ComboA.ComboASheatheSweep2,
                                    OrientationStart = CFrame.fromOrientation(0.18404496962280206, 1.2916658195234436, 2.9543362781433213),
                                    OrientationGoal = CFrame.fromOrientation(-0.1297652298857784, -2.109282760912707, -2.913582840109254),
                                    HSVShift = GetHSVShift(p68)
                                });
                            end;
                        end },
                    { 12, 17, "Attack" },
                    { 12, 17, function(p72, p73, p74, p75) -- Line: 308
                            -- upvalues: u31 (ref), TableUtil (copy), u33 (copy)
                            if not u31(p74.Character) then
                                return;
                            end;

                            local v76 = TableUtil.Copy(p75);
                            v76.AttackStats = TableUtil.Copy(v76.AttackStats, true);

                            if v76.AttackStats.Damage then
                                local AttackStats = v76.AttackStats;
                                AttackStats.Damage = AttackStats.Damage * 0.5;
                            end;

                            local Hitbox = v76.AttackStats.Hitbox;
                            Hitbox.Offset = Hitbox.Offset * u33;
                            v76.FullName = v76.FullName .. "_Doppel";
                            v76.Common.ParseAction(p72, p74, v76, "Attack");
                        end },
                    { 20, function(p77, p78, p79, p80) -- Line: 321
                            -- upvalues: u30 (ref)
                            p79.PlayerCache = {};

                            for i, _ in p77.Hit[p80.FullName] do
                                local v81 = game.Players:GetPlayerFromCharacter(i);

                                if v81 then
                                    table.insert(p79.PlayerCache, v81);
                                end;
                            end;

                            u30(p79);
                        end },
                    { 20, "End" }
                },
                HitRemotes = { v5 },
                HitSounds = {
                    Hit = {
                        SoundId = 122115667903719,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-3"] = TableUtil.Reconcile({
                Endlag = 0.3,
                Speed = 1.5,
                Stun = {
                    Time = 0.5,
                    StunDecay = true,
                    Priority = Enums.Stun.Medium
                },
                Sequence = {
                    {
                        0,
                        "Start",
                        {
                            Transformer = function(p82, p83, p84, p85) -- Line: 355, Name: Transformer
                                if p83.Character:GetAttribute("SDT") then
                                    p84.VoicelineFullName = p84.FullName .. "-SDT";
                                end;
                            end
                        }
                    },
                    { 0, function(p86, p87, p88, p89) -- Line: 361
                            -- upvalues: u29 (ref)
                            u29(p88, p86);
                        end },
                    { 23, function(p90, p91, p92, p93) -- Line: 366
                            -- upvalues: Knit (copy), ComboA (copy), GetHSVShift (copy), u31 (ref)
                            local v94 = Knit.GetService("EffectService");
                            local Player = p92.Player;
                            local _ = p93.AttackStats;
                            local _ = p92.Input;
                            local Character = p92.Character;
                            local _ = Character.HumanoidRootPart;
                            v94.FireAllClients("VergilComboA", {
                                DecalName = "SlashDecal1",
                                DecalTransparency = 0,
                                Player = Player,
                                Attacker = Character,
                                VFX = ComboA.ComboASlash1,
                                OrientationStart = CFrame.fromOrientation(0.8480554835440448, -2.3405737933869957, -0.7137174910180412),
                                OrientationGoal = CFrame.fromOrientation(-0.9908757762347408, 1.1661591930125312, 0.4214272011865508),
                                DustVFX = ComboA.ComboASlash1Dust,
                                DustOffset = CFrame.fromOrientation(0, -3.141592653589793, 0) + Vector3.new(0, -2.45, 0),
                                HSVShift = GetHSVShift(p92)
                            });
                            local v95 = u31(Character);

                            if v95 then
                                v94.FireAllClients("VergilComboA", {
                                    DecalName = "SlashDecal1",
                                    DecalTransparency = 0,
                                    Player = Player,
                                    Attacker = v95,
                                    VFX = ComboA.ComboASlash1,
                                    OrientationStart = CFrame.fromOrientation(0.8480554835440448, -2.3405737933869957, -0.7137174910180412),
                                    OrientationGoal = CFrame.fromOrientation(-0.9908757762347408, 1.1661591930125312, 0.4214272011865508),
                                    DustVFX = ComboA.ComboASlash1Dust,
                                    DustOffset = CFrame.fromOrientation(0, -3.141592653589793, 0) + Vector3.new(0, -2.45, 0),
                                    HSVShift = GetHSVShift(p92)
                                });
                            end;
                        end },
                    { 23, Unsheathe },
                    { 23, function(p96, p97, p98, p99) -- Line: 401
                            -- upvalues: u31 (ref), GetSheatheData (copy)
                            local v100 = u31(p98.Character);

                            if v100 then
                                local v101 = GetSheatheData(p96, p97, v100, p99);
                                v101.SheatheWeld.Enabled = false;
                                v101.SheatheWeld.Part1 = nil;
                                v101.YamatoRig.Part1 = v101.Blade;
                                v101.YamatoRig.Enabled = true;
                            end;
                        end },
                    { 25, 30, "Attack" },
                    { 25, 30, function(p102, p103, p104, p105) -- Line: 408
                            -- upvalues: u31 (ref), TableUtil (copy), u33 (copy)
                            if not u31(p104.Character) then
                                return;
                            end;

                            local v106 = TableUtil.Copy(p105);
                            v106.AttackStats = TableUtil.Copy(v106.AttackStats, true);

                            if v106.AttackStats.Damage then
                                local AttackStats = v106.AttackStats;
                                AttackStats.Damage = AttackStats.Damage * 0.5;
                            end;

                            local Hitbox = v106.AttackStats.Hitbox;
                            Hitbox.Offset = Hitbox.Offset * u33;
                            v106.FullName = v106.FullName .. "_Doppel";
                            v106.Common.ParseAction(p102, p104, v106, "Attack");
                        end },
                    { 35, function(p107, p108, p109, p110) -- Line: 421
                            -- upvalues: u30 (ref)
                            p109.PlayerCache = {};

                            for i, _ in p107.Hit[p110.FullName] do
                                local v111 = game.Players:GetPlayerFromCharacter(i);

                                if v111 then
                                    table.insert(p109.PlayerCache, v111);
                                end;
                            end;

                            u30(p109);
                        end },
                    { 35, "End" }
                },
                HitRemotes = { v5 },
                HitSounds = v7
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Endlag = 0.3,
                Speed = 1.25,
                Stun = {
                    Time = 0.5,
                    StunDecay = true,
                    Priority = Enums.Stun.Medium
                },
                Sequence = {
                    {
                        0,
                        "Start",
                        {
                            Transformer = function(p112, p113, p114, p115) -- Line: 450, Name: Transformer
                                if p113.Character:GetAttribute("SDT") then
                                    p114.VoicelineFullName = p114.FullName .. "-SDT";
                                end;
                            end
                        }
                    },
                    { 0, Unsheathe },
                    { 0, function(p116, p117, p118, p119) -- Line: 457
                            -- upvalues: u31 (ref), GetSheatheData (copy)
                            local v120 = u31(p118.Character);

                            if v120 then
                                local v121 = GetSheatheData(p116, p117, v120, p119);
                                v121.SheatheWeld.Enabled = false;
                                v121.SheatheWeld.Part1 = nil;
                                v121.YamatoRig.Part1 = v121.Blade;
                                v121.YamatoRig.Enabled = true;
                            end;
                        end },
                    { 0, function(p122, p123, p124, p125) -- Line: 463
                            -- upvalues: u29 (ref)
                            u29(p124, p122);
                        end },
                    { 15, function(p126, p127, p128, p129) -- Line: 468
                            -- upvalues: Knit (copy), ComboA (copy), GetHSVShift (copy), u31 (ref)
                            local v130 = Knit.GetService("EffectService");
                            local Player = p128.Player;
                            local _ = p129.AttackStats;
                            local _ = p128.Input;
                            local Character = p128.Character;
                            local _ = Character.HumanoidRootPart;
                            v130.FireAllClients("VergilComboA", {
                                DecalName = "SlashDecal1",
                                DecalTransparency = 0,
                                Player = Player,
                                Attacker = Character,
                                VFX = ComboA.ComboASlash2,
                                OrientationStart = CFrame.fromOrientation(-0.27817057618285623, 0.09677850702308557, -1.8515848968557442),
                                OrientationGoal = CFrame.fromOrientation(0.026127578902355116, -3.116634445286274, 1.8406067758607),
                                DustVFX = ComboA.ComboASlash2Dust,
                                DustOffset = CFrame.new(0, 0, -4) * CFrame.fromOrientation(0, -1.5707963267948966, 0) + Vector3.new(0, -2.45, 0),
                                HSVShift = GetHSVShift(p128)
                            });
                            local v131 = u31(p128.Character);

                            if v131 then
                                v130.FireAllClients("VergilComboA", {
                                    DecalName = "SlashDecal1",
                                    DecalTransparency = 0,
                                    Player = Player,
                                    Attacker = v131,
                                    VFX = ComboA.ComboASlash2,
                                    OrientationStart = CFrame.fromOrientation(-0.27817057618285623, 0.09677850702308557, -1.8515848968557442),
                                    OrientationGoal = CFrame.fromOrientation(0.026127578902355116, -3.116634445286274, 1.8406067758607),
                                    DustVFX = ComboA.ComboASlash2Dust,
                                    DustOffset = CFrame.new(0, 0, -4) * CFrame.fromOrientation(0, -1.5707963267948966, 0) + Vector3.new(0, -2.45, 0),
                                    HSVShift = GetHSVShift(p128)
                                });
                            end;
                        end },
                    { 17, 22, "Attack" },
                    { 17, 22, function(p132, p133, p134, p135) -- Line: 503
                            -- upvalues: u31 (ref), TableUtil (copy), u33 (copy)
                            if not u31(p134.Character) then
                                return;
                            end;

                            local v136 = TableUtil.Copy(p135);
                            v136.AttackStats = TableUtil.Copy(v136.AttackStats, true);

                            if v136.AttackStats.Damage then
                                local AttackStats = v136.AttackStats;
                                AttackStats.Damage = AttackStats.Damage * 0.5;
                            end;

                            local Hitbox = v136.AttackStats.Hitbox;
                            Hitbox.Offset = Hitbox.Offset * u33;
                            v136.FullName = v136.FullName .. "_Doppel";
                            v136.Common.ParseAction(p132, p134, v136, "Attack");
                        end },
                    { 25, function(p137, p138, p139, p140) -- Line: 516
                            -- upvalues: u30 (ref)
                            p139.PlayerCache = {};

                            for i, _ in p137.Hit[p140.FullName] do
                                local v141 = game.Players:GetPlayerFromCharacter(i);

                                if v141 then
                                    table.insert(p139.PlayerCache, v141);
                                end;
                            end;

                            u30(p139);
                        end },
                    { 25, "End" }
                },
                HitRemotes = { v5 },
                HitSounds = v7
            }, BaseStatsModule.Rush_Attack),
            ["LMB-5"] = TableUtil.Reconcile({
                Endlag = 0.3,
                Speed = 1.5,
                Stun = {
                    Time = 1,
                    StunDecay = true,
                    Priority = Enums.Stun.Medium
                },
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = 10,
                    Offset = CFrame.identity
                },
                HitRemotes = { v6 },
                HitSounds = v7,
                Sequence = {
                    {
                        0,
                        "Start",
                        {
                            Transformer = function(p142, p143, p144, p145) -- Line: 557, Name: Transformer
                                if p143.Character:GetAttribute("SDT") then
                                    p144.VoicelineFullName = p144.FullName .. "-SDT";
                                end;
                            end
                        }
                    },
                    { 0, Unsheathe },
                    { 0, function(p146, p147, p148, p149) -- Line: 564
                            -- upvalues: u31 (ref), GetSheatheData (copy)
                            local v150 = u31(p148.Character);

                            if v150 then
                                local v151 = GetSheatheData(p146, p147, v150, p149);
                                v151.SheatheWeld.Enabled = false;
                                v151.SheatheWeld.Part1 = nil;
                                v151.YamatoRig.Part1 = v151.Blade;
                                v151.YamatoRig.Enabled = true;
                            end;
                        end },
                    { 0, function(p152, p153, p154, p155) -- Line: 570
                            -- upvalues: u29 (ref)
                            u29(p154, p152);
                        end },
                    { 28, function(p156, p157, p158, p159) -- Line: 575
                            -- upvalues: Knit (copy), ComboA (copy), GetHSVShift (copy), u31 (ref)
                            local v160 = Knit.GetService("EffectService");
                            local Player = p158.Player;
                            local _ = p159.AttackStats;
                            local _ = p158.Input;
                            local Character = p158.Character;
                            local _ = Character.HumanoidRootPart;
                            v160.FireAllClients("VergilComboA", {
                                DecalName = "EndSlashDecal",
                                DecalTransparency = 0,
                                Player = Player,
                                Attacker = Character,
                                VFX = ComboA.ComboASlash3,
                                OrientationStart = CFrame.fromOrientation(-0.25268876910373905, -0.37634534660753727, -0.46364671579229366),
                                OrientationGoal = CFrame.fromOrientation(0.1297652298857784, 3.0008842092940102, 0.5087111170787872),
                                DustVFX = ComboA.ComboASlash3Dust,
                                DustOffset = CFrame.new(0, -2.45, 0),
                                HSVShift = GetHSVShift(p158)
                            });
                            local v161 = u31(p158.Character);

                            if v161 then
                                v160.FireAllClients("VergilComboA", {
                                    DecalName = "EndSlashDecal",
                                    DecalTransparency = 0,
                                    Player = Player,
                                    Attacker = v161,
                                    VFX = ComboA.ComboASlash3,
                                    OrientationStart = CFrame.fromOrientation(-0.25268876910373905, -0.37634534660753727, -0.46364671579229366),
                                    OrientationGoal = CFrame.fromOrientation(0.1297652298857784, 3.0008842092940102, 0.5087111170787872),
                                    DustVFX = ComboA.ComboASlash3Dust,
                                    DustOffset = CFrame.new(0, -2.45, 0),
                                    HSVShift = GetHSVShift(p158)
                                });
                            end;
                        end },
                    { 30, 38, "Attack" },
                    { 30, 38, function(p162, p163, p164, p165) -- Line: 610
                            -- upvalues: u31 (ref), TableUtil (copy), u33 (copy)
                            if not u31(p164.Character) then
                                return;
                            end;

                            local v166 = TableUtil.Copy(p165);
                            v166.AttackStats = TableUtil.Copy(v166.AttackStats, true);

                            if v166.AttackStats.Damage then
                                local AttackStats = v166.AttackStats;
                                AttackStats.Damage = AttackStats.Damage * 0.5;
                            end;

                            local Hitbox = v166.AttackStats.Hitbox;
                            Hitbox.Offset = Hitbox.Offset * u33;
                            v166.FullName = v166.FullName .. "_Doppel";
                            v166.Common.ParseAction(p162, p164, v166, "Attack");
                        end },
                    { 60, function(p167, p168, p169, p170) -- Line: 623
                            -- upvalues: Knit (copy)
                            local v171 = Knit.GetService("TagService");
                            local _ = p169.Player;
                            local _ = p170.AttackStats;
                            local _ = p169.Input;

                            for _, child in v171:GetContainer(p169.Character):GetChildren() do
                                if child.Name == "NoRun" then
                                    child:Destroy();
                                end;
                            end;
                        end },
                    { 115, Sheathe },
                    { 115, function(p172, p173, p174, p175) -- Line: 635
                            -- upvalues: u31 (ref), GetSheatheData (copy)
                            local v176 = u31(p174.Character);

                            if v176 then
                                local v177 = GetSheatheData(p172, p173, v176, p175);
                                v177.YamatoRig.Enabled = false;
                                v177.YamatoRig.Part1 = nil;
                                v177.SheatheWeld.Part1 = v177.Blade;
                                v177.SheatheWeld.Enabled = true;
                            end;
                        end },
                    { 115, function(p178, p179, p180, p181) -- Line: 641
                            -- upvalues: u30 (ref)
                            p180.PlayerCache = {};

                            for i, _ in p178.Hit[p181.FullName] do
                                local v182 = game.Players:GetPlayerFromCharacter(i);

                                if v182 then
                                    table.insert(p180.PlayerCache, v182);
                                end;
                            end;

                            u30(p180);
                        end },
                    { 115, function(p183, p184, p185, p186) -- Line: 649
                            -- upvalues: Knit (copy)
                            local v187 = Knit.GetService("EffectService");
                            local _ = p186.AttackStats;
                            local _ = p185.Input;
                            local Character = p185.Character;
                            local _ = Character.HumanoidRootPart;
                            v187.FireAllClients("VergilSheathe", {
                                Player = p185.Player,
                                Attacker = Character
                            });
                        end },
                    { 115, "End" }
                }
            }, BaseStatsModule.Rush_Attack_Finisher),
            Callbacks = {
                PostHit = function(p188, p189) -- Line: 665, Name: PostHit
                    -- upvalues: u32 (ref), u4 (ref)
                    if not p188.Arguments[1] then
                        return;
                    end;

                    local ValidHits = p189.ValidHits;

                    if not ValidHits or #ValidHits <= 0 then
                        return;
                    end;

                    local Character = p188.Character;

                    if not Character:FindFirstChild("HumanoidRootPart") then
                        return;
                    end;

                    local CharacterState = p188.CharacterState;
                    local v190 = u32(Character, CharacterState["Rush Attack"].Count == 5 and 2 or 1.5, {
                        Ascend = Vector3.new(0, 2.5, 0)
                    });

                    if not v190 then
                        return;
                    end;

                    for _, v in ValidHits do
                        local HaltPosition = v.Character:FindFirstChild("HaltPosition", true);

                        if CharacterState["Rush Attack"].Count == 5 and HaltPosition then
                            HaltPosition:Destroy();
                        else
                            u4.Stun(v.Character, {
                                Time = 1.5,
                                StunDecay = true,
                                Priority = u4.Enums.Stun.Medium
                            });
                            u32(v.Character, 1.5, {
                                AutoCreate = false,
                                AlignPosition = v190
                            });
                        end;
                    end;

                    local HaltPosition = Character:FindFirstChild("HaltPosition", true);

                    if CharacterState["Rush Attack"].Count == 5 and HaltPosition then
                        HaltPosition:Destroy();
                    end;
                end
            }
        },
        Barrage = {
            Active = true,
            JudgementCuts = 1,
            Stand = false,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Hit = {
                Damage = 1,
                HitAnimations = "Default",
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(10, 8, 8.5),
                    Offset = CFrame.new(0, 0, -4.25)
                },
                Stun = {
                    Time = 0.65,
                    Barrage = true,
                    Priority = Enums.Stun.Medium
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 4,
                    Time = 0.1
                },
                Block = {
                    Blockable = true,
                    PerfectBlockable = false
                },
                HitRemotes = { v5 },
                HitSounds = v7
            },
            Finisher = {
                Damage = 20,
                HitAnimations = "Default",
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = 12,
                    HitboxType = "ClientHitbox",
                    Debug = false,
                    Offset = CFrame.identity
                },
                Stun = {
                    Time = 1
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 64,
                    Time = 0.2
                },
                Block = {
                    Blockable = true,
                    PerfectBlockable = false,
                    BlockBreak = true
                }
            }
        },
        InstantJC = {
            Active = true,
            Damage = 10,
            Stun = nil,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 8,
                HitboxType = "ClientHitbox",
                Debug = false,
                Offset = CFrame.identity
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            HitRemotes = { v6 }
        },
        ["Judgement Cut"] = {
            Active = true,
            JudgementCuts = 3,
            Damage = 10,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 6,
                AfterMove = true,
                Client = false
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 4.8,
                HitboxType = "ClientHitbox",
                Debug = false,
                Offset = CFrame.identity
            },
            Meter = {
                MeterGain = 0,
                RequiredAmount = 10,

                BypassCheck = function(p191) -- Line: 848, Name: BypassCheck
                    return p191.Character:GetAttribute("SDT");
                end
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            Stun = {
                Time = 1,
                Priority = Enums.Stun.Medium
            },
            HitRemotes = { v6 },
            Invoke = AirInvoke
        },
        ["Void Slash"] = {
            Active = true,
            JudgementCuts = 1,
            Damage = 20,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 14,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 12,
                HitboxType = "ClientHitbox",
                Debug = false,
                Offset = CFrame.identity
            },
            Block = {
                Unblockable = true
            },
            Stun = {
                Time = 2,
                Priority = Enums.Stun.Medium
            },
            HitRemotes = { v6 },
            HitSounds = v7
        },
        ["Rapid Slash"] = {
            Active = true,
            JudgementCuts = 1,
            Damage = 20,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 10,
                Manual = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(15, 8, 40),
                Debug = false,
                Offset = CFrame.new(0, 0, -20)
            },
            Meter = {
                MeterGain = 0,
                RequiredAmount = 25,

                BypassCheck = function(p192) -- Line: 938, Name: BypassCheck
                    local v193 = p192.Character:GetAttribute("SDT") and p192.Character:GetAttribute("Meter") >= 10;

                    return v193;
                end
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            Stun = {
                Time = 2,
                StunDecay = true,
                Priority = Enums.Stun.Medium
            },
            HitRemotes = { v6 },
            HitSounds = v7
        },
        ["Rising Star"] = {
            Active = true,
            JudgementCuts = 1,
            Damage = 10,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 20,
                AfterMove = true
            },
            AirborneAttack = {
                Damage = 10,
                HitAnimations = "Default",
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = 8,
                    Debug = false,
                    Offset = CFrame.identity
                },
                Block = {
                    Blockable = true,
                    PerfectBlockable = false
                },
                Stun = {
                    Time = 2,
                    Priority = Enums.Stun.Medium
                },
                HitRemotes = { v6 },
                HitSounds = v7
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(15, 8, 8),
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            Meter = {
                MeterGain = 0,
                RequiredAmount = 25,

                BypassCheck = function(p194) -- Line: 1015, Name: BypassCheck
                    return p194.Character:GetAttribute("SDT");
                end
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            Stun = {
                Time = 2,
                Priority = Enums.Stun.Medium
            },
            HitRemotes = { v6 },
            HitSounds = v7
        },
        ["Upper Slash"] = {
            Active = true,
            JudgementCuts = 1,
            Damage = 20,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Meter = {
                RemoveMeter = false,
                RequiredAmount = 25,

                BypassCheck = function(p195) -- Line: 1054, Name: BypassCheck
                    return not p195.Arguments[1];
                end
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                HitboxType = "ClientHitbox",
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            Stun = {
                Time = 2,
                Priority = Enums.Stun.Medium
            },
            HitRemotes = { v5 },
            HitSounds = v7,
            Invoke = AirInvoke
        },
        ["Upper Slash 2"] = {
            Active = true,
            JudgementCuts = 1,
            Damage = 20,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Meter = {
                RemoveMeter = false,
                RequiredAmount = 25,

                BypassCheck = function(p196) -- Line: 1100, Name: BypassCheck
                    return not p196.Arguments[1];
                end
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                HitboxType = "ClientHitbox",
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            Stun = {
                Time = 1.5,
                Priority = Enums.Stun.Medium
            },
            HitRemotes = { v5 },
            HitSounds = v7,
            Invoke = AirInvoke
        },
        ["Aerial Rave"] = {
            Active = true,
            Damage = 8.5,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 10,
                Manual = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Stun = {
                Time = 1,
                Priority = Enums.Stun.Medium
            },
            HitRemotes = { v6 },
            HitSounds = v7,
            Finisher = {
                Damage = 17,
                HitAnimations = "Default",
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(8, 8, 8),
                    Offset = CFrame.new(0, 0, -4)
                },
                Stun = {
                    Time = 0.5,
                    Priority = Enums.Stun.Medium
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 64,
                    Time = 0.2
                },
                HitRemotes = { v6 },
                HitSounds = v7
            },
            Invoke = AirborneOnly
        },
        ["Aerial Cleave"] = {
            Active = true,
            JudgementCuts = 1,
            Damage = 21.25,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 15,
                Manual = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            Meter = {
                RemoveMeter = false,
                MeterGain = 0,
                RequiredAmount = 25,

                BypassCheck = function(p197) -- Line: 1218, Name: BypassCheck
                    return p197.Character:GetAttribute("SDT");
                end
            },
            Block = {
                Unblockable = true
            },
            Stun = {
                Time = 2,
                Priority = Enums.Stun.Medium
            },
            HitRemotes = { v6 },
            HitSounds = v7,
            Invoke = AirborneOnly
        },
        ["Judgement Cut End"] = {
            Active = true,
            Damage = 100,
            TrueDamage = true,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 60,
                AfterMove = false,
                Manual = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 100,
                HitboxType = "ClientHitbox",
                Debug = false,
                Offset = CFrame.identity
            },
            Priority = Enums.Intangible.Move,
            Meter = {
                MeterGain = 0,
                RequiredAmount = 100,

                BypassCheck = function(p198) -- Line: 1270, Name: BypassCheck
                    return p198.Character:GetAttribute("SDT");
                end
            },
            Block = {
                Unblockable = true
            },
            Stun = {
                Time = 1,
                Priority = Enums.Stun.Medium
            },
            Ragdoll = {
                Time = 0.5
            },
            HitRemotes = { v5 },
            HitSounds = v7
        },
        SDT = {
            HealPercent = 0.01,
            HealCap = 15,
            Duration = 10,
            Heal = 0,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 60
            },
            StatBuffs = {
                Attack = 50
            },
            Meter = {
                RemoveMeter = false,
                RequiredAmount = 100,
                DrainAmount = 0
            }
        },
        Doppelganger = {
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 30,
                Manual = true
            },
            Meter = {
                RemoveMeter = false,
                RequiredAmount = 50,
                DrainAmount = 5
            }
        },
        Trick = {
            Active = true,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 1.5,
                AfterMove = true
            }
        },
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
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
                Name = "Quickstep",
                Time = 1.5,
                Force = true,
                CooldownReduction = false,
                Manual = true
            },
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },

            Invoke = function(p199) -- Line: 1398, Name: Invoke
                -- upvalues: Knit (copy), TagService (copy), AnimationHandler (copy), TweenService (copy), Trove (copy)
                local v200 = Knit.GetController("CombatController");
                local v201 = Knit.GetService("MoveInputService");
                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;
                TagService:GetContainer(LocalPlayer);
                local Humanoid = Character:WaitForChild("Humanoid");
                local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
                local u202 = AnimationHandler.Get(Humanoid.Animator);
                local v203;

                if Humanoid.MoveDirection == Vector3.new(0, 0, 0) then
                    v203 = -HumanoidRootPart.CFrame.LookVector;
                else
                    v203 = Humanoid.MoveDirection;
                end;

                v201:FireInput(p199.RawInput);

                local function Lerp(p204, p205, p206) -- Line: 1416
                    return p204 + (p205 - p204) * p206;
                end;

                local v207 = HumanoidRootPart.CFrame:VectorToObjectSpace(v203);
                local v208 = math.atan2(v207.X, -v207.Z);
                local v209 = math.deg(v208) - 0.5;
                local v210 = math.ceil(v209);
                u202:StopAnimation("ForwardDash", 0.1);
                u202:StopAnimation("BackwardDash", 0.1);
                u202:StopAnimation("LeftDash", 0.1);
                u202:StopAnimation("RightDash", 0.1);
                local v211 = HumanoidRootPart.CFrame + v203 * 20;
                local v212 = RaycastParams.new();
                v212.FilterDescendantsInstances = { workspace.Map, workspace.Terrain };
                v212.FilterType = Enum.RaycastFilterType.Include;
                v212.IgnoreWater = true;
                local v213 = workspace:Raycast(HumanoidRootPart.Position, CFrame.lookAt(HumanoidRootPart.Position, v211.Position).LookVector * 20, v212);

                if v213 and v213.Position then
                    v211 = CFrame.new(v213.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
                end;

                local u214 = TweenService:Create(HumanoidRootPart, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
                    CFrame = v211
                });
                local u215 = false;
                local v216 = Trove.new();
                local u217 = `{v210 > 45 and v210 < 135 and "Right" or (v210 < -45 and v210 > -135 and "Left" or ((v210 <= -135 or v210 >= 135) and "Backward" or "Forward"))}Dash`;
                u202:PlayAnimation(u217, 0.9);
                v216:Add(v200.QuickstepInterrupted:Connect(function() -- Line: 1480
                    -- upvalues: u215 (ref), u202 (copy), u217 (copy), u214 (copy)
                    u215 = true;
                    u202:StopAnimation(u217, 0.9);
                    u214:Cancel();
                end));
                u214:Play();
            end
        },
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p218, p219) -- Line: 1512, Name: Transformer
                    -- upvalues: TableUtil (copy)
                    local v220 = TableUtil.Copy(p218.Stats, true);
                    local _ = p218.Character.HumanoidRootPart;
                    v220.ChairType = math.random(2) == 1 and "TreeChair" or "PlasticChair";

                    if v220.ChairType == "PlasticChair" then
                        v220.StartAnim = "PlasticPoseTransition";
                        v220.LoopAnim = "PlasticPoseIdle";
                    end;

                    return v220;
                end,

                PoseTransition = function(p221, p222) -- Line: 1527, Name: PoseTransition
                    -- upvalues: Knit (copy)
                    Knit.GetService("EffectService").FireAllClients("VergilPose", {
                        Player = p221.Player,
                        Attacker = p221.Character,
                        ChairType = p222.NewStats.ChairType
                    });
                end
            }
        },
        Grab = {
            From = "Combat.Grab",
            Indicators = { {
                    Group = "Universal",
                    InputText = "%s",
                    Visible = true
                } },
            Grab = {
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "Universal_Grab_Hit", "__Attacker", "__Target" }
                    } }
            },
            Throw = {
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "Universal_Grab_Throw", "__Attacker", "__Target" }
                    } }
            }
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 118991432540563,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 71474575628076,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 127895402345563,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 125284688099187,
            Volume = 2
        },
        ["LMB-5"] = {
            SoundId = 104602175537558,
            Volume = 2
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 128276125478987,
            Volume = 2
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 76790759392534,
            Volume = 2
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 100489614860673,
            Volume = 2
        },
        ["LMB-5-Voiceline"] = {
            SoundId = 87109723709138,
            Volume = 2
        },
        ["LMB-1-SDT-Voiceline"] = {
            SoundId = 95056957170813,
            Volume = 2
        },
        ["LMB-3-SDT-Voiceline"] = {
            SoundId = 108840007139947,
            Volume = 2
        },
        ["LMB-4-SDT-Voiceline"] = {
            SoundId = 84819511749343,
            Volume = 2
        },
        ["LMB-5-SDT-Voiceline"] = {
            SoundId = 138005551805511,
            Volume = 2
        },
        vergil_judgement_cut_hitbox_appear_sfx = {
            SoundId = 121471138505450,
            Volume = 2
        },
        vergil_quick_judgement_cut_sfx = {
            SoundId = 100883672104066,
            Volume = 2
        },
        vergil_manual_judgement_cut_sfx = {
            SoundId = 126413896329526,
            Volume = 2
        },
        vergil_rapid_slash_sfx = {
            SoundId = 109411956219847,
            Volume = 2
        },
        vergil_barrage_startup_sfx = {
            SoundId = 109524597791313,
            Volume = 2
        },
        vergil_barrage_loop_sfx = {
            SoundId = 99917706738744,
            Volume = 2,
            Looped = true
        },
        vergil_barrage_finisher_sfx = {
            SoundId = 132878447092910,
            Volume = 2
        },
        vergil_void_slash_sfx = {
            SoundId = 84887443146228,
            Volume = 2
        },
        vergil_upper_slash_sfx = {
            SoundId = 102051173107609,
            Volume = 2
        },
        vergil_upper_slash_voiceline = {
            SoundId = 76467891670069,
            Volume = 2
        },
        vergil_rapid_slash_voiceline = {
            SoundId = 90408513756930,
            Volume = 2
        },
        vergil_void_slash_voiceline = {
            SoundId = 96901008344429,
            Volume = 2
        },
        vergil_barrage_voiceline = {
            SoundId = 103634469952521,
            Volume = 2
        },
        vergil_judgement_cut_voiceline = {
            SoundId = 81913756047738,
            Volume = 2
        },
        vergil_manual_judgement_cut_voiceline = {
            SoundId = 129093868574941,
            Volume = 2
        },
        vergil_judgement_cut_end_voiceline1 = {
            SoundId = 92949578296976,
            Volume = 2
        },
        vergil_judgement_cut_end_voiceline2 = {
            SoundId = 135903818058151,
            Volume = 2
        },
        vergil_judgement_cut_end_sfx = {
            SoundId = 73081510948061,
            Volume = 2
        },
        vergil_doppelganger_activated_sfx = {
            SoundId = 74506968706370,
            Volume = 2
        },
        vergil_sdt_activated_sfx = {
            SoundId = 112877630391926,
            Volume = 2
        },
        vergil_sdtonly_barrage_finisher_voice = {
            SoundId = 73472060228723,
            Volume = 2
        },
        vergil_sdtonly_rapid_slash_voiceline1 = {
            SoundId = 92416536192044,
            Volume = 2
        },
        vergil_sdtonly_upper_slash_voice = {
            SoundId = 122497419371098,
            Volume = 2
        },
        vergil_sdtonly_judgement_cut_voice1 = {
            SoundId = 127333229240029,
            Volume = 2
        },
        vergil_sdtonly_judgement_cut_voice2 = {
            SoundId = 117460533815447,
            Volume = 2
        },
        vergil_sdtonly_jce_voice1 = {
            SoundId = 125074013892121,
            Volume = 2
        },
        vergil_sdtonly_jce_voice2 = {
            SoundId = 86108485117888,
            Volume = 2
        },
        vergil_sdtonly_ijc_voice1 = {
            SoundId = 73833537396644,
            Volume = 2
        },
        vergil_sdtonly_ijc_voice2 = {
            SoundId = 118571599569354,
            Volume = 2
        },
        vergil_sdtonly_void_slash_voice1 = {
            SoundId = 98338218252658,
            Volume = 2
        },
        vergil_sdtonly_void_slash_voice2 = {
            SoundId = 73500327344571,
            Volume = 2
        },
        vergil_trick_sfx = {
            SoundId = 104949035889095,
            Volume = 2
        },
        vergil_aerial_rave_sfx = {
            SoundId = 140178561419434,
            Volume = 2
        },
        vergil_aerial_cleave_sfx = {
            SoundId = 73680658100983,
            Volume = 2
        },
        vergil_aerial_cleave_voice = {
            SoundId = 71679158592859,
            Volume = 2
        },
        vergil_sdt_aerial_cleave_voice = {
            SoundId = 115224433951339,
            Volume = 2
        },
        vergil_jackpot_voiceline = {
            SoundId = 138097361967977,
            Volume = 2
        },
        vergil_risingstar_follow_up_voice = {
            SoundId = 72008327777900,
            Volume = 2
        },
        vergil_sdt_risingstar_follow_up_voice = {
            SoundId = 120105372396026,
            Volume = 2
        },
        vergil_risingstar_follow_up_sfx = {
            SoundId = 85236606221419,
            Volume = 2
        },
        vergil_upper_slash_2_sfx = {
            SoundId = 136929877134712,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 6914699450,
            Volume = 1
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
                    SoundId = "rbxassetid://78829051738082",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Now I\'m a little motivated."
                        } }
                }, {
                    SoundId = "rbxassetid://76109519177285",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Show me your motivation!"
                        } }
                }, {
                    SoundId = "rbxassetid://124118328090206",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You think you stand a chance...? Hmm..."
                        } }
                } },
            SDT = { {
                    SoundId = "rbxassetid://137630130508763",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Fine, I suppose this is how you wish to die."
                        } }
                }, {
                    SoundId = "rbxassetid://131077071133714",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Scum."
                        } }
                }, {
                    SoundId = "rbxassetid://139389784822929",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "...You\'re just gonna stand there?"
                        } }
                } }
        }
    },
    Metadata = {
        PostRig = function(p223) -- Line: 2117, Name: PostRig
            local Stand = p223.Character:WaitForChild("Stand");
            local YamatoRig_Motor6D = Stand:WaitForChild("YamatoRig"):WaitForChild("YamatoRig_Motor6D");
            local SheatheBladeWeld = Stand:WaitForChild("YamatoSheatheRig"):WaitForChild("SheatheBladeWeld");
            local YamatoRig = Stand:WaitForChild("YamatoRig");
            YamatoRig_Motor6D.Enabled = false;
            YamatoRig_Motor6D.Part1 = nil;
            SheatheBladeWeld.Enabled = true;
            SheatheBladeWeld.Part1 = YamatoRig;
        end
    }
};