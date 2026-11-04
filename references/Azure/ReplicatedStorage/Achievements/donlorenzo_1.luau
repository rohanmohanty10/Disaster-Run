 
 

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
    Name = "Ya-hoo!",
    Description = "Block an Insta-Kill Flash with your awakening / Defensive Stance",
    codename = "take this kaiser....",
    Reward = {
        stylecoins = 750
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
    Name = "Yo, Micheal.",
    Description = "Use Yo Michael on a Kaiser",
    codename = "mikael u will Lose",
    Reward = {
        stylecoins = 250
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

local v8 = {
    Name = "Really bro...",
    Description = "Fail Yo Michael",
    codename = "wow ur trash",
    Reward = {
        coins = 500
    }
};
local v9;

if v8.Name then
    v9 = {
        Name = v8.Name
    };

    for i, v in v8 do
        if i ~= "Name" then
            v9[i] = v;
        end;
    end;
else
    v9 = nil;
end;

v3[1], v3[2], v3[3], v3[4] = v5, v7, v9, CreateAchievement({
    Name = "Feeding time, okay?",
    Description = "Land the Barou Chemical Reaction",
    codename = "barou gets w eats",
    Reward = {
        stylecoins = 750
    }
});

return v3;