 

 

game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local u1 = {
    ["Kaiser\'s Ego"] = {
        beinschuss = false,
        superstar = false,
        stealball = false,
        lightning = false,
        counter = {
            max = 5
        },
        offball = {
            max = 10
        }
    },
    ["Rin\'s Hatred"] = {
        killgrab = false,
        crashout = false,
        killgoal = false,
        centerofgravity = false,
        fakecounter = {
            max = 7
        },
        curvegoal = {
            max = 7
        }
    },
    ["Isagi\'s Rebirth"] = {
        mydirectgoal = false,
        passit = false,
        moveit = false,
        luckygoal = false,
        directgoal = {
            max = 10
        }
    },
    ["Kunigami\'s Biggest Fan"] = {
        evenforyou = false,
        demonscontract = false,
        heroinstinct = false,
        justiceheader = false,
        heroicclash = {
            max = 10
        },
        leftyshot = {
            max = 5
        }
    },
    ["Aiku\'s Path To Blooming"] = {
        ultimatedefense = false,
        formerstriker = false,
        reflextackle = {
            max = 10
        },
        venomtrap = {
            max = 5
        }
    },
    ["The King\'s Reign"] = {
        stealthshot = false,
        devourautogoal = false,
        chopdribble = {
            max = 5
        },
        longshot = {
            max = 5
        },
        kingspath = {
            max = 10
        },
        predatorseye = {
            max = 5
        }
    },
    ["Don Lorenzo\'s Greed"] = {
        yomichael = false,
        aceeater = false,
        zombiedribble = {
            max = 4
        },
        defensivestance = {
            max = 7
        },
        horrificintercept = {
            max = 5
        },
        undeadcrash = {
            max = 5
        }
    },
    ["british aiku quest 1"] = {
        britishaiku4 = false,
        britishaiku1 = {
            max = 5
        },
        britishaiku2 = {
            max = 5
        },
        britishaiku3 = {
            max = 10
        }
    },
    ["british aiku quest 2"] = {
        britishaiku8 = false,
        britishaiku5 = {
            max = 10
        },
        britishaiku6 = {
            max = 5
        },
        britishaiku7 = {
            max = 4
        }
    },
    ["evil naruhaya footwork quest"] = {
        naruhayafootwork = {
            max = 10000
        }
    },
    ["Isagi\'s Rebirth Encore"] = {
        twogunvolleyhiori = false,
        directshothiori = {
            max = 10
        },
        mydirectshothiori = {
            max = 5
        },
        moveithiori = {
            max = 5
        }
    },
    ["Kurona\'s Passing"] = {
        autogoal = false,
        guarddog = {
            max = 10
        },
        flows = {
            max = 5
        }
    },
    ["NEL Isagi\'s Adaption"] = {
        leftyshotnel = false,
        rebirth = false,
        neodirectshot = {
            max = 10
        },
        metaburststeal = {
            max = 5
        },
        metabursttrap = {
            max = 5
        }
    },
    Partners = {
        partnersKuronaPasses = {
            max = 10
        },
        partnersSaePasses = {
            max = 10
        },
        partnersLorenzoPasses = {
            max = 10
        },
        partnersHioriPasses = {
            max = 10
        }
    },
    ["Unstoppable Ego"] = {
        egoIsagi = {
            max = 5
        },
        egoNagi = {
            max = 5
        },
        egoBachira = {
            max = 5
        },
        egoRin = {
            max = 5
        }
    },
    Killers = {
        killersIsagiTGV = {
            max = 5
        },
        killersRinVIP = {
            max = 5
        },
        killersRinKill = {
            max = 5
        },
        killersKunigamiInstinct = {
            max = 5
        }
    },
    Defenders = {
        defenseAikuSteal = {
            max = 10
        },
        defenseAikuUltimate = {
            max = 5
        },
        defenseReoSerpent = {
            max = 5
        },
        defenseNelDirect = {
            max = 5
        }
    }
};
local u2 = {
    luckygoal = "End the match with a goal made fabricated from LUCK.",
    moveit = "Chigiri, get the ball!",
    passit = "Give me, The Ball.",
    mydirectgoal = "My own direct shot!",
    directgoal = "Direct Shoot",
    killgrab = "Stop leashing my potential..!",
    centerofgravity = "Know your place, Old Man.",
    killgoal = "Kill.. Kill.. Kill!",
    crashout = "Half-baked, Isagi..?!",
    curvegoal = "Perfect Curve Shot",
    fakecounter = "Perfect Curve Shot..?",
    beinschuss = "Eat it, Losers!",
    superstar = "What are you...? A superstar?!",
    lightning = "The fastest shot.",
    stealball = "Ex-freaking-cuse me.",
    counter = "Dribble past",
    offball = "Off-the-Ball Movement",
    heroicclash = "Successfully stop 10 players with Heroic Clash",
    leftyshot = "Score 5 goals with Lefty Shot",
    evenforyou = "Steal from someone whose actions were too forced",
    demonscontract = "Show the world what you would do if you were a superhero",
    heroinstinct = "Steal the ball using Hero\'s Instinct",
    justiceheader = "Use Justice Header to knock away the ball",
    reflextackle = "You won\'t be stealing any goals, lil\' burglar.",
    venomtrap = "Nice shot.",
    ultimatedefense = "The Final Wall.",
    formerstriker = "Unfortunately for you, I happen to be a former striker.",
    chopdribble = "This route is the only path that exists for my goal!",
    longshot = "I\'ll devour everything in this match!",
    stealthshot = "On the field, I am the king.",
    kingspath = "I need more to devour...",
    devourautogoal = "Your light.. IS MINE!",
    predatorseye = "Can\'t you see? I\'m Isagi-hunting.",
    zombiedribble = "What are you, some kind of zombie?!!",
    undeadcrash = "Feeding time, OK?",
    defensivestance = "Hi-ya.",
    horrificintercept = "It\'s mine now!",
    yomichael = "Yo, Michael.",
    aceeater = "47 Million.",
    britishaiku1 = "Forced Beauty",
    britishaiku2 = "Counter Dribbling",
    britishaiku3 = "He doesn\'t have the angle...!",
    britishaiku4 = "You\'ve got a good nose. Selfish Captain.",
    britishaiku5 = "I\'M HERE!",
    britishaiku6 = "NOBODY STOPS THE OLIVER TRAIN!",
    britishaiku7 = "NOT SO FAST, THIS JUST GOT INTERCEPTED BY OLIVER AIKU",
    britishaiku8 = "WATCH OUT MATE, THIS IS MY DIRECTTT SHOOOOOOOOOT!",
    directshothiori = "Direct Shoot",
    mydirectshothiori = "My own direct shot!",
    twogunvolleyhiori = "All my senses!!",
    moveithiori = "MOVE IT",
    guarddog = "Chomp Chomp",
    flows = "Orbiting Body",
    autogoal = "Let\'s go. Smash it!",
    neodirectshot = "Meta Vision... Direct Shot...",
    metaburststeal = "Nice Work, New King",
    metabursttrap = "It\'s Here, Isn\'t It?",
    leftyshotnel = "Think again...",
    rebirth = "This Is The Rebirth... of Yoichi Isagi!",
    naruhayafootwork = "have fun :D",
    partnersKuronaPasses = "Catch, chomp chomp.",
    partnersSaePasses = "Worthy Of My Passes",
    partnersLorenzoPasses = "How Selfish.",
    partnersHioriPasses = "Discarded Strikers",
    egoIsagi = "my directo shoota 🦵🔥",
    egoNagi = "U-20 Spotlight",
    egoBachira = "My ego...",
    egoRin = "Here\'s your VIP seat...",
    killersIsagiTGV = "Dual Pistols",
    killersRinVIP = "Jersey Grabbing",
    killersRinKill = "Die.",
    killersKunigamiInstinct = "Heroic Kick Away",
    defenseAikuSteal = "Reflexive Steal",
    defenseAikuUltimate = "I\'m So British",
    defenseReoSerpent = "Copied Serpent Savior",
    defenseNelDirect = "NEL Defensive Volley"
};
local u3 = {
    kaiser = "Kaiser\'s Ego",
    rin = "Rin\'s Hatred",
    isagi = "Isagi\'s Rebirth",
    kunigami = "Kunigami\'s Biggest Fan",
    donlorenzo = "Don Lorenzo\'s Greed",
    aiku = "Aiku\'s Path To Blooming",
    barou = "The King\'s Reign",
    nelisagi = "NEL Isagi\'s Adaption"
};
local v4 = {
    Quests = u1,
    Conversions = u3
};

