 
 

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
    Name = "Eat ####, LOSERS!",
    Description = "Score a goal with Kaiser Impact: Beinschuss",
    codename = "DONT U SWEAR AT ME KAISER",
    Reward = {
        stylecoins = 500
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

v3[1], v3[2] = v5, CreateAchievement({
    Name = "Excuse me!",
    Description = "Use the air awakening to steal it from your teammate",
    codename = "DONT U steal from ME KAISER",
    Reward = {
        stylecoins = 350
    }
});

return v3;