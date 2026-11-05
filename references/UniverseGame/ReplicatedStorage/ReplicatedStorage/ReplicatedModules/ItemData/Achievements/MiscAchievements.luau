  

 

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

local function SkinRollCheck(u5) -- Line: 15
    return function(p6, p7) -- Line: 16
        -- upvalues: u5 (copy)
        local v8 = 0;

        if p6.RollSkins then
            for i, v in pairs(p6.RollSkins) do
                if u5 == nil or u5 == i then
                    v8 = v8 + v;
                end;
            end;
        end;

        return v8;
    end;
end;

local function MoveProgressCheck(u9, u10) -- Line: 33
    return function(p11, p12) -- Line: 34
        -- upvalues: u9 (copy), u10 (copy)
        local v13 = 0;

        if p11.UsedMoves then
            for i, v in p11.UsedMoves do
                if u9 == nil or i == u9 then
                    for i2, v2 in v do
                        if u10 == nil or i2 == u10 then
                            v13 = v13 + v2;
                        end;
                    end;
                end;
            end;
        end;

        return v13;
    end;
end;

local function EatFruitProgressCheck(u14) -- Line: 57
    return function(p15, p16) -- Line: 58
        -- upvalues: u14 (copy)
        local v17 = 0;

        if p15.EatenFruits then
            for i, v in p15.EatenFruits do
                if u14 == nil or u14 == i then
                    v17 = v17 + v;
                end;
            end;
        end;

        return v17;
    end;
end;

local function MountProgressCheck(u18) -- Line: 75
    return function(p19, p20) -- Line: 76
        -- upvalues: u18 (copy)
        local v21 = 0;

        if p19.MountTime then
            for i, v in p19.MountTime do
                if u18 == nil or i == u18 then
                    v21 = v21 + v;
                end;
            end;
        end;

        return v21;
    end;
end;

local function MiscCheck(u22) -- Line: 93
    return function(p23, p24) -- Line: 94
        -- upvalues: u22 (copy)
        local v25 = 0;

        if p23.Misc and p23.Misc[u22] then
            v25 = v25 + p23.Misc[u22];
        end;

        return v25;
    end;
end;

local v26 = {};
local v27 = {
    Name = "Random Killer",
    Description = "Defeat <Amount> Players",
    Category = "Miscellaneous",
    Type = "Achievement",
    Requirements = {}
};
local u28 = "Players";

function v27.ProgressCallback(p29, p30) -- Line: 2
    -- upvalues: u28 (copy)
    local v31 = 0;

    if p29[u28] then
        for _, v in pairs(p29[u28]) do
            v31 = v31 + v;
        end;
    end;

    return v31;
end;

v26.ACHIEVEMENT_20000 = v27;
local v32 = {
    Name = "RDM RDM RDM",
    Description = "Defeat <Amount> Players",
    Category = "Miscellaneous",
    Type = "Achievement",
    Requirements = {}
};
local u33 = "Players";

function v32.ProgressCallback(p34, p35) -- Line: 2
    -- upvalues: u33 (copy)
    local v36 = 0;

    if p34[u33] then
        for _, v in pairs(p34[u33]) do
            v36 = v36 + v;
        end;
    end;

    return v36;
end;

v26.ACHIEVEMENT_20001 = v32;
local v37 = {
    Name = "Villain",
    Description = "Defeat <Amount> Players",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 2,
    Requirements = {}
};
local u38 = "Players";

function v37.ProgressCallback(p39, p40) -- Line: 2
    -- upvalues: u38 (copy)
    local v41 = 0;

    if p39[u38] then
        for _, v in pairs(p39[u38]) do
            v41 = v41 + v;
        end;
    end;

    return v41;
end;

