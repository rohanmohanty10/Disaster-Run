  

 

local PathShortcuts = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").PathShortcuts);
table.find(PathShortcuts.TestPlaces, game.PlaceId);
local RunService = game:GetService("RunService");
local u1 = {
    Movesets = {
        Hornet = {
            LMB = "m1",
            Q = "Grapple",
            E = "Hegale",
            R = "Dash Strike",
            T = "Edino",
            X = "Block",
            C = "Dash",
            P = "Pose"
        },
        Clown = {
            LMB = "LMB Combo V3",
            E = "Barrage",
            R = "Strong Punch",
            T = "Uzi",
            F = "Timestop",
            V = "Insta-Dash",
            B = "Stand Jump",
            U = "Pilot",
            Y = "Time Erase",
            H = "Time Accelerate",
            Q = "Summon",
            P = "Pose",
            ["Alt-N"] = "Quote V2"
        },
        A_Sans = {
            E = "Bone Field",
            J = "Bad Time"
        },
        Hollow = {
            LMB = "LMB Combo",
            E = "Spin",
            R = "Rift Slash",
            T = "Teleport Smash",
            F = "Summon Skeletons"
        },
        ["Skeleton NPC"] = {
            LMB = "LMB Combo",
            E = "Hit",
            R = "Headbutt",
            T = "ArmHit"
        },
        Thug = {
            LMB = "Oni Combo",
            T = "Invitation to Hell",
            R = "Drop Kick",
            E = "Stylish Sweeps",
            G = "Dragon Bite",
            F = "Asphalt Connoisseur",
            H = "Way of the Yakuza",
            V = "Brawler\'s Instinct",
            C = "Dash",
            X = "Block",
            P = "Pose"
        },
        Fightsabre = {
            LMB = "Shoot",
            R = "Reload",
            E = "Kick",
            C = "GungeonDash",
            X = "Block",
            P = "Pose"
        },
        ["Slayer Armor II"] = {
            Q = "Equip",
            LMB = "LMB Combo",
            F = "Execute",
            V = "Carry",
            R = "C4",
            X = "Block",
            P = "Pose",
            C = "Dash"
        },
        Ruined = {
            Q = "Equip",
            LMB = "LMB Combo V2",
            X = "Block",
            R = "Thrust",
            C = "Dash"
        },
        Gun = {
            LMB = "Shoot",
            R = "Reload",
            E = "Kick",
            C = "GungeonDash",
            X = "Block",
            P = "Pose"
        },
        ["Tatoo You"] = {
            LMB = "LMB Combo",
            T = "GunShot",
            E = "Hide",
            R = "Exit"
        },
        ["PLANET // SHAPER"] = {
            Q = "Summon",
            LMB = "LMB Combo V3",
            E = "Earthquake",
            R = "Portal Pass",
            Y = "PortalRemedy",
            F = "GemBlast",
            G = "Gate",
            H = "Teamwork",
            V = "GateWarp",
            T = "Roar",
            P = "Pose",
            C = "Dash",
            X = "Block"
        },
        ["Nuclear Star"] = {
            Groups = {
                Universal = {
                    Visible = true
                },
                StandOff = {
                    Visible = true
                },
                StandOn = {
                    Visible = false
                }
            },
            Moves = {
                Q = "Summon",
                MouseButton1 = "Rush Attack",
                F = "Block",
                C = "Quickstep",
                X = "Grab",
                E = "EMoves",
                R = "RMoves",
                T = "TMoves",
                Y = "YMoves",
                G = "GMoves",
                V = "VMoves",
                P = "Pose"
            }
        },
        CR_R = {
            Groups = {
                Universal = {
                    Visible = true
                },
                StandOff = {
                    Visible = true
                },
                StandOn = {
                    Visible = false
                }
            },
            Moves = {
                Q = "Summon",
                MouseButton1 = "Rush Attack",
                F = "Block",
                C = "Quickstep",
                X = "Grab",
                E = "EMoves",
                R = "RMoves",
                T = "TMoves",
                Y = "YMoves",
                G = "GMoves",
                H = "HMoves",
                J = "JMoves",
                P = "Pose"
            }
        },
        ["The Hand"] = {
            Groups = {
                Universal = {
                    Visible = true
                },
                StandOff = {
                    Visible = true
                },
                StandOn = {
                    Visible = false
                }
            },
            Moves = {
                Q = "Summon",
                F = "Block",
                C = "Quickstep",
                E = "EMoves",
                R = "RMoves",
                T = "TMoves",
                Y = "Quick Swipe",
                G = "The Hand",
                H = "The Foot",
                V = "Erasure Teleportation"
            }
        },
        Vampire = {
            Groups = {
                Universal = {
                    Visible = true
                }
            },
            Moves = {
                LMB = "Rush Attack",
                Q = "Villainous Presence",
                E = "5 or 6 Broken Ribs",
                R = "Vaporization Freeze",
                T = "Space Ripper Stingy Eyes",
                Y = "Magnificent Power",
                G = "Defensive Will",
                H = "Call of the Dead",
                V = "Banishment",
                F = "Block",
                C = "Quickstep",
                P = "Pose"
            }
        },
        EP_R = {
            Groups = {
                Universal = {
                    Visible = true
                }
            },
            Moves = {
                MouseButton1 = "Rush Attack",
                F = "Block",
                C = "Quickstep",
                X = "Grab",
                Q = "QMoves",
                E = "EMoves",
                R = "RMoves",
                T = "TMoves",
                Y = "YMoves",
                G = "GMoves",
                H = "HMoves",
                V = "VMoves",
                B = "BMoves",
                P = "Pose"
            }
        },
        ["STEEL SPIN_R"] = {
            Groups = {
                Universal = {
                    Visible = true
                }
            },
            Moves = {
                MouseButton1 = "Rush Attack",
                C = "Quickstep",
                X = "Grab",
                Q = "QMoves",
                E = "EMoves",
                R = "RMoves",
                T = "TMoves",
                Y = "YMoves",
                G = "GMoves",
                H = "HMoves",
                V = "VMoves",
                B = "BMoves",
                F = "FMoves",
                Z = "ZMoves",
                P = "Pose"
            }
        },
        Goku = {
            Q = "Charge",
            P = "Pose",
            B = "Detransform",
            LMB = "LMB Combo",
            E = "Kamehameha",
            R = "Feint",
            T = "Genkidama",
            Y = "Dragon Fist",
            F = "Barrage",
            G = "Meteor Strike",
            V = "Blink",
            H = "Instant Transmission",
            C = "Dash",
            X = "Block",
            One = "Transform",
            Two = "Transform",
            Three = "Transform",
            Four = "Transform",
            Five = "Transform",
            Six = "Transform",
            Seven = "Transform",
            Eight = "Transform",
            Nine = "Transform"
        },
        ["Planet Shaper"] = {
            Q = "Summon",
            E = "Barrage",
            LMB = "LMB",
            C = "Dash",
            X = "Block",
            R = "Strong Punch",
            T = "Infuse",
            F = "Reality Shift",
            Y = "Rampage",
            B = "Blackhole Punch",
            H = "Ground Slam",
            V = "Wing Slash"
        },
        Ardoth = {
            Q = "Lightning Dash",
            E = "Lightning Elbow",
            LMB = "LMB Combo",
            R = "Lightning Drop",
            T = "Thundering Leap",
            C = "Dash",
            X = "Block"
        },
        ["Made In Heaven"] = {
            Q = "Summon",
            LMB = "LMB Combo V3",
            C = "Dash",
            X = "Block",
            E = "BurstBarrage",
            F = "Last Strike",
            Y = "MiHYMovesY",
            T = "Knives",
            R = "QuickJab",
            V = "Teleport",
            P = "Pose",
            H = "TimeAccelerate"
        },
        ["Stone Free"] = {
            Q = "Summon",
            E = "Ora Kicks",
            T = "Spider Tacks/Pitcher Fly",
            Y = "Letterman Grapple",
            G = "String Barrier",
            H = "Chin Crusher",
            R = "RMoves",
            F = "Strand Separation",
            B = "String Guard",
            C = "Dash",
            X = "Block",
            P = "Pose"
        },
        ["Uber Oni"] = {
            Q = "DemonFlipM2",
            Y = "Misogi",
            E = "RisingDragon",
            R = "LegBreaker",
            G = "AxeKick",
            F = "Rampage",
            C = "Demon Step",
            B = "Consuming Flames"
        },
        ["Dragon Sage"] = {
            LMB = "LMB Combo",
            Q = "Lightning Dash",
            E = "Lightning Elbow",
            R = "Lightning Drop",
            T = "Thundering Leap",
            Y = "Electric Smite",
            F = "Seismic Toss",
            G = "Monk Shield"
        },
        Gaster = {
            LMB = "Combo",
            R = "LMB",
            F = "Summon",
            E = "SwitchL",
            Q = "SwitchR",
            T = "Fire",
            C = "Dash",
            X = "Block"
        },
        Chara = {
            LMB = "LMB"
        },
        HI = {
            ["are u stealing?"] = "LOL",
            nice = "Synapse X",
            ["while true do"] = "instance.new(\'Part\', workspace)",
            ["L + bozo + ratio + imagine synapse"] = "hi ",
            ["hi guys"] = "ez"
        },
        ["Sticky Fingers"] = {
            F = "Zipper Finger",
            C = "Ambition Dash",
            V = "Zipper Glide",
            E = "Barrage",
            R = "Heavy Punch",
            T = "Zipper Punch",
            Y = "Zipper Extended Punch",
            H = "Zipper Hand",
            L = "who actually thinks this is real"
        },
        ["Demon Lord"] = {
            Q = "Devil Eyes",
            E = "Lightning Strike",
            V = "Regenerate"
        },
        Garuto = {
            Q = "QMoves",
            LMB = "LMB Combo",
            E = "EMoves"
        },
        Shinigami = {
            Q = "Summon",
            E = "StrongPunch",
            R = "Chop",
            Y = "Kick",
            H = "StrongerStrongPunch",
            X = "Block",
            Z = "StandJump",
            F = "Slam",
            V = "Shift",
            C = "Dash",
            T = "Heal",
            G = "Pose",
            LMB = "Punch"
        },
        CakePlatinum = {
            Q = "Summon",
            E = "Barrage",
            R = "StrongPunch",
            H = "Slam",
            V = "OHBlast",
            Y = "SelfHeal",
            F = "Timestop",
            X = "Block",
            Z = "StandJump",
            C = "Dash",
            P = "Pose",
            LMB = "Punch"
        },
        ["The World"] = {
            Q = "Summon",
            E = "Barrage",
            R = "Donut",
            T = "Checkmate",
            Y = "RoadRoller",
            ["SUB-Y"] = "Stop Sign",
            F = "Timestop",
            G = "DebrisSlam",
            B = "BloodSuck",
            LMB = "LMB Combo V3",
            C = "Dash",
            X = "Block",
            V = "Teleport",
            P = "Pose"
        },
        Dio = {
            Q = "Summon",
            E = "Barrage",
            R = "Donut",
            T = "Checkmate",
            ["SUB-Y"] = "Stop Sign",
            F = "Timestop",
            G = "DebrisSlam",
            B = "BloodSuck",
            LMB = "LMB Combo",
            C = "Dash",
            X = "Block",
            V = "Teleport"
        },
        SP_CR = {
            Q = "Summon",
            MouseButton1 = "Rush Attack",
            E = "Barrage",
            C = "Quickstep",
            F = "Block",
            G = "Grab",
            Z = "ZMoves",
            X = "XMoves"
        },
        ["Creeper Queen"] = {
            Q = "Summon",
            E = "EMoves",
            R = "RMoves",
            F = "FMoves",
            C = "Dash",
            X = "Block",
            H = "Sheer Heart Attack",
            T = "Yen Throw",
            Y = "Bubble Bomb",
            G = "Escape Plan",
            LMB = "LMB Combo V3",
            P = "Pose"
        },
        Inker = {
            Q = "Summon",
            E = "Barrage",
            R = "RMove",
            LMB = "LMB Combo",
            X = "Block",
            C = "Dash",
            T = "Bullets",
            H = "GroundSlam",
            F = "Ultimate",
            P = "Pose",
            V = "Teleport",
            G = "Flight",
            B = "Susanoo Summon",
            Y = "Susanoo Roar",
            J = "Susanoo Slashes"
        },
        Crystallized = {
            E = "Barrage",
            Q = "Summon",
            R = "Strong Punch",
            V = "Crystal Dash",
            F = "Crystallize",
            T = "Crystal Bombardment",
            LMB = "Crystal Punch",
            X = "Block",
            C = "Dash",
            B = "Stand Jump"
        },
        ["Nuclear Star"] = {
            E = "Barrage",
            Q = "Summon",
            R = "Strong Punch",
            V = "Stellar Dash",
            F = "Stellar Eruptions",
            T = "Crystal Bombardment",
            X = "Block",
            C = "Dash",
            LMB = "Stellar Punch",
            B = "Stand Jump"
        },
        ["Senator Armstrong"] = {
            LMB = "Heavy Blows",
            E = "University of Texas",
            R = "Field Goal",
            T = "Fart Reverb",
            Y = "Light of Allah",
            F = "Charging Headbutt",
            G = "Nanomachines, Son!",
            X = "Block"
        },
        STWR_R = {
            Groups = {
                Universal = {
                    Visible = true
                },
                StandOff = {
                    Visible = true
                },
                StandOn = {
                    Visible = false
                }
            },
            Moves = {
                Q = "Summon",
                MouseButton1 = "Rush Attack",
                F = "Block",
                C = "Quickstep",
                X = "Grab",
                E = "EMoves",
                R = "RMoves",
                T = "Sinful Puncture",
                Y = "YMoves",
                G = "Shaded Induction",
                V = "Cursed Arrow",
                H = "Shadowy Ire",
                P = "Pose",
                Z = "ZMoves"
            }
        },
        SPR = {
            LMB = "LMB Combo V3",
            Q = "Summon",
            E = "Cursed Punches",
            R = "Arrow Judgement",
            T = "Arrow Throw",
            H = "StarBreaker",
            Y = "Arrow Prison",
            V = "TSTeleport",
            F = "Timestop",
            C = "Dash",
            G = "GroundSlam",
            X = "Block",
            J = "Combo",
            P = "Pose"
        },
        TWHV = {
            Q = "Summon",
            E = "Barrage",
            R = "HeavyPunch",
            T = "KnifeThrow",
            Y = "Revolver",
            F = "Timestop",
            H = "TripleMuda",
            G = "CutsceneMove",
            B = "Gasoline",
            J = "Horse",
            U = "BarbedWire",
            V = "Teleport",
            P = "Pose",
            X = "Block",
            LMB = "LMB Combo V3",
            C = "Dash"
        },
        StarPlatinumOVA = {
            Q = "Summon",
            E = "Barrage",
            T = "TMoves",
            R = "HeavyPunch",
            B = "Drink",
            G = "GroundSlam",
            F = "FMoves",
            H = "StarSuck",
            X = "Block",
            P = "Pose",
            LMB = "LMB Combo",
            C = "Dash"
        },
        DOG = {
            LMB = "Attack"
        },
        SINKING = {
            Q = "Summon"
        },
        NOC_R = {
            Groups = {
                Universal = {
                    Visible = true
                },
                StandOff = {
                    Visible = true
                },
                StandOn = {
                    Visible = false
                }
            },
            Moves = {
                Q = "Summon",
                MouseButton1 = "Rush Attack",
                F = "Block",
                C = "Quickstep",
                X = "Grab"
            }
        },
        Reaper = {
            Q = "Summon",
            LMB = "Slash",
            E = "Soul Torment",
            R = "Wither",
            C = "Dash",
            T = "Lost Soul",
            Y = "Soul Consumption",
            F = "Consecutive Slashes",
            G = "Frightened Soul",
            V = "Soul Embodiment",
            X = "Block",
            P = "Pose"
        },
        ["Soft and Wet"] = {
            Q = "Summon",
            E = "Barrage",
            R = "HeavyPunch",
            LMB = "LMB Combo",
            C = "Dash",
            X = "Block"
        },
        Guts = {
            LMB = "LMB Combo V3",
            Q = "Berserker Armor",
            E = "Cleaver",
            R = "Earthquake",
            T = "Vital Targeting",
            Y = "Loose Cannon",
            F = "Opening Cut",
            G = "Dragon Slayer",
            H = "Blood & Guts"
        },
        ["Diver Down"] = {
            Q = "Summon",
            E = "Barrage",
            R = "HeavyPunch",
            LMB = "LMB Combo",
            C = "Dash",
            X = "Block"
        },
        Sol = {
            Q = "Summon",
            LMB = "LMB Combo",
            E = "Teleport Barrage",
            R = "Intangible Punch",
            T = "Nuclear Fusion",
            F = "Sol Star",
            G = "Cosmic Dust",
            V = "Teleport",
            C = "Dash",
            X = "Block",
            P = "Pose"
        },
        SOL_R = {
            Groups = {
                Universal = {
                    Visible = true
                },
                StandOff = {
                    Visible = true
                },
                StandOn = {
                    Visible = false
                }
            },
            Moves = {
                Q = "Summon",
                MouseButton1 = "Rush Attack",
                F = "Block",
                C = "Quickstep",
                X = "Grab",
                G = "Slam"
            }
        },
        Deathnote = {
            Q = "Toggle"
        },
        Johnny = {
            Q = "Summon Tusk",
            E = "Barrage",
            M = "Wormhole Barrage",
            LMB = "LMB Combo",
            R = "Skull Bash",
            C = "Dash",
            F = "Rotational Guidance",
            H = "Dark Determination",
            T = "Nail Shot",
            V = "Unrelenting Assault",
            X = "Block",
            B = "Herbal Tea",
            Y = "Wormhole Crash"
        },
        GOKU_R = {
            Groups = {
                Universal = {
                    Visible = true
                },
                Base = {
                    Visible = true
                },
                Saiyan = {
                    Visible = false
                },
                ["Saiyan God"] = {
                    Visible = false
                },
                ["Ultra Instinct"] = {
                    Visible = false
                }
            },
            Moves = {
                MouseButton1 = "Rush Attack",
                One = "Base",
                Two = "Super Saiyan",
                Three = "Super Saiyan God",
                Four = "Ultra Instinct",
                E = "EMoves",
                R = "RMoves",
                T = "TMoves",
                Y = "YMoves",
                G = "GMoves",
                B = "BMoves",
                H = "Senzu Bean",
                K = "Kaioken",
                V = "Instant Transmission",
                X = "Grab",
                C = "Quickstep",
                F = "Block",
                P = "Pose"
            }
        },
        UBER_R = {
            Groups = {
                Universal = {
                    Visible = true
                }
            },
            Moves = {
                MouseButton1 = "Rush Attack",
                V = "Demon Step",
                G = "Raging Demon",
                X = "Grab",
                C = "Quickstep",
                F = "Block",
                P = "Pose"
            }
        },
        zaihop = {
            LMB = "Shovel Slashes",
            E = "Spiraling Spade",
            R = "Home Run",
            T = "Bullet Hell",
            V = "Hopu Hopu Hamma",
            B = "Intonjutsu",
            C = "Dash",
            P = "Pose"
        },
        GER = {
            Q = "Summon",
            LMB = "LMB Combo V3",
            E = "Barrage",
            R = "Heavy Attack",
            T = "Return To Zero",
            Y = "Unreachable Truth",
            F = "Berserk Senses V2",
            G = "Debris Projectile",
            H = "Life Giver",
            V = "Pursuit Rush",
            C = "Dash",
            P = "Pose"
        },
        ["Mortal Man"] = {
            Q = "Summon",
            C = "Dash",
            X = "Block",
            P = "Pose",
            V = "VMoves",
            E = "EMoves",
            R = "RMoves",
            T = "TMoves",
            Y = "YMoves",
            F = "FMoves",
            G = "GMoves",
            H = "HMoves",
            B = "BMoves",
            J = "JMoves",
            U = "UMoves"
        },
        ["S/TW"] = {
            Q = "Summon",
            C = "Dash",
            X = "Block",
            P = "Pose",
            LMB = "LMB Combo",
            V = "VMoves",
            E = "EMoves",
            R = "RMoves",
            T = "TMoves",
            Y = "YMoves",
            F = "FMoves",
            G = "GMoves",
            H = "HMoves",
            B = "BMoves",
            J = "JMoves",
            U = "UMoves"
        }
    }
};
u1.Movesets.StarPlatinumOVA = u1.Movesets["Star Platinum"];
u1.Movesets.Urzan = u1.Movesets.Reaper;
u1.Movesets.Reakur = u1.Movesets.Reaper;
u1.Movesets.DTWHV = u1.Movesets.TWHV;
u1.Movesets["Boa H"] = u1.Movesets["Mero Mero"];