local function DeepCopyTable(p5) -- Line: 237
    -- upvalues: DeepCopyTable (copy)
    local v6 = {};

    for i, v in pairs(p5) do
        if type(v) == "table" then
            v6[i] = DeepCopyTable(v);
        else
            v6[i] = v;
        end;
    end;

    return v6;
end;

local function ReconcileTable(p7, p8) -- Line: 249
    -- upvalues: DeepCopyTable (copy), ReconcileTable (copy)
    for i, v in pairs(p8) do
        if type(i) == "string" then
            if p7[i] == nil then
                if type(v) == "table" then
                    p7[i] = DeepCopyTable(v);
                else
                    p7[i] = v;
                end;
            elseif type(p7[i]) == "table" and type(v) == "table" then
                ReconcileTable(p7[i], v);
            end;
        end;
    end;
end;

function v4.Convert(p9: string?) -- Line: 265
    -- upvalues: u3 (copy)
    return u3[p9];
end;

function v4.CreateNew(p10) -- Line: 269
    -- upvalues: u1 (copy)
    local v11 = u1[p10];

    if v11 then
        local v12 = {
            zCreatedManually23567 = true
        };

        for i, v in v11 do
            if typeof(v) == "table" and v.max then
                v12[i] = 0;
            else
                v12[i] = false;
            end;
        end;

        return v12;
    end;
end;

function v4.ReturnString(p13) -- Line: 289
    -- upvalues: u2 (copy)
    return u2[p13] or p13;
end;

function v4.VerifySingle(p14, p15, p16) -- Line: 293
    -- upvalues: u1 (copy)
    local v17 = u1[p15];

    if v17 then
        if typeof(v17[p14]) == "table" then
            return v17[p14].max <= p16;
        end;

        return p16 ~= v17[p14];
    end;
end;

function v4.Verify(p18, p19) -- Line: 310
    -- upvalues: u1 (copy)
    local v20 = u1[p18];

    if v20 then
        local v21 = true;

        for i, v in v20 do
            if typeof(v) == "table" and typeof(v.max) == "number" then
                if typeof(p19[i]) == "number" and p19[i] >= v.max then
                    p19[i] = v.max;
                else
                    v21 = false;
                end;
            elseif v == p19[i] then
                v21 = false;
            end;
        end;

        return v21;
    end;
end;

return v4;