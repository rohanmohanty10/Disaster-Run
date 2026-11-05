  

 

local function BossProgressCheck(u1) -- Line: 1
    return function(p2, p3) -- Line: 2
        -- upvalues: u1 (copy)
        local v4 = 0;

        if p2[u1] then
            for _, v in pairs(p2[u1]) do
                v4 = v4 + v;
            end;
        end;

        return v4;
    end;
end;

local v5 = {};
local v6 = {
    Name = "Keeping The Peace",
    Description = "Defeat <Amount> Thugs",
    Category = "Progression",
    Type = "Achievement",
    Requirements = {}
};
local u7 = "Thugs";

function v6.ProgressCallback(p8, p9) -- Line: 2
    -- upvalues: u7 (copy)
    local v10 = 0;

    if p8[u7] then
        for _, v in pairs(p8[u7]) do
            v10 = v10 + v;
        end;
    end;

    return v10;
end;

v5.ACHIEVEMENT_10000 = v6;
local v11 = {
    Name = "Vigilante",
    Description = "Defeat <Amount> Thugs",
    Category = "Progression",
    Type = "Achievement",
    Requirements = {}
};
local u12 = "Thugs";

function v11.ProgressCallback(p13, p14) -- Line: 2
    -- upvalues: u12 (copy)
    local v15 = 0;

    if p13[u12] then
        for _, v in pairs(p13[u12]) do
            v15 = v15 + v;
        end;
    end;

    return v15;
end;

v5.ACHIEVEMENT_10001 = v11;
local v16 = {
    Name = "Bandit Beater",
    Description = "Defeat <Amount> Thugs",
    Category = "Progression",
    Type = "Achievement",
    Requirements = {}
};
local u17 = "Thugs";

function v16.ProgressCallback(p18, p19) -- Line: 2
    -- upvalues: u17 (copy)
    local v20 = 0;

    if p18[u17] then
        for _, v in pairs(p18[u17]) do
            v20 = v20 + v;
        end;
    end;

    return v20;
end;

v5.ACHIEVEMENT_10002 = v16;
local v21 = {
    Name = "Bandit Destroyer",
    Description = "Defeat <Amount> Thugs",
    Category = "Progression",
    Type = "Achievement",
    Rarity = 2,
    Requirements = {}
};
local u22 = "Thugs";

function v21.ProgressCallback(p23, p24) -- Line: 2
    -- upvalues: u22 (copy)
    local v25 = 0;

    if p23[u22] then
        for _, v in pairs(p23[u22]) do
            v25 = v25 + v;
        end;
    end;

    return v25;
end;

v5.ACHIEVEMENT_10003 = v21;
local v26 = {
    Name = "Raider I",
    Description = "Defeat <Amount> Hooligans",
    Category = "Progression",
    Type = "Achievement",
    Requirements = {}
};
local u27 = "Hooligans";

function v26.ProgressCallback(p28, p29) -- Line: 2
    -- upvalues: u27 (copy)
    local v30 = 0;

    if p28[u27] then
        for _, v in pairs(p28[u27]) do
            v30 = v30 + v;
        end;
    end;

    return v30;
end;

v5.ACHIEVEMENT_10004 = v26;
local v31 = {
    Name = "Raider II",
    Description = "Defeat <Amount> Hooligans",
    Category = "Progression",
    Type = "Achievement",
    Requirements = {}
};
local u32 = "Hooligans";

function v31.ProgressCallback(p33, p34) -- Line: 2
    -- upvalues: u32 (copy)
    local v35 = 0;

    if p33[u32] then
        for _, v in pairs(p33[u32]) do
            v35 = v35 + v;
        end;
    end;

    return v35;
end;

v5.ACHIEVEMENT_10005 = v31;
local v36 = {
    Name = "Raider III",
    Description = "Defeat <Amount> Hooligans",
    Category = "Progression",
    Type = "Achievement",
    Requirements = {}
};
local u37 = "Hooligans";

function v36.ProgressCallback(p38, p39) -- Line: 2
    -- upvalues: u37 (copy)
    local v40 = 0;

    if p38[u37] then
        for _, v in pairs(p38[u37]) do
            v40 = v40 + v;
        end;
    end;

    return v40;
end;

v5.ACHIEVEMENT_10006 = v36;
local v41 = {
    Name = "Raider IV",
    Description = "Defeat <Amount> Hooligans",
    Category = "Progression",
    Type = "Achievement",
    Rarity = 2,
    Requirements = {}
};
local u42 = "Hooligans";