for _, v in pairs(u1.Movesets) do
    if v.Moves then
        if not v.Moves.Run then
            v.Moves.Run = "RUN";
        end;

        if not v.Moves.Lock then
            v.Moves.Lock = "LOCK";
        end;
    else
        if not v.Z then
            v.Z = "Sprint";
        end;

        if not v.X then
            v.X = "Block";
        end;
    end;
end;

local function deepCopy(p2) -- Line: 1112
    -- upvalues: deepCopy (copy)
    local v3 = {};

    for i, v in pairs(p2) do
        if type(v) == "table" then
            local v = deepCopy(v) or v;
        end;

        v3[i] = v;
    end;

    return v3;
end;

u1.DefaultKeys = deepCopy(u1.Movesets);
u1.KeybindFunctions = {};
u1.ExternalKeybinds = {};

function u1.KeybindFunctions.ChangeKey(p4, p5, p6, p7) -- Line: 1124
    -- upvalues: u1 (copy), RunService (copy)
    local v8 = u1.Movesets[p5];

    if not RunService:IsClient() then
        if RunService:IsServer() and (p4 and p4.Parent == game.Players) then
            if not u1.ExternalKeybinds[p4.Name] then
                u1.ExternalKeybinds[p4.Name] = {};
            end;

            u1.ExternalKeybinds[p4.Name][p7] = v8[p6];
        end;

        return p7;
    end;

    v8[p7] = v8[p6];
    v8[p6] = nil;
    print("rebinded", v8[p7], "from", p6, "to", p7, RunService:IsClient() and "Client" or "Server");
    game.ReplicatedStorage.Remotes.InputFunc:InvokeServer("Change Key", p5, p6, p7);

    return p7;
end;

function u1.KeybindFunctions.ResetKeys(p9) -- Line: 1140
    -- upvalues: RunService (copy), u1 (copy), deepCopy (copy)
    if RunService:IsStudio() and (p9 and p9.Parent == game.Players) then
        table.clear(u1.ExternalKeybinds[p9.Name] or {});
    end;

    table.clear(u1.Movesets);

    for i, v in pairs(u1.DefaultKeys) do
        u1.Movesets[i] = deepCopy(v);
    end;
end;

return u1;