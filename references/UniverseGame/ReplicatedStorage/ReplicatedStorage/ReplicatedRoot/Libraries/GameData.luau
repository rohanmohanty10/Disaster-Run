  

 

local TableUtil = require(game.ReplicatedStorage.ReplicatedRoot.Libraries.Utility.TableUtil);
local v1 = {
    Live = {
        GameId = 1782832995,
        Flags = {},
        Places = {
            MainGame = {
                PlaceId = 6846458508,
                Type = "Gameplay"
            },
            Gamemodes = {
                PlaceId = 8023712967,
                Type = "Gameplay"
            },
            Arena = {
                PlaceId = 94960960966233,
                Type = "Gameplay"
            }
        }
    },
    TestPlaceA = {
        GameId = 1900951801,
        Flags = {
            IsTesting = true,
            IsPublicTesting = false,
            EnableAttackPriority = true,
            UseNewCounter = false
        },
        Places = {
            TestPlace = {
                PlaceId = 9690974327,
                Type = "Gameplay"
            },
            Gamemodes = {
                PlaceId = 15120891286,
                Type = "Gameplay"
            },
            Overworld = {
                PlaceId = 88260739977198,
                Type = "Gameplay"
            },
            Arena = {
                PlaceId = 96407804143331,
                Type = "Gameplay",
                Flags = {
                    Arena = true,
                    LoadProfile = true,
                    DisableParty = true,
                    DisableLab = true,
                    DisableFastTravel = true,
                    DisableRegionService = true,
                    DisableGamemodes = true
                }
            }
        }
    },
    TestPlaceB = {
        GameId = 2913165147,
        Flags = {
            IsTesting = true,
            IsPublicTesting = false
        },
        Places = {
            Overworld = {
                PlaceId = 10444059340,
                Type = "Gameplay"
            }
        }
    }
};
v1.Live.Places.Arena.Flags = v1.TestPlaceA.Places.Arena.Flags;
local v2 = {
    Unknown = {
        Packages = {
            Core = true,
            Gameplay = true,
            Gameplay_Content = true
        }
    },
    Menu = {
        Packages = {
            Core = true
        }
    },
    Gameplay = {
        Packages = {
            Core = true,
            Gameplay = true,
            Gameplay_Content = true
        }
    }
};

for i, v in pairs(v1) do
    v.Name = i;

    for i2, v3 in pairs(v.Places) do
        v3.Name = i2;
        local v4 = v2[v3.Type or "Unknown"];

        if v4 ~= nil then
            local v5 = TableUtil.Reconcile(v3, v4);
            v.Places[i2] = v5;
        end;
    end;
end;

return {
    Games = v1,
    PlaceTypes = v2
};