 

 

local v1 = {
    [5] = "FirstSteps",
    [10] = "QuickFeet",
    [15] = "CornerArtist",
    [20] = "Untouchable",
    [25] = "ValleyVeteran",
    [30] = "ValleyElite"
};
local v2 = {
    [10] = "NightRunner",
    [20] = "CrownChaser",
    [30] = "ValleyRoyalty"
};
local v3 = {};

for i = 1, 30 do
    v3[i] = {
        Free = {
            Key = "free_" .. i,
            Gems = i % 5 == 0 and 50 or 15,
            Badge = v1[i]
        },
        Premium = {
            Key = "premium_" .. i,
            Gems = i % 5 == 0 and 100 or 35,
            Coins = i % 5 == 0 and 150 or 0,
            Badge = v2[i]
        }
    };
    local _ = i;
end;

for i, v in {
    Free = {
        [6] = "SnappySkipping",
        [8] = "AnimePose",
        [10] = "IdleDance",
        [20] = "WavyGrooves",
        [22] = "Jumpstyle",
        [30] = "SkeletonGrooves"
    },
    Premium = {
        [2] = "WibblyWobbly",
        [5] = "LoseIt",
        [7] = "Skeleton",
        [10] = "Shuffle",
        [11] = "BTSDance",
        [14] = "Flexer",
        [21] = "Moongazer",
        [24] = "ElectroShuffle",
        [28] = "CatDance"
    }
} do
    local v4 = i;

    for i2, v5 in v do
        v3[i2][v4].EmoteId = v5;
    end;
end;

v3[15].Premium.SkinId = "VipersFang";
v3[20].Premium.SkinId = "Bloodthorn";
v3[20].Premium.KnifeIcon = "rbxassetid://88199896269875";
v3[25].Premium.SkinId = "Voidspine";
v3[30].Premium.SkinId = "IceCreamDagger";

for i, v in {
    [3] = 1,
    [6] = 1,
    [9] = 1,
    [12] = 1,
    [15] = 1,
    [18] = 2,
    [21] = 2,
    [24] = 2,
    [27] = 2,
    [30] = 2
} do
    v3[i].Free.Spins = v;
end;

for i, v in {
    [2] = 1,
    [5] = 1,
    [8] = 1,
    [11] = 2,
    [14] = 2,
    [17] = 2,
    [20] = 3,
    [23] = 3,
    [26] = 4,
    [29] = 6
} do
    v3[i].Premium.Spins = v;
end;

return v3;