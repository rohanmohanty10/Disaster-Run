  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local Knit = require(ReplicatedStorage.Packages.Knit);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local CameraController = require(ReplicatedStorage.Controllers.CameraController);

local function isPointInVolume(p1: vector, p2, p3: vector) -- Line: 9
    local v4 = p2:PointToObjectSpace(p1);
    local v5;

    if v4.X >= -p3.X / 2 and (v4.X <= p3.X / 2 and (v4.Y >= -p3.Y / 2 and (v4.Y <= p3.Y / 2 and v4.Z >= -p3.Z / 2))) then
        v5 = v4.Z <= p3.Z / 2;
    else
        v5 = false;
    end;

    return v5;
end;

return {
    ["Reaper Sae"] = {
        Abilities = {
            ["1"] = function(p6, p7, p8) -- Line: 22
                return p8 and (p7.PlayerStats.InAwakening.Value and "Reaper Step" or (p8:GetAttribute("DeathsCall") and "Deaths Call" or "Scythe Pass")) or "";
            end,

            ["2"] = function(p9, p10, p11) -- Line: 34
                return p11 and (p10.PlayerStats.InAwakening.Value and "Execution Shot" or (p11.Values.HasBall.Value and "Reaper Turn" or "Scythe Slam")) or "";
            end,

            ["3"] = function(p12, p13, p14) -- Line: 46
                return "Graveyard";
            end
        }
    },
    ["Demon Shidou"] = {
        Abilities = {
            ["1"] = function(p15, p16, p17) -- Line: 54
                return p17 and (p16.PlayerStats.InAwakening.Value and "Inferno Dragon Drive" or (p17:GetAttribute("DemonicDribble") and "Demonic Shot" or "Demonic Dribble")) or "";
            end,

            ["2"] = function(p18, p19, p20) -- Line: 67
                return p20 and (p19.PlayerStats.InAwakening.Value and "The Gate" or "Demonic Overhead Kick") or "";
            end,

            ["3"] = function(p21, p22, p23) -- Line: 78
                return p23 and (p23.Values.HasBall.Value and "Demon Header" or "Bloodlust") or "";
            end
        }
    },
    ["Don Lorenzo"] = {
        Abilities = {
            ["1"] = function(p24, p25, p26) -- Line: 195
                return p26 and (p25.PlayerStats.InAwakening.Value and "Yo Michael" or (p26.Values.HasBall.Value and not p26:GetAttribute("ZombieDash") and "Zombie Dribble" or "Zombie Dash")) or "-";
            end
        }
    },
    Sae = {
        Abilities = {
            ["1"] = function(p27, p28, p29) -- Line: 213
                -- upvalues: ReplicatedStorage (copy)
                if not p29 then
                    return "Perfect Pass";
                end;

                if not p28.PlayerStats.InAwakening.Value or p29.Values.HasBall.Value then
                    return p29.Values.HasBall.Value and "Perfect Pass" or "Off Balance";
                end;

                local Value = ReplicatedStorage.Football.Value;

                return Value and (not Value.OnPlayer.Value and ((p28.Team.Name == "Away" and workspace.PenaltyArea.Home or workspace.PenaltyArea.Away).Position - p29.HumanoidRootPart.Position).Magnitude <= 100) and "Divine Destruction" or "Shoulder Push";
            end,

            ["2"] = function(p30, p31, p32) -- Line: 235
                -- upvalues: AbilityBalancing (copy), AbilityUtils (copy)
                if not p32 then
                    return "Metavision";
                end;

                local CreativeDribble = AbilityBalancing.CreativeDribble;

                return p32:GetAttribute("DivineLift") and "Divine Lift" or (p32:GetAttribute("HeelFlick") and "Heel Flick" or (p31.PlayerStats.InAwakening.Value and (AbilityUtils.checks.enemyTarget(CreativeDribble.ActivationRangePlayer) and "Creative Dribble" or "Divine Lift") or "Magical Turn"));
            end,

            ["3"] = function(p33, p34, p35) -- Line: 261
                return p35 and (p34.PlayerStats.InAwakening.Value and "You\'ll Never Surpass Me." or "Beautiful Shot") or "Beautiful Shot";
            end
        }
    },
    Bachira = {
        Abilities = {
            ["1"] = function(p36, p37, p38) -- Line: 273
                return p38 and (p37.PlayerStats.InAwakening.Value and "Monster Trance" or (p38:GetAttribute("BeeFlick") and "Bee Flick" or "Nutmeg")) or "Nutmeg";
            end,

            ["2"] = function(p39, p40, p41) -- Line: 283
                return p41 and (p40.PlayerStats.InAwakening.Value and (p41:GetAttribute("ScissorShot") and "Scissor Shot" or "Scissor Kicks") or (p41:GetAttribute("BeeFlick") and "Bee Flick" or "Nutmeg")) or "Nutmeg";
            end
        }
    },
    Bunny = {
        Abilities = {
            ["1"] = function(p42, p43, p44) -- Line: 316
                return p44 and (p43.PlayerStats.InAwakening.Value and "Enter Striker" or (p44.Values.HasBall.Value and "Scissor Kick" or "Bunny Hop")) or "Bunny Hop";
            end,

            ["2"] = function(p45, p46, p47) -- Line: 325
                return p47 and (p47:HasTag("CrownHopped") and "Lob Pass" or "Crown Hopper") or "Crown Hopper";
            end,

            ["3"] = function(p48, p49, p50) -- Line: 335
                return p49.PlayerStats.InAwakening.Value and "Hare In The Air" or "Rabbit Trap";
            end
        }
    },
    ["NEL Isagi"] = {
        Abilities = {
            ["1"] = function(p51, p52, p53) -- Line: 347
                return p52.PlayerStats.InAwakening.Value and "Demon King" or "Direct Shot";
            end,

            ["2"] = function(p54, p55, p56) -- Line: 358
                return p56 and (p55.PlayerStats.InAwakening.Value and "Two Gun Volley" or (p56.Values.HasBall.Value and "Direct Pass" or (p56:GetAttribute("Omnivision") and "Blind Spot" or "Omnivision"))) or "Omnivision";
            end,

            ["3"] = function(p57, p58, p59) -- Line: 374
                return p59 and (p59:GetAttribute("RivalsClash") and "RIVALS CLASH!" or (p59.Values.HasBall.Value and "Offensive Dash" or "Defensive Dash")) or "Defensive Dash";
            end
        }
    },
    Hiori = {
        Abilities = {
            ["2"] = function(p60, p61, p62) -- Line: 387
                return p62 and (p62:GetAttribute("IceDribble") and "Pass" or "Ice Dribble") or "Frostbite";
            end
        }
    },
    Kaiser = {
        Abilities = {
            ["2"] = function(p63, p64, p65) -- Line: 399
                return p65 and (p64.PlayerStats.InAwakening.Value and "Magnus" or (p65.Values.HasBall.Value and (p65:GetAttribute("KaiserDribbleShot") and "IMPACT." or "Emperor\'s Dribble") or (p65:GetAttribute("KaiserDribbleTake") and "Subjugation" or "Emperor\'s Route"))) or "Royal Route";
            end,

            ["3"] = function(p66, p67, p68) -- Line: 416
                return p68 and (p67.PlayerStats.InAwakening.Value and (p68.Values.HasBall.Value and (p68:GetAttribute("KaiserDribbleShot") and "IMPACT." or "Emperor\'s Dribble") or (p68:GetAttribute("KaiserDribbleTake") and "Subjugation" or "Royal Route")) or "Kaiser Volley") or "Kaiser Volley";
            end
        }
    },
    Lavinho = {
        Abilities = {
            ["1"] = function(p69, p70, p71) -- Line: 467
                -- upvalues: ReplicatedStorage (copy), CameraController (copy)
                if not p71 then
                    return "Rising Dance";
                end;

                if not p69.AbilityController.legacy.PossessionTime then
                    p69.AbilityController.legacy.PossessionTime = 0;
                    local v72 = ReplicatedStorage.Assets.UI.LavinhoBDTimer:Clone();
                    v72.Parent = p70.PlayerGui.InGameUI.Bottom.Abilities["1"];
                    p69.LavinhoTimer = v72;
                end;

                local LavinhoTimer = p69.LavinhoTimer;

                if p71.Values.HasBall.Value and (p70.PlayerStats.InAwakening.Value and CameraController.Cutscene == false) then
                    local legacy = p69.AbilityController.legacy;
                    local v73 = p69.AbilityController.legacy.PossessionTime + game["Run Service"].Heartbeat:Wait();
                    legacy.PossessionTime = math.min(v73, 10);
                else
                    local legacy = p69.AbilityController.legacy;
                    local v74 = p69.AbilityController.legacy.PossessionTime - game["Run Service"].Heartbeat:Wait();
                    legacy.PossessionTime = math.max(v74, 0);
                end;

                LavinhoTimer.Text = math.round(p69.AbilityController.legacy.PossessionTime);

                if p70.PlayerStats.InAwakening.Value then
                    LavinhoTimer.Visible = true;
                else
                    LavinhoTimer.Visible = false;
                end;

                if p70.PlayerStats.InAwakening.Value == false then
                    p69.ResetCD = nil;
                end;

                if not (p70.PlayerStats.InAwakening.Value and (p69.AbilityController.legacy.PossessionTime and p69.AbilityController.legacy.PossessionTime >= 10)) then
                    return p71:GetAttribute("ButterflyDribble") and "Butterfly Dribble" or "Rising Dance";
                end;

                if not p69.ResetCD then
                    p69.ResetCD = true;
                end;

                return "Butterfly Dance";
            end,

            ["2"] = function(p75, p76, p77) -- Line: 514
                return p77 and (p77:GetAttribute("GingaStyle") == 3 and "Ginga Shot" or "Ginga Style") or "Ginga Style";
            end,

            ["3"] = function(p78, p79, p80) -- Line: 522
                return p80 and (p79.PlayerStats.InAwakening.Value and ((p80.Values.HasBall.Value or p80:GetAttribute("TikiTaka")) and "Tiki Taka" or "Butterfly Intercept") or "Butterfly Counter") or "Butterfly Counter";
            end
        }
    },
    ["NEL Bachira"] = {
        Abilities = {
            ["1"] = function(p81, p82, p83) -- Line: 538
                -- upvalues: Knit (copy)
                if p83 and p83:HasTag("Otoya-NELBachira-CR") then
                    local Controller = Knit.GetController("ChemicalReactionController");

                    if Controller.ChemicalReactions["Otoya-NELBachira-CR"].check() and not Controller.ChemicalReactions["Otoya-NELBachira-CR"].cooldown then
                        return "Smash Pass";
                    end;
                end;

                if p82.PlayerStats.InAwakening.Value then
                    return p83 and (p83.Values.HasBall.Value and "Ginga Dribble" or "Ginga Steal") or "Ginga Steal";
                end;

                if not p83 then
                    return "Monster Steal";
                end;

                if p82.PlayerStats.InAwakening.Value then
                    return "Ginga Dribble";
                end;

                if not p83.Values.HasBall.Value then
                    return "Monster Steal";
                end;

                print(p83:GetAttribute("NELBachiraLift"));

                return p83:GetAttribute("NELBachiraLift") and "Stinger Shot" or "Roulette";
            end,

            ["2"] = function(p84, p85, p86) -- Line: 568
                return p85.PlayerStats.InAwakening.Value and "Ginga Monster" or (p86:GetAttribute("ButterflyLift") and "Butterfly Lift" or "The Butterfly");
            end
        }
    },
    Otoya = {
        Abilities = {
            ["1"] = function(p87, p88, p89) -- Line: 592
                return p88.PlayerStats.InAwakening.Value and "Shadow Steal" or "Stealthy Steps";
            end,

            ["2"] = function(p90, p91, p92) -- Line: 599
                return p91.Character:GetAttribute("OtoyaShot") and "Shadow Shot" or "Ninja Dribble";
            end
        }
    },
    ["NEL Rin"] = {
        Abilities = {
            ["1"] = function(p93, p94, p95) -- Line: 610
                return p94.PlayerStats.InAwakening.Value and "Center Of Gravity" or (p95 and (p95:GetAttribute("DestroyerMode") and "Opposite Direction" or "Destroyer Mode") or "Destroyer Mode");
            end,

            ["2"] = function(p96, p97, p98) -- Line: 622
                return p97.PlayerStats.InAwakening.Value and "Destructive Crash Shot" or (p97.Character.Values.HasBall.Value and "Occlusion Break" or "Destructive Charge");
            end,

            ["3"] = function(p99, p100, p101) -- Line: 632
                return p101:GetAttribute("RivalsClash") and "RIVALS CLASH!" or (p100.PlayerStats.InAwakening.Value and "Die." or "Curve Shot");
            end
        }
    },
    Loki = {
        Abilities = {
            ["1"] = function(p102, p103, p104) -- Line: 644
                return p104 and (p103.PlayerStats.InAwakening.Value and p104:GetAttribute("GodspeedShot") and "GODSPEED SHOT" or "Explosive Acceleration") or "-";
            end,

            ["2"] = function(p105, p106, p107) -- Line: 652
                return p107 and (p106.PlayerStats.InAwakening.Value and "Too Slow, Too Slow" or (p107:GetAttribute("VelocityShot") and "Velocity Shot" or "Velocity Dash")) or "-";
            end,

            ["3"] = function(p108, p109, p110) -- Line: 665
                return p110 and (p110:GetAttribute("LokiBlackFlash") and "GODSPEED FLASH!" or (p109.PlayerStats.InAwakening.Value and "Its Too Slow" or "Swift Intercept")) or "-";
            end
        }
    },
    ["NEL Nagi"] = {
        Abilities = {
            ["1"] = function(p111, p112, p113) -- Line: 682
                -- upvalues: isPointInVolume (copy)
                return p113 and (p113:FindFirstChild("HumanoidRootPart") and (p112.PlayerStats.InAwakening.Value and "Death Dance" or (isPointInVolume(p113.HumanoidRootPart.Position, p112.Team == "Away" and workspace.PenaltyArea.Home.CFrame or workspace.PenaltyArea.Away.CFrame, p112.Team == "Away" and workspace.PenaltyArea.Home.Size or workspace.PenaltyArea.Away.Size) and (p113:GetAttribute("Trapped") and p113.Values.HasBall.Value) and "Side Trap Shot" or (p113:GetAttribute("Trapped") and p113.Values.HasBall.Value and "Trap Shot" or "Trap"))) or "-") or "-";
            end,

            ["2"] = function(p114, p115, p116) -- Line: 700
                return p116 and (p115.PlayerStats.InAwakening.Value and (p116.Values.HasBall.Value and "Five Stage Volley" or "Two Stage Volley") or "Zero Reset Turn") or "-";
            end,

            ["3"] = function(p117, p118, p119) -- Line: 715
                return p119 and (p118.PlayerStats.InAwakening.Value and (p119.Values.HasBall.Value and "Tap Lift" or "Space Shot") or (p119:GetAttribute("JuggleFeint") and "Juggle Feint" or "Juggling Shot")) or "-";
            end
        }
    },
    ["McNagi Fryshiro"] = {
        Abilities = {
            ["1"] = function(p120, p121, p122) -- Line: 737
                -- upvalues: isPointInVolume (copy)
                return p122 and (p122:FindFirstChild("HumanoidRootPart") and (p121.PlayerStats.InAwakening.Value and "Death Dance" or (isPointInVolume(p122.HumanoidRootPart.Position, p121.Team == "Away" and workspace.PenaltyArea.Home.CFrame or workspace.PenaltyArea.Away.CFrame, p121.Team == "Away" and workspace.PenaltyArea.Home.Size or workspace.PenaltyArea.Away.Size) and (p122:GetAttribute("Trapped") and p122.Values.HasBall.Value) and "Side Trap Shot" or (p122:GetAttribute("Trapped") and p122.Values.HasBall.Value and "Trap Shot" or "Trap"))) or "-") or "-";
            end,

            ["2"] = function(p123, p124, p125) -- Line: 755
                return p125 and (p124.PlayerStats.InAwakening.Value and (p125.Values.HasBall.Value and "Five Stage Volley" or "Two Stage Volley") or "Zero Reset Turn") or "-";
            end,

            ["3"] = function(p126, p127, p128) -- Line: 769
                return p128 and (p127.PlayerStats.InAwakening.Value and (p128.Values.HasBall.Value and "Tap Lift" or "Space Shot") or (p128:GetAttribute("JuggleFeint") and "Juggle Feint" or "Juggling Shot")) or "-";
            end
        }
    },
    Shidou = {
        Abilities = {
            ["1"] = function(p129, p130, p131) -- Line: 792
                return p131 and (p131:FindFirstChild("HumanoidRootPart") and "KABLAMO!!" or "-") or "-";
            end,

            ["2"] = function(p132, p133, p134) -- Line: 803
                return p134 and (p134.Values.HasBall.Value and "Dragon Header" or "Demon Drive") or "-";
            end
        }
    },
    Charles = {
        Abilities = {
            ["2"] = function(p135, p136, p137) -- Line: 817
                return p137 and (p136.PlayerStats.InAwakening.Value and "The Final Boss" or (p137:GetAttribute("ContrarianPass") and "Contrarian Pass" or "Contrarian Dribble")) or "Contrarian Dribble";
            end,

            ["3"] = function(p138, p139, p140) -- Line: 830
                return p140 and (p140:FindFirstChild("Values") and p140.Values.HasBall.Value and "Dartboard Lens" or "Contrarian Defense") or "Contrarian Defense";
            end
        }
    },
    ["Blood Moon Rin"] = {
        Abilities = {
            ["2"] = function(p141, p142, p143) -- Line: 843
                return p143 and (p143.Values.HasBall.Value and "Crow Elusion" or "Lunar Axis") or "-";
            end
        }
    },
    ["Phantom Isagi"] = {
        Abilities = {
            ["2"] = function(p144, p145, p146) -- Line: 857
                return p146 and (p146.Values.HasBall.Value and "Phantom Dribble" or "Phantom Step") or "Phantom Dribble";
            end
        }
    },
    ["Skeleton Nagi"] = {
        Abilities = {
            ["1"] = function(p147, p148, p149) -- Line: 871
                return p149 and (p148.PlayerStats.InAwakening.Value and "Skeleton Imprisonment" or (p149:GetAttribute("SkeletonTrap") and "Skull Shot" or "Skeleton Trap")) or "Skeleton Trap";
            end
        }
    }
};