function v41.ProgressCallback(p43, p44) -- Line: 2
    -- upvalues: u42 (copy)
    local v45 = 0;

    if p43[u42] then
        for _, v in pairs(p43[u42]) do
            v45 = v45 + v;
        end;
    end;

    return v45;
end;

v5.ACHIEVEMENT_10007 = v41;
local v46 = {
    Name = "Stardust Crusader I",
    Description = "Defeat <Amount> Stand Users",
    Category = "Progression",
    Type = "Achievement",
    Requirements = {}
};
local u47 = "Stand Users";

function v46.ProgressCallback(p48, p49) -- Line: 2
    -- upvalues: u47 (copy)
    local v50 = 0;

    if p48[u47] then
        for _, v in pairs(p48[u47]) do
            v50 = v50 + v;
        end;
    end;

    return v50;
end;

v5.ACHIEVEMENT_10008 = v46;
local v51 = {
    Name = "Stardust Crusader II",
    Description = "Defeat <Amount> Stand Users",
    Category = "Progression",
    Type = "Achievement",
    Requirements = {}
};
local u52 = "Stand Users";

function v51.ProgressCallback(p53, p54) -- Line: 2
    -- upvalues: u52 (copy)
    local v55 = 0;

    if p53[u52] then
        for _, v in pairs(p53[u52]) do
            v55 = v55 + v;
        end;
    end;

    return v55;
end;

v5.ACHIEVEMENT_10009 = v51;
local v56 = {
    Name = "Stardust Crusader III",
    Description = "Defeat <Amount> Stand Users",
    Category = "Progression",
    Type = "Achievement",
    Requirements = {}
};
local u57 = "Stand Users";

function v56.ProgressCallback(p58, p59) -- Line: 2
    -- upvalues: u57 (copy)
    local v60 = 0;

    if p58[u57] then
        for _, v in pairs(p58[u57]) do
            v60 = v60 + v;
        end;
    end;

    return v60;
end;

v5.ACHIEVEMENT_10010 = v56;
local v61 = {
    Name = "Stardust Crusader IV",
    Description = "Defeat <Amount> Stand Users",
    Category = "Progression",
    Type = "Achievement",
    Rarity = 2,
    Requirements = {}
};
local u62 = "Stand Users";

function v61.ProgressCallback(p63, p64) -- Line: 2
    -- upvalues: u62 (copy)
    local v65 = 0;

    if p63[u62] then
        for _, v in pairs(p63[u62]) do
            v65 = v65 + v;
        end;
    end;

    return v65;
end;

v5.ACHIEVEMENT_10011 = v61;
local v66 = {
    Name = "Jusoshi I",
    Description = "Defeat <Amount> Jujutsu Sorcerers",
    Category = "Progression",
    Type = "Achievement",
    Requirements = {}
};
local u67 = "Jujutsu Sorcerers";

function v66.ProgressCallback(p68, p69) -- Line: 2
    -- upvalues: u67 (copy)
    local v70 = 0;

    if p68[u67] then
        for _, v in pairs(p68[u67]) do
            v70 = v70 + v;
        end;
    end;

    return v70;
end;

v5.ACHIEVEMENT_10012 = v66;
local v71 = {
    Name = "Jusoshi II",
    Description = "Defeat <Amount> Jujutsu Sorcerers",
    Category = "Progression",
    Type = "Achievement",
    Requirements = {}
};
local u72 = "Jujutsu Sorcerers";

function v71.ProgressCallback(p73, p74) -- Line: 2
    -- upvalues: u72 (copy)
    local v75 = 0;

    if p73[u72] then
        for _, v in pairs(p73[u72]) do
            v75 = v75 + v;
        end;
    end;

    return v75;
end;

v5.ACHIEVEMENT_10013 = v71;
local v76 = {
    Name = "Jusoshi III",
    Description = "Defeat <Amount> Jujutsu Sorcerers",
    Category = "Progression",
    Type = "Achievement",
    Requirements = {}
};
local u77 = "Jujutsu Sorcerers";

function v76.ProgressCallback(p78, p79) -- Line: 2
    -- upvalues: u77 (copy)
    local v80 = 0;

    if p78[u77] then
        for _, v in pairs(p78[u77]) do
            v80 = v80 + v;
        end;
    end;

    return v80;
end;

v5.ACHIEVEMENT_10014 = v76;
local v81 = {
    Name = "Jusoshi IV",
    Description = "Defeat <Amount> Jujutsu Sorcerers",
    Category = "Progression",
    Type = "Achievement",
    Rarity = 2,
    Requirements = {}
};
local u82 = "Jujutsu Sorcerers";

