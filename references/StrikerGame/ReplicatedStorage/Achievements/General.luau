 

 

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
    Name = "Chemical Reaction",
    Description = "Use an awakening skill while the ball is midair after being passed to by a teammate.",
    codename = "chem_react",
    Reward = {
        coins = 500
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
    Name = "Clean Sheet",
    Description = "Win 5-0 whilst playing as GK (you have to be GK from the start of the round.)",
    codename = "gk_warrior",
    Reward = {
        coins = 1500
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
    Name = "Egoist",
    Description = "Obtain MVP 50 times",
    codename = "mvp_get",
    Requirement = 50,
    Reward = {
        stylecoins = 500
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

local v10 = {
    Name = "Ultimate Striker",
    Description = "Obtain MVP 100 times",
    codename = "mvp_get_longer",
    Requirement = 100,
    Reward = {
        stylecoins = 1000
    }
};
local v11;

if v10.Name then
    v11 = {
        Name = v10.Name
    };

    for i, v in v10 do
        if i ~= "Name" then
            v11[i] = v;
        end;
    end;
else
    v11 = nil;
end;

local v12 = {
    Name = "Half-Baked",
    Description = "Land the special \"You will never surpass me\" interaction on a Rin",
    codename = "rin_will_Lose",
    Reward = {
        stylecoins = 500
    }
};
local v13;

if v12.Name then
    v13 = {
        Name = v12.Name
    };

    for i, v in v12 do
        if i ~= "Name" then
            v13[i] = v;
        end;
    end;
else
    v13 = nil;
end;

local v14 = {
    Name = "Hat Trick",
    Description = "Score three goals in a row",
    codename = "Hat_Trick",
    Reward = {
        stylecoins = 500,
        coins = 500
    }
};
local v15;

if v14.Name then
    v15 = {
        Name = v14.Name
    };

    for i, v in v14 do
        if i ~= "Name" then
            v15[i] = v;
        end;
    end;
else
    v15 = nil;
end;

local v16 = {
    Name = "Goal ANY%",
    Description = "Score within 10 seconds of a match starting",
    codename = "the_fastest_goal_of_all_time",
    Reward = {
        stylecoins = 500,
        coins = 500
    }
};
local v17;

if v16.Name then
    v17 = {
        Name = v16.Name
    };

    for i, v in v16 do
        if i ~= "Name" then
            v17[i] = v;
        end;
    end;
else
    v17 = nil;
end;

local v18 = {
    Name = "Devour",
    Description = "Intercept a teammate\'s shot and score within 5 seconds",
    codename = "ez_ball_stealer",
    Reward = {
        stylecoins = 250,
        coins = 250
    }
};
local v19;

if v18.Name then
    v19 = {
        Name = v18.Name
    };

    for i, v in v18 do
        if i ~= "Name" then
            v19[i] = v;
        end;
    end;
else
    v19 = nil;
end;

local v20 = {
    Name = "Chemical Reaction: The Sequel",
    Description = "Control a magic pass and land the special control variant in Nagi\'s Flow",
    codename = "thank you sae itoshi",
    Reward = {
        stylecoins = 500
    }
};
local v21;

if v20.Name then
    v21 = {
        Name = v20.Name
    };

    for i, v in v20 do
        if i ~= "Name" then
            v21[i] = v;
        end;
    end;
else
    v21 = nil;
end;

local v22 = {
    Name = "VIP Seat",
    Description = "Land \"Kill.\" on an opponent using Isagi.",
    codename = "ISAGI LEAVE ME ALONE",
    Reward = {
        coins = 750
    }
};
local v23;

if v22.Name then
    v23 = {
        Name = v22.Name
    };

    for i, v in v22 do
        if i ~= "Name" then
            v23[i] = v;
        end;
    end;
else
    v23 = nil;
end;

local v24 = {
    Name = "Japan Football Union",
    Description = "Meet a Tester. (unobtainable)",
    codename = "NOOB IN MY LOBBY",
    Reward = {
        stylecoins = 500
    }
};
local v25;

if v24.Name then
    v25 = {
        Name = v24.Name
    };

    for i, v in v24 do
        if i ~= "Name" then
            v25[i] = v;
        end;
    end;
else
    v25 = nil;
end;

local v26 = {
    Name = "Anri Teieri",
    Description = "Meet a Developer. (unobtainable)",
    codename = "PRO IN MY LOBBY",
    Reward = {
        stylecoins = 1000
    }
};
local v27;

if v26.Name then
    v27 = {
        Name = v26.Name
    };

    for i, v in v26 do
        if i ~= "Name" then
            v27[i] = v;
        end;
    end;
else
    v27 = nil;
end;

local v28 = {
    Name = "Jinpachi Ego",
    Description = "Meet a Manager. (unobtainable)",
    codename = "SORRATANA4 IN MY BEGINNER LOBBY",
    Reward = {
        stylecoins = 6767
    }
};
local v29;

if v28.Name then
    v29 = {
        Name = v28.Name
    };

    for i, v in v28 do
        if i ~= "Name" then
            v29[i] = v;
        end;
    end;
else
    v29 = nil;
end;

local v30 = {
    Name = "You Suck",
    Description = "Miss any counter 30 times.",
    codename = "Counter Misser Noobie",
    Requirement = 30,
    Reward = {
        coins = 500
    }
};
local v31;

if v30.Name then
    v31 = {
        Name = v30.Name
    };

    for i, v in v30 do
        if i ~= "Name" then
            v31[i] = v;
        end;
    end;
else
    v31 = nil;
end;

local v32 = {
    Name = "With My Genes",
    Description = "Score using Shidou\'s Formless bicycle kick from a perfect pass at point blank range",
    codename = "Shidou Pro Style",
    Reward = {
        coins = 500
    }
};
local v33;

if v32.Name then
    v33 = {
        Name = v32.Name
    };

    for i, v in v32 do
        if i ~= "Name" then
            v33[i] = v;
        end;
    end;
else
    v33 = nil;
end;

local v34 = {
    Name = "LUCK",
    Description = "Score the winning goal using MY DIRECT SHOT when the ball is airborne and going towards you",
    codename = "true isagi style",
    Reward = {
        coins = 500
    }
};
local v35;

if v34.Name then
    v35 = {
        Name = v34.Name
    };

    for i, v in v34 do
        if i ~= "Name" then
            v35[i] = v;
        end;
    end;
else
    v35 = nil;
end;

v3[1], v3[2], v3[3], v3[4], v3[5], v3[6], v3[7], v3[8], v3[9], v3[10], v3[11], v3[12], v3[13], v3[14], v3[15], v3[16] = v5, v7, v9, v11, v13, v15, v17, v19, v21, v23, v25, v27, v29, v31, v33, v35;
local v36 = {
    Name = "Wow, someone actually uses this...?",
    Description = "Steal a ball with Dobermann Charge",
    codename = "dobermann bark",
    Reward = {
        coins = 500
    }
};
local v37;

if v36.Name then
    v37 = {
        Name = v36.Name
    };

    for i, v in v36 do
        if i ~= "Name" then
            v37[i] = v;
        end;
    end;
else
    v37 = nil;
end;

local v38 = {
    Name = "Ultimate Egoist",
    Description = "Awaken Flow three times in one match",
    codename = "flow god",
    Reward = {
        coins = 500
    }
};
local v39;

if v38.Name then
    v39 = {
        Name = v38.Name
    };

    for i, v in v38 do
        if i ~= "Name" then
            v39[i] = v;
        end;
    end;
else
    v39 = nil;
end;

local v40 = {
    Name = "Collector",
    Description = "Obtain every free style, MVP Animation, Emote and Title in game.",
    codename = "what a collector",
    Reward = {
        stylecoins = 1500
    }
};
local v41;

if v40.Name then
    v41 = {
        Name = v40.Name
    };

    for i, v in v40 do
        if i ~= "Name" then
            v41[i] = v;
        end;
    end;
else
    v41 = nil;
end;

v3[17], v3[18], v3[19], v3[20] = v37, v39, v41, CreateAchievement({
    Name = "Awakened Prodigy",
    Description = "Land Fake Volley four times in a row before then shooting and scoring.",
    codename = "bro is WAKE",
    Reward = {
        stylecoins = 1000
    }
});

return v3;