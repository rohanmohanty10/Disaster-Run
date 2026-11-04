 
 

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
    Name = "The King is ME!!",
    Description = "Score with more than three enemy players close you",
    codename = "barou godlike gamer",
    Reward = {
        coins = 500,
        stylecoins = 1000
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
    Name = "I can\'t tell who\'s shooting...",
    Description = "Score with Stealth Shot",
    codename = "evil scary",
    Reward = {
        stylecoins = 500
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
    Name = "Barou Barou Kyun!",
    Description = "barou wyd bro its overtime we are going to Lose wyd Idiot.",
    codename = "guess",
    Reward = {
        stylecoins = 1000
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
    Name = "I quit this lousy job!",
    Description = "Use flow during Overtime as Barou",
    codename = "barou omg bro its overtime we are going to win good job goat!",
    Reward = {
        coins = 500,
        stylecoins = 250
    }
});

return v3;