function v81.ProgressCallback(p83, p84) -- Line: 2
    -- upvalues: u82 (copy)
    local v85 = 0;

    if p83[u82] then
        for _, v in pairs(p83[u82]) do
            v85 = v85 + v;
        end;
    end;

    return v85;
end;

v5.ACHIEVEMENT_10015 = v81;
local v86 = {
    Name = "Jujutsushi I",
    Description = "Defeat <Amount> Curses",
    Category = "Progression",
    Type = "Achievement",
    Requirements = {}
};
local u87 = "Curses";

function v86.ProgressCallback(p88, p89) -- Line: 2
    -- upvalues: u87 (copy)
    local v90 = 0;

    if p88[u87] then
        for _, v in pairs(p88[u87]) do
            v90 = v90 + v;
        end;
    end;

    return v90;
end;

v5.ACHIEVEMENT_10016 = v86;
local v91 = {
    Name = "Jujutsushi II",
    Description = "Defeat <Amount> Curses",
    Category = "Progression",
    Type = "Achievement",
    Requirements = {}
};
local u92 = "Curses";

function v91.ProgressCallback(p93, p94) -- Line: 2
    -- upvalues: u92 (copy)
    local v95 = 0;

    if p93[u92] then
        for _, v in pairs(p93[u92]) do
            v95 = v95 + v;
        end;
    end;

    return v95;
end;

v5.ACHIEVEMENT_10017 = v91;
local v96 = {
    Name = "Jujutsushi III",
    Description = "Defeat <Amount> Curses",
    Category = "Progression",
    Type = "Achievement",
    Requirements = {}
};
local u97 = "Curses";

function v96.ProgressCallback(p98, p99) -- Line: 2
    -- upvalues: u97 (copy)
    local v100 = 0;

    if p98[u97] then
        for _, v in pairs(p98[u97]) do
            v100 = v100 + v;
        end;
    end;

    return v100;
end;

v5.ACHIEVEMENT_10018 = v96;
local v101 = {
    Name = "Jujutsushi IV",
    Description = "Defeat <Amount> Curses",
    Category = "Progression",
    Type = "Achievement",
    Rarity = 2,
    Requirements = {}
};
local u102 = "Curses";

function v101.ProgressCallback(p103, p104) -- Line: 2
    -- upvalues: u102 (copy)
    local v105 = 0;

    if p103[u102] then
        for _, v in pairs(p103[u102]) do
            v105 = v105 + v;
        end;
    end;

    return v105;
end;

v5.ACHIEVEMENT_10019 = v101;
local v106 = {
    Name = "Intruder I",
    Description = "Defeat <Amount> Guardians",
    Category = "Progression",
    Type = "Achievement",
    Requirements = {}
};
local u107 = "Guardians";

function v106.ProgressCallback(p108, p109) -- Line: 2
    -- upvalues: u107 (copy)
    local v110 = 0;

    if p108[u107] then
        for _, v in pairs(p108[u107]) do
            v110 = v110 + v;
        end;
    end;

    return v110;
end;

v5.ACHIEVEMENT_10020 = v106;
local v111 = {
    Name = "Intruder II",
    Description = "Defeat <Amount> Guardians",
    Category = "Progression",
    Type = "Achievement",
    Requirements = {}
};
local u112 = "Guardians";

function v111.ProgressCallback(p113, p114) -- Line: 2
    -- upvalues: u112 (copy)
    local v115 = 0;

    if p113[u112] then
        for _, v in pairs(p113[u112]) do
            v115 = v115 + v;
        end;
    end;

    return v115;
end;

v5.ACHIEVEMENT_10021 = v111;
local v116 = {
    Name = "Intruder III",
    Description = "Defeat <Amount> Guardians",
    Category = "Progression",
    Type = "Achievement",
    Requirements = {}
};
local u117 = "Guardians";

function v116.ProgressCallback(p118, p119) -- Line: 2
    -- upvalues: u117 (copy)
    local v120 = 0;

    if p118[u117] then
        for _, v in pairs(p118[u117]) do
            v120 = v120 + v;
        end;
    end;

    return v120;
end;

v5.ACHIEVEMENT_10022 = v116;
local v121 = {
    Name = "Intruder IV",
    Description = "Defeat <Amount> Guardians",
    Category = "Progression",
    Type = "Achievement",
    Rarity = 2,
    Requirements = {}
};
local u122 = "Guardians";

