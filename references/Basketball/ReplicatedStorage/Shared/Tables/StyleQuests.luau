 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Packages.Knit);

local function CreateTargetQuest(p1: string, p2: string, u3: string, u4) -- Line: 18
    return {
        Name = p1,
        Description = p2,

        CanComplete = function(p5) -- Line: 29, Name: CanComplete
            -- upvalues: u3 (copy)
            return p5.Metadata[u3] >= p5.Metadata.Target;
        end,

        InitialMetadata = function() -- Line: 33, Name: InitialMetadata
            -- upvalues: u3 (copy), u4 (copy)
            return {
                [u3] = 0,
                Index = u3,
                Target = u4
            };
        end
    };
end;

return {
    General = {
        CreateTargetQuest("The Difference Maker.", "Obtain MVP 50 times", "MVP", 50),
        CreateTargetQuest("MVP Material", "Obtain MVP 100 times", "MVP", 100),
        CreateTargetQuest("Can\'t Miss.", "Score five shots in a row", "Shots in a row", 5),
        CreateTargetQuest("Blink and You\'ll Miss It.", "Score within ten second of the match starting", "10 seconds", 1),
        CreateTargetQuest("Not In My House.", "Block 50 shots", "Blocks", 50),
        (function(p6: string, p7: string, u8: string, u9: table) -- Line: 43, Name: CreateObtainQuest
            return {
                Name = p6,
                Description = p7,

                CanComplete = function(p10) -- Line: 54, Name: CanComplete
                    -- upvalues: u8 (copy)
                    return #p10.Metadata[u8] >= #p10.Metadata.Target;
                end,

                InitialMetadata = function() -- Line: 58, Name: InitialMetadata
                    -- upvalues: u8 (copy), u9 (copy)
                    return {
                        [u8] = {},
                        Index = u8,
                        Target = u9
                    };
                end
            };
        end)(
            "Jack of All Trades.",
            "Obtain every Non-Limited Styles in the game",
            "Styles",
            { "Sniper", "Phantom", "Clutch", "Star", "Ace", "Giant", "Flash", "Playmaker", "Jackpot", "Chuck", "Lock", "Copycat", "Emperor", "Quick", "Fetch", "Gold", "BasketballUnc", "Silver", "Thief", "Izure" }
        )
    },
    Ninja = {
        CreateTargetQuest("MY SQUAD. MY NINJA WAY.", "Use \"Clone Blitz\" 15 times.", "Clone Blitz", 15),
        CreateTargetQuest("HOKAGE LEVEL THREAT.", "Use \"Tail Dribble\" to get past 15 opponents.", "Tail Dribble", 15),
        CreateTargetQuest(
            "ARMS BACK. ANKLES GONE.",
            "Steal the ball after using \"NINJA RUN\" down the court 10 times.",
            "NINJA RUN",
            10
        ),
        CreateTargetQuest(
            "THE SEAL IS BROKEN.",
            "Use \"Shadow Launch\" after \"Shadow Relay\" 15 times.",
            "Shadow Launch",
            15
        ),
        CreateTargetQuest("UNLEASH THE NINE TAILS.", "Steal the ball using \"Tail Bomb\" 5 times.", "Tail Bomb", 5),
        CreateTargetQuest(
            "THI ISN\'T MY FINAL EPISODE.",
            "Win 5 matches after awakening while your team is losing.",
            "Win From Losing Awakening",
            5
        )
    }
};