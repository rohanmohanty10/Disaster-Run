 
 

local function CreateAchievement(p1) -- Line: 1
    if p1.Name then
        local v2 = {
            Name = p1.Name
        };

        for i, v in p1 do
            if i ~= "Name" then
                v2[i] = v;
            end;
        end;

        return v2;
    end;
end;

local v3 = {};
local v4 = {
    Name = "He doesn\'t have the angle, good.",
    Description = "Score with the autogoal.",
    codename = "sae does a cool trick",
    Reward = {
        stylecoins = 400
    }
};
local v5;

if v4.Name then
    v5 = {
        Name = v4.Name
    };

    for i, v in v4 do
        if i ~= "Name" then
            v5[i] = v;
        end;
    end;
else
    v5 = nil;
end;

local v6 = {
    Name = "You will never surpass me.",
    Description = "Score by doing Cross-Elastico on a Rin",
    codename = "rin u stinky",
    Reward = {
        coins = 750
    }
};
local v7;

if v6.Name then
    v7 = {
        Name = v6.Name
    };

    for i, v in v6 do
        if i ~= "Name" then
            v7[i] = v;
        end;
    end;
else
    v7 = nil;
end;

v3[1], v3[2], v3[3] = v5, v7, CreateAchievement({
    Name = "One-Shot Match",
    Description = "Use flow during Overtime as Sae",
    codename = "sae goes super saying",
    Reward = {
        coins = 500,
        stylecoins = 250
    }
});

return v3;