v26.ACHIEVEMENT_20002 = v37;
local v42 = {
    Name = "Supervillain",
    Description = "Defeat <Amount> Players",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u43 = "Players";

function v42.ProgressCallback(p44, p45) -- Line: 2
    -- upvalues: u43 (copy)
    local v46 = 0;

    if p44[u43] then
        for _, v in pairs(p44[u43]) do
            v46 = v46 + v;
        end;
    end;

    return v46;
end;

v26.ACHIEVEMENT_20003 = v42;
local v47 = {
    Name = "Public Enemy #1",
    Description = "Defeat <Amount> Players",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u48 = "Players";

function v47.ProgressCallback(p49, p50) -- Line: 2
    -- upvalues: u48 (copy)
    local v51 = 0;

    if p49[u48] then
        for _, v in pairs(p49[u48]) do
            v51 = v51 + v;
        end;
    end;

    return v51;
end;

v26.ACHIEVEMENT_20004 = v47;
local v52 = {
    Name = "Tyrant",
    Description = "Defeat <Amount> Players",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u53 = "Players";

function v52.ProgressCallback(p54, p55) -- Line: 2
    -- upvalues: u53 (copy)
    local v56 = 0;

    if p54[u53] then
        for _, v in pairs(p54[u53]) do
            v56 = v56 + v;
        end;
    end;

    return v56;
end;

v26.ACHIEVEMENT_20005 = v52;
local v57 = {
    Name = "Ruler",
    Description = "Defeat <Amount> Players",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 7,
    Requirements = {}
};
local u58 = "Players";

function v57.ProgressCallback(p59, p60) -- Line: 2
    -- upvalues: u58 (copy)
    local v61 = 0;

    if p59[u58] then
        for _, v in pairs(p59[u58]) do
            v61 = v61 + v;
        end;
    end;

    return v61;
end;

v26.ACHIEVEMENT_20006 = v57;
local v62 = {
    Name = "Maybe this ability isn\'t good",
    Description = "Die <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Requirements = {}
};
local u63 = "Deaths";

function v62.ProgressCallback(p64, p65) -- Line: 2
    -- upvalues: u63 (copy)
    local v66 = 0;

    if p64[u63] then
        for _, v in pairs(p64[u63]) do
            v66 = v66 + v;
        end;
    end;

    return v66;
end;

v26.ACHIEVEMENT_21000 = v62;
local v67 = {
    Name = "Skill Issue",
    Description = "Die <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u68 = "Deaths";

function v67.ProgressCallback(p69, p70) -- Line: 2
    -- upvalues: u68 (copy)
    local v71 = 0;

    if p69[u68] then
        for _, v in pairs(p69[u68]) do
            v71 = v71 + v;
        end;
    end;

    return v71;
end;

v26.ACHIEVEMENT_21001 = v67;
local v72 = {
    Name = "This is Power",
    Description = "Perform <Amount> Instant Judgement Cuts",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 7,
    Requirements = {}
};
local u73 = "ABILITY_51";
local u74 = "InstantJC";

function v72.ProgressCallback(p75, p76) -- Line: 34
    -- upvalues: u73 (copy), u74 (copy)
    local v77 = 0;

    if p75.UsedMoves then
        for i, v in p75.UsedMoves do
            if u73 == nil or i == u73 then
                for i2, v2 in v do
                    if u74 == nil or i2 == u74 then
                        v77 = v77 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v77;
end;

v26.ACHIEVEMENT_23000 = v72;
local v78 = {
    Name = "Let me break it down for you",
    Description = "Emote for <Amount> minutes",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 1,
    Requirements = {}
};
local u79 = "DancedForTime";

function v78.ProgressCallback(p80, p81) -- Line: 2
    -- upvalues: u79 (copy)
    local v82 = 0;

    if p80[u79] then
        for _, v in pairs(p80[u79]) do
            v82 = v82 + v;
        end;
    end;

    return v82;
end;

v26.ACHIEVEMENT_50000 = v78;
local v83 = {
    Name = "The Dragon of Dojima I",
    Description = "Use \"Way of the Yakuza\" move with Standless <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 1,
    Requirements = {}
};
local u84 = "ABILITY_1";
local u85 = "Way of the Yakuza";

function v83.ProgressCallback(p86, p87) -- Line: 34
    -- upvalues: u84 (copy), u85 (copy)
    local v88 = 0;

    if p86.UsedMoves then
        for i, v in p86.UsedMoves do
            if u84 == nil or i == u84 then
                for i2, v2 in v do
                    if u85 == nil or i2 == u85 then
                        v88 = v88 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v88;
end;

v26.ACHIEVEMENT_50001 = v83;
local v89 = {
    Name = "The Dragon of Dojima II",
    Description = "Use \"Way of the Yakuza\" move with Standless <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 2,
    Requirements = {}
};
local u90 = "ABILITY_1";
local u91 = "Way of the Yakuza";

function v89.ProgressCallback(p92, p93) -- Line: 34
    -- upvalues: u90 (copy), u91 (copy)
    local v94 = 0;

    if p92.UsedMoves then
        for i, v in p92.UsedMoves do
            if u90 == nil or i == u90 then
                for i2, v2 in v do
                    if u91 == nil or i2 == u91 then
                        v94 = v94 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v94;
end;

v26.ACHIEVEMENT_50002 = v89;
local v95 = {
    Name = "The Dragon of Dojima III",
    Description = "Use \"Way of the Yakuza\" move with Standless <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u96 = "ABILITY_1";
local u97 = "Way of the Yakuza";

function v95.ProgressCallback(p98, p99) -- Line: 34
    -- upvalues: u96 (copy), u97 (copy)
    local v100 = 0;

    if p98.UsedMoves then
        for i, v in p98.UsedMoves do
            if u96 == nil or i == u96 then
                for i2, v2 in v do
                    if u97 == nil or i2 == u97 then
                        v100 = v100 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v100;
end;

v26.ACHIEVEMENT_50003 = v95;
v26.ACHIEVEMENT_50004 = {
    Name = "Kur\'s Blessing I",
    Description = "Roll an unusual <Amount> time",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {},

    ProgressCallback = function(p101, p102) -- Line: 236, Name: ProgressCallback
        return p101.RollUnusualSkins or 0;
    end
};
v26.ACHIEVEMENT_50005 = {
    Name = "Kur\'s Blessing II",
    Description = "Roll an unusual <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {},

    ProgressCallback = function(p103, p104) -- Line: 247, Name: ProgressCallback
        return p103.RollUnusualSkins or 0;
    end
};
v26.ACHIEVEMENT_50006 = {
    Name = "Kur\'s Blessing III",
    Description = "Roll an unusual <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {},

    ProgressCallback = function(p105, p106) -- Line: 258, Name: ProgressCallback
        return p105.RollUnusualSkins or 0;
    end
};
local v107 = {
    Name = "Average UG Player",
    Description = "Use <Amount> moves.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 7,
    Requirements = {}
};
local u108 = nil;
local u109 = nil;

function v107.ProgressCallback(p110, p111) -- Line: 34
    -- upvalues: u108 (copy), u109 (copy)
    local v112 = 0;

    if p110.UsedMoves then
        for i, v in p110.UsedMoves do
            if u108 == nil or i == u108 then
                for i2, v2 in v do
                    if u109 == nil or i2 == u109 then
                        v112 = v112 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v112;
end;

v26.ACHIEVEMENT_50007 = v107;
local v113 = {
    Name = "The Devil\'s Luck I",
    Description = "Roll an epic skin <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 2,
    Requirements = {}
};
local u114 = "Epic";

function v113.ProgressCallback(p115, p116) -- Line: 16
    -- upvalues: u114 (copy)
    local v117 = 0;

    if p115.RollSkins then
        for i, v in pairs(p115.RollSkins) do
            if u114 == nil or u114 == i then
                v117 = v117 + v;
            end;
        end;
    end;

    return v117;
end;

v26.ACHIEVEMENT_50008 = v113;
local v118 = {
    Name = "The Devil\'s Luck II",
    Description = "Roll a legendary skin <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u119 = "Legendary";

function v118.ProgressCallback(p120, p121) -- Line: 16
    -- upvalues: u119 (copy)
    local v122 = 0;

    if p120.RollSkins then
        for i, v in pairs(p120.RollSkins) do
            if u119 == nil or u119 == i then
                v122 = v122 + v;
            end;
        end;
    end;

    return v122;
end;

v26.ACHIEVEMENT_50009 = v118;
local v123 = {
    Name = "The Devil\'s Luck III",
    Description = "Roll a mythic skin <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u124 = "Mythic";

function v123.ProgressCallback(p125, p126) -- Line: 16
    -- upvalues: u124 (copy)
    local v127 = 0;

    if p125.RollSkins then
        for i, v in pairs(p125.RollSkins) do
            if u124 == nil or u124 == i then
                v127 = v127 + v;
            end;
        end;
    end;

    return v127;
end;

v26.ACHIEVEMENT_50010 = v123;
local v128 = {
    Name = "Ferocious Pirate I",
    Description = "Amass <Amount> bounty",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u129 = "Bounty";

function v128.ProgressCallback(p130, p131) -- Line: 2
    -- upvalues: u129 (copy)
    local v132 = 0;

    if p130[u129] then
        for _, v in pairs(p130[u129]) do
            v132 = v132 + v;
        end;
    end;

    return v132;
end;

v26.ACHIEVEMENT_50011 = v128;
local v133 = {
    Name = "Ferocious Pirate II",
    Description = "Amass <Amount> bounty",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u134 = "Bounty";

function v133.ProgressCallback(p135, p136) -- Line: 2
    -- upvalues: u134 (copy)
    local v137 = 0;

    if p135[u134] then
        for _, v in pairs(p135[u134]) do
            v137 = v137 + v;
        end;
    end;

    return v137;
end;

v26.ACHIEVEMENT_50012 = v133;
local v138 = {
    Name = "Ferocious Pirate III",
    Description = "Amass <Amount> bounty",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 7,
    Requirements = {}
};
local u139 = "Bounty";

function v138.ProgressCallback(p140, p141) -- Line: 2
    -- upvalues: u139 (copy)
    local v142 = 0;

    if p140[u139] then
        for _, v in pairs(p140[u139]) do
            v142 = v142 + v;
        end;
    end;

    return v142;
end;

v26.ACHIEVEMENT_50013 = v138;
local v143 = {
    Name = "A Knife for Hire I",
    Description = "Complete a Slayer contract <Amount> time.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u144 = "CompletedSlayersQuest";

function v143.ProgressCallback(p145, p146) -- Line: 2
    -- upvalues: u144 (copy)
    local v147 = 0;

    if p145[u144] then
        for _, v in pairs(p145[u144]) do
            v147 = v147 + v;
        end;
    end;

    return v147;
end;

v26.ACHIEVEMENT_50014 = v143;
local v148 = {
    Name = "A Knife for Hire II",
    Description = "Complete a Slayer contract <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u149 = "CompletedSlayersQuest";

function v148.ProgressCallback(p150, p151) -- Line: 2
    -- upvalues: u149 (copy)
    local v152 = 0;

    if p150[u149] then
        for _, v in pairs(p150[u149]) do
            v152 = v152 + v;
        end;
    end;

    return v152;
end;

v26.ACHIEVEMENT_50015 = v148;
local v153 = {
    Name = "A Knife for Hire III",
    Description = "Complete a Slayer contract <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u154 = "CompletedSlayersQuest";

function v153.ProgressCallback(p155, p156) -- Line: 2
    -- upvalues: u154 (copy)
    local v157 = 0;

    if p155[u154] then
        for _, v in pairs(p155[u154]) do
            v157 = v157 + v;
        end;
    end;

    return v157;
end;

v26.ACHIEVEMENT_50016 = v153;
local v158 = {
    Name = "Rejuvenation I",
    Description = "Activate the \"Rebirth\" passive with Dragon Knight <Amount> time.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u159 = "ABILITY_23";
local u160 = "RebirthPassive";

function v158.ProgressCallback(p161, p162) -- Line: 34
    -- upvalues: u159 (copy), u160 (copy)
    local v163 = 0;

    if p161.UsedMoves then
        for i, v in p161.UsedMoves do
            if u159 == nil or i == u159 then
                for i2, v2 in v do
                    if u160 == nil or i2 == u160 then
                        v163 = v163 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v163;
end;

v26.ACHIEVEMENT_50017 = v158;
local v164 = {
    Name = "Rejuvenation II",
    Description = "Activate the \"Rebirth\" passive with Dragon Knight <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u165 = "ABILITY_23";
local u166 = "RebirthPassive";

function v164.ProgressCallback(p167, p168) -- Line: 34
    -- upvalues: u165 (copy), u166 (copy)
    local v169 = 0;

    if p167.UsedMoves then
        for i, v in p167.UsedMoves do
            if u165 == nil or i == u165 then
                for i2, v2 in v do
                    if u166 == nil or i2 == u166 then
                        v169 = v169 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v169;
end;

v26.ACHIEVEMENT_50018 = v164;
local v170 = {
    Name = "Rejuvenation III",
    Description = "Activate the \"Rebirth\" passive with Dragon Knight <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u171 = "ABILITY_23";
local u172 = "RebirthPassive";

function v170.ProgressCallback(p173, p174) -- Line: 34
    -- upvalues: u171 (copy), u172 (copy)
    local v175 = 0;

    if p173.UsedMoves then
        for i, v in p173.UsedMoves do
            if u171 == nil or i == u171 then
                for i2, v2 in v do
                    if u172 == nil or i2 == u172 then
                        v175 = v175 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v175;
end;

v26.ACHIEVEMENT_50019 = v170;
local v176 = {
    Name = "The Strongest Stand I",
    Description = "Use the \"Cursed Command\" move with Anubis <Amount> time.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 2,
    Requirements = {}
};
local u177 = "ABILITY_80086";
local u178 = "Cursed Command";

function v176.ProgressCallback(p179, p180) -- Line: 34
    -- upvalues: u177 (copy), u178 (copy)
    local v181 = 0;

    if p179.UsedMoves then
        for i, v in p179.UsedMoves do
            if u177 == nil or i == u177 then
                for i2, v2 in v do
                    if u178 == nil or i2 == u178 then
                        v181 = v181 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v181;
end;

v26.ACHIEVEMENT_50020 = v176;
local v182 = {
    Name = "The Strongest Stand II",
    Description = "Use the \"Cursed Command\" move with Anubis <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u183 = "ABILITY_80086";
local u184 = "Cursed Command";

function v182.ProgressCallback(p185, p186) -- Line: 34
    -- upvalues: u183 (copy), u184 (copy)
    local v187 = 0;

    if p185.UsedMoves then
        for i, v in p185.UsedMoves do
            if u183 == nil or i == u183 then
                for i2, v2 in v do
                    if u184 == nil or i2 == u184 then
                        v187 = v187 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v187;
end;

v26.ACHIEVEMENT_50021 = v182;
local v188 = {
    Name = "The Strongest Stand III",
    Description = "Use the \"Cursed Command\" move with Anubis <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u189 = "ABILITY_80086";
local u190 = "Cursed Command";

function v188.ProgressCallback(p191, p192) -- Line: 34
    -- upvalues: u189 (copy), u190 (copy)
    local v193 = 0;

    if p191.UsedMoves then
        for i, v in p191.UsedMoves do
            if u189 == nil or i == u189 then
                for i2, v2 in v do
                    if u190 == nil or i2 == u190 then
                        v193 = v193 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v193;
end;

v26.ACHIEVEMENT_50022 = v188;
local v194 = {
    Name = "Fruit Muncher I",
    Description = "Eat a Devil Fruit <Amount> time.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u195 = nil;

function v194.ProgressCallback(p196, p197) -- Line: 58
    -- upvalues: u195 (copy)
    local v198 = 0;

    if p196.EatenFruits then
        for i, v in p196.EatenFruits do
            if u195 == nil or u195 == i then
                v198 = v198 + v;
            end;
        end;
    end;

    return v198;
end;

v26.ACHIEVEMENT_50023 = v194;
local v199 = {
    Name = "Fruit Muncher II",
    Description = "Eat a Devil Fruit <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u200 = nil;

function v199.ProgressCallback(p201, p202) -- Line: 58
    -- upvalues: u200 (copy)
    local v203 = 0;

    if p201.EatenFruits then
        for i, v in p201.EatenFruits do
            if u200 == nil or u200 == i then
                v203 = v203 + v;
            end;
        end;
    end;

    return v203;
end;

v26.ACHIEVEMENT_50024 = v199;
local v204 = {
    Name = "Fruit Muncher III",
    Description = "Eat a Devil Fruit <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u205 = nil;

function v204.ProgressCallback(p206, p207) -- Line: 58
    -- upvalues: u205 (copy)
    local v208 = 0;

    if p206.EatenFruits then
        for i, v in p206.EatenFruits do
            if u205 == nil or u205 == i then
                v208 = v208 + v;
            end;
        end;
    end;

    return v208;
end;

v26.ACHIEVEMENT_50025 = v204;
local v209 = {
    Name = "Portal 2 I",
    Description = "Use the \"VOID // GATE\" move on PLANET // SHAPER <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 2,
    Requirements = {}
};
local u210 = "ABILITY_658";
local u211 = "VOID // GATE";

function v209.ProgressCallback(p212, p213) -- Line: 34
    -- upvalues: u210 (copy), u211 (copy)
    local v214 = 0;

    if p212.UsedMoves then
        for i, v in p212.UsedMoves do
            if u210 == nil or i == u210 then
                for i2, v2 in v do
                    if u211 == nil or i2 == u211 then
                        v214 = v214 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v214;
end;

v26.ACHIEVEMENT_50026 = v209;
local v215 = {
    Name = "Portal 2 II",
    Description = "Use the \"VOID // GATE\" move on PLANET // SHAPER <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u216 = "ABILITY_658";
local u217 = "VOID // GATE";

function v215.ProgressCallback(p218, p219) -- Line: 34
    -- upvalues: u216 (copy), u217 (copy)
    local v220 = 0;

    if p218.UsedMoves then
        for i, v in p218.UsedMoves do
            if u216 == nil or i == u216 then
                for i2, v2 in v do
                    if u217 == nil or i2 == u217 then
                        v220 = v220 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v220;
end;

v26.ACHIEVEMENT_50027 = v215;
local v221 = {
    Name = "Portal 2 III",
    Description = "Use the \"VOID // GATE\" move on PLANET // SHAPER <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u222 = "ABILITY_658";
local u223 = "VOID // GATE";

function v221.ProgressCallback(p224, p225) -- Line: 34
    -- upvalues: u222 (copy), u223 (copy)
    local v226 = 0;

    if p224.UsedMoves then
        for i, v in p224.UsedMoves do
            if u222 == nil or i == u222 then
                for i2, v2 in v do
                    if u223 == nil or i2 == u223 then
                        v226 = v226 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v226;
end;

v26.ACHIEVEMENT_50028 = v221;
local v227 = {
    Name = "Are you Stand proud, You\'re Strong because your Nah I\'d Win? I",
    Description = "Use the \"Unlimited Void\" move with The Strongest for <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u228 = "ABILITY_12789";
local u229 = "Infinity";

function v227.ProgressCallback(p230, p231) -- Line: 34
    -- upvalues: u228 (copy), u229 (copy)
    local v232 = 0;

    if p230.UsedMoves then
        for i, v in p230.UsedMoves do
            if u228 == nil or i == u228 then
                for i2, v2 in v do
                    if u229 == nil or i2 == u229 then
                        v232 = v232 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v232;
end;

v26.ACHIEVEMENT_50029 = v227;
local v233 = {
    Name = "Are you Stand proud, You\'re Strong because your Nah I\'d Win? II",
    Description = "Use the \"Unlimited Void\" move with The Strongest for <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u234 = "ABILITY_12789";
local u235 = "Infinity";

function v233.ProgressCallback(p236, p237) -- Line: 34
    -- upvalues: u234 (copy), u235 (copy)
    local v238 = 0;

    if p236.UsedMoves then
        for i, v in p236.UsedMoves do
            if u234 == nil or i == u234 then
                for i2, v2 in v do
                    if u235 == nil or i2 == u235 then
                        v238 = v238 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v238;
end;

v26.ACHIEVEMENT_50030 = v233;
local v239 = {
    Name = "Are you Stand proud, You\'re Strong because your Nah I\'d Win? III",
    Description = "Use the \"Unlimited Void\" move with The Strongest for <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u240 = "ABILITY_12789";
local u241 = "Infinity";

function v239.ProgressCallback(p242, p243) -- Line: 34
    -- upvalues: u240 (copy), u241 (copy)
    local v244 = 0;

    if p242.UsedMoves then
        for i, v in p242.UsedMoves do
            if u240 == nil or i == u240 then
                for i2, v2 in v do
                    if u241 == nil or i2 == u241 then
                        v244 = v244 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v244;
end;

v26.ACHIEVEMENT_50031 = v239;
local v245 = {
    Name = "Boundless Luck",
    Description = "Roll a Universal skin.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 12,
    Requirements = {}
};
local u246 = "Universal";

function v245.ProgressCallback(p247, p248) -- Line: 16
    -- upvalues: u246 (copy)
    local v249 = 0;

    if p247.RollSkins then
        for i, v in pairs(p247.RollSkins) do
            if u246 == nil or u246 == i then
                v249 = v249 + v;
            end;
        end;
    end;

    return v249;
end;

v26.ACHIEVEMENT_50032 = v245;
local v250 = {
    Name = "In Shambles I",
    Description = "Use the \"Shambles\" move with Ope <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u251 = "ABILITY_911";
local u252 = "Shambles";

function v250.ProgressCallback(p253, p254) -- Line: 34
    -- upvalues: u251 (copy), u252 (copy)
    local v255 = 0;

    if p253.UsedMoves then
        for i, v in p253.UsedMoves do
            if u251 == nil or i == u251 then
                for i2, v2 in v do
                    if u252 == nil or i2 == u252 then
                        v255 = v255 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v255;
end;

v26.ACHIEVEMENT_50033 = v250;
local v256 = {
    Name = "In Shambles II",
    Description = "Use the \"Shambles\" move with Ope <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u257 = "ABILITY_911";
local u258 = "Shambles";

function v256.ProgressCallback(p259, p260) -- Line: 34
    -- upvalues: u257 (copy), u258 (copy)
    local v261 = 0;

    if p259.UsedMoves then
        for i, v in p259.UsedMoves do
            if u257 == nil or i == u257 then
                for i2, v2 in v do
                    if u258 == nil or i2 == u258 then
                        v261 = v261 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v261;
end;

v26.ACHIEVEMENT_50034 = v256;
local v262 = {
    Name = "In Shambles III",
    Description = "Use the \"Shambles\" move with Ope <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u263 = "ABILITY_911";
local u264 = "Shambles";

function v262.ProgressCallback(p265, p266) -- Line: 34
    -- upvalues: u263 (copy), u264 (copy)
    local v267 = 0;

    if p265.UsedMoves then
        for i, v in p265.UsedMoves do
            if u263 == nil or i == u263 then
                for i2, v2 in v do
                    if u264 == nil or i2 == u264 then
                        v267 = v267 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v267;
end;

v26.ACHIEVEMENT_50035 = v262;
local v268 = {
    Name = "ROOM! I",
    Description = "Use the \"Room\" move with Ope <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 1,
    Requirements = {}
};
local u269 = "ABILITY_911";
local u270 = "Room";

function v268.ProgressCallback(p271, p272) -- Line: 34
    -- upvalues: u269 (copy), u270 (copy)
    local v273 = 0;

    if p271.UsedMoves then
        for i, v in p271.UsedMoves do
            if u269 == nil or i == u269 then
                for i2, v2 in v do
                    if u270 == nil or i2 == u270 then
                        v273 = v273 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v273;
end;

v26.ACHIEVEMENT_50036 = v268;
local v274 = {
    Name = "ROOM! II",
    Description = "Use the \"Room\" move with Ope <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 2,
    Requirements = {}
};
local u275 = "ABILITY_911";
local u276 = "Room";

function v274.ProgressCallback(p277, p278) -- Line: 34
    -- upvalues: u275 (copy), u276 (copy)
    local v279 = 0;

    if p277.UsedMoves then
        for i, v in p277.UsedMoves do
            if u275 == nil or i == u275 then
                for i2, v2 in v do
                    if u276 == nil or i2 == u276 then
                        v279 = v279 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v279;
end;

v26.ACHIEVEMENT_50037 = v274;
local v280 = {
    Name = "ROOM! III",
    Description = "Use the \"Room\" move with Ope <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u281 = "ABILITY_911";
local u282 = "Room";

function v280.ProgressCallback(p283, p284) -- Line: 34
    -- upvalues: u281 (copy), u282 (copy)
    local v285 = 0;

    if p283.UsedMoves then
        for i, v in p283.UsedMoves do
            if u281 == nil or i == u281 then
                for i2, v2 in v do
                    if u282 == nil or i2 == u282 then
                        v285 = v285 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v285;
end;

v26.ACHIEVEMENT_50038 = v280;
local v286 = {
    Name = "Heartless I",
    Description = "Use the \"Heartless\" move with Mero <Amount> time.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 2,
    Requirements = {}
};
local u287 = "ABILITY_911111";
local u288 = "Heartless";

function v286.ProgressCallback(p289, p290) -- Line: 34
    -- upvalues: u287 (copy), u288 (copy)
    local v291 = 0;

    if p289.UsedMoves then
        for i, v in p289.UsedMoves do
            if u287 == nil or i == u287 then
                for i2, v2 in v do
                    if u288 == nil or i2 == u288 then
                        v291 = v291 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v291;
end;

v26.ACHIEVEMENT_50039 = v286;
local v292 = {
    Name = "Heartless II",
    Description = "Use the \"Heartless\" move with Mero <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u293 = "ABILITY_911111";
local u294 = "Heartless";

function v292.ProgressCallback(p295, p296) -- Line: 34
    -- upvalues: u293 (copy), u294 (copy)
    local v297 = 0;

    if p295.UsedMoves then
        for i, v in p295.UsedMoves do
            if u293 == nil or i == u293 then
                for i2, v2 in v do
                    if u294 == nil or i2 == u294 then
                        v297 = v297 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v297;
end;

v26.ACHIEVEMENT_50040 = v292;
local v298 = {
    Name = "Heartless III",
    Description = "Use the \"Heartless\" move with Mero <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u299 = "ABILITY_911111";
local u300 = "Heartless";

function v298.ProgressCallback(p301, p302) -- Line: 34
    -- upvalues: u299 (copy), u300 (copy)
    local v303 = 0;

    if p301.UsedMoves then
        for i, v in p301.UsedMoves do
            if u299 == nil or i == u299 then
                for i2, v2 in v do
                    if u300 == nil or i2 == u300 then
                        v303 = v303 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v303;
end;

v26.ACHIEVEMENT_50041 = v298;
local v304 = {
    Name = "Empress of Love I",
    Description = "Use the \"Infatuation\" move with Mero <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u305 = "ABILITY_911111";
local u306 = "Infatuation";

function v304.ProgressCallback(p307, p308) -- Line: 34
    -- upvalues: u305 (copy), u306 (copy)
    local v309 = 0;

    if p307.UsedMoves then
        for i, v in p307.UsedMoves do
            if u305 == nil or i == u305 then
                for i2, v2 in v do
                    if u306 == nil or i2 == u306 then
                        v309 = v309 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v309;
end;

v26.ACHIEVEMENT_50042 = v304;
local v310 = {
    Name = "Empress of Love II",
    Description = "Use the \"Infatuation\" move with Mero <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u311 = "ABILITY_911111";
local u312 = "Infatuation";

function v310.ProgressCallback(p313, p314) -- Line: 34
    -- upvalues: u311 (copy), u312 (copy)
    local v315 = 0;

    if p313.UsedMoves then
        for i, v in p313.UsedMoves do
            if u311 == nil or i == u311 then
                for i2, v2 in v do
                    if u312 == nil or i2 == u312 then
                        v315 = v315 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v315;
end;

v26.ACHIEVEMENT_50043 = v310;
local v316 = {
    Name = "Empress of Love III",
    Description = "Use the \"Infatuation\" move with Mero <Amount> times.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 6,
    Requirements = {}
};
local u317 = "ABILITY_911111";
local u318 = "Infatuation";

function v316.ProgressCallback(p319, p320) -- Line: 34
    -- upvalues: u317 (copy), u318 (copy)
    local v321 = 0;

    if p319.UsedMoves then
        for i, v in p319.UsedMoves do
            if u317 == nil or i == u317 then
                for i2, v2 in v do
                    if u318 == nil or i2 == u318 then
                        v321 = v321 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v321;
end;

v26.ACHIEVEMENT_50044 = v316;
local v322 = {
    Name = "Aerial Transportation I",
    Description = "Drive with a \"Hoverboard\" type mount for <Amount> seconds.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 1,
    Requirements = {}
};
local u323 = "Hoverboard";

function v322.ProgressCallback(p324, p325) -- Line: 76
    -- upvalues: u323 (copy)
    local v326 = 0;

    if p324.MountTime then
        for i, v in p324.MountTime do
            if u323 == nil or i == u323 then
                v326 = v326 + v;
            end;
        end;
    end;

    return v326;
end;

v26.ACHIEVEMENT_50045 = v322;
local v327 = {
    Name = "Aerial Transportation II",
    Description = "Drive with a \"Hoverboard\" type mount for <Amount> seconds.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 2,
    Requirements = {}
};
local u328 = "Hoverboard";

function v327.ProgressCallback(p329, p330) -- Line: 76
    -- upvalues: u328 (copy)
    local v331 = 0;

    if p329.MountTime then
        for i, v in p329.MountTime do
            if u328 == nil or i == u328 then
                v331 = v331 + v;
            end;
        end;
    end;

    return v331;
end;

v26.ACHIEVEMENT_50046 = v327;
local v332 = {
    Name = "Aerial Transportation III",
    Description = "Drive with a \"Hoverboard\" type mount for <Amount> seconds.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u333 = "Hoverboard";

function v332.ProgressCallback(p334, p335) -- Line: 76
    -- upvalues: u333 (copy)
    local v336 = 0;

    if p334.MountTime then
        for i, v in p334.MountTime do
            if u333 == nil or i == u333 then
                v336 = v336 + v;
            end;
        end;
    end;

    return v336;
end;

v26.ACHIEVEMENT_50047 = v332;
local v337 = {
    Name = "Grounded Transportation I",
    Description = "Drive with a \"Bike\" type mount for <Amount> seconds.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 1,
    Requirements = {}
};
local u338 = "Bike";

function v337.ProgressCallback(p339, p340) -- Line: 76
    -- upvalues: u338 (copy)
    local v341 = 0;

    if p339.MountTime then
        for i, v in p339.MountTime do
            if u338 == nil or i == u338 then
                v341 = v341 + v;
            end;
        end;
    end;

    return v341;
end;

v26.ACHIEVEMENT_50048 = v337;
local v342 = {
    Name = "Grounded Transportation II",
    Description = "Drive with a \"Bike\" type mount for <Amount> seconds.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 2,
    Requirements = {}
};
local u343 = "Bike";

function v342.ProgressCallback(p344, p345) -- Line: 76
    -- upvalues: u343 (copy)
    local v346 = 0;

    if p344.MountTime then
        for i, v in p344.MountTime do
            if u343 == nil or i == u343 then
                v346 = v346 + v;
            end;
        end;
    end;

    return v346;
end;

v26.ACHIEVEMENT_50049 = v342;
local v347 = {
    Name = "Grounded Transportation III",
    Description = "Drive with a \"Bike\" type mount for <Amount> seconds.",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u348 = "Bike";

function v347.ProgressCallback(p349, p350) -- Line: 76
    -- upvalues: u348 (copy)
    local v351 = 0;

    if p349.MountTime then
        for i, v in p349.MountTime do
            if u348 == nil or i == u348 then
                v351 = v351 + v;
            end;
        end;
    end;

    return v351;
end;

v26.ACHIEVEMENT_50050 = v347;
local v352 = {
    Name = "Indiana Jones I",
    Description = "Complete any adventure board quest <Amount> time",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 2,
    Requirements = {}
};
local u353 = "CompleteAdventureboard";

function v352.ProgressCallback(p354, p355) -- Line: 2
    -- upvalues: u353 (copy)
    local v356 = 0;

    if p354[u353] then
        for _, v in pairs(p354[u353]) do
            v356 = v356 + v;
        end;
    end;

    return v356;
end;

v26.ACHIEVEMENT_50051 = v352;
local v357 = {
    Name = "Indiana Jones II",
    Description = "Complete any adventure board quest <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u358 = "CompleteAdventureboard";

function v357.ProgressCallback(p359, p360) -- Line: 2
    -- upvalues: u358 (copy)
    local v361 = 0;

    if p359[u358] then
        for _, v in pairs(p359[u358]) do
            v361 = v361 + v;
        end;
    end;

    return v361;
end;

v26.ACHIEVEMENT_50052 = v357;
local v362 = {
    Name = "Indiana Jones III",
    Description = "Complete any adventure board quest <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u363 = "CompleteAdventureboard";

function v362.ProgressCallback(p364, p365) -- Line: 2
    -- upvalues: u363 (copy)
    local v366 = 0;

    if p364[u363] then
        for _, v in pairs(p364[u363]) do
            v366 = v366 + v;
        end;
    end;

    return v366;
end;

v26.ACHIEVEMENT_50053 = v362;
local v367 = {
    Name = "Protector Of Time I",
    Description = "Awaken with Chrono Warden <Amount> time",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u368 = "ABILITY_42";
local u369 = "ChronoRessurect";

function v367.ProgressCallback(p370, p371) -- Line: 34
    -- upvalues: u368 (copy), u369 (copy)
    local v372 = 0;

    if p370.UsedMoves then
        for i, v in p370.UsedMoves do
            if u368 == nil or i == u368 then
                for i2, v2 in v do
                    if u369 == nil or i2 == u369 then
                        v372 = v372 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v372;
end;

v26.ACHIEVEMENT_50054 = v367;
local v373 = {
    Name = "Protector Of Time II",
    Description = "Awaken with Chrono Warden <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u374 = "ABILITY_42";
local u375 = "ChronoRessurect";

function v373.ProgressCallback(p376, p377) -- Line: 34
    -- upvalues: u374 (copy), u375 (copy)
    local v378 = 0;

    if p376.UsedMoves then
        for i, v in p376.UsedMoves do
            if u374 == nil or i == u374 then
                for i2, v2 in v do
                    if u375 == nil or i2 == u375 then
                        v378 = v378 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v378;
end;

v26.ACHIEVEMENT_50055 = v373;
local v379 = {
    Name = "Protector Of Time III",
    Description = "Awaken with Chrono Warden <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 6,
    Requirements = {}
};
local u380 = "ABILITY_42";
local u381 = "ChronoRessurect";

function v379.ProgressCallback(p382, p383) -- Line: 34
    -- upvalues: u380 (copy), u381 (copy)
    local v384 = 0;

    if p382.UsedMoves then
        for i, v in p382.UsedMoves do
            if u380 == nil or i == u380 then
                for i2, v2 in v do
                    if u381 == nil or i2 == u381 then
                        v384 = v384 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v384;
end;

v26.ACHIEVEMENT_50056 = v379;
local v385 = {
    Name = "Black Flash I",
    Description = "Land Black Flash with The Vessel <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u386 = "ABILITY_32003";
local u387 = "BlackFlash";

function v385.ProgressCallback(p388, p389) -- Line: 34
    -- upvalues: u386 (copy), u387 (copy)
    local v390 = 0;

    if p388.UsedMoves then
        for i, v in p388.UsedMoves do
            if u386 == nil or i == u386 then
                for i2, v2 in v do
                    if u387 == nil or i2 == u387 then
                        v390 = v390 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v390;
end;

v26.ACHIEVEMENT_50057 = v385;
local v391 = {
    Name = "Black Flash II",
    Description = "Land Black Flash with The Vessel <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u392 = "ABILITY_32003";
local u393 = "BlackFlash";

function v391.ProgressCallback(p394, p395) -- Line: 34
    -- upvalues: u392 (copy), u393 (copy)
    local v396 = 0;

    if p394.UsedMoves then
        for i, v in p394.UsedMoves do
            if u392 == nil or i == u392 then
                for i2, v2 in v do
                    if u393 == nil or i2 == u393 then
                        v396 = v396 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v396;
end;

v26.ACHIEVEMENT_50058 = v391;
local v397 = {
    Name = "Black Flash III",
    Description = "Land Black Flash with The Vessel <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 6,
    Requirements = {}
};
local u398 = "ABILITY_32003";
local u399 = "BlackFlash";

function v397.ProgressCallback(p400, p401) -- Line: 34
    -- upvalues: u398 (copy), u399 (copy)
    local v402 = 0;

    if p400.UsedMoves then
        for i, v in p400.UsedMoves do
            if u398 == nil or i == u398 then
                for i2, v2 in v do
                    if u399 == nil or i2 == u399 then
                        v402 = v402 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v402;
end;

v26.ACHIEVEMENT_50059 = v397;
local v403 = {
    Name = "Divine Technique I",
    Description = "Use Malevolent Shrine <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u404 = "ABILITY_320003";
local u405 = "MalevolentShrine";

function v403.ProgressCallback(p406, p407) -- Line: 34
    -- upvalues: u404 (copy), u405 (copy)
    local v408 = 0;

    if p406.UsedMoves then
        for i, v in p406.UsedMoves do
            if u404 == nil or i == u404 then
                for i2, v2 in v do
                    if u405 == nil or i2 == u405 then
                        v408 = v408 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v408;
end;

v26.ACHIEVEMENT_50060 = v403;
local v409 = {
    Name = "Divine Technique II",
    Description = "Use Malevolent Shrine <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u410 = "ABILITY_320003";
local u411 = "MalevolentShrine";

function v409.ProgressCallback(p412, p413) -- Line: 34
    -- upvalues: u410 (copy), u411 (copy)
    local v414 = 0;

    if p412.UsedMoves then
        for i, v in p412.UsedMoves do
            if u410 == nil or i == u410 then
                for i2, v2 in v do
                    if u411 == nil or i2 == u411 then
                        v414 = v414 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v414;
end;

v26.ACHIEVEMENT_50061 = v409;
local v415 = {
    Name = "Divine Technique III",
    Description = "Use Malevolent Shrine <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 6,
    Requirements = {}
};
local u416 = "ABILITY_320003";
local u417 = "MalevolentShrine";

function v415.ProgressCallback(p418, p419) -- Line: 34
    -- upvalues: u416 (copy), u417 (copy)
    local v420 = 0;

    if p418.UsedMoves then
        for i, v in p418.UsedMoves do
            if u416 == nil or i == u416 then
                for i2, v2 in v do
                    if u417 == nil or i2 == u417 then
                        v420 = v420 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v420;
end;

v26.ACHIEVEMENT_50062 = v415;
local v421 = {
    Name = "Space Ripper I",
    Description = "Use Space Ripper Stingy Eyes <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u422 = "ABILITY_16";
local u423 = "SpaceRipper";

function v421.ProgressCallback(p424, p425) -- Line: 34
    -- upvalues: u422 (copy), u423 (copy)
    local v426 = 0;

    if p424.UsedMoves then
        for i, v in p424.UsedMoves do
            if u422 == nil or i == u422 then
                for i2, v2 in v do
                    if u423 == nil or i2 == u423 then
                        v426 = v426 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v426;
end;

v26.ACHIEVEMENT_50063 = v421;
local v427 = {
    Name = "Space Ripper II",
    Description = "Use Space Ripper Stingy Eyes <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u428 = "ABILITY_16";
local u429 = "SpaceRipper";

function v427.ProgressCallback(p430, p431) -- Line: 34
    -- upvalues: u428 (copy), u429 (copy)
    local v432 = 0;

    if p430.UsedMoves then
        for i, v in p430.UsedMoves do
            if u428 == nil or i == u428 then
                for i2, v2 in v do
                    if u429 == nil or i2 == u429 then
                        v432 = v432 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v432;
end;

v26.ACHIEVEMENT_50064 = v427;
local v433 = {
    Name = "Space Ripper III",
    Description = "Use Space Ripper Stingy Eyes <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u434 = "ABILITY_16";
local u435 = "SpaceRipper";

function v433.ProgressCallback(p436, p437) -- Line: 34
    -- upvalues: u434 (copy), u435 (copy)
    local v438 = 0;

    if p436.UsedMoves then
        for i, v in p436.UsedMoves do
            if u434 == nil or i == u434 then
                for i2, v2 in v do
                    if u435 == nil or i2 == u435 then
                        v438 = v438 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v438;
end;

v26.ACHIEVEMENT_50065 = v433;
local v439 = {
    Name = "Bloodsight I",
    Description = "Use Inhumane Perception <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 2,
    Requirements = {}
};
local u440 = "ABILITY_16";
local u441 = "InhumanePerception";

function v439.ProgressCallback(p442, p443) -- Line: 34
    -- upvalues: u440 (copy), u441 (copy)
    local v444 = 0;

    if p442.UsedMoves then
        for i, v in p442.UsedMoves do
            if u440 == nil or i == u440 then
                for i2, v2 in v do
                    if u441 == nil or i2 == u441 then
                        v444 = v444 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v444;
end;

v26.ACHIEVEMENT_50066 = v439;
local v445 = {
    Name = "Bloodsight II",
    Description = "Use Inhumane Perception <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u446 = "ABILITY_16";
local u447 = "InhumanePerception";

function v445.ProgressCallback(p448, p449) -- Line: 34
    -- upvalues: u446 (copy), u447 (copy)
    local v450 = 0;

    if p448.UsedMoves then
        for i, v in p448.UsedMoves do
            if u446 == nil or i == u446 then
                for i2, v2 in v do
                    if u447 == nil or i2 == u447 then
                        v450 = v450 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v450;
end;

v26.ACHIEVEMENT_50067 = v445;
local v451 = {
    Name = "Bloodsight III",
    Description = "Use Inhumane Perception <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u452 = "ABILITY_16";
local u453 = "InhumanePerception";

function v451.ProgressCallback(p454, p455) -- Line: 34
    -- upvalues: u452 (copy), u453 (copy)
    local v456 = 0;

    if p454.UsedMoves then
        for i, v in p454.UsedMoves do
            if u452 == nil or i == u452 then
                for i2, v2 in v do
                    if u453 == nil or i2 == u453 then
                        v456 = v456 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v456;
end;

v26.ACHIEVEMENT_50068 = v451;
local v457 = {
    Name = "Voidwalker I",
    Description = "Use Shadow Step <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u458 = "ABILITY_16";
local u459 = "Shadowstep";

function v457.ProgressCallback(p460, p461) -- Line: 34
    -- upvalues: u458 (copy), u459 (copy)
    local v462 = 0;

    if p460.UsedMoves then
        for i, v in p460.UsedMoves do
            if u458 == nil or i == u458 then
                for i2, v2 in v do
                    if u459 == nil or i2 == u459 then
                        v462 = v462 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v462;
end;

v26.ACHIEVEMENT_50069 = v457;
local v463 = {
    Name = "Voidwalker II",
    Description = "Use Shadow Step <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u464 = "ABILITY_16";
local u465 = "Shadowstep";

function v463.ProgressCallback(p466, p467) -- Line: 34
    -- upvalues: u464 (copy), u465 (copy)
    local v468 = 0;

    if p466.UsedMoves then
        for i, v in p466.UsedMoves do
            if u464 == nil or i == u464 then
                for i2, v2 in v do
                    if u465 == nil or i2 == u465 then
                        v468 = v468 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v468;
end;

v26.ACHIEVEMENT_50070 = v463;
local v469 = {
    Name = "Voidwalker III",
    Description = "Use Shadow Step <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 7,
    Requirements = {}
};
local u470 = "ABILITY_16";
local u471 = "Shadowstep";

function v469.ProgressCallback(p472, p473) -- Line: 34
    -- upvalues: u470 (copy), u471 (copy)
    local v474 = 0;

    if p472.UsedMoves then
        for i, v in p472.UsedMoves do
            if u470 == nil or i == u470 then
                for i2, v2 in v do
                    if u471 == nil or i2 == u471 then
                        v474 = v474 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v474;
end;

v26.ACHIEVEMENT_50071 = v469;
local v475 = {
    Name = "Bloodfiend I",
    Description = "Land Life Drain (on Vampire [Dio Brando]) <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u476 = "ABILITY_16";
local u477 = "LifeDrain";

function v475.ProgressCallback(p478, p479) -- Line: 34
    -- upvalues: u476 (copy), u477 (copy)
    local v480 = 0;

    if p478.UsedMoves then
        for i, v in p478.UsedMoves do
            if u476 == nil or i == u476 then
                for i2, v2 in v do
                    if u477 == nil or i2 == u477 then
                        v480 = v480 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v480;
end;

v26.ACHIEVEMENT_50072 = v475;
local v481 = {
    Name = "Bloodfiend II",
    Description = "Land Life Drain (on Vampire [Dio Brando]) <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u482 = "ABILITY_16";
local u483 = "LifeDrain";

function v481.ProgressCallback(p484, p485) -- Line: 34
    -- upvalues: u482 (copy), u483 (copy)
    local v486 = 0;

    if p484.UsedMoves then
        for i, v in p484.UsedMoves do
            if u482 == nil or i == u482 then
                for i2, v2 in v do
                    if u483 == nil or i2 == u483 then
                        v486 = v486 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v486;
end;

v26.ACHIEVEMENT_50073 = v481;
local v487 = {
    Name = "Bloodfiend III",
    Description = "Land Life Drain (on Vampire [Dio Brando]) <Amount> times",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u488 = "ABILITY_16";
local u489 = "LifeDrain";

function v487.ProgressCallback(p490, p491) -- Line: 34
    -- upvalues: u488 (copy), u489 (copy)
    local v492 = 0;

    if p490.UsedMoves then
        for i, v in p490.UsedMoves do
            if u488 == nil or i == u488 then
                for i2, v2 in v do
                    if u489 == nil or i2 == u489 then
                        v492 = v492 + v2;
                    end;
                end;
            end;
        end;
    end;

    return v492;
end;

v26.ACHIEVEMENT_50074 = v487;
local v493 = {
    Name = "Science Hurts",
    Description = "Ignore the safety precugions in the Gateway Sector",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u494 = "Lab_Death";

function v493.ProgressCallback(p495, p496) -- Line: 94
    -- upvalues: u494 (copy)
    local v497 = 0;

    if p495.Misc and p495.Misc[u494] then
        v497 = v497 + p495.Misc[u494];
    end;

    return v497;
end;

v26.ACHIEVEMENT_55000 = v493;
local v498 = {
    Name = "Look Above",
    Description = "Die from the impact of a Camellite Meteor",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u499 = "Cam_Meteor_Death";

function v498.ProgressCallback(p500, p501) -- Line: 94
    -- upvalues: u499 (copy)
    local v502 = 0;

    if p500.Misc and p500.Misc[u499] then
        v502 = v502 + p500.Misc[u499];
    end;

    return v502;
end;

v26.ACHIEVEMENT_55001 = v498;
local v503 = {
    Name = "MY CRATE!!!",
    Description = "Have your Lost Equipment Crate stolen from you",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u504 = "Lab_Crate_Robbed";

function v503.ProgressCallback(p505, p506) -- Line: 94
    -- upvalues: u504 (copy)
    local v507 = 0;

    if p505.Misc and p505.Misc[u504] then
        v507 = v507 + p505.Misc[u504];
    end;

    return v507;
end;

v26.ACHIEVEMENT_55003 = v503;
local v508 = {
    Name = "Ill-Gotten Gains",
    Description = "Successfully steal a Lost Equipment Crate from another player and turn it in",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u509 = "Lab_Crate_Theft_Success";

function v508.ProgressCallback(p510, p511) -- Line: 94
    -- upvalues: u509 (copy)
    local v512 = 0;

    if p510.Misc and p510.Misc[u509] then
        v512 = v512 + p510.Misc[u509];
    end;

    return v512;
end;

v26.ACHIEVEMENT_55004 = v508;
local v513 = {
    Name = "Lab Courier I",
    Description = "Successfully turn in <Amount> Lost Equipment Crates",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u514 = "Lab_Crate_Turned_In";

function v513.ProgressCallback(p515, p516) -- Line: 94
    -- upvalues: u514 (copy)
    local v517 = 0;

    if p515.Misc and p515.Misc[u514] then
        v517 = v517 + p515.Misc[u514];
    end;

    return v517;
end;

v26.ACHIEVEMENT_55005 = v513;
local v518 = {
    Name = "Lab Courier II",
    Description = "Successfully turn in <Amount> Lost Equipment Crates",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u519 = "Lab_Crate_Turned_In";

function v518.ProgressCallback(p520, p521) -- Line: 94
    -- upvalues: u519 (copy)
    local v522 = 0;

    if p520.Misc and p520.Misc[u519] then
        v522 = v522 + p520.Misc[u519];
    end;

    return v522;
end;

v26.ACHIEVEMENT_55006 = v518;
local v523 = {
    Name = "Lab Courier III",
    Description = "Successfully turn in <Amount> Lost Equipment Crates",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u524 = "Lab_Crate_Turned_In";

function v523.ProgressCallback(p525, p526) -- Line: 94
    -- upvalues: u524 (copy)
    local v527 = 0;

    if p525.Misc and p525.Misc[u524] then
        v527 = v527 + p525.Misc[u524];
    end;

    return v527;
end;

v26.ACHIEVEMENT_55007 = v523;
local v528 = {
    Name = "Priority-Class Courier",
    Description = "Successfully turn in a rare, SPECIAL Lost Equipment Crate",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u529 = "Lab_Rare_Crate_Turned_In";

function v528.ProgressCallback(p530, p531) -- Line: 94
    -- upvalues: u529 (copy)
    local v532 = 0;

    if p530.Misc and p530.Misc[u529] then
        v532 = v532 + p530.Misc[u529];
    end;

    return v532;
end;

v26.ACHIEVEMENT_55008 = v528;
local v533 = {
    Name = "Master Courier",
    Description = "Successfully turn in <Amount> rare, SPECIAL Lost Equipment Crates",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 7,
    Requirements = {}
};
local u534 = "Lab_Rare_Crate_Turned_In";

function v533.ProgressCallback(p535, p536) -- Line: 94
    -- upvalues: u534 (copy)
    local v537 = 0;

    if p535.Misc and p535.Misc[u534] then
        v537 = v537 + p535.Misc[u534];
    end;

    return v537;
end;

v26.ACHIEVEMENT_55009 = v533;
local v538 = {
    Name = "Miner I",
    Description = "Successfully mine <Amount> Camellite Deposits",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 3,
    Requirements = {}
};
local u539 = "Camellite_Mined";

function v538.ProgressCallback(p540, p541) -- Line: 94
    -- upvalues: u539 (copy)
    local v542 = 0;

    if p540.Misc and p540.Misc[u539] then
        v542 = v542 + p540.Misc[u539];
    end;

    return v542;
end;

v26.ACHIEVEMENT_55010 = v538;
local v543 = {
    Name = "Miner II",
    Description = "Successfully mine <Amount> Camellite Deposits",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 4,
    Requirements = {}
};
local u544 = "Camellite_Mined";

function v543.ProgressCallback(p545, p546) -- Line: 94
    -- upvalues: u544 (copy)
    local v547 = 0;

    if p545.Misc and p545.Misc[u544] then
        v547 = v547 + p545.Misc[u544];
    end;

    return v547;
end;

v26.ACHIEVEMENT_55011 = v543;
local v548 = {
    Name = "Miner III",
    Description = "Successfully mine <Amount> Camellite Deposits",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u549 = "Camellite_Mined";

function v548.ProgressCallback(p550, p551) -- Line: 94
    -- upvalues: u549 (copy)
    local v552 = 0;

    if p550.Misc and p550.Misc[u549] then
        v552 = v552 + p550.Misc[u549];
    end;

    return v552;
end;

v26.ACHIEVEMENT_55012 = v548;
local v553 = {
    Name = "Space Hazard",
    Description = "Die to Radiation in Space",
    Category = "Miscellaneous",
    Type = "Achievement",
    Rarity = 5,
    Requirements = {}
};
local u554 = "RadiationDeath";

function v553.ProgressCallback(p555, p556) -- Line: 94
    -- upvalues: u554 (copy)
    local v557 = 0;

    if p555.Misc and p555.Misc[u554] then
        v557 = v557 + p555.Misc[u554];
    end;

    return v557;
end;

v26.ACHIEVEMENT_55013 = v553;

return v26;