function v121.ProgressCallback(p123, p124) -- Line: 2
    -- upvalues: u122 (copy)
    local v125 = 0;

    if p123[u122] then
        for _, v in pairs(p123[u122]) do
            v125 = v125 + v;
        end;
    end;

    return v125;
end;

v5.ACHIEVEMENT_10023 = v121;
local v126 = {
    Name = "Capo Dei Capi",
    Description = "Slay \'The Boss\' with a contract from Hecate.",
    Category = "Progression",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u127 = "BurSlayed";

function v126.ProgressCallback(p128, p129) -- Line: 2
    -- upvalues: u127 (copy)
    local v130 = 0;

    if p128[u127] then
        for _, v in pairs(p128[u127]) do
            v130 = v130 + v;
        end;
    end;

    return v130;
end;

v5.ACHIEVEMENT_11000 = v126;
local v131 = {
    Name = "Übermensch",
    Description = "Slay \'The Oni\' with a contract from Hecate.",
    Category = "Progression",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u132 = "OniSlayed";

function v131.ProgressCallback(p133, p134) -- Line: 2
    -- upvalues: u132 (copy)
    local v135 = 0;

    if p133[u132] then
        for _, v in pairs(p133[u132]) do
            v135 = v135 + v;
        end;
    end;

    return v135;
end;

v5.ACHIEVEMENT_11001 = v131;
local v136 = {
    Name = "Special Grade Slayer",
    Description = "Slay \'The Bearer\' with a contract from Hecate.",
    Category = "Progression",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u137 = "BearerSlayed";

function v136.ProgressCallback(p138, p139) -- Line: 2
    -- upvalues: u137 (copy)
    local v140 = 0;

    if p138[u137] then
        for _, v in pairs(p138[u137]) do
            v140 = v140 + v;
        end;
    end;

    return v140;
end;

v5.ACHIEVEMENT_11002 = v136;
local v141 = {
    Name = "Nah, I\'d win.",
    Description = "Slay \'The Honored One\' with a contract from Hecate.",
    Category = "Progression",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u142 = "FraudSlayed";

function v141.ProgressCallback(p143, p144) -- Line: 2
    -- upvalues: u142 (copy)
    local v145 = 0;

    if p143[u142] then
        for _, v in pairs(p143[u142]) do
            v145 = v145 + v;
        end;
    end;

    return v145;
end;

v5.ACHIEVEMENT_11003 = v141;
local v146 = {
    Name = "...",
    Description = "Slay \'The Knight\' with a contract from Hecate.",
    Category = "Progression",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u147 = "KnightSlayed";

function v146.ProgressCallback(p148, p149) -- Line: 2
    -- upvalues: u147 (copy)
    local v150 = 0;

    if p148[u147] then
        for _, v in pairs(p148[u147]) do
            v150 = v150 + v;
        end;
    end;

    return v150;
end;

v5.ACHIEVEMENT_11005 = v146;
local v151 = {
    Name = "I am the superior one.",
    Description = "Slay \'Previous Star\' after talking with Mingo",
    Category = "Progression",
    Type = "Achievement",
    Rarity = 7,
    Requirements = {}
};
local u152 = "PreviousStar";

function v151.ProgressCallback(p153, p154) -- Line: 2
    -- upvalues: u152 (copy)
    local v155 = 0;

    if p153[u152] then
        for _, v in pairs(p153[u152]) do
            v155 = v155 + v;
        end;
    end;

    return v155;
end;

v5.ACHIEVEMENT_11006 = v151;
local v156 = {
    Name = "...",
    Description = "Slay \'Dio Brando\' with a contract from Hecate.",
    Category = "Progression",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u157 = "DioSlayed";

function v156.ProgressCallback(p158, p159) -- Line: 2
    -- upvalues: u157 (copy)
    local v160 = 0;

    if p158[u157] then
        for _, v in pairs(p158[u157]) do
            v160 = v160 + v;
        end;
    end;

    return v160;
end;

v5.ACHIEVEMENT_11007 = v156;
local v161 = {
    Name = "...",
    Description = "Slay \'Luffy\' with a contract from Hecate.",
    Category = "Progression",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u162 = "LuffySlayed";

function v161.ProgressCallback(p163, p164) -- Line: 2
    -- upvalues: u162 (copy)
    local v165 = 0;

    if p163[u162] then
        for _, v in pairs(p163[u162]) do
            v165 = v165 + v;
        end;
    end;

    return v165;
end;

v5.ACHIEVEMENT_11008 = v161;

return v5;