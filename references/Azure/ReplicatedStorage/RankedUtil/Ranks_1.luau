 
 

local u1 = {
    Challengers = 25,
    StreakStart = 3,
    StreakBonus = { 2, 4, 6, 8, 10, 12, 14, 16, 18, 20 }
};
local u11 = {
    GetColor = function(p2) -- Line: 34, Name: GetColor
        local v3 = {};

        for _, v in ipairs(p2.Color) do
            table.insert(v3, ColorSequenceKeypoint.new(v[1], v[2]));
        end;

        return ColorSequence.new(v3);
    end,

    BlendedColorSequence = function(p4, p5) -- Line: 42, Name: BlendedColorSequence
        local Keypoints = p4:GetColor().Keypoints;
        local Keypoints2 = p5:GetColor().Keypoints;
        local v6 = {};

        for i, v in ipairs(Keypoints) do
            table.insert(v6, ColorSequenceKeypoint.new((i - 1) / (#Keypoints - 1 + 1) * 0.5, v.Value));
        end;

        for i, v in ipairs(Keypoints2) do
            table.insert(v6, ColorSequenceKeypoint.new(0.5 + i / (#Keypoints2 - 1 + 1) * 0.5, v.Value));
        end;

        return ColorSequence.new(v6);
    end,

    Next = function(p7) -- Line: 59, Name: Next
        -- upvalues: u1 (copy)
        local v8 = p7.Index + 1;
        local v9 = u1.RankInfo[v8];

        if v9 then
            return u1.FromRankData(v9, v8);
        end;
    end,

    IsMax = function(p10) -- Line: 68, Name: IsMax
        -- upvalues: u1 (copy)
        return p10.Index == #u1.RankInfo;
    end
};
u1.RankInfo = {};
u1.RankInfo = {
    {
        Name = "Bronze",
        MinElo = 0,
        MaxElo = 999,
        WinGain = 75,
        LossAmount = -35,
        Icon = "rbxassetid://107230166143702",
        Color = {
            { 0, Color3.fromRGB(170, 85, 0) },
            { 1, Color3.fromRGB(115, 58, 0) }
        }
    },
    {
        Name = "Silver",
        MinElo = 1000,
        MaxElo = 1999,
        WinGain = 70,
        LossAmount = -35,
        Icon = "rbxassetid://92428465912855",
        Color = {
            { 0, Color3.fromRGB(192, 192, 192) },
            { 1, Color3.fromRGB(150, 150, 150) }
        }
    },
    {
        Name = "Gold",
        MinElo = 2000,
        MaxElo = 2999,
        WinGain = 65,
        LossAmount = -40,
        EloDivisionAbove = true,
        Icon = "rbxassetid://103342805687978",
        Color = {
            { 0, Color3.fromRGB(255, 170, 0) },
            { 1, Color3.fromRGB(255, 255, 0) }
        }
    },
    {
        Name = "Platinum",
        MinElo = 3000,
        MaxElo = 3999,
        WinGain = 50,
        LossAmount = -40,
        Icon = "rbxassetid://96112608003617",
        Color = {
            { 0, Color3.fromRGB(0, 255, 255) },
            { 1, Color3.fromRGB(216, 252, 255) }
        }
    },
    {
        Name = "Diamond",
        MinElo = 4000,
        MaxElo = 4999,
        WinGain = 50,
        LossAmount = -40,
        Icon = "rbxassetid://119823221050566",
        Color = {
            { 0, Color3.fromHex("#0099ff") },
            { 1, Color3.fromRGB(105, 78, 255) }
        }
    },
    {
        Name = "Master",
        MinElo = 5000,
        MaxElo = 5999,
        WinGain = 50,
        LossAmount = -40,
        EloDivisionAbove = true,
        Icon = "rbxassetid://82960562346996",
        Color = {
            { 0, Color3.fromRGB(255, 85, 255) },
            { 1, Color3.fromRGB(170, 85, 255) }
        }
    },
    {
        Name = "Grandmaster",
        MinElo = 6000,
        MaxElo = 6999,
        WinGain = 35,
        LossAmount = -40,
        Icon = "rbxassetid://120637516915280",
        Color = {
            { 0, Color3.fromRGB(255, 0, 0) },
            { 1, Color3.fromRGB(255, 64, 64) }
        }
    },
    {
        Name = "Challenger",
        MinElo = 7000,
        MaxElo = (1 / 0),
        WinGain = 35,
        LossAmount = -40,
        Icon = "rbxassetid://82671622949313",
        Color = {
            { 0, Color3.fromRGB(255, 0, 0) },
            { 1, Color3.fromRGB(255, 165, 0) }
        }
    }
};

function u1.FromRankData(p12: table, p13: number) -- Line: 151
    -- upvalues: u11 (copy)
    return setmetatable({
        Index = p13,
        GetColor = u11.GetColor,
        BlendedColorSequence = u11.BlendedColorSequence,
        Next = u11.Next,
        IsMax = u11.IsMax
    }, {
        __index = p12
    });
end;

function u1.ReturnRank(p14: number, p15: userdata?) -- Line: 162
    -- upvalues: u1 (copy)
    local v16 = u1.RankInfo[1];
    local v17 = 1;

    for i = 1, #u1.RankInfo do
        local v18 = u1.RankInfo[i];

        if v18.MinElo > p14 then
            break;
        end;

        v16 = v18;
        v17 = i;
        local v19 = v17;
        local v20 = v17;
        v17 = v19;
        v20 = v19;
    end;

    if v17 == 8 and not (p15 and p15:GetAttribute("MasterStriker")) then
        v16 = u1.RankInfo[7];
        v17 = 7;
    end;

    return u1.FromRankData(v16, v17);
end;

function u1.GetEloDelta(p21: number) -- Line: 181
    -- upvalues: u1 (copy)
    local v22 = u1.ReturnRank(p21);

    return v22.WinGain, v22.LossAmount;
end;

function u1.GetDivisionPool(p23: number) -- Line: 186
    -- upvalues: u1 (copy)
    local v24 = 1;

    for i = 1, #u1.RankInfo do
        local v25 = u1.RankInfo[i];

        if v25.MinElo > p23 then
            break;
        end;

        local v26;

        if v25.EloDivisionAbove and v25.MaxElo < p23 then
            v24 = v24 + 1;
            v26 = i;
        else
            v26 = i;
        end;
    end;

    return v24;
end;

return u1;