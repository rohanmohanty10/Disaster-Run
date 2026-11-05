  

 

local u1 = {
    Bosses = {
        ["The Hunter"] = {
            Requirements = {
                UCoins = 250000,
                Items = {
                    ITEM_4 = 1,
                    ITEM_41 = 1
                }
            }
        },
        ["Josuke Higashikata"] = {
            Requirements = {
                UCoins = 100000,
                Items = {
                    ITEM_1 = 2
                }
            }
        },
        Diavolo = {
            Requirements = {
                UCoins = 250000,
                Items = {
                    ITEM_1 = 5
                }
            }
        },
        Shadow = {
            SecondConfirmationMessage = "Are you <font color=\"#ff7f7f\">ABSOLUTELY</font> sure you want to spawn Shadow?\nYou can only get Shadow if you have Bur\'s quest active, NOT NITRON\'S.",
            Requirements = {
                UCoins = 1000000,
                Items = {
                    ITEM_532 = 1
                }
            }
        },
        Dio = {
            Requirements = {
                UCoins = 250000
            }
        },
        Reaper = {
            Requirements = {
                UCoins = 250000,
                Items = {
                    ITEM_5 = 1
                }
            }
        },
        ["Minos Prime"] = {
            Requirements = {
                UCoins = 250000
            }
        },
        ["Hamon Trainer"] = {
            Requirements = {
                UCoins = 100000,
                Items = {
                    ITEM_61 = 1
                }
            }
        },
        ["Joseph Joestar"] = {
            Requirements = {
                UCoins = 250000,
                Items = {
                    ITEM_71 = 1
                }
            }
        },
        ["Jonathan Joestar"] = {
            Requirements = {
                UCoins = 250000,
                Items = {
                    ITEM_64 = 1
                }
            }
        },
        ["Dio Brando"] = {
            Requirements = {
                UCoins = 1000000,
                Items = {
                    ITEM_75 = 1
                }
            }
        },
        Sanji = {
            Requirements = {
                UCoins = 300000,
                Items = {
                    ITEM_94 = 1
                }
            }
        },
        Homelander = {
            Requirements = {
                UCoins = 2500000
            }
        },
        ["Shadow Assassin"] = {
            Requirements = {
                UCoins = 250000,
                Items = {
                    ITEM_4 = 1,
                    ITEM_530 = 1
                }
            }
        },
        ["Skibidi Noobie"] = {
            Requirements = {
                UCoins = 300000,
                Items = {
                    ITEM_23 = 3
                }
            }
        }
    },
    Spawners = {
        ["Dark Souls"] = {
            SpawnChance = 1,
            SpawnTime = 1800,
            Bosses = { "Shadow", "Skibidi Noobie", "Shadow Assassin", "Sanji", "Dio Brando", "Jonathan Joestar", "Joseph Joestar", "Hamon Trainer", "Minos Prime", "Reaper", "Dio", "Homelander", "The Hunter", "Diavolo", "Josuke Higashikata" }
        }
    }
};

function u1.GetBossData(p2) -- Line: 155
    -- upvalues: u1 (copy)
    return u1.Bosses[p2];
end;

function u1.GetRequirements(p3) -- Line: 159
    -- upvalues: u1 (copy)
    return u1.Bosses[p3] and u1.Bosses[p3].Requirements;
end;

function u1.GetSpawner(p4) -- Line: 163
    -- upvalues: u1 (copy)
    return u1.Spawners[p4];
end;

function u1.GetBosses(p5) -- Line: 167
    -- upvalues: u1 (copy)
    if u1.Spawners[p5] then
        return u1.Spawners[p5].Bosses;
    end;
end;

for i, v in u1.Bosses do
    if v.Testing and game.GameId ~= 1900951801 then
        u1.Bosses[i] = nil;
    end;
end;

return u1;