 

 

local u1 = pcall;
local u2 = coroutine;
local l__resume__1 = u2.resume;
local l__create__2 = u2.create;
local l__delay__3 = task.delay;
local _ = task.spawn;
local l__wait__4 = task.wait;
local l__ServerStorage__5 = game:GetService("ServerStorage");
local l__ReplicatedStorage__6 = game:GetService("ReplicatedStorage");
local l__TweenService__7 = game:GetService("TweenService");
local l__CollectionService__8 = game:GetService("CollectionService");
local l__HttpService__9 = game:GetService("HttpService");
local l__MarketplaceService__10 = game:GetService("MarketplaceService");
local l__RunService__11 = game:GetService("RunService");
local l__Debris2__12 = require(l__ReplicatedStorage__6:WaitForChild("Modules"):WaitForChild("Debris2"));
game:GetService("PhysicsService");
local l__IgnoreInstances__13 = workspace:WaitForChild("IgnoreInstances");
local l__UserInputService__14 = game:GetService("UserInputService");
local l__Weighted__15 = require(l__ReplicatedStorage__6.Modules.Weighted);
local l__ClientFX__16 = l__ReplicatedStorage__6:WaitForChild("ClientFX");
l__ReplicatedStorage__6:WaitForChild("Sounds");
l__ReplicatedStorage__6:WaitForChild("Effects");
l__ReplicatedStorage__6:WaitForChild("Objects");
local l__Anims__17 = l__ReplicatedStorage__6:WaitForChild("Anims");
local l__RegionMod__18 = require(l__ReplicatedStorage__6:WaitForChild("Modules"):WaitForChild("RegionMod"));
local l__Players__19 = game:GetService("Players");
local u3 = #game.ServerStorage:GetChildren() == 0;
local u4 = {
    ItemShop = {
        ["1x Mysterious Arrow"] = {
            Item = "Mysterious Arrow",
            Amount = 1,
            Price = 750
        },
        ["5x Mysterious Arrow"] = {
            Item = "Mysterious Arrow",
            Amount = 5,
            Price = 3375
        },
        ["1x Lucky Arrow"] = {
            Item = "Lucky Arrow",
            Amount = 1,
            Price = 75000
        },
        ["1x Rokakaka"] = {
            Item = "Rokakaka",
            Amount = 1,
            Price = 2500
        },
        ["5x Rokakaka"] = {
            Item = "Rokakaka",
            Amount = 5,
            Price = 11250
        },
        ["1x Pure Rokakaka"] = {
            Item = "Pure Rokakaka",
            Amount = 1,
            Price = 4000
        },
        ["1x Rib Cage of the Saint\'s Corpse"] = {
            Item = "Rib Cage of The Saint\'s Corpse",
            Amount = 1,
            Price = 3500
        },
        ["5x Rib Cage of the Saint\'s Corpse"] = {
            Item = "Rib Cage of The Saint\'s Corpse",
            Amount = 5,
            Price = 15750
        },
        ["1x Left Arm of the Saint\'s Corpse"] = {
            Item = "Left Arm of The Saint\'s Corpse",
            Amount = 1,
            Price = 15000
        },
        ["1x Pelvis of The Saint\'s Corpse"] = {
            Item = "Pelvis of The Saint\'s Corpse",
            Amount = 1,
            Price = 45000
        },
        ["1x Heart of The Saint\'s Corpse"] = {
            Item = "Heart of The Saint\'s Corpse",
            Amount = 1,
            Price = 45000
        },
        ["1x DIO\'s Diary"] = {
            Item = "Dio\'s Diary",
            Amount = 1,
            Price = 20000
        }
    },
    CurrencyShop = {
        [2626107996] = {
            Name = "10,000 SG Bucks",
            Type = "Money",
            Amount = 10000,
            LayoutOrder = 11
        },
        [2626115284] = {
            Name = "50,000 SG Bucks",
            Type = "Money",
            Amount = 50000,
            LayoutOrder = 12
        },
        [2626177791] = {
            Name = "100,000 SG Bucks",
            Type = "Money",
            Amount = 100000,
            LayoutOrder = 13
        },
        [2626198890] = {
            Name = "250,000 SG Bucks",
            Type = "Money",
            Amount = 250000,
            LayoutOrder = 14
        },
        [2626494173] = {
            Name = "500,000 SG Bucks",
            Type = "Money",
            Amount = 500000,
            LayoutOrder = 15
        },
        [2626554507] = {
            Name = "750,000 SG Bucks",
            Type = "Money",
            Amount = 750000,
            LayoutOrder = 16
        },
        [2626938033] = {
            Name = "75 Gems",
            Type = "Gems",
            Amount = 75,
            LayoutOrder = 1
        },
        [2626952225] = {
            Name = "250 Gems",
            Type = "Gems",
            Amount = 250,
            LayoutOrder = 2
        },
        [2626967974] = {
            Name = "400 Gems",
            Type = "Gems",
            Amount = 400,
            LayoutOrder = 3
        },
        [2626975173] = {
            Name = "650 Gems",
            Type = "Gems",
            Amount = 650,
            LayoutOrder = 4
        },
        [2626983539] = {
            Name = "1000 Gems",
            Type = "Gems",
            Amount = 1000,
            LayoutOrder = 5
        }
    },
    Max_Finishers = 100,
    Random_Finisher = {
        Product_Id = 1891876901,
        Prices = {
            Robux = 49
        },
        Rarities = {
            {
                Rarity = "Common",
                Percent = 79
            },
            {
                Rarity = "Rare",
                Percent = 16
            },
            {
                Rarity = "Epic",
                Percent = 3.7
            },
            {
                Rarity = "Legendary",
                Percent = 1
            },
            {
                Rarity = "Mythical",
                Percent = 0.3
            }
        }
    },
    Rollable_Finishers = {}
};
for _, v5 in pairs(l__ReplicatedStorage__6.Modules:WaitForChild("VFX_Finishers"):GetChildren()) do
    if v5:GetAttribute("Rarity") then
        local l__Rollable_Finishers__20 = u4.Rollable_Finishers;
        local v6 = {
            Name = v5.Name,
            Rarity = v5:GetAttribute("Rarity")
        };
        table.insert(l__Rollable_Finishers__20, v6);
    end;
end;
function u4.LoadAnimation(...) --[[ Line: 120 ]]
    local v7 = ...;
    local l__Animator__21 = v7.Animator;
    local l__Animation__22 = v7.Animation;
    local l__Priority__23 = v7.Priority;
    local v8 = l__Animator__21:LoadAnimation(l__Animation__22);
    if l__Priority__23 then
        v8.Priority = l__Priority__23;
    end;
    if v7.Play then
        local v9 = typeof(v7.Play) == "table" and (v7.Play or {}) or {};
        v8:Play(v9.FadeIn);
        if v9.Speed then
            v8:AdjustSpeed(v9.Speed);
        end;
        if v9.TimePosition then
            v8.TimePosition = v9.TimePosition;
        end;
    end;
    return v8;
end;
u4.Months = {
    {
        Month = "January"
    },
    {
        Month = "February"
    },
    {
        Month = "March"
    },
    {
        Month = "April"
    },
    {
        Month = "May"
    },
    {
        Month = "June"
    },
    {
        Month = "July"
    },
    {
        Month = "August"
    },
    {
        Month = "September"
    },
    {
        Month = "October"
    },
    {
        Month = "November"
    },
    {
        Month = "December"
    }
};
u4.RankPlacementGames = 5;
u4.Rank_Monthly_Seasons = { 1, 5, 9 };
u4.RankLoot_MaxProgress = 20;
u4.Max_RankLoot_Inventory = 500;
local function u18(p10, ...) --[[ Line: 201 ]]
    -- upvalues: l__ClientFX__16 (copy), u4 (copy), l__ServerStorage__5 (copy)
    local v11 = ...;
    local l__Char__24 = p10.Char;
    local l__Root__25 = p10.Root;
    local l__Player__26 = p10.Player;
    l__ClientFX__16:FireAllClients("PlaySound", {
        Sound = "Common_Item_Pick",
        Origin = l__Root__25
    });
    local v12 = v11.Item or u4.ReturnRandomPercentile(v11.Percent).Name;
    local v13 = 0;
    local v14 = u4.DroppableItems[v12] and u4.DroppableItems[v12].Max or (u4.MaxItems[v12] and (u4.MaxItems[v12].Max or 99) or 99);
    if v14 and l__ServerStorage__5.PlayerData[l__Player__26.Name].InventoryGamepass.Value == "Has" then
        v14 = v14 * 2;
    end;
    for _, v15 in pairs(l__Player__26.Backpack:GetChildren()) do
        if v15.Name == v12 then
            v13 = v13 + 1;
        end;
    end;
    for _, v16 in pairs(l__Player__26.Character:GetChildren()) do
        if v16.Name == v12 then
            v13 = v13 + 1;
        end;
    end;
    if v13 < v14 then
        l__ServerStorage__5.Tools[v12]:Clone().Parent = l__Player__26.Backpack;
    else
        local v17 = v14 <= v13 and l__Char__24:FindFirstChild("RemoteEvent");
        if v17 then
            v17:FireClient(l__Player__26, "Message", {
                Text = "You can\'t have more than " .. v14 .. " " .. v12 .. "(s) in your inventory"
            });
        end;
    end;
end;
u4.RankLoot_Rarities = {
    Rarities = {
        {
            Rarity = "Common",
            Iron_Percent = 70,
            Bronze_Percent = 68.4,
            Silver_Percent = 67,
            Gold_Percent = 65.2,
            Platinum_Percent = 62.9,
            Diamond_Percent = 60.1,
            Crusader_Percent = 53.2,
            Requiem_Percent = 49.1,
            Ascended_Percent = 46.5,
            Loot = function(p19, ...) --[[ Name: Loot, Line 257 ]]
                -- upvalues: u18 (copy), u4 (copy)
                local _ = p19.Char;
                local _ = p19.Root;
                local _ = p19.Player;
                for _ = 1, 3 do
                    u18(p19, {
                        Percent = u4.SpawnableItems
                    });
                end;
            end
        },
        {
            Rarity = "Rare",
            Iron_Percent = 28.65,
            Bronze_Percent = 30,
            Silver_Percent = 31,
            Gold_Percent = 32,
            Platinum_Percent = 33,
            Diamond_Percent = 35,
            Crusader_Percent = 40,
            Requiem_Percent = 40,
            Ascended_Percent = 40,
            Loot = function(p20, ...) --[[ Name: Loot, Line 287 ]]
                -- upvalues: u18 (copy), u4 (copy)
                local _ = p20.Char;
                local _ = p20.Root;
                local l__Player__27 = p20.Player;
                u18(p20, {
                    Percent = u4.SBRItems
                });
                local l__Name__28 = u4.ReturnRandomPercentile(u4.SBRCosmeticChances).Name;
                local v21 = u4.ReturnCosmeticsInType(l__Name__28);
                local v22 = v21[math.random(1, #v21)];
                _G.Playerlist[l__Player__27.Name].AddCosmetics(v22);
            end
        },
        {
            Rarity = "Epic",
            Iron_Percent = 1,
            Bronze_Percent = 1.2,
            Silver_Percent = 1.5,
            Gold_Percent = 2,
            Platinum_Percent = 3,
            Diamond_Percent = 3.5,
            Crusader_Percent = 5,
            Requiem_Percent = 8,
            Ascended_Percent = 10,
            Loot = function(p23, ...) --[[ Name: Loot, Line 322 ]]
                -- upvalues: u18 (copy)
                local _ = p23.Char;
                local _ = p23.Root;
                local _ = p23.Player;
                p23:RandomFinisher();
                u18(p23, {
                    Item = "Lucky Arrow"
                });
            end
        },
        {
            Rarity = "Legendary",
            Iron_Percent = 0.3,
            Bronze_Percent = 0.4,
            Silver_Percent = 0.5,
            Gold_Percent = 0.7,
            Platinum_Percent = 1,
            Diamond_Percent = 1.2,
            Crusader_Percent = 1.5,
            Requiem_Percent = 2.5,
            Ascended_Percent = 3,
            Loot = function(p24, ...) --[[ Name: Loot, Line 353 ]]
                -- upvalues: u18 (copy)
                local _ = p24.Char;
                local _ = p24.Root;
                local _ = p24.Player;
                for _ = 1, 3 do
                    u18(p24, {
                        Item = "Lucky Arrow"
                    });
                end;
                u18(p24, {
                    Item = "Lucky Stone Mask"
                });
                p24:RandomFinisher();
            end
        },
        {
            Rarity = "Jackpot",
            Iron_Percent = 0.05,
            Bronze_Percent = 0.07,
            Silver_Percent = 0.09,
            Gold_Percent = 0.12,
            Platinum_Percent = 0.16,
            Diamond_Percent = 0.2,
            Crusader_Percent = 0.3,
            Requiem_Percent = 0.4,
            Ascended_Percent = 0.5,
            Loot = function(p25, ...) --[[ Name: Loot, Line 394 ]]
                -- upvalues: u18 (copy)
                local _ = p25.Char;
                local _ = p25.Root;
                local _ = p25.Player;
                for _ = 1, 5 do
                    u18(p25, {
                        Item = "Lucky Arrow"
                    });
                end;
                local v26 = {
                    "Stop Sign",
                    "Eye of The Saint\'s Corpse",
                    "Boxing Claws",
                    "Bone Gloves",
                    "Cursed Scythe",
                    "Scythe",
                    "Candy cane",
                    "Festive Gloves",
                    "Festive Blade",
                    "Candy Cane Sword",
                    "Candy Cane Blade",
                    "Festive Scythe",
                    "Cyber Scythe",
                    "Jingle Bell",
                    "Peppermint Ball",
                    "Gold Umbrella",
                    "Crystal Umbrella",
                    "Ice Umbrella"
                };
                u18(p25, {
                    Item = v26[math.random(#v26)]
                });
                p25:RandomFinisher();
            end
        }
    }
};
u4.Ranks = {
    [0] = {
        Rank = "Unranked",
        Icon = "rbxassetid://14017065092"
    },
    [1] = {
        Rank = "Iron",
        Icon = "rbxassetid://14017065092"
    },
    [2] = {
        Rank = "Bronze",
        Icon = "rbxassetid://14017065816"
    },
    [3] = {
        Rank = "Silver",
        Icon = "rbxassetid://14017064597"
    },
    [4] = {
        Rank = "Gold",
        Icon = "rbxassetid://14017065276"
    },
    [5] = {
        Rank = "Platinum",
        Icon = "rbxassetid://14017064955"
    },
    [6] = {
        Rank = "Diamond",
        Icon = "rbxassetid://14017065452"
    },
    [7] = {
        Rank = "Crusader",
        Icon = "rbxassetid://14017065609"
    },
    [8] = {
        Rank = "Requiem",
        Icon = "rbxassetid://14017064773"
    },
    [9] = {
        Rank = "Ascended",
        Icon = "rbxassetid://14017066103"
    }
};
u4.NameTypes = {
    Snow = {
        Name = "Snow"
    },
    Wood = {
        Name = "Wood"
    },
    Metal = {
        Name = "Metal"
    },
    Grass = {
        Name = "Grass"
    },
    Sand = {
        Name = "Sand"
    },
    Concrete = {
        Name = "Concrete"
    },
    Water = {
        Name = "Water"
    }
};
u4.FloorMaterials = {
    [Enum.Material.Grass] = {
        Name = "Grass"
    },
    [Enum.Material.Fabric] = {
        Name = "Grass"
    },
    [Enum.Material.Snow] = {
        Name = "Snow"
    },
    [Enum.Material.Glass] = {
        Name = "Glass"
    },
    [Enum.Material.Rock] = {
        Name = "Concrete"
    },
    [Enum.Material.Concrete] = {
        Name = "Concrete"
    },
    [Enum.Material.Ice] = {
        Name = "Concrete"
    },
    [Enum.Material.Foil] = {
        Name = "Concrete"
    },
    [Enum.Material.ForceField] = {
        Name = "Concrete"
    },
    [Enum.Material.Brick] = {
        Name = "Concrete"
    },
    [Enum.Material.Cobblestone] = {
        Name = "Concrete"
    },
    [Enum.Material.Concrete] = {
        Name = "Concrete"
    },
    [Enum.Material.Granite] = {
        Name = "Concrete"
    },
    [Enum.Material.Ice] = {
        Name = "Concrete"
    },
    [Enum.Material.Marble] = {
        Name = "Concrete"
    },
    [Enum.Material.Neon] = {
        Name = "Concrete"
    },
    [Enum.Material.Pebble] = {
        Name = "Concrete"
    },
    [Enum.Material.Plastic] = {
        Name = "Concrete"
    },
    [Enum.Material.Slate] = {
        Name = "Concrete"
    },
    [Enum.Material.SmoothPlastic] = {
        Name = "Concrete"
    },
    [Enum.Material.Wood] = {
        Name = "Wood"
    },
    [Enum.Material.WoodPlanks] = {
        Name = "Wood"
    },
    [Enum.Material.CorrodedMetal] = {
        Name = "Metal"
    },
    [Enum.Material.DiamondPlate] = {
        Name = "Metal"
    },
    [Enum.Material.Metal] = {
        Name = "Metal"
    },
    [Enum.Material.Water] = {
        Name = "Metal"
    }
};
u4.MBRAutoStart = 1200;
u4.Races = {
    Human = true,
    Vampire = true,
    Majin = {
        [19919175] = true,
        [75859777] = true,
        [2918021418] = true,
        [29876845] = true,
        [427348404] = true
    }
};
u4.PlaceIds = {
    [2809202155] = {
        GameType = "Main Game",
        PlaceType = "Main Game"
    },
    [4643697430] = {
        GameType = "Main Game",
        PlaceType = "MBR"
    },
    [5290796989] = {
        GameType = "Main Game",
        PlaceType = "1v1s Lobby"
    },
    [5290908008] = {
        GameType = "Main Game",
        PlaceType = "1v1s"
    },
    [5816891721] = {
        GameType = "Main Game",
        PlaceType = "2v2s Lobby"
    },
    [5818061503] = {
        GameType = "Main Game",
        PlaceType = "2v2s"
    },
    [12807820316] = {
        GameType = "Main Game",
        PlaceType = "Trade Hub"
    },
    [12807832128] = {
        GameType = "Main Game",
        PlaceType = "Trade Hub"
    },
    [4477488648] = {
        GameType = "Update Place",
        PlaceType = "Main Game"
    },
    [4572813082] = {
        GameType = "Update Place",
        PlaceType = "MBR"
    },
    [5290238956] = {
        GameType = "Update Place",
        PlaceType = "1v1s Lobby"
    },
    [5289574894] = {
        GameType = "Update Place",
        PlaceType = "1v1s"
    },
    [5816891721] = {
        GameType = "Update Place",
        PlaceType = "2v2s Lobby"
    },
    [5816901378] = {
        GameType = "Update Place",
        PlaceType = "2v2s"
    },
    [12660971624] = {
        GameType = "Update Place",
        PlaceType = "Trade Hub"
    },
    [12672580144] = {
        GameType = "Update Place",
        PlaceType = "Trade Hub"
    }
};
u4.SkillKeys = {
    ["Enum.KeyCode.E"] = "E",
    ["Enum.KeyCode.R"] = "R",
    ["Enum.KeyCode.T"] = "T",
    ["Enum.KeyCode.Y"] = "Y",
    ["Enum.KeyCode.U"] = "U",
    ["Enum.KeyCode.G"] = "G",
    ["Enum.KeyCode.H"] = "H",
    ["Enum.KeyCode.J"] = "J",
    ["Enum.KeyCode.K"] = "K",
    ["Enum.KeyCode.L"] = "L",
    ["Enum.KeyCode.Z"] = "Z",
    ["Enum.KeyCode.X"] = "X",
    ["Enum.KeyCode.C"] = "C",
    ["Enum.KeyCode.V"] = "V",
    ["Enum.KeyCode.B"] = "B",
    ["Enum.KeyCode.N"] = "N",
    ["Enum.KeyCode.M"] = "M"
};
u4.LevelMultiplier = 50;
u4.PointsPerLvl = 2;
u4.PrestigeLvls = 5;
u4.MaxPrestige = 3;
u4.Slot2GP = 9837261;
u4.Slot3GP = 9838197;
u4.Slot4GP = 16423469;
u4.Slot5GP = 16423475;
u4.StyleSlot2GP = 13258801;
u4.StyleSlot3GP = 13258808;
u4.JesusJoinReq = 240;
u4.RacialFightingStyles = {
    Vampirism = true
};
u4.StandWhitelists = {
    Template = {
        [19919175] = true,
        [28769503] = true,
        [427348404] = true
    },
    Kikoku = {
        [19919175] = true,
        [64130481] = true,
        [8540278] = true,
        [28769503] = true,
        [393235591] = true,
        [70167862] = true,
        [427348404] = true,
        [88923163] = true
    },
    ["Ultra Instinct"] = {
        [19919175] = true,
        [65237130] = true,
        [28769503] = true,
        [2053842003] = true,
        [427348404] = true
    },
    Mera = {
        [19919175] = true,
        [75859777] = true,
        [28769503] = true,
        [2918021418] = true,
        [194177872] = true,
        [29876845] = true,
        [427348404] = true,
        [-1] = true,
        [-2] = true
    },
    ["Paragon Platinum"] = {
        [427348404] = true,
        [19919175] = true,
        [28769503] = true
    },
    ["「Star Platinum」"] = {
        [427348404] = true,
        [19919175] = true,
        [28769503] = true,
        [1736507522] = true,
        [119869416] = true
    }
};
u4.SBRCosmeticChances = {
    {
        Name = "Common",
        Percentage = 0.6
    },
    {
        Name = "Uncommon",
        Percentage = 0.3
    },
    {
        Name = "Epic",
        Percentage = 0.08
    },
    {
        Name = "Legendary",
        Percentage = 0.02
    }
};
u4.StandSkinRarityChances = {
    {
        Name = "Common",
        Percentage = 0.6
    },
    {
        Name = "Uncommon",
        Percentage = 0.3
    },
    {
        Name = "Epic",
        Percentage = 0.08
    },
    {
        Name = "Legendary",
        Percentage = 0.02
    }
};
u4.CosmeticRarities = {
    Common = {
        Color = BrickColor.new("Cool yellow").Color
    },
    Uncommon = {
        Color = BrickColor.new("Mint").Color
    },
    Epic = {
        Color = BrickColor.new("Royal purple").Color
    },
    Legendary = {
        Color = BrickColor.new("Gold").Color
    },
    Unique = {
        Color = BrickColor.new("Carnation pink").Color
    }
};
u4.RequiemStands = {
    ["Gold Experience"] = "Gold Experience Requiem",
    ["Silver Chariot"] = "Chariot Requiem",
    ["King Crimson"] = "King Crimson Requiem",
    ["Killer Queen"] = "Killer Queen: Bites the Dust",
    ["Star Platinum"] = "Star Platinum: The World"
};
u4.RequiemStandNames = {
    ["Gold Experience Requiem"] = true,
    ["Chariot Requiem"] = true,
    ["King Crimson Requiem"] = true,
    ["Killer Queen: Bites the Dust"] = true,
    ["Star Platinum: The World"] = true,
    ["D4C Love Train"] = true,
    ["Tusk ACT 4"] = true,
    ["The World Over Heaven"] = true,
    ["Made in Heaven"] = true,
    ["Soft & Wet: Go Beyond"] = true,
    ["Shadow The World"] = true,
    ["Chili Pepper Alternate Universe"] = true
};
u4.EvolvedStandNames = {
    ["Gold Experience Requiem"] = "Gold Experience",
    ["Chariot Requiem"] = "Silver Chariot",
    ["King Crimson Requiem"] = "King Crimson",
    ["Killer Queen: Bites the Dust"] = "Killer Queen",
    ["Star Platinum: The World"] = "Star Platinum",
    ["D4C Love Train"] = "D4C",
    ["Tusk ACT 2"] = "Tusk ACT 1",
    ["Tusk ACT 3"] = "Tusk ACT 2",
    ["Tusk ACT 4"] = "Tusk ACT 3",
    ["The World Over Heaven"] = "The World",
    ["C-Moon"] = "Whitesnake",
    ["Made in Heaven"] = "C-Moon",
    ["Soft & Wet"] = "Soft & Wet: Go Beyond"
};
u4.StandPilotSettings = {
    ["Red Hot Chili Pepper"] = {
        Speed = 20,
        Type = "Manual Walk",
        Range = 60
    },
    ["C-Moon"] = {
        Speed = 22,
        Type = "Manual Walk",
        Range = 40
    },
    Whitesnake = {
        Speed = 24,
        Type = "Manual Walk",
        Range = 40
    },
    ["Hierophant Green"] = {
        Speed = 0.5,
        Type = "Manual",
        Range = 50
    },
    Aerosmith = {
        Speed = 0.5,
        Type = "Manual",
        Range = 75
    },
    ["Chariot Requiem"] = {
        Speed = 16,
        Type = "Manual Walk",
        Range = 3000
    }
};
u4.Vertices = {
    { 1, 1, -1 },
    { 1, -1, -1 },
    { -1, -1, -1 },
    { -1, 1, -1 },
    { 1, 1, 1 },
    { 1, -1, 1 },
    { -1, -1, 1 },
    { -1, 1, 1 }
};
u4.AllCFrameAngles = {
    {
        { "LookVector", 1 }
    },
    {
        { "LookVector", -1 }
    },
    {
        { "RightVector", 1 }
    },
    {
        { "RightVector", -1 }
    },
    {
        { "UpVector", 1 }
    },
    {
        { "UpVector", -1 }
    },
    {
        { "LookVector", 1 },
        { "RightVector", 1 }
    },
    {
        { "LookVector", -1 },
        { "RightVector", 1 }
    },
    {
        { "LookVector", 1 },
        { "RightVector", -1 }
    },
    {
        { "LookVector", -1 },
        { "RightVector", -1 }
    },
    {
        { "LookVector", 1 },
        { "UpVector", 1 }
    },
    {
        { "LookVector", -1 },
        { "UpVector", 1 }
    },
    {
        { "LookVector", 1 },
        { "UpVector", -1 }
    },
    {
        { "LookVector", -1 },
        { "UpVector", -1 }
    },
    {
        { "LookVector", 1 },
        { "UpVector", 1 }
    },
    {
        { "LookVector", -1 },
        { "UpVector", 1 }
    },
    {
        { "LookVector", 1 },
        { "UpVector", -1 }
    },
    {
        { "LookVector", -1 },
        { "UpVector", -1 }
    },
    {
        { "RightVector", 1 },
        { "UpVector", 1 }
    },
    {
        { "RightVector", -1 },
        { "UpVector", 1 }
    },
    {
        { "RightVector", 1 },
        { "UpVector", -1 }
    },
    {
        { "RightVector", -1 },
        { "UpVector", -1 }
    }
};
u4.UnsaveableTools = {
    Revolver = true,
    Tea = true,
    ["The Idol"] = true,
    Pizza = true,
    BoomBox = true,
    Dagger = true
};
u4.ThanosSnap = {
    [19919175] = true,
    [28769503] = true,
    [427348404] = true
};
u4.RBD = {
    [19919175] = true,
    [28769503] = true,
    [427348404] = true
};
u4.GonPose = {
    [19919175] = true,
    [64130481] = true,
    [28769503] = true,
    [427348404] = true
};
u4.PlugWalk = {
    [19919175] = true,
    [108286167] = true,
    [427348404] = true
};
u4.TradeableItems = {
    ["Eye of The Saint\'s Corpse"] = {
        Max = 30
    },
    ["Jingle Bell"] = {
        Max = 30
    },
    ["Peppermint Ball"] = {
        Max = 30
    },
    ["Cursed Scythe"] = {
        Max = 30
    },
    Scythe = {
        Max = 30
    },
    ["Boxing Claws"] = {
        Max = 30
    },
    ["Bone Gloves"] = {
        Max = 30
    },
    ["Stop Sign"] = {
        Max = 30
    },
    ["Candy cane"] = {
        Max = 30
    },
    ["Festive Gloves"] = {
        Max = 30
    },
    ["Festive Scythe"] = {
        Max = 30
    },
    ["Cyber Scythe"] = {
        Max = 30
    },
    ["Candy Cane Sword"] = {
        Max = 30
    },
    ["Festive Blade"] = {
        Max = 30
    },
    ["Candy Cane Blade"] = {
        Max = 30
    }
};
u4.DroppableItems = {
    Diamond = {
        Max = 30
    },
    ["Gold Coin"] = {
        Max = 45
    },
    ["Mysterious Arrow"] = {
        Max = 25
    },
    ["Pure Rokakaka"] = {
        Max = 10
    },
    Rokakaka = {
        Max = 25
    },
    ["Stone Mask"] = {
        Max = 10
    },
    ["Mysterious Bow"] = {
        Max = 10
    },
    ["Bottle of Blood"] = {
        Max = 2
    },
    ["Rib Cage of The Saint\'s Corpse"] = {
        Max = 20
    },
    ["Steel Ball"] = {
        Max = 10
    },
    ["Ancient Scroll"] = {
        Max = 10
    },
    ["Caesar\'s Headband"] = {
        Max = 10
    },
    Clackers = {
        Max = 10
    },
    ["Zeppeli\'s Hat"] = {
        Max = 10
    },
    ["Dio\'s Diary"] = {
        Max = 10
    },
    ["Left Arm of The Saint\'s Corpse"] = {
        Max = 10
    },
    ["Pelvis of The Saint\'s Corpse"] = {
        Max = 10
    },
    ["Heart of The Saint\'s Corpse"] = {
        Max = 10
    },
    ["Quinton\'s Glove"] = {
        Max = 10
    },
    ["Lucky Arrow"] = {
        Max = 10
    },
    ["Lucky Stone Mask"] = {
        Max = 10
    },
    ["Red Candy"] = {
        Max = 45
    },
    ["Blue Candy"] = {
        Max = 45
    },
    ["Green Candy"] = {
        Max = 45
    },
    ["Yellow Candy"] = {
        Max = 45
    },
    ["Christmas Present"] = {
        Max = 45
    }
};
u4.MaxItems = {
    ["Stand Arrow"] = {
        Max = 5
    },
    Pluck = {
        Max = 30
    },
    ["Boxing Gloves"] = {
        Max = 30
    },
    Bat = {
        Max = 30
    },
    ["Akuma Gloves"] = {
        Max = 30
    },
    Shovel = {
        Max = 30
    },
    Taser = {
        Max = 1
    },
    Umbrella = {
        Max = 30
    },
    Dagger = {
        Max = 1
    },
    BoomBox = {
        Max = 1
    },
    ["Koichi\'s Suitcase"] = {
        Max = 1
    },
    ["The Idol"] = {
        Max = 1
    },
    Lighter = {
        Max = 1
    },
    ["Requiem Arrow"] = {
        Max = 5
    },
    Tea = {
        Max = 1
    },
    ["Hot Chocolate"] = {
        Max = 1
    },
    ["Joe Meal"] = {
        Max = 1
    },
    Pizza = {
        Max = 1
    },
    ["Pelvis of The Saint\'s Corpse"] = {
        Max = 5
    },
    ["Heart of The Saint\'s Corpse"] = {
        Max = 5
    },
    ["Green Baby"] = {
        Max = 5
    },
    ["Dio\'s Bone"] = {
        Max = 5
    },
    ["Jotaro\'s Disc"] = {
        Max = 5
    },
    ["Weather Report\'s Disc"] = {
        Max = 5
    },
    ["DIO\'s Headband"] = {
        Max = 5
    },
    ["Stand Virus Capsule"] = {
        Max = 1
    },
    ["Cookie Beam"] = {
        Max = 1
    },
    ["Majin Sacrifice"] = {
        Max = 1
    },
    ["Crystal Umbrella"] = {
        Max = 30
    },
    ["Ice Umbrella"] = {
        Max = 30
    },
    ["Gold Umbrella"] = {
        Max = 30
    },
    ["Stop Sign"] = {
        Max = 30
    },
    Scythe = {
        Max = 30
    },
    ["Boxing Claws"] = {
        Max = 30
    },
    ["Bone Gloves"] = {
        Max = 30
    },
    ["Eye of The Saint\'s Corpse"] = {
        Max = 30
    },
    ["Cursed Scythe"] = {
        Max = 30
    },
    ["Candy cane"] = {
        Max = 30
    },
    ["Festive Gloves"] = {
        Max = 30
    },
    ["Festive Scythe"] = {
        Max = 30
    },
    ["Cyber Scythe"] = {
        Max = 30
    },
    ["Candy Cane Sword"] = {
        Max = 30
    },
    ["Festive Blade"] = {
        Max = 30
    },
    ["Candy Cane Blade"] = {
        Max = 30
    },
    ["Jingle Bell"] = {
        Max = 30
    },
    ["Peppermint Ball"] = {
        Max = 30
    },
    ["Casual MBR Money 1"] = {
        Max = 30
    },
    ["Casual MBR Money 2"] = {
        Max = 30
    },
    ["Casual MBR Money 3"] = {
        Max = 30
    },
    ["Comp MBR Money 1"] = {
        Max = 30
    },
    ["Comp MBR Money 2"] = {
        Max = 30
    },
    ["Comp MBR Money 3"] = {
        Max = 30
    },
    ["Redeemed Rib Cage of The Saint\'s Corpse"] = {
        Max = 30
    },
    ["Redeemed Heart of The Saint\'s Corpse"] = {
        Max = 30
    },
    ["Redeemed Left Arm of The Saint\'s Corpse"] = {
        Max = 30
    },
    ["Redeemed Pelvis of The Saint\'s Corpse"] = {
        Max = 30
    },
    ["Redeemed Mysterious Arrow"] = {
        Max = 30
    },
    ["Redeemed Requiem Arrow"] = {
        Max = 30
    },
    ["Redeemed Lucky Arrow"] = {
        Max = 30
    },
    ["Redeemed Pure Rokakaka"] = {
        Max = 30
    },
    ["Redeemed Rokakaka"] = {
        Max = 30
    },
    ["Redeemed Green Baby"] = {
        Max = 30
    },
    ["Redeemed Dio\'s Diary"] = {
        Max = 30
    }
};
u4.SellableItems = {
    Diamond = 500,
    ["Gold Coin"] = 120,
    ["Mysterious Arrow"] = 200,
    ["Pure Rokakaka"] = 1500,
    Rokakaka = 600,
    ["Stone Mask"] = 1000,
    ["Rib Cage of The Saint\'s Corpse"] = 1200,
    ["Heart of The Saint\'s Corpse"] = 2500,
    ["Left Arm of The Saint\'s Corpse"] = 2500,
    ["Pelvis of The Saint\'s Corpse"] = 2500,
    ["Steel Ball"] = 1000,
    ["Ancient Scroll"] = 1000,
    ["Caesar\'s Headband"] = 1000,
    Clackers = 1000,
    ["Zeppeli\'s Hat"] = 1000,
    ["DIO\'s Headband"] = 1500,
    ["Zepellin\'s Headband"] = 1000,
    ["Quinton\'s Glove"] = 1000,
    ["Dio\'s Diary"] = 2500,
    ["Green Baby"] = 2500,
    ["Casual MBR Money 1"] = 5000,
    ["Casual MBR Money 2"] = 4000,
    ["Casual MBR Money 3"] = 2500,
    ["Comp MBR Money 1"] = 5000,
    ["Comp MBR Money 2"] = 5000,
    ["Comp MBR Money 3"] = 5000,
    ["Redeemed Rib Cage of The Saint\'s Corpse"] = 1200,
    ["Redeemed Heart of The Saint\'s Corpse"] = 2500,
    ["Redeemed Left Arm of The Saint\'s Corpse"] = 2500,
    ["Redeemed Pelvis of The Saint\'s Corpse"] = 2500,
    ["Redeemed Mysterious Arrow"] = 200,
    ["Redeemed Pure Rokakaka"] = 1500,
    ["Redeemed Rokakaka"] = 600
};
u4.GangRequirements = {
    Cost = 1000,
    Level = 10
};
u4.Swords = {
    Pluck = true
};
local v27 = {
    [19919175] = {
        Name = "OhMyBruh1",
        DontTextScaled = true
    },
    [44097012] = {
        Name = "SoyBoyDestroyer",
        DontTextScaled = true
    },
    [108286167] = {
        Name = "Darius, The Executioner",
        Color = BrickColor.new("Maroon")
    },
    [91088265] = {
        Name = "King of Heroes",
        Color = BrickColor.new("Gold")
    },
    [21895856] = {
        Name = "Roar Gang Leader",
        Color = BrickColor.new("Dark green")
    },
    [19648022] = {
        Name = "Mafia Boss, Shift",
        Color = BrickColor.new("Royal purple")
    },
    [20138360] = {
        Name = "Justin, Killer King"
    },
    [30881468] = {
        Name = "Capa, Vandexity\'s Fear"
    },
    [24923960] = {
        Name = "Azula, The Cursed One",
        Invisible = true,
        DontTextScaled = true,
        Color = BrickColor.new("Hot pink")
    },
    [-1] = {
        Invisible = true,
        Name = "Bruh Moment"
    },
    [427348404] = {
        Name = "Paragon",
        Invisible = true,
        Color = BrickColor.new("Really red")
    },
    [84071818] = {
        Color = BrickColor.new("Light blue")
    },
    [64130481] = {
        Name = "The Most Hated, Soni"
    },
    [8540278] = {
        Name = "Queso"
    },
    [65237130] = {
        Name = "Azeus",
        Color = BrickColor.new("Electric blue")
    },
    [1328636041] = {
        Color = BrickColor.new("Neon orange")
    },
    [54302863] = {
        Invisible = true,
        Color = BrickColor.new("Royal purple")
    },
    [75859777] = {
        Name = "Ifrit",
        DontTextScaled = true
    },
    [72787966] = {
        Name = "Elder Vampire Roomy",
        DontTextScaled = true
    },
    [1241044562] = {
        Name = "Solo Progression King",
        Color = BrickColor.new("Sea green")
    }
};
u4.CustomNames = v27;
u4.CustomChat = {
    UzuKee = {
        Name = v27[19919175].Name,
        NameColor = BrickColor.new("Pink").Color
    },
    CookieJarian = {
        NameColor = BrickColor.new("Pink").Color
    },
    Infernasu = {
        Name = v27[44097012].Name
    },
    Paragon_Penguin = {
        Name = v27[427348404].Name,
        NameColor = BrickColor.new("Really red").Color
    }
};
u4.CPStandRarities = {
    {
        Name = "Soft & Wet",
        Percentage = 0.2
    },
    {
        Name = "The World Alternate Universe",
        Percentage = 0.2
    },
    {
        Name = "Scary Monsters",
        Percentage = 0.2
    },
    {
        Name = "D4C",
        Percentage = 0.2
    },
    {
        Name = "Tusk ACT 1",
        Percentage = 0.2
    }
};
u4.StandRarities = {
    {
        Name = "Stone Free",
        Percentage = 0.025
    },
    {
        Name = "Whitesnake",
        Percentage = 0.025
    },
    {
        Name = "King Crimson",
        Percentage = 0.025
    },
    {
        Name = "Gold Experience",
        Percentage = 0.025
    },
    {
        Name = "Sticky Fingers",
        Percentage = 0.05
    },
    {
        Name = "Six Pistols",
        Percentage = 0.05
    },
    {
        Name = "Aerosmith",
        Percentage = 0.05
    },
    {
        Name = "Purple Haze",
        Percentage = 0.05
    },
    {
        Name = "White Album",
        Percentage = 0.05
    },
    {
        Name = "Mr. President",
        Percentage = 0.07
    },
    {
        Name = "Beach Boy",
        Percentage = 0.07
    },
    {
        Name = "Crazy Diamond",
        Percentage = 0.025
    },
    {
        Name = "Killer Queen",
        Percentage = 0.025
    },
    {
        Name = "The Hand",
        Percentage = 0.05
    },
    {
        Name = "Red Hot Chili Pepper",
        Percentage = 0.05
    },
    {
        Name = "Star Platinum",
        Percentage = 0.025
    },
    {
        Name = "The World",
        Percentage = 0.025
    },
    {
        Name = "Hermit Purple",
        Percentage = 0.06
    },
    {
        Name = "Hierophant Green",
        Percentage = 0.05
    },
    {
        Name = "Silver Chariot",
        Percentage = 0.05
    },
    {
        Name = "Magician\'s Red",
        Percentage = 0.05
    },
    {
        Name = "Cream",
        Percentage = 0.05
    },
    {
        Name = "Anubis",
        Percentage = 0.05
    }
};
u4.PremiumEvolvedStandRarities = {
    "The World Over Heaven",
    "Star Platinum: The World",
    "Killer Queen: Bites the Dust",
    "C-Moon",
    "Made in Heaven",
    "Tusk ACT 4",
    "D4C Love Train",
    "Soft & Wet: Go Beyond",
    "Gold Experience Requiem",
    "Chariot Requiem",
    "King Crimson Requiem",
    "Shadow The World",
    "Chili Pepper Alternate Universe",
    "Weather Report"
};
u4.PremiumStandRarities = {
    "Star Platinum",
    "Magician\'s Red",
    "Hermit Purple",
    "Hierophant Green",
    "Silver Chariot",
    "Anubis",
    "Cream",
    "The World",
    "Crazy Diamond",
    "The Hand",
    "Red Hot Chili Pepper",
    "Killer Queen",
    "Gold Experience",
    "Sticky Fingers",
    "Six Pistols",
    "Aerosmith",
    "Purple Haze",
    "Mr. President",
    "Beach Boy",
    "White Album",
    "King Crimson",
    "Stone Free",
    "Whitesnake",
    "Scary Monsters",
    "D4C",
    "The World Alternate Universe",
    "Soft & Wet"
};
u4.SpawnableItems = {
    {
        Name = "Diamond",
        Percentage = 0.05,
        Rarity = "Trinket"
    },
    {
        Name = "Gold Coin",
        Percentage = 0.2346,
        Rarity = "Trinket"
    },
    {
        Name = "Mysterious Arrow",
        Percentage = 0.33,
        Rarity = "Artifact"
    },
    {
        Name = "Rokakaka",
        Percentage = 0.2,
        Rarity = "Artifact"
    },
    {
        Name = "Pure Rokakaka",
        Percentage = 0.005,
        Rarity = "Artifact"
    },
    {
        Name = "Rib Cage of The Saint\'s Corpse",
        Percentage = 0.05,
        Rarity = "Artifact"
    },
    {
        Name = "Dio\'s Diary",
        Percentage = 0.01,
        Rarity = "Artifact"
    },
    {
        Name = "Stone Mask",
        Percentage = 0.015,
        Rarity = "Artifact"
    },
    {
        Name = "Steel Ball",
        Percentage = 0.01,
        Rarity = "Artifact"
    },
    {
        Name = "Quinton\'s Glove",
        Percentage = 0.02,
        Rarity = "Artifact"
    },
    {
        Name = "Ancient Scroll",
        Percentage = 0.03,
        Rarity = "Artifact"
    },
    {
        Name = "Caesar\'s Headband",
        Percentage = 0.015,
        Rarity = "Artifact"
    },
    {
        Name = "Clackers",
        Percentage = 0.015,
        Rarity = "Artifact"
    },
    {
        Name = "Zeppeli\'s Hat",
        Percentage = 0.015,
        Rarity = "Artifact"
    },
    {
        Name = "Lucky Arrow",
        Percentage = 0.0002,
        Rarity = "Artifact"
    },
    {
        Name = "Lucky Stone Mask",
        Percentage = 0.0002,
        Rarity = "Artifact"
    }
};
u4.ItemMachine = {
    {
        Name = "Mysterious Arrow",
        Percentage = 0.3185,
        Color = BrickColor.new("Cool yellow").Color
    },
    {
        Name = "Rokakaka",
        Percentage = 0.3,
        Color = BrickColor.new("Medium red").Color
    },
    {
        Name = "Rib Cage of The Saint\'s Corpse",
        Percentage = 0.06,
        Color = BrickColor.new("Fossil").Color
    },
    {
        Name = "Diamond",
        Percentage = 0.075,
        Color = BrickColor.new("Medium blue").Color
    },
    {
        Name = "Ancient Scroll",
        Percentage = 0.025,
        Color = BrickColor.new("Institutional white").Color
    },
    {
        Name = "Caesar\'s Headband",
        Percentage = 0.025,
        Color = BrickColor.new("Institutional white").Color
    },
    {
        Name = "Clackers",
        Percentage = 0.025,
        Color = BrickColor.new("Institutional white").Color
    },
    {
        Name = "Zeppeli\'s Hat",
        Percentage = 0.025,
        Color = BrickColor.new("Institutional white").Color
    },
    {
        Name = "Stone Mask",
        Percentage = 0.025,
        Color = BrickColor.new("Dark stone grey").Color
    },
    {
        Name = "Quinton\'s Glove",
        Percentage = 0.025,
        Color = BrickColor.new("Brown").Color
    },
    {
        Name = "Steel Ball",
        Percentage = 0.025,
        Color = BrickColor.new("Lime green").Color
    },
    {
        Name = "Pure Rokakaka",
        Percentage = 0.015,
        Color = BrickColor.new("Persimmon").Color
    },
    {
        Name = "Dio\'s Diary",
        Percentage = 0.015,
        Color = BrickColor.new("Fawn brown").Color
    },
    {
        Name = "Heart of The Saint\'s Corpse",
        Percentage = 0.005,
        Color = BrickColor.new("Really red").Color
    },
    {
        Name = "Left Arm of The Saint\'s Corpse",
        Percentage = 0.025,
        Color = BrickColor.new("Institutional white").Color
    },
    {
        Name = "Pelvis of The Saint\'s Corpse",
        Percentage = 0.005,
        Color = BrickColor.new("Pearl").Color
    },
    {
        Name = "Requiem Arrow",
        Percentage = 0.005,
        Color = BrickColor.new("New Yeller").Color
    },
    {
        Name = "Lucky Arrow",
        Percentage = 0.00075,
        Color = BrickColor.new("New Yeller").Color
    },
    {
        Name = "Lucky Stone Mask",
        Percentage = 0.00075,
        Color = BrickColor.new("New Yeller").Color
    }
};
u4.SBRItems = {
    {
        Name = "Heart of The Saint\'s Corpse",
        Percentage = 0.3
    },
    {
        Name = "Pelvis of The Saint\'s Corpse",
        Percentage = 0.3
    },
    {
        Name = "Left Arm of The Saint\'s Corpse",
        Percentage = 0.3
    },
    {
        Name = "Rib Cage of The Saint\'s Corpse",
        Percentage = 0.1
    }
};
u4.BodyParts = {
    StandAura = {
        RightUpperArm = true,
        RightLowerArm = true,
        LeftUpperArm = true,
        LeftLowerArm = true,
        LeftUpperLeg = true,
        LeftLowerLeg = true,
        RightUpperLeg = true,
        RightLowerLeg = true,
        Head = true,
        UpperTorso = true,
        LowerTorso = true
    },
    HandsFeet = {
        RightHand = true,
        LeftHand = true,
        LeftFoot = true,
        RightFoot = true
    },
    MainLimbs = {
        RightUpperArm = true,
        RightHand = true,
        LeftUpperArm = true,
        LeftHand = true,
        LeftUpperLeg = true,
        LeftFoot = true,
        RightUpperLeg = true,
        RightFoot = true
    },
    Limbs = {
        RightUpperArm = true,
        RightLowerArm = true,
        RightHand = true,
        LeftUpperArm = true,
        LeftLowerArm = true,
        LeftHand = true,
        LeftUpperLeg = true,
        LeftLowerLeg = true,
        LeftFoot = true,
        RightUpperLeg = true,
        RightLowerLeg = true,
        RightFoot = true
    },
    Others = {
        Head = true,
        UpperTorso = true,
        LowerTorso = true
    },
    All = {
        RightUpperArm = true,
        RightLowerArm = true,
        RightHand = true,
        LeftUpperArm = true,
        LeftLowerArm = true,
        LeftHand = true,
        LeftUpperLeg = true,
        LeftLowerLeg = true,
        LeftFoot = true,
        RightUpperLeg = true,
        RightLowerLeg = true,
        RightFoot = true,
        Head = true,
        UpperTorso = true,
        LowerTorso = true
    },
    Motors = {
        LeftAnkle = "LeftFoot",
        LeftWrist = "LeftHand",
        LeftElbow = "LeftLowerArm",
        LeftKnee = "LeftLowerLeg",
        LeftShoulder = "LeftUpperArm",
        LeftHip = "LeftUpperLeg",
        Root = "LowerTorso",
        RightAnkle = "RightFoot",
        RightWrist = "RightHand",
        RightElbow = "RightLowerArm",
        RightKnee = "RightLowerLeg",
        RightShoulder = "RightUpperArm",
        RightHip = "RightUpperLeg",
        Waist = "UpperTorso",
        Neck = "Head"
    }
};
u4.NewLowestRanking = 300;
u4.LowestRanking = 100;
function u4.ReturnScalingIncrease(p28, p29, p30, p31) --[[ Line: 1434 ]]
    return p28 * p29 * ((p30 - p31) / p30);
end;
function u4.Return1v1MMR(...) --[[ Line: 1446 ]]
    local v32 = ...;
    local l__Player__29 = v32.Player;
    local l__PlayerName__30 = v32.PlayerName;
    if l__PlayerName__30 then
        l__Player__29 = l__PlayerName__30;
    elseif l__Player__29 then
        l__Player__29 = l__Player__29.Name;
    end;
    local l___1v1Rank__31 = v32._1v1Rank;
    if not l___1v1Rank__31 then
        if l__Player__29 then
            l___1v1Rank__31 = _G.Playerlist[l__Player__29].ReturnData()._1v1_Rank;
        else
            l___1v1Rank__31 = l__Player__29;
        end;
    end;
    if l___1v1Rank__31.Rank <= 0 and l__Player__29 then
        local _ = l___1v1Rank__31.Placements.Rank;
    end;
    local v33 = l___1v1Rank__31.Wins + l___1v1Rank__31.Losses;
    local v34 = v33 - v33 / (l___1v1Rank__31.Wins / v33);
    local v35 = tostring(v34):lower();
    return (v35 == "-nan" or (v35 == "nan" or v35 == "+nan")) and 0 or v34;
end;
function u4.ReturnSprintSpeed(p36) --[[ Line: 1472 ]]
    local l__Character__32 = p36.Character;
    local v37;
    if l__Character__32 then
        v37 = l__Character__32:FindFirstChild("Blood");
    else
        v37 = l__Character__32;
    end;
    local v38;
    if l__Character__32 then
        v38 = l__Character__32:FindFirstChild("Health");
    else
        v38 = l__Character__32;
    end;
    local v39 = 6;
    for _, v40 in pairs(p36.CharacterSkillTree:GetChildren()) do
        if v40.Name:match("Agility") and v40.Value then
            v39 = v39 + 2;
        end;
    end;
    for _, v41 in pairs(p36.StandSkillTree:GetChildren()) do
        if v41.Name:match("Agility") and v41.Value then
            v39 = v39 + 2;
        end;
        if v41.Name:match("Superhuman Speed") and v41.Value then
            v39 = v39 + 25;
        end;
    end;
    local v42 = p36:FindFirstChild("SpecSkillTree");
    if v42 then
        local v43 = v42:FindFirstChild("Courageous Spirit");
        if v38 and (v43 and (v43.Value and v38.Value / v38.MaxValue >= 0.75)) then
            v39 = v39 + 4;
        end;
    end;
    if l__Character__32:GetAttribute("DeepPassBubbleBuff") then
        v39 = v39 + 6;
    end;
    if l__Character__32:FindFirstChild("Godspeed") then
        v39 = v39 * 2;
    end;
    if l__Character__32:GetAttribute("SM_Full_Form") then
        v39 = v39 * 1.25;
    end;
    if v37 and v37.Value > 0 then
        local v44 = 4;
        v39 = v39 + math.clamp(v44 * (v37.Value / (v37.MaxValue * 0.75)), 0, v44);
    end;
    if l__Character__32:GetAttribute("SecretTechniqueBuff") then
        v39 = v39 + 10;
    end;
    return v39;
end;
function u4.ReturnSlotRequirements(p45, p46) --[[ Line: 1536 ]]
    local l__PlayerStats__33 = p45.PlayerStats;
    for v47, v48 in pairs({
        Slot1 = l__PlayerStats__33.Prestige.Value >= 1,
        Slot2 = l__PlayerStats__33.Prestige.Value >= 2,
        Slot3 = l__PlayerStats__33.Prestige.Value >= 3,
        StyleSlot1 = l__PlayerStats__33.Level.Value >= 50
    }) do
        if v47 == p46 and v48 == false then
            return false;
        end;
    end;
    return true;
end;
function u4.ReturnMobile() --[[ Line: 1554 ]]
    -- upvalues: l__UserInputService__14 (copy)
    return l__UserInputService__14.TouchEnabled or l__UserInputService__14.KeyboardEnabled == false;
end;
u4.MaxSlot = 99;
u4.MaxStyleSlot = 99;
function u4.ReturnSlots(...) --[[ Line: 1561 ]]
    local v49 = ...;
    local _ = v49.Player;
    local l__PlayerStats__34 = v49.PlayerStats;
    local l__ProfileData__35 = v49.ProfileData;
    local l__Slot_Type__36 = v49.Slot_Type;
    return (function(p50) --[[ Line: 1568 ]]
        -- upvalues: l__Slot_Type__36 (copy)
        local v51 = typeof(p50) == "table";
        local v52 = {};
        for v56, v57 in pairs(v51 and p50 and p50 or p50:GetChildren()) do
            if not v51 and string.sub(v57.Name, 1, #l__Slot_Type__36) == l__Slot_Type__36 or string.sub(v56, 1, #l__Slot_Type__36) == l__Slot_Type__36 then
                local v55 = {};
                if not v51 then
                    local v56 = v57.Name or v56;
                end;
                v55.Name = v56;
                if not v51 then
                    local v57 = v57.Value or v57;
                end;
                v55.Value = v57;
                table.insert(v52, v55);
            end;
        end;
        return v52;
    end)(l__ProfileData__35 or l__PlayerStats__34);
end;
function u4.InvisibleTool(p58, p59, u60) --[[ Line: 1589 ]]
    -- upvalues: u4 (copy)
    if p58 and p59 then
        _G[u60] = p59;
        for _, v61 in pairs(p59:GetDescendants()) do
            if v61:IsA("BasePart") then
                v61:SetAttribute("OriginalTransparency", v61:GetAttribute("OriginalTransparency") or v61.Transparency);
                v61.Transparency = 1;
            elseif v61:IsA("ParticleEmitter") or (v61:IsA("Beam") or v61:IsA("Trail")) then
                v61:SetAttribute("OriginalEnabled", v61:GetAttribute("OriginalEnabled") or v61.Enabled);
                v61.Enabled = false;
            end;
        end;
    else
        if _G[u60] then
            u4.pcall(function() --[[ Line: 1605 ]]
                -- upvalues: u60 (copy)
                for _, v62 in pairs(_G[u60]:GetDescendants()) do
                    if v62:IsA("BasePart") then
                        v62.Transparency = v62:GetAttribute("OriginalTransparency") or 1;
                    elseif v62:IsA("ParticleEmitter") or (v62:IsA("Beam") or v62:IsA("Trail")) then
                        v62.Enabled = v62:GetAttribute("OriginalEnabled");
                    end;
                end;
            end);
            _G[u60] = nil;
        end;
    end;
end;
function u4.ScaleModel(p63, p64, p65, p66, p67) --[[ Line: 1619 ]]
    local v68 = p63:GetDescendants();
    table.insert(v68, p63);
    local l__p__37 = p65.p;
    local v69 = tonumber(p64);
    local v70 = v69 or (p64.X > p64.Y and p64.X > p64.Z and p64.X or p64.Y > p64.X and p64.Y > p64.Z and p64.Y or (p64.Z > p64.Y and p64.Z > p64.X and p64.Z or p64.X));
    for _, v71 in pairs(v68) do
        if v71:IsA("Weld") or (v71:IsA("ManualWeld") or v71:IsA("WeldConstraint")) then
            v71:Destroy();
        end;
    end;
    for _, v72 in pairs(v68) do
        if not v72:GetAttribute("DontScale") then
            if v72:IsA("BasePart") then
                if not v72:GetAttribute("DontScaleSize") and (not v72:GetAttribute("DontScaleSizeUnder") or v72:GetAttribute("DontScaleSizeUnder") <= v70) then
                    v72.Size = v72.Size * p64;
                end;
                local v73 = v72.Position - l__p__37;
                local v74 = v72.CFrame - v72.Position;
                v72.CFrame = CFrame.new(l__p__37 + v73 * p64) * v74;
            elseif v72:IsA("Attachment") and p66 then
                v72.WorldPosition = l__p__37 + (v72.WorldPosition - l__p__37) * p64;
            elseif v72:IsA("Beam") and p67 then
                local v75 = tonumber(p67.AdjustCurveSize) or v69;
                if v75 then
                    v72.CurveSize0 = v72.CurveSize0 * v75;
                    v72.CurveSize1 = v72.CurveSize1 * v75;
                end;
                local v76 = tonumber(p67.AdjustWidth) or v69;
                if v76 then
                    v72.Width0 = v72.Width0 * v76;
                    v72.Width1 = v72.Width1 * v76;
                end;
            end;
        end;
    end;
end;
function u4.CalculateSkinPity(p77) --[[ Line: 1666 ]]
    local v78 = p77.PlayerStats:FindFirstChild("PityCount");
    return v78.Value <= 0 and 1 or math.clamp(1 + v78.Value / 25, 0, 10);
end;
function u4.ReturnIsPrivateServerOwner(...) --[[ Line: 1679 ]]
    -- upvalues: u4 (copy)
    local l__Player__38 = (...).Player;
    return game.PrivateServerId ~= "" and (game.PrivateServerOwnerId ~= 0 and l__Player__38.UserId == game.PrivateServerOwnerId) and true or (u4.PlaceIds[game.PlaceId].GameType == "Update Place" and true or (_G.VipPlayers and _G.VipPlayers[l__Player__38.Name] and true or nil));
end;
function u4.ReturnUseAdmin(...) --[[ Line: 1694 ]]
    -- upvalues: u4 (copy)
    local _ = (...).Player;
    return u4.PlaceIds[game.PlaceId].GameType == "Update Place" and true or nil;
end;
function u4.NewUpdatePlayerVisualRankings(...) --[[ Line: 1705 ]]
    -- upvalues: u4 (copy)
    local v79 = ...;
    local l__PlayerDataTable__39 = v79.PlayerDataTable;
    local v80 = v79.Type .. "_Visual";
    local v81 = v80 .. workspace:GetAttribute("Current_Monthly_Season") .. workspace:GetAttribute("Current_Year");
    local v82 = _G[v80]:GetAsync(v81) or {};
    if l__PlayerDataTable__39 then
        v82[l__PlayerDataTable__39.UserId] = l__PlayerDataTable__39;
    end;
    if v79.Remove then
        v82[v79.Remove] = nil;
    end;
    local v83 = {};
    for _, v84 in pairs(v82) do
        table.insert(v83, {
            Name = v84.Name,
            Points = v84.Points,
            Gang = v84.Gang,
            UserId = v84.UserId
        });
    end;
    table.sort(v83, function(p85, p86) --[[ Line: 1727 ]]
        return p85.Points > p86.Points;
    end);
    for v87, v88 in pairs(v83) do
        if v88.UserId and (v88.Points and (u4.NewLowestRanking < v87 or v88.Points <= 0)) then
            v82[v88.UserId] = nil;
        end;
    end;
    _G[v80]:SetAsync(v81, v82);
end;
function u4.UpdatePlayerVisualRankings(...) --[[ Line: 1741 ]]
    -- upvalues: u4 (copy)
    local v89 = ...;
    local l__PlayerDataTable__40 = v89.PlayerDataTable;
    local v90 = v89.Type .. "Visual";
    local v91 = v90 .. _G.RankingsSeason;
    local v92 = _G[v90]:GetAsync(v91) or {};
    if l__PlayerDataTable__40 then
        v92[l__PlayerDataTable__40.UserId] = l__PlayerDataTable__40;
    end;
    local v93 = {};
    for _, v94 in pairs(v92) do
        table.insert(v93, {
            Name = v94.Name,
            Points = v94.Points,
            Gang = v94.Gang,
            UserId = v94.UserId
        });
    end;
    table.sort(v93, function(p95, p96) --[[ Line: 1759 ]]
        return p95.Points > p96.Points;
    end);
    for v97, v98 in pairs(v93) do
        if v98.UserId and (v98.Points and (u4.LowestRanking < v97 or v98.Points <= 0)) then
            v92[v98.UserId] = nil;
        end;
    end;
    _G[v90]:SetAsync(v91, v92);
end;
function u4.getOutfits(p99) --[[ Line: 1773 ]]
    -- upvalues: u1 (copy), l__HttpService__9 (copy)
    local u100 = nil;
    local u101 = "https://avatar.rprxy.xyz/v1/users/" .. p99 .. "/outfits?itemsPerPage=1000";
    local v102, v103 = u1(function() --[[ Line: 1776 ]]
        -- upvalues: u100 (ref), l__HttpService__9 (ref), u101 (copy)
        u100 = l__HttpService__9:JSONDecode(l__HttpService__9:GetAsync(u101, true));
    end);
    if not v102 then
        print(v103);
    end;
    local l__data__41 = u100.data;
    local v104 = {};
    for v105 = 1, #l__data__41 do
        table.insert(v104, l__data__41[v105].id);
    end;
    return v104;
end;
function u4.ReturnMaxCosmetics(p106) --[[ Line: 1790 ]]
    -- upvalues: l__MarketplaceService__10 (copy)
    local v107 = 5 * (p106.PlayerStats.Prestige.Value + 1);
    if l__MarketplaceService__10:UserOwnsGamePassAsync(p106.UserId, 14597766) then
        v107 = v107 * 2;
    end;
    return v107;
end;
function u4.ReturnCustomChatStuff(...) --[[ Line: 1803 ]]
    -- upvalues: u4 (copy)
    local v108 = ... or {};
    local l__Name__42 = v108.Name;
    local l__useNameColor__43 = v108.useNameColor;
    local l__useChatColor__44 = v108.useChatColor;
    local v109 = u4.CustomChat[l__Name__42];
    if v109 then
        local l__NameColor__45 = v109.NameColor;
        local l__ChatColor__46 = v109.ChatColor;
        l__Name__42 = v109.Name or l__Name__42;
        l__useNameColor__43 = l__NameColor__45 or l__useNameColor__43;
        if l__ChatColor__46 then
            l__useChatColor__44 = l__ChatColor__46;
        end;
    end;
    return {
        Player = game:GetService("Players"):findFirstChild(v108.Name),
        Name = l__Name__42,
        useNameColor = l__useNameColor__43,
        useChatColor = l__useChatColor__44
    };
end;
function u4.ReturnStandSkinsInRarity(p110, p111) --[[ Line: 1833 ]]
    -- upvalues: l__ServerStorage__5 (copy)
    local v112 = {};
    local v113 = l__ServerStorage__5.Stands[p110]:FindFirstChild("Skins");
    if v113 then
        for _, v114 in pairs(v113:GetChildren()) do
            local v115 = l__ServerStorage__5.Skins[v114.Name];
            if v114.Value and (v115:GetAttribute("Rarity") == p111 and not v115:GetAttribute("Unrollable")) then
                table.insert(v112, v114.Name);
            end;
        end;
    end;
    return v112;
end;
function u4.ReturnUmbrellaSkinsInType(p116) --[[ Line: 1850 ]]
    -- upvalues: l__ServerStorage__5 (copy)
    local v117 = {};
    for _, v118 in pairs(l__ServerStorage__5.Tools:GetChildren()) do
        if v118:GetAttribute("IsUmbrella") and (v118:GetAttribute("Rarity") == p116 and not (v118:GetAttribute("Unique") or v118:GetAttribute("Unrollable"))) then
            table.insert(v117, v118);
        end;
    end;
    return v117;
end;
function u4.ReturnCosmeticsInType(p119) --[[ Line: 1862 ]]
    -- upvalues: l__ReplicatedStorage__6 (copy)
    local v120 = {};
    for _, v121 in pairs(l__ReplicatedStorage__6.Cosmetics:GetChildren()) do
        if v121:GetAttribute("Rarity") == p119 and not (v121:GetAttribute("Unique") or v121:GetAttribute("Unrollable")) then
            table.insert(v120, v121.Name);
        end;
    end;
    return v120;
end;
function u4.TimeStop(u122, u123, p124, p125) --[[ Line: 1874 ]]
    -- upvalues: l__CollectionService__8 (copy), u4 (copy), l__ReplicatedStorage__6 (copy), l__Debris2__12 (copy), l__ClientFX__16 (copy), l__wait__4 (copy)
    local l__Char__47 = u122.Char;
    local l__StandMorph__48 = l__Char__47.StandMorph;
    local l__Value__49 = u122.Char:FindFirstChild("ResistTimeStop").Value;
    if not u122.Player then
        l__Value__49 = l__Value__49 * 3;
    end;
    if l__CollectionService__8:HasTag(l__Char__47, "Two Steps") then
        l__Value__49 = l__Value__49 / 2;
    end;
    local u126 = p125 or l__Value__49;
    local v127 = p124 + u126;
    u122:AddUsingMove({
        Name = u123 .. "2"
    });
    u122.AddCD(u122, {
        Name = u123,
        Timer = v127
    });
    u122.AddWalkSpeed(u122, {
        Value = -1000,
        Name = u123
    });
    u122.AddJumpPower(u122, {
        Value = -1000,
        Name = u123
    });
    u122.AddAutoRotate(u122, {
        Name = u123
    });
    u122.RemoveUsingMove(u122, "TimeStopping");
    if u122.Player and not (_G.DisabledCooldowns and _G.DisabledCooldowns[u122.Player.UserId]) then
        local u128 = Instance.new("Folder");
        u128.Name = "Time Stop";
        u128.Parent = u122.Player;
        u4.Delay(v127, function() --[[ Line: 1906 ]]
            -- upvalues: u128 (copy)
            u128:Destroy();
        end);
    end;
    local u133 = require(l__ReplicatedStorage__6:WaitForChild("Modules"):WaitForChild("ChannelMod2")).new(1.25, function() --[[ Line: 1913 ]]
        -- upvalues: l__Char__47 (copy), l__Debris2__12 (ref), u126 (ref), l__CollectionService__8 (ref), l__ClientFX__16 (ref), u122 (copy), l__StandMorph__48 (copy), l__wait__4 (ref), u4 (ref), u123 (copy)
        local v129 = Instance.new("Folder", l__Char__47);
        l__Debris2__12:AddItem(v129, u126 + 6);
        v129.Name = "TimeStopping";
        l__CollectionService__8:AddTag(l__Char__47, "UsedTimeStop");
        l__ClientFX__16:FireAllClients("PlaySound", {
            Origin = u122.Root,
            Sound = l__StandMorph__48["Stand Name"].Value .. " Time Stop"
        });
        l__wait__4(0.5);
        local u130 = u122:ReturnClientCFrame();
        u122.TimeStopVictims = {};
        for _, u131 in pairs(workspace.Living:GetChildren()) do
            u4.Spawn(function() --[[ Line: 1929 ]]
                -- upvalues: u131 (copy), l__CollectionService__8 (ref), u130 (copy), u126 (ref), l__Char__47 (ref), u122 (ref)
                local v132 = u131:findFirstChild("HumanoidRootPart");
                if v132 and (u131:findFirstChild("BindableEvent") and (not l__CollectionService__8:HasTag(u131, "InD4CDimension") and (not l__CollectionService__8:HasTag(u131, "Return to Zero") and (not l__CollectionService__8:HasTag(u131, "Universe Resetted") and (u131:findFirstChild("InTimeStop") == nil and (v132.Position - u130.Position).magnitude <= 130))))) then
                    u131.BindableEvent:Fire("InTimeStop", {
                        Duration = u126,
                        Attacker = l__Char__47
                    });
                    table.insert(u122.TimeStopVictims, u131);
                end;
            end);
        end;
        u122.RemoveWalkSpeed(u122, u123);
        u122.RemoveJumpPower(u122, u123);
        u122.RemoveAutoRotate(u122, u123);
        u122:RemoveUsingMove(u123 .. "2");
        u4.Delay(u126, function() --[[ Line: 1945 ]]
            -- upvalues: u122 (ref), l__CollectionService__8 (ref), l__Char__47 (ref)
            if u122.TimeStopVictims then
                u122.TimeStopVictims = nil;
            end;
            l__CollectionService__8:RemoveTag(l__Char__47, "UsedTimeStop");
        end);
    end);
    function u133.Duration() --[[ Line: 1954 ]]
        -- upvalues: u122 (copy), l__CollectionService__8 (ref), l__Char__47 (copy), u123 (copy), u133 (copy)
        if u122.Player and (l__CollectionService__8:HasTag(u122.Char, "Stunned") or (l__CollectionService__8:HasTag(u122.Char, "Ragdolled") or l__CollectionService__8:HasTag(l__Char__47, "Return to Zero"))) then
            u122.RemoveWalkSpeed(u122, u123);
            u122.RemoveJumpPower(u122, u123);
            u122.RemoveAutoRotate(u122, u123);
            u122:RemoveUsingMove(u123 .. "2");
            u133:Cancel();
        end;
    end;
    u133:Start();
end;
function u4.TimeStop2(u134, u135, p136, p137) --[[ Line: 1972 ]]
    -- upvalues: l__CollectionService__8 (copy), u4 (copy), l__ReplicatedStorage__6 (copy), l__Debris2__12 (copy), l__ClientFX__16 (copy)
    local l__Char__50 = u134.Char;
    local l__StandMorph__51 = l__Char__50.StandMorph;
    local v138 = u134.Char:FindFirstChild("ResistTimeStop").Value / 2.25;
    if not u134.Player then
        v138 = v138 * 3;
    end;
    if l__CollectionService__8:HasTag(l__Char__50, "Two Steps") then
        v138 = v138 / 2;
    end;
    local u139 = p137 or v138;
    local v140 = p136 + u139;
    u134:AddUsingMove({
        Name = u135 .. "2"
    });
    u134.AddCD(u134, {
        Name = u135,
        Timer = v140
    });
    u134.AddWalkSpeed(u134, {
        Value = -1000,
        Name = u135
    });
    u134.AddJumpPower(u134, {
        Value = -1000,
        Name = u135
    });
    u134.AddAutoRotate(u134, {
        Name = u135
    });
    u134.RemoveUsingMove(u134, "TimeStopping");
    if u134.Player and not (_G.DisabledCooldowns and _G.DisabledCooldowns[u134.Player.UserId]) then
        local u141 = Instance.new("Folder");
        u141.Name = "Time Stop";
        u141.Parent = u134.Player;
        u4.Delay(v140, function() --[[ Line: 2004 ]]
            -- upvalues: u141 (copy)
            u141:Destroy();
        end);
    end;
    local u147 = require(l__ReplicatedStorage__6:WaitForChild("Modules"):WaitForChild("ChannelMod2")).new(1, function() --[[ Line: 2011 ]]
        -- upvalues: l__Char__50 (copy), l__Debris2__12 (ref), u139 (ref), l__CollectionService__8 (ref), l__ClientFX__16 (ref), u134 (copy), l__StandMorph__51 (copy), u4 (ref), u135 (copy)
        local v142 = Instance.new("Folder", l__Char__50);
        l__Debris2__12:AddItem(v142, u139 + 6);
        v142.Name = "TimeStopping";
        l__CollectionService__8:AddTag(l__Char__50, "UsedTimeStop");
        l__ClientFX__16:FireAllClients("PlaySound", {
            Origin = u134.Root,
            Sound = l__StandMorph__51["Stand Name"].Value .. " Time Stop"
        });
        local u143 = u134:ReturnClientCFrame();
        u134.TimeStopVictims = {};
        local u144 = game.HttpService:GenerateGUID();
        for _, u145 in pairs(workspace.Living:GetChildren()) do
            u4.Spawn(function() --[[ Line: 2028 ]]
                -- upvalues: u145 (copy), l__CollectionService__8 (ref), u143 (copy), u139 (ref), l__Char__50 (ref), u144 (copy), u134 (ref)
                local v146 = u145:findFirstChild("HumanoidRootPart");
                if v146 and (u145:findFirstChild("BindableEvent") and (not l__CollectionService__8:HasTag(u145, "InD4CDimension") and (not l__CollectionService__8:HasTag(u145, "Return to Zero") and (not l__CollectionService__8:HasTag(u145, "Universe Resetted") and (u145:findFirstChild("InTimeStop") == nil and (v146.Position - u143.Position).magnitude <= 130))))) then
                    u145.BindableEvent:Fire("InTimeStop", {
                        Duration = u139,
                        Attacker = l__Char__50,
                        Id = u144
                    });
                    table.insert(u134.TimeStopVictims, u145);
                end;
            end);
        end;
        u134.RemoveWalkSpeed(u134, u135);
        u134.RemoveJumpPower(u134, u135);
        u134.RemoveAutoRotate(u134, u135);
        u134:RemoveUsingMove(u135 .. "2");
        u4.Delay(u139, function() --[[ Line: 2044 ]]
            -- upvalues: u134 (ref), l__CollectionService__8 (ref), l__Char__50 (ref)
            if u134.TimeStopVictims then
                u134.TimeStopVictims = nil;
            end;
            l__CollectionService__8:RemoveTag(l__Char__50, "UsedTimeStop");
        end);
    end);
    function u147.Duration() --[[ Line: 2053 ]]
        -- upvalues: u134 (copy), l__CollectionService__8 (ref), l__Char__50 (copy), u135 (copy), u147 (copy)
        if u134.Player and (l__CollectionService__8:HasTag(u134.Char, "Stunned") or (l__CollectionService__8:HasTag(u134.Char, "Ragdolled") or l__CollectionService__8:HasTag(l__Char__50, "Return to Zero"))) then
            u134.RemoveWalkSpeed(u134, u135);
            u134.RemoveJumpPower(u134, u135);
            u134.RemoveAutoRotate(u134, u135);
            u134:RemoveUsingMove(u135 .. "2");
            u147:Cancel();
        end;
    end;
    u147:Start();
end;
local u148 = {};
function u4.getUserIdFromUsername(u149) --[[ Line: 2072 ]]
    -- upvalues: u148 (copy), l__Players__19 (copy), u1 (copy)
    if u148[u149] then
        return u148[u149];
    end;
    local v150 = l__Players__19:FindFirstChild(u149);
    if v150 then
        u148[u149] = v150.UserId;
        return v150.UserId;
    end;
    local u151 = nil;
    u1(function() --[[ Line: 2083 ]]
        -- upvalues: u151 (ref), l__Players__19 (ref), u149 (copy)
        u151 = l__Players__19:GetUserIdFromNameAsync(u149);
    end);
    u148[u149] = u151;
    return u151;
end;
function u4.New_Raycast(...) --[[ Line: 2090 ]]
    -- upvalues: u4 (copy)
    local v152 = {
        workspace.Camera,
        workspace.CurrentCamera,
        workspace.IgnoreInstances,
        workspace:FindFirstChild("Mob_Spawns"),
        workspace:FindFirstChild("Mob_Spawns2")
    };
    local v153 = {};
    local v154 = ...;
    for _, v155 in pairs(v152) do
        if v155 and v155.Parent then
            table.insert(v153, v155);
        end;
    end;
    local v156 = v154.IgnoreDefaults and {} or v153;
    if v154.Ignore then
        for _, v157 in pairs(v154.Ignore) do
            table.insert(v156, v157);
        end;
    end;
    local v158 = v154.RaycastParams or RaycastParams.new();
    v158.FilterType = v154.FilterType or Enum.RaycastFilterType.Exclude;
    v158.FilterDescendantsInstances = v156;
    v158.RespectCanCollide = v154.IgnoreNonCollisionMap;
    local v159 = v154.Ray.Unit * -(v154.Safety_Check or 3);
    local v160 = workspace:Raycast(v154.Origin + v159, v154.Ray - v159, v158);
    local v161;
    if v160 then
        v161 = v160.Instance;
    else
        v161 = v160;
    end;
    local v162;
    if v160 then
        v162 = v160.Position;
    else
        v162 = v160;
    end;
    local v163;
    if v160 then
        v163 = v160.Normal;
    else
        v163 = v160;
    end;
    if v160 then
        v160 = v160.Distance;
    end;
    local v164 = v161 and v154.IgnoreChar;
    if v164 then
        v164 = v161:IsDescendantOf(v154.IgnoreChar);
    end;
    local v165 = v154.IgnoreNonCollisionMap and (v161 and not v161.CanCollide);
    if v165 then
        v165 = v161.Anchored;
    end;
    if (v164 or v165) and (not v154.RecursiveCount or v154.RecursiveCount < 10) then
        local v166 = v161:IsDescendantOf(workspace.Living);
        if v164 then
            v166 = nil;
        end;
        if not v166 then
            table.insert(v156, v161);
            v154.Ignore = v156;
            v154.RecursiveCount = v154.RecursiveCount and (v154.RecursiveCount + 1 or 1) or 1;
            v154.RaycastParams = v158;
            return u4.New_Raycast(v154);
        end;
    end;
    return v161, v162, v163, v160;
end;
function u4.Raycast(...) --[[ Line: 2166 ]]
    -- upvalues: u4 (copy)
    local v167 = ...;
    local v168 = {
        workspace.CurrentCamera,
        workspace.IgnoreInstances,
        workspace:FindFirstChild("Mob_Spawns"),
        workspace:FindFirstChild("Mob_Spawns2")
    };
    if v167.Ignore then
        for _, v169 in pairs(v167.Ignore) do
            table.insert(v168, v169);
        end;
    end;
    local v170 = v167.RaycastParams or RaycastParams.new();
    v170.FilterType = v167.FilterType or Enum.RaycastFilterType.Exclude;
    v170.FilterDescendantsInstances = v168;
    local v171 = workspace:Raycast(v167.Origin, v167.Ray, v170);
    local v172;
    if v171 then
        v172 = v171.Instance;
    else
        v172 = v171;
    end;
    local v173;
    if v171 then
        v173 = v171.Position;
    else
        v173 = v171;
    end;
    local v174;
    if v171 then
        v174 = v171.Normal;
    else
        v174 = v171;
    end;
    if v171 then
        v171 = v171.Distance;
    end;
    if not v167.IgnoreNonCollisionMap or (not v172 or (v172.CanCollide or (not v172.Anchored or v167.RecursiveCount and v167.RecursiveCount >= 10))) or (v172.Parent:FindFirstChild("Health") or v172.Parent.Parent:FindFirstChild("Health")) then
        return v172, v173, v174, v171;
    end;
    table.insert(v168, v172);
    v167.Ignore = v168;
    v167.RecursiveCount = v167.RecursiveCount and (v167.RecursiveCount + 1 or 1) or 1;
    v167.RaycastParams = v170;
    return u4.Raycast(v167);
end;
function u4.CheckPartInfront(p175, p176, p177, p178, p179, p180) --[[ Line: 2206 ]]
    -- upvalues: u4 (copy)
    local v181 = Ray.new(p175, (p176.p - p175).unit * p177);
    local v182 = p178 or {};
    if p179 then
        for _, v183 in pairs(p179:GetChildren()) do
            if v183:IsA("BasePart") then
                table.insert(v182, v183);
            elseif v183:IsA("Accessory") then
                table.insert(v182, v183:findFirstChildWhichIsA("BasePart"));
            end;
        end;
    end;
    local v184, v185, v186 = workspace:FindPartOnRayWithIgnoreList(v181, v182, false, true);
    if v184 and (v184.CanCollide and (v185 and not (p180 and v184:IsDescendantOf(workspace.Living)))) then
        return v185, v184, {
            SurfaceNormal = v186
        };
    end;
    if not v184 then
        return p176.p, false, {
            SurfaceNormal = v186
        };
    end;
    table.insert(v182, v184);
    return u4.CheckPartInfront(p175, p176, p177, v182, p179);
end;
function u4.GetPoint(p187, p188) --[[ Line: 2235 ]]
    local v189 = Ray.new(p187.Position, (p188.Position - p187.Position).unit * 999);
    local _, v190 = workspace:FindPartOnRayWithWhitelist(v189, { p188 });
    return v190;
end;
function u4.GetPosAndSizeBetweenParts(p191, p192, p193) --[[ Line: 2241 ]]
    -- upvalues: u4 (copy)
    local v194 = u4.GetPoint(p192, p191);
    local v195 = u4.GetPoint(p191, p192);
    return v194 + (v195 - v194) / (p193 or 2), (v195 - v194).Magnitude;
end;
function u4.UnpilotStand(u196) --[[ Line: 2251 ]]
    -- upvalues: u4 (copy)
    local u197 = u196.Char:findFirstChild("StandMorph");
    if u196.IsPiloting then
        u196.IsPiloting = nil;
        u196.PilotCam:Destroy();
        u4.pcall(function() --[[ Line: 2259 ]]
            -- upvalues: u197 (copy), u196 (copy), u4 (ref)
            if u197.Parent ~= nil then
                local l__StandAttach__52 = u197.HumanoidRootPart.StandAttach;
                for _, v198 in pairs(u197:GetDescendants()) do
                    if v198:IsA("BasePart") or v198:IsA("UnionOperation") then
                        v198.CollisionGroup = "Stands";
                    end;
                end;
                u196.IsPilotingFolder:Destroy();
                u196.PilotSpeed:Destroy();
                if u196.PilotBodyPosition then
                    u196.PilotBodyPosition:Destroy();
                end;
                if u196.PilotBodyGyro then
                    u196.PilotBodyGyro:Destroy();
                end;
                for _, v199 in pairs(u197:GetChildren()) do
                    if v199:IsA("BasePart") and (u4.BodyParts.All[v199.Name] or v199.Name == "HumanoidRootPart") and not v199:GetAttribute("MassOn") then
                        v199.Massless = true;
                    end;
                end;
                u197.HumanoidRootPart.CustomPhysicalProperties = nil;
                u197.HumanoidRootPart.CFrame = u196.Root.CFrame;
                if u196.Player then
                    u197.PrimaryPart:SetNetworkOwner(u196.Player);
                end;
                l__StandAttach__52.AlignOrientation.Attachment0 = l__StandAttach__52;
                l__StandAttach__52.AlignPosition.Attachment0 = l__StandAttach__52;
                if u196.PilotAnimIdle then
                    u196.PilotAnimIdle:Stop();
                end;
                local v200 = u197:FindFirstChild("Shadow Atmosphere");
                if v200 then
                    v200:Destroy();
                end;
            end;
        end);
        u196.Player.CameraMinZoomDistance = 0.5;
        u196.RemoveWalkSpeed(u196, "Pilot");
        u196.RemoveJumpPower(u196, "Pilot");
    end;
end;
function u4.ReturnServerList(p201) --[[ Line: 2302 ]]
    local v202 = 0;
    local v203 = {};
    if p201 then
        for _, v204 in pairs(p201) do
            if v204.Code and not v204.Commenced then
                table.insert(v203, v204.Code);
                v202 = v202 + 1;
                if v202 >= 25 then
                    break;
                end;
            end;
        end;
    end;
    return v203;
end;
u4["New Game Mode Code"] = function(p205, u206, p207) --[[ Line: 2323 ]]
    -- upvalues: u1 (copy), u4 (copy)
    local u208 = p207 or _G[u206]:GetAsync(u206);
    if not u208 then
        print("Breh no data doe #1");
        u208 = {};
    end;
    local u209 = game:GetService("TeleportService"):ReserveServer(p205);
    local u210 = string.sub(u209, 1, 50);
    local u211 = nil;
    local u212 = nil;
    if u206 == "Metal Ball Run" then
        u211 = {
            Players = 0,
            RequiredPlayers = 16,
            MaxPlayers = 30,
            Commenced = false,
            Code = u209,
            ShortenedCode = u210,
            OsTime = os.time()
        };
        u212 = _G.CasualSBR;
    elseif u206 == "[COMPETITIVE] Metal Ball Run" then
        u211 = {
            Players = 0,
            RequiredPlayers = 16,
            MaxPlayers = 30,
            Commenced = false,
            Code = u209,
            ShortenedCode = u210,
            OsTime = os.time()
        };
        u212 = _G.CompetitiveSBR;
    end;
    for v213, u214 in pairs(u208) do
        if u214.ShortenedCode and not u214.Commenced then
            local l__Code__53 = u214.Code;
            local v215 = u212:GetAsync(u214.ShortenedCode);
            if v215 then
                local v216 = v215[l__Code__53];
                if v216.Commenced or (not v216.OsTime or os.time() - v216.OsTime >= 1800) then
                    u208[v213] = nil;
                    local v217, _ = u1(function() --[[ Line: 2380 ]]
                        -- upvalues: u212 (ref), u214 (copy)
                        return u212:RemoveAsync(u214.ShortenedCode);
                    end);
                    if not v217 then
                        print("Error removing code, " .. l__Code__53 .. " from server data store");
                    end;
                end;
            else
                u208[v213] = nil;
                print("No data for server data store. Code: " .. l__Code__53);
            end;
        end;
    end;
    if #u4.ReturnServerList(u208) < 16 then
        u208[tostring(u209)] = u211;
    end;
    local v218, v219 = u1(function() --[[ Line: 2402 ]]
        -- upvalues: u212 (ref), u210 (copy), u208 (ref)
        return u212:SetAsync(u210, u208);
    end);
    if not v218 then
        print("Error setting server data: " .. v219);
        if tostring(v219) == "105: Serialized value exceeds 260,000 character limit." then
            local v220, _ = u1(function() --[[ Line: 2410 ]]
                -- upvalues: u209 (copy), u211 (ref), u212 (ref), u210 (copy)
                return u212:SetAsync(u210, {
                    [tostring(u209)] = u211
                });
            end);
            if v220 then
                print("Server data filled up...! Reset the data.");
            else
                print("Server data filled up...! Was --UNABLE-- to reset the data.");
            end;
        end;
    end;
    local v221, v222 = u1(function() --[[ Line: 2426 ]]
        -- upvalues: u206 (copy), u208 (ref)
        return _G[u206]:SetAsync(u206, u208);
    end);
    if not v221 then
        print("Error setting gamemode data: " .. v222);
        if tostring(v222) == "105: Serialized value exceeds 260,000 character limit." then
            local v223, _ = u1(function() --[[ Line: 2434 ]]
                -- upvalues: u208 (ref), u209 (copy), u211 (ref), u206 (copy)
                u208 = {
                    [tostring(u209)] = u211
                };
                return _G[u206]:SetAsync(u206, u208);
            end);
            if v223 then
                print("Gamemode data filled up...! Reset the data.");
            else
                print("Gamemode data filled up...! Was --UNABLE-- to reset the data.");
            end;
        end;
    end;
    return u208;
end;
function u4.Debris(u224, p225) --[[ Line: 2453 ]]
    -- upvalues: u4 (copy)
    u4.Delay(p225, function() --[[ Line: 2454 ]]
        -- upvalues: u224 (copy)
        if u224 then
            u224:Destroy();
        end;
    end);
end;
function u4.ReturnRomanNumeral(p226) --[[ Line: 2459 ]]
    local v227 = {
        { 1000, "M" },
        { 900, "CM" },
        { 500, "D" },
        { 400, "CD" },
        { 100, "C" },
        { 90, "XC" },
        { 50, "L" },
        { 40, "XL" },
        { 10, "X" },
        { 9, "IX" },
        { 5, "V" },
        { 4, "IV" },
        { 1, "I" }
    };
    local v228 = "";
    while p226 > 0 do
        for _, v229 in pairs(v227) do
            local v230 = v229[2];
            local v231 = v229[1];
            while v231 <= p226 do
                v228 = v228 .. v230;
                p226 = p226 - v231;
            end;
        end;
    end;
    return v228;
end;
function u4.ReturnIsEven(p232) --[[ Line: 2493 ]]
    return p232 % 2 == 0;
end;
function u4.OwnCocoJumbo(p233) --[[ Line: 2497 ]]
    local l__Coco_Jumbos__54 = workspace.Coco_Jumbos;
    if not p233 then
        return false;
    end;
    local v234 = l__Coco_Jumbos__54:FindFirstChild(p233.Name, true);
    if v234 then
        return v234;
    end;
    for _, v235 in pairs(l__Coco_Jumbos__54:GetChildren()) do
        local l__Owner__55 = v235.Owner;
        local v236 = l__Owner__55:GetChildren();
        if #v236 == 0 or not game.Players:FindFirstChild(v236[1].Name) then
            local v237 = Instance.new("Folder");
            v237.Name = p233.Name;
            v237.Parent = l__Owner__55;
            return v235;
        end;
    end;
    return v234;
end;
function u4.ReturnInGameMode() --[[ Line: 2524 ]]
    -- upvalues: l__ReplicatedStorage__6 (copy)
    return (l__ReplicatedStorage__6.Game_Modes["1v1s"].PlaceIds:FindFirstChild(game.PlaceId) or (l__ReplicatedStorage__6.Game_Modes["2v2s"].PlaceIds:FindFirstChild(game.PlaceId) or l__ReplicatedStorage__6.Game_Modes["Metal Ball Run"].PlaceIds:FindFirstChild(game.PlaceId))) and true or false;
end;
function u4.EnterCocoJumbo(u238, u239, p240, p241) --[[ Line: 2534 ]]
    -- upvalues: l__CollectionService__8 (copy), l__Debris2__12 (copy), u4 (copy), l__ServerStorage__5 (copy)
    if l__CollectionService__8:HasTag(u238, "Ragdolled") or (l__CollectionService__8:HasTag(u238, "Bites the Dust") or u238:FindFirstChild("ExitedCocoJumbo")) then
    else
        local v242 = p240 or 5;
        local u243 = game.Players:GetPlayerFromCharacter(u238);
        local v244 = u238:FindFirstChild("InCocoJumbo");
        local v245 = l__CollectionService__8:HasTag(u238, "Time Acceleration");
        if v245 then
            local v246 = v245:FindFirstChild("Seat");
            local v247 = u238:FindFirstChild("BindableEvent");
            if u238:FindFirstChild("Humanoid") and (v246 and v247) then
                v247:Fire("Knock", 1);
                v247:Fire("AddWalkSpeed", {
                    Name = "InCocoJumboSBR",
                    Value = -100,
                    Timer = v242
                });
                local v248 = Instance.new("StringValue");
                l__Debris2__12:AddItem(v248, v242);
                v248.Name = "InCocoJumbo";
                v248.Value = u239;
                v248.Parent = u238;
                v248:SetAttribute("VictimOriginPosition", u238.PrimaryPart.Position);
                return;
            end;
        end;
        if v244 then
        else
            local v249 = workspace.Coco_Jumbos:FindFirstChild(u239, true);
            if v249 then
                local l__Parent__56 = v249.Parent.Parent;
                local l__CFrame__57 = u238.HumanoidRootPart.CFrame;
                local v250 = Instance.new("StringValue");
                v250.Parent = u238;
                v250.Name = "InCocoJumbo";
                v250.Value = u239;
                local v251 = Instance.new("ObjectValue");
                v251.Parent = v250;
                v251.Name = "Captor";
                v251.Value = p241;
                local v252 = Instance.new("CFrameValue");
                v252.Parent = v250;
                v252.Name = "CFrame";
                v252.Value = l__CFrame__57;
                if u243 then
                    local u253 = nil;
                    local v254 = p241 or u243;
                    if v254 then
                        local v255 = _G.Playerlist[v254.Name].ReturnStandsData();
                        if v255.Main and (v255.Main.Skin and v255.Main.Skin ~= "None") then
                            u253 = v255.Main.Skin;
                        end;
                    end;
                    u4.pcall(function() --[[ Line: 2604 ]]
                        -- upvalues: u238 (copy), u243 (copy), l__Parent__56 (ref), u253 (ref)
                        u238.RemoteFunction:InvokeClient(u243, "EnterCocoJumbo", {
                            Room = l__Parent__56.Name,
                            Skin = u253
                        });
                    end);
                end;
                u238.BindableEvent:Fire("AddTP", {
                    CFrame = l__Parent__56.Teleport.CFrame
                });
                local u256 = l__ServerStorage__5.Objects.ExitCocoJumbo:Clone();
                u256.Parent = u243.PlayerGui;
                u256.TextButton.Visible = false;
                u4.Delay(v242, function() --[[ Line: 2618 ]]
                    -- upvalues: u256 (copy), u243 (copy), l__CFrame__57 (copy), u239 (copy), u4 (ref), u238 (copy)
                    if u256 == nil or u256.Parent == nil then
                    else
                        u256.TextButton.Visible = true;
                        local u257 = nil;
                        local u258 = nil;
                        u257 = u256.TextButton.MouseButton1Click:connect(function() --[[ Line: 2626 ]]
                            -- upvalues: u258 (ref), u243 (ref), l__CFrame__57 (ref), u239 (ref), u4 (ref), u238 (ref), u257 (ref)
                            if u258 then
                            else
                                u258 = true;
                                local l__Value__58 = u243.PlayerStats.Race.Value;
                                local v259 = workspace.Spawns[l__Value__58 == "Majin" and "Human" or l__Value__58];
                                local _ = v259:GetChildren()[math.random(1, #v259:GetChildren())];
                                local v260 = l__CFrame__57;
                                local v261 = game.Players:FindFirstChild(u239);
                                if v261 and (v261.Character and (v261.Character:findFirstChild("InCocoJumbo") == nil and (v261.Character:FindFirstChild("HumanoidRootPart") and not u4.ReturnInGameMode()))) then
                                    v260 = v261.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0);
                                end;
                                u4.ExitCocoJumbo(u238, u239, v260);
                                u257:Disconnect();
                            end;
                        end);
                    end;
                end);
                return v250;
            end;
        end;
    end;
end;
function u4.ExitCocoJumbo(u262, p263, u264) --[[ Line: 2654 ]]
    -- upvalues: u4 (copy), l__Debris2__12 (copy)
    local v265 = game.Players:GetPlayerFromCharacter(u262);
    local v266 = u262:FindFirstChild("InCocoJumbo");
    local v267 = v266 and v266:FindFirstChild("Captor");
    if v267 then
        v267 = v266.Captor.Value;
    end;
    if v267 and v267.PrimaryPart then
        if not u4.ReturnInGameMode() then
            u264 = v267.PrimaryPart.CFrame;
        end;
        if v267:FindFirstChild("InCocoJumbo") then
            local v268 = v266:FindFirstChild("CFrame");
            if v268 then
                u264 = v268.Value;
            end;
        end;
    end;
    if not u264 then
        local l__Value__59 = v265.PlayerStats.Race.Value;
        local v269 = workspace.Spawns[l__Value__59 == "Majin" and "Human" or l__Value__59];
        u264 = v269:GetChildren()[math.random(1, #v269:GetChildren())].CFrame;
        if v266:GetAttribute("VictimOriginPosition") then
            u264 = CFrame.new(v266:GetAttribute("VictimOriginPosition"));
        end;
    end;
    local v270 = Instance.new("Folder");
    l__Debris2__12:AddItem(v270, 1);
    v270.Name = "ExitedCocoJumbo";
    v270.Parent = u262;
    local v271 = workspace.Coco_Jumbos:FindFirstChild(p263, true);
    if v271 then
        local l__Parent__60 = v271.Parent.Parent;
        u262.BindableEvent:Fire("AddInvincibility", {
            Name = "ExitingCocoJumbo",
            Timer = 1
        });
        local u272 = Instance.new("BodyPosition");
        l__Debris2__12:AddItem(u272, 6);
        u272.Position = l__Parent__60.Top.Position - Vector3.new(0, 5, 0);
        u272.MaxForce = Vector3.new(100000, 100000, 100000);
        u272.P = 100000;
        if v265 then
            u262.BindableEvent:Fire("AddForce", {
                Force = u272,
                Origin = u262.UpperTorso
            });
        else
            u272.Parent = u262.UpperTorso;
        end;
        u4.Delay(1, function() --[[ Line: 2723 ]]
            -- upvalues: u272 (copy), u262 (copy), u264 (ref)
            u272:Destroy();
            u262.BindableEvent:Fire("AddTP", {
                CFrame = u264
            });
            for _, v273 in pairs(u262:GetChildren()) do
                if v273.Name == "InCocoJumbo" then
                    v273:Destroy();
                end;
            end;
        end);
    else
        u262.BindableEvent:Fire("AddTP", {
            CFrame = u264
        });
        for _, v274 in pairs(u262:GetChildren()) do
            if v274.Name == "InCocoJumbo" then
                v274:Destroy();
            end;
        end;
    end;
    if v265 then
        for _, v275 in pairs(v265.PlayerGui:GetChildren()) do
            if v275.Name == "ExitCocoJumbo" then
                v275:Destroy();
            end;
        end;
    end;
end;
function u4.Round(p276, p277) --[[ Line: 2753 ]]
    local v278 = 10 ^ (p277 or 0);
    return math.floor(p276 * v278 + 0.5) / v278;
end;
function u4.Ban(...) --[[ Line: 2758 ]]
    -- upvalues: l__ServerStorage__5 (copy), u4 (copy), u1 (copy)
    local v279 = ...;
    local l__Id__61 = v279.Id;
    local l__Type__62 = v279.Type;
    local l__Reason__63 = v279.Reason;
    local l__Admin__64 = v279.Admin;
    local u280 = l__Admin__64 and (l__Admin__64.Name or "?") or "?";
    if l__Admin__64 then
        local l__LastBanned__65 = l__ServerStorage__5.PlayerData[l__Admin__64.Name].LastBanned;
        if os.time() - l__LastBanned__65.Value < 10 then
            local v281 = u4.convertToHMS(10 - (os.time() - l__LastBanned__65.Value));
            l__Admin__64.Character.RemoteEvent:FireClient(l__Admin__64, "Message", {
                Duration = 5,
                Text = "Admin is on cooldown: " .. v281 .. " remaining"
            });
            return;
        end;
        l__LastBanned__65.Value = os.time();
    end;
    local v282 = l__ServerStorage__5.Admins:FindFirstChild("Group");
    for _, v283 in pairs(game:GetService("GroupService"):GetGroupsAsync((tonumber(l__Id__61)))) do
        if v283.Id == v282.ID.Value and (l__Type__62 and v283.Rank >= 6) then
            _G.DiscordWebhook("Tag1", u280 .. " tried to ban User ID " .. l__Id__61 .. ", but it failed because the user is in the group, " .. v283.Name .. ", with the role, " .. v283.Role, "Admin CMD Usage", "BAN Attempt");
            return;
        end;
    end;
    local u284 = nil;
    local u285 = {};
    local v288, v289 = u1(function() --[[ Line: 2796 ]]
        -- upvalues: u284 (ref), l__Id__61 (copy), u285 (copy)
        u284 = _G.BansDataStore:GetAsync(l__Id__61);
        if u284 then
            for v286, v287 in pairs(u284) do
                u285[v286] = v287;
            end;
        end;
    end);
    if v288 then
        if u284 and u284.Banned == l__Type__62 then
            local v290 = l__Type__62 and "Ban" or "Unban";
            if u280 ~= "?" then
                _G.DiscordWebhook("Tag1", u280 .. " tried to " .. v290 .. " User ID " .. l__Id__61 .. ", but it failed because the user is already " .. v290 .. "ned. (Tag - " .. game.GameId .. " | Reason - " .. tostring(u284.Reason) .. ")", "Admin CMD Usage", string.upper(v290) .. " Attempt");
            end;
        else
            if v288 and (l__Type__62 and u280 == "?") then
                _G.DiscordWebhook("Tag2", "The anti exploit banned User ID " .. l__Id__61 .. " (Tag - " .. game.GameId .. " | Reason - " .. tostring(l__Reason__63) .. ")", "GAME BAN", "ANTI EXPLOIT", "828598073143984182");
            end;
            local v298, v299 = u1(function() --[[ Line: 2827 ]]
                -- upvalues: l__Id__61 (copy), l__Type__62 (copy), l__Reason__63 (copy), u280 (copy)
                local v291 = os.time();
                local v292 = os.date("*t", v291);
                _G.RankingsSeason = v292.year .. v292.month;
                local l__BansDataStore__66 = _G.BansDataStore;
                local v293 = l__Id__61;
                local v294 = {
                    Banned = l__Type__62,
                    Reason = l__Reason__63 or "",
                    OsTime = v291
                };
                local v295 = l__Type__62;
                if v295 then
                    v295 = v292.year;
                end;
                v294.Year = v295;
                local v296 = l__Type__62;
                if v296 then
                    v296 = v292.month;
                end;
                v294.Month = v296;
                local v297 = l__Type__62;
                if v297 then
                    v297 = v292.day;
                end;
                v294.Day = v297;
                v294.Admin = u280;
                return l__BansDataStore__66:SetAsync(v293, v294);
            end);
            if v298 then
                if l__Type__62 then
                    for _, v300 in pairs(game.Players:GetChildren()) do
                        if v300.UserId == l__Id__61 then
                            v300:Kick(l__Reason__63 or "");
                        end;
                    end;
                end;
                return u285;
            end;
            print("UNABLE TO BAN! ERROR: " .. v299);
        end;
    else
        print(v289);
    end;
end;
function u4.convertToHMS(p301) --[[ Line: 2857 ]]
    local v302 = (p301 - p301 % 60) / 60;
    local v303 = p301 - v302 * 60;
    local v304 = (v302 - v302 % 60) / 60;
    local v305 = v302 - v304 * 60;
    return string.format("%02i", v304) .. ":" .. string.format("%02i", v305) .. ":" .. string.format("%02i", v303);
end;
function u4.ReturnRandomPercentile(p306) --[[ Line: 2870 ]]
    local v307 = math.random();
    local v308 = { unpack(p306) };
    local v309 = { unpack(p306) };
    local v310 = 0;
    for v311 = 1, #v308 do
        v308[v311] = table.remove(v309, math.random(#v309));
    end;
    for v312 = 1, #v308 do
        if v307 < v308[v312].Percentage + v310 then
            return v308[v312];
        end;
        v310 = v310 + v308[v312].Percentage;
    end;
    print("Percent total was lower than 100.. returning random in table...");
    return v308[math.random(1, #v308)];
end;
function u4.FindIn(p313, p314) --[[ Line: 2894 ]]
    local v315 = {};
    for _, v316 in pairs(p313:GetChildren()) do
        if v316.Name:lower() == p314:lower() then
            return v316;
        end;
        v315[v316.Name:sub(1, #p314):lower()] = v316;
    end;
    if v315[p314:lower()] then
        return v315[p314:lower()];
    else
        return nil;
    end;
end;
function u4.FilterGangName(u317, u318) --[[ Line: 2912 ]]
    -- upvalues: u4 (copy)
    local v319 = {
        rozenstruik = 64217106,
        passione = 427348404
    };
    local u320 = true;
    if u318 ~= "" and string.len(u318) <= 15 then
        local v321 = game:GetService("Chat"):FilterStringForBroadcast(u318, u317);
        if string.sub(v321, 1, 1) ~= "#" then
            local v322 = true;
            for v323 = 1, #v321 do
                local v324 = v321:sub(v323, v323);
                if not string.match(v324, "%u") then
                    if not string.match(v324, "%l") then
                        v322 = false;
                    end;
                end;
            end;
            if v322 then
                u320 = false;
            end;
        end;
        u4.pcall(function() --[[ Line: 2943 ]]
            -- upvalues: u318 (copy), u317 (copy), u320 (ref)
            local v325 = game:GetService("TextService"):FilterStringAsync(u318, u317.UserId):GetChatForUserAsync(u317.UserId);
            for v326 = 1, #v325 do
                if string.sub(v325, v326, v326) == "#" then
                    u320 = true;
                    return;
                end;
            end;
        end);
        u4.pcall(function() --[[ Line: 2957 ]]
            -- upvalues: u318 (copy), u320 (ref)
            if _G.GangsBLDataStore:GetAsync(string.lower(u318)) then
                u320 = true;
            end;
        end);
    end;
    if v319[string.lower(u318)] then
        if v319[string.lower(u318)] == u317.UserId then
            print(u318 .. " was whitelisted to " .. u317.Name .. "!");
            u320 = false;
        else
            print(u318 .. " is reserved!");
            u320 = true;
        end;
    end;
    local v327 = _G.GangsDataStore:GetAsync(u318);
    local v328 = v327 and (v327.Owner ~= 0 and v327.Owner ~= u317.UserId) and true or u320;
    print(u318 .. " Filtered: " .. tostring(v328));
    return v328;
end;
function u4.DiscordWebhook(_, u329, p330, p331, u332, u333) --[[ Line: 2986 ]]
    -- upvalues: u1 (copy), l__ServerStorage__5 (copy)
    local u334 = p330 or "";
    local u335 = p331 or "";
    u1(function() --[[ Line: 2990 ]]
        -- upvalues: u332 (copy), u334 (ref), u335 (ref), u329 (copy), l__ServerStorage__5 (ref), u333 (copy)
        local v336 = u332 or {
            title = u334,
            description = u335,
            timestamp = os.time,
            color = 2951298,
            footer = {
                text = u329 or ""
            },
            thumbnail = {
                url = "http://www.robertspestcontrol.com/wp-content/uploads/2015/06/roaches-austin-tx-4.jpg",
                height = 200,
                width = 200
            }
        };
        require(l__ServerStorage__5.Modules.SGBot):PostMessage({
            Embed = v336,
            ChannelId = u333
        });
        game:GetService("HttpService");
    end);
end;
function u4.RemoveGravity(p337) --[[ Line: 3018 ]]
    for _, v338 in pairs(p337:GetChildren()) do
        if v338.Name == "Gravity_Tag" then
            v338:Destroy();
        end;
    end;
end;
function u4.AddGravity(p339, ...) --[[ Line: 3026 ]]
    -- upvalues: u4 (copy), l__Debris2__12 (copy)
    local v340 = ...;
    u4.RemoveGravity(p339);
    local v341 = Instance.new("NumberValue", p339);
    v341.Value = v340.Gravity;
    v341.Name = "Gravity_Tag";
    if v340.Duration then
        l__Debris2__12:AddItem(v341, v340.Duration);
    end;
    return v341;
end;
function u4.ReturnStandArms(...) --[[ Line: 3040 ]]
    -- upvalues: l__Debris2__12 (copy), l__ReplicatedStorage__6 (copy), l__ServerStorage__5 (copy), u4 (copy)
    local v342 = ...;
    local l__StandInFolder__67 = v342.StandInFolder;
    local l__UseChar__68 = v342.UseChar;
    local l__Char__69 = v342.Char;
    local v343 = v342.Despawn or 60;
    local u344 = Instance.new("Model");
    l__Debris2__12:AddItem(u344, v343);
    u344.Parent = l__ReplicatedStorage__6;
    local u345 = Instance.new("Model");
    l__Debris2__12:AddItem(u345, v343);
    u345.Parent = l__ReplicatedStorage__6;
    local u346 = {
        HumanoidRootPart = true,
        Torso = true,
        UpperTorso = true,
        LowerTorso = true
    };
    local u347 = v342.LimbType or "Arm";
    local u348 = "Lower" .. u347;
    local v349 = game.Players:GetPlayerFromCharacter(l__Char__69) or game.Players:GetPlayerFromCharacter(l__Char__69.Parent);
    if l__UseChar__68 then
        l__StandInFolder__67 = l__Char__69;
    elseif v349 then
        local v350 = _G.Playerlist[v349.Name].ReturnStandsData();
        if v350.Main and (v350.Main.Skin and v350.Main.Skin ~= "None") then
            l__StandInFolder__67 = l__ServerStorage__5.Skins[v350.Main.Skin].StandMorph;
        end;
    end;
    u4.pcall(function() --[[ Line: 3077 ]]
        -- upvalues: u344 (copy), u345 (copy), u348 (ref), u347 (copy), l__StandInFolder__67 (ref), l__UseChar__68 (copy), u346 (copy)
        for v351 = 1, 2 do
            local v352 = u344;
            local v353;
            if v351 == 2 then
                v352 = u345;
                v353 = "Left";
            else
                v353 = "Right";
            end;
            for v354 = 1, 3 do
                if v354 == 1 then
                    u348 = "Lower" .. u347;
                elseif v354 == 2 then
                    u348 = "Upper" .. u347;
                elseif v354 == 3 then
                    u348 = u347 == "Arm" and "Hand" or (u347 == "Leg" and "Foot" or false);
                end;
                local v355 = l__StandInFolder__67:FindFirstChild(v353 .. u348);
                if not v355 then
                    for _, v356 in pairs(l__StandInFolder__67:GetDescendants()) do
                        if (v356:IsA("BasePart") or v356:IsA("UnionOperation")) and v356.Name == v353 .. u348 then
                            v355 = v356;
                            break;
                        end;
                    end;
                end;
                local v357 = v355:Clone();
                for _, v358 in pairs(v357:GetChildren()) do
                    if v358:IsA("SurfaceAppearance") or (v358:IsA("Decal") or v358:IsA("Texture")) then
                        if v358:IsA("Decal") or v358:IsA("Texture") then
                            v358.Transparency = v358:GetAttribute("Transparent") and 1 or (v358:GetAttribute("Transparency") or 0);
                        end;
                    else
                        v358:Destroy();
                    end;
                end;
                v357.CastShadow = false;
                v357.CanTouch = false;
                v357.CanCollide = false;
                v357.Anchored = true;
                v357.Material = "Glass";
                v357.Transparency = v355:GetAttribute("Transparent") and 1 or (v355:GetAttribute("Transparency") or 0);
                v357.Parent = v352;
                if v352.PrimaryPart == nil then
                    v352.PrimaryPart = v357;
                end;
                if not l__UseChar__68 then
                    for _, v359 in pairs(l__StandInFolder__67:GetDescendants()) do
                        if (v359:IsA("BasePart") or v359:IsA("UnionOperation")) and not u346[v359.Name] then
                            for _, v360 in pairs(v359:GetChildren()) do
                                if (v360:IsA("Weld") or (v360:IsA("Motor6D") or (v360:IsA("ManualWeld") or v360:IsA("WeldConstraint")))) and (v360.Part0 == v355 or v360.Part1 == v355) then
                                    local v361;
                                    if v359 == v355 then
                                        if v360.Part0 == v355 then
                                            v361 = v360.Part1;
                                        elseif v360.Part1 == v355 then
                                            v361 = v360.Part0;
                                        else
                                            v361 = v359;
                                        end;
                                    else
                                        v361 = v359;
                                    end;
                                    if v361 and not u346[v361.Name] then
                                        local v362 = v361:Clone();
                                        for _, v363 in pairs(v362:GetChildren()) do
                                            if v363:IsA("SurfaceAppearance") or (v363:IsA("Decal") or v363:IsA("Texture")) then
                                                if v363:IsA("Decal") or v363:IsA("Texture") then
                                                    v363.Transparency = v363:GetAttribute("Transparent") and 1 or (v363:GetAttribute("Transparency") or 0);
                                                end;
                                            else
                                                v363:Destroy();
                                            end;
                                        end;
                                        v362.CanTouch = false;
                                        v362.CastShadow = false;
                                        v362.Material = "Glass";
                                        v362.CanCollide = false;
                                        v362.Anchored = true;
                                        v362.Transparency = v361:GetAttribute("Transparent") and 1 or (v361:GetAttribute("Transparency") or 0);
                                        v362.Parent = v352;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                for _, v364 in pairs(v352:GetChildren()) do
                    if v364 ~= v352.PrimaryPart then
                        local v365 = Instance.new("Weld");
                        v365.Part0 = v352.PrimaryPart;
                        v365.Part1 = v364;
                        local v366 = CFrame.new(v352.PrimaryPart.Position);
                        local v367 = v352.PrimaryPart.CFrame:inverse() * v366;
                        local v368 = v364.CFrame:inverse() * v366;
                        v365.C0 = v367;
                        v365.C1 = v368;
                        v365.Parent = v364;
                        v364.Anchored = false;
                    end;
                end;
            end;
        end;
    end);
    return u344, u345;
end;
function u4.Random_SFX(p369, p370, p371) --[[ Line: 3196 ]]
    -- upvalues: u4 (copy)
    local v372 = p369:GetChildren();
    local v373 = v372[math.random(1, #v372)];
    if p371 then
        return u4.PlaySound({
            Return = true,
            Sound = v373,
            Origin = p370
        });
    end;
    u4.PlaySound({
        Sound = v373,
        Origin = p370
    });
end;
function u4.PlaySound(...) --[[ Line: 3216 ]]
    -- upvalues: u4 (copy), l__ReplicatedStorage__6 (copy), u3 (copy), l__TweenService__7 (copy)
    local u374 = {};
    local u375 = ... or {};
    local l__LocalPlayer__70 = game.Players.LocalPlayer;
    if u375.ClientOnly or not (game.Lighting:FindFirstChild("InAcidicSpew") or l__LocalPlayer__70 and (l__LocalPlayer__70:FindFirstChild("LoadingScreen1") or l__LocalPlayer__70:FindFirstChild("LoadingScreen"))) then
        u4.pcall(function() --[[ Line: 3223 ]]
            -- upvalues: u375 (copy), l__ReplicatedStorage__6 (ref), u3 (ref), u4 (ref), l__TweenService__7 (ref), u374 (copy)
            local v376 = {};
            local v377 = {};
            local l__Sound__71 = u375.Sound;
            if typeof(l__Sound__71) == "table" then
                v376 = l__Sound__71;
            else
                table.insert(v376, l__Sound__71);
            end;
            for _, v378 in pairs(v376) do
                local v379;
                if typeof(v378) == "string" then
                    v379 = l__ReplicatedStorage__6.Sounds:findFirstChild(v378) or v378;
                else
                    v379 = v378;
                end;
                if not v378 or typeof(v379) == "string" then
                    print("Error while trying to play sound: " .. tostring(v379));
                    return;
                end;
                local v380 = v379:Clone();
                if u3 and not (u375.Lifetime or u375.Return) then
                    v380.Name = "Sound";
                end;
                v377[v380] = {
                    Original = v379,
                    Replica = v380
                };
            end;
            local function u383(p381) --[[ Line: 3254 ]]
                -- upvalues: u375 (ref), u4 (ref), l__TweenService__7 (ref)
                local l__Replica__72 = p381.Replica;
                local l__Original__73 = p381.Original;
                l__Replica__72:Play();
                local v382 = u375.Lifetime or l__Original__73.TimeLength / p381.Pitch + 0.05;
                local l__FadeOut__74 = u375.FadeOut;
                if l__FadeOut__74 then
                    u4.Delay(v382 - l__FadeOut__74, function() --[[ Line: 3264 ]]
                        -- upvalues: l__TweenService__7 (ref), l__Replica__72 (copy), l__FadeOut__74 (copy)
                        l__TweenService__7:Create(l__Replica__72, TweenInfo.new(l__FadeOut__74, Enum.EasingStyle.Linear), {
                            Volume = 0
                        }):Play();
                    end);
                end;
                u4.Delay(v382, function() --[[ Line: 3270 ]]
                    -- upvalues: l__Replica__72 (copy)
                    l__Replica__72:Destroy();
                end);
                if u375.Position then
                    u4.Delay(v382, function() --[[ Line: 3275 ]]
                        -- upvalues: l__Replica__72 (copy)
                        l__Replica__72:Destroy();
                    end);
                end;
            end;
            if u375.ClientOnly == true then
                u375.Origin = workspace;
            elseif u375.Position then
                u375.Origin = Instance.new("Part");
                u375.Origin.Anchored = true;
                u375.Origin.CanCollide = false;
                u375.Origin.Position = u375.Position;
                u375.Origin.Transparency = 1;
                u375.Origin.Parent = workspace:FindFirstChild("IgnoreInstances");
            end;
            for _, u384 in pairs(v377) do
                u4.Spawn(function() --[[ Line: 3293 ]]
                    -- upvalues: u384 (copy), u375 (ref), u374 (ref), u383 (copy)
                    local l__Replica__75 = u384.Replica;
                    local _ = u384.Original;
                    if u375.TimePosition then
                        l__Replica__75.TimePosition = u375.TimePosition;
                    end;
                    local l__Pitch__76 = u375.Pitch;
                    u384.Pitch = l__Replica__75.Pitch;
                    if l__Pitch__76 then
                        l__Replica__75.Pitch = l__Pitch__76;
                        u384.Pitch = l__Pitch__76;
                    end;
                    if u375.Volume then
                        l__Replica__75.Volume = u375.Volume;
                    end;
                    l__Replica__75.Parent = u375.Origin;
                    if u375.Return then
                        table.insert(u374, l__Replica__75);
                    else
                        u383(u384);
                    end;
                end);
            end;
        end);
        return u374;
    end;
end;
function u4.StandFade(u385, u386, u387) --[[ Line: 3328 ]]
    -- upvalues: u4 (copy), l__IgnoreInstances__13 (copy), l__wait__4 (copy), l__Anims__17 (copy)
    u4.pcall(function() --[[ Line: 3329 ]]
        -- upvalues: u387 (copy), u386 (copy), l__IgnoreInstances__13 (ref), u4 (ref), u385 (copy), l__wait__4 (ref), l__Anims__17 (ref)
        local v388 = u387 or {};
        local l__Instant__77 = v388.Instant;
        local u389 = v388.TweenInfo or TweenInfo.new(v388.FadeTime or 0.7, v388.EasingStyle or Enum.EasingStyle.Quint, v388.EasingDirection or Enum.EasingDirection.Out);
        local v390 = u386:GetDescendants();
        local l__Value__78 = u386.StandSkin.Value;
        local l__Parent__79 = u386.Parent;
        local v391 = u386:FindFirstChild("CustomEquip");
        local v392;
        if l__Parent__79 then
            v392 = l__IgnoreInstances__13.StandMorphs:FindFirstChild(l__Parent__79.Name);
        else
            v392 = l__Parent__79;
        end;
        if v392 then
            for _, v393 in pairs(v392:GetDescendants()) do
                table.insert(v390, v393);
            end;
        end;
        if v391 and v391.Value == "Anubis" then
            local u394 = l__Parent__79:FindFirstChild("SwordSheath");
            local u395 = {
                ["Kanshou & Bakuya"] = true,
                ["Elucidator & Dark Repulser"] = true,
                Sasageyo = true,
                ["Linked Sword"] = true,
                Bloodthirster = true,
                ["Spirit Bomb Sword"] = true,
                ["Blade of The Exile"] = true
            };
            if u395[l__Value__78] then
                l__Instant__77 = nil;
                for _, v396 in pairs(u394:GetDescendants()) do
                    if v396:IsA("BasePart") then
                        table.insert(v390, v396);
                    end;
                end;
            else
                l__Instant__77 = true;
            end;
            u4.pcall(function() --[[ Line: 3375 ]]
                -- upvalues: u385 (ref), u395 (copy), l__Value__78 (copy), u4 (ref), u394 (copy), l__Parent__79 (copy), l__wait__4 (ref), l__Anims__17 (ref)
                if u385 then
                    if u395[l__Value__78] then
                        u4.PlaySound({
                            Sound = u394.Handle.UnsheatheSound,
                            Origin = l__Parent__79.HumanoidRootPart
                        });
                        l__wait__4(0.2);
                    else
                        l__Parent__79.Humanoid:LoadAnimation(l__Anims__17["Anubis Unsheathe"]):Play();
                        l__wait__4(0.2);
                        u4.PlaySound({
                            Sound = u394.Handle.UnsheatheSound,
                            Origin = l__Parent__79.HumanoidRootPart
                        });
                    end;
                end;
                for _, v397 in pairs(u394.Sword:GetChildren()) do
                    v397.Transparency = u385 and 1 or 0;
                end;
            end);
        end;
        local l__TweenService__80 = game:GetService("TweenService");
        local u398 = u385 and 0 or 1;
        local function v408(u399) --[[ Line: 3414 ]]
            -- upvalues: u398 (ref), u385 (ref), l__Instant__77 (ref), l__TweenService__80 (copy), u389 (copy), u4 (ref)
            if u399:IsA("Beam") or (u399:IsA("Decal") or (u399:IsA("Texture") or (u399:IsA("ParticleEmitter") or (u399:IsA("PointLight") or (u399:IsA("Trail") or u399:IsA("Script")))))) then
                if u399.Name ~= "Transparent" and not u399:GetAttribute("Transparent") then
                    if u399:IsA("Decal") or u399:IsA("Texture") then
                        local v400 = u398;
                        local v401 = u399:GetAttribute("Transparency");
                        if not v401 or u398 ~= 0 then
                            v401 = v400;
                        end;
                        u399.Transparency = v401;
                        return;
                    end;
                    if u399:IsA("Beam") or (u399:IsA("ParticleEmitter") or (u399:IsA("PointLight") or u399:IsA("Trail"))) then
                        u399.Enabled = u385;
                        return;
                    end;
                    if u399:IsA("Script") then
                    end;
                end;
            elseif u399:IsA("BasePart") or u399:IsA("UnionOperation") then
                if u399.Name ~= "HumanoidRootPart" then
                    local u402 = u399:GetAttribute("Transparency");
                    local v403 = u398;
                    if not u402 or u398 ~= 0 then
                        u402 = v403;
                    end;
                    if u385 and (u399.Name ~= "Transparent" and not u399:GetAttribute("Transparent")) then
                        if l__Instant__77 then
                            l__TweenService__80:Create(u399, TweenInfo.new(0), {
                                Transparency = u402
                            }):Play();
                            u399.Transparency = u402;
                        else
                            local v404 = {
                                Transparency = u402
                            };
                            local l__Material__81 = u399.Material;
                            local v405 = u399:IsA("MeshPart");
                            if v405 then
                                v405 = u399.TextureID;
                            end;
                            local l__Color__82 = u399.Color;
                            local u406 = l__TweenService__80:Create(u399, u389, v404);
                            u406:Play();
                            if v405 then
                                u4.Delay(u389.Time * 0.5, function() --[[ Line: 3464 ]] end);
                            end;
                            u4.Spawn(function() --[[ Line: 3469 ]]
                                -- upvalues: u406 (copy), u399 (copy), u402 (ref), l__Material__81 (copy), l__Color__82 (copy)
                                u406.Completed:wait();
                                u399.Transparency = u402;
                                u399.Material = l__Material__81;
                                u399.Color = l__Color__82;
                            end);
                        end;
                    elseif not u385 then
                        if l__Instant__77 then
                            l__TweenService__80:Create(u399, TweenInfo.new(0), {
                                Transparency = u402
                            }):Play();
                            u399.Transparency = u402;
                        else
                            local u407 = l__TweenService__80:Create(u399, u389, {
                                Transparency = u402
                            });
                            u407:Play();
                            u4.Spawn(function() --[[ Line: 3488 ]]
                                -- upvalues: u407 (copy), u399 (copy), u402 (ref)
                                u407.Completed:wait();
                                u399.Transparency = u402;
                            end);
                        end;
                    end;
                    return;
                end;
                u399.Transparency = 1;
                l__TweenService__80:Create(u399, TweenInfo.new(0), {
                    Transparency = 1
                }):Play();
            end;
        end;
        for _, v409 in pairs(v390) do
            if v409:IsA("ObjectValue") and (v409:GetAttribute("StandObject") and v409.Value) then
                v408(v409.Value);
            else
                v408(v409);
            end;
        end;
    end);
end;
function u4.SummonSixPistolsBullet(u410, ...) --[[ Line: 3514 ]]
    -- upvalues: l__ReplicatedStorage__6 (copy), l__ClientFX__16 (copy), l__ServerStorage__5 (copy), l__Debris2__12 (copy), u4 (copy), l__wait__4 (copy)
    local l__ChannelMod2__83 = require(l__ReplicatedStorage__6:WaitForChild("Modules"):WaitForChild("ChannelMod2"));
    local l__CombatStyleLibrary__84 = require(l__ReplicatedStorage__6:WaitForChild("Modules"):WaitForChild("CombatStyleLibrary"));
    local l__Char__85 = u410.Char;
    local l__Stand__86 = u410.Stand;
    local u411 = ... or {};
    for _, v412 in pairs(workspace.Living:GetChildren()) do
        local v413 = game.Players:GetPlayerFromCharacter(v412);
        local v414 = v412:findFirstChild("HumanoidRootPart");
        if v413 and (v414 and (v414.Position - u410.Root.Position).magnitude <= 10) then
            v412.RemoteEvent:FireClient(v413, "CameraShake", {
                Origin = u410.LowerTorso
            });
        end;
    end;
    l__ClientFX__16:FireAllClients("PlaySound", {
        Sound = "Gun_Shot1",
        Origin = l__Char__85.HumanoidRootPart
    });
    l__ClientFX__16:FireAllClients("Shoot Six Pistols", {
        Origin = l__Stand__86.FirePart
    });
    local u415 = 5;
    if u410.Player then
        local v416 = 1;
        for _, v417 in pairs(u410.StandSkillTree:GetChildren()) do
            if v417.Name:match("Marksman ") and v417.Value then
                v416 = v416 + 0.25;
            end;
        end;
        u415 = u415 * v416;
    end;
    local l__Position__87 = u410.Root.Position;
    local u418 = -(u410.Root.Position - u410.RemoteFunction:InvokeClient(u410.Player, "ReturnMouseHit", {
        RayCast = true
    }).p).unit;
    local u419 = nil;
    local u420 = l__ServerStorage__5.Objects["Six Pistols Bullet"]:Clone();
    l__Debris2__12:AddItem(u420, 20);
    u420.CFrame = u410.Root.CFrame;
    u420.Parent = workspace.IgnoreInstances;
    u420.Name = u410.Char.Name .. " SP Bullet";
    u410.LastSPBullet = u420;
    local u421 = false;
    local u422 = nil;
    local u424 = l__ChannelMod2__83.new(8, function() --[[ Line: 3564 ]]
        -- upvalues: u421 (ref), u410 (copy), u420 (copy), u422 (ref), u4 (ref), l__Char__85 (copy), l__CombatStyleLibrary__84 (copy), u411 (copy), l__wait__4 (ref)
        if u421 then
        else
            u421 = true;
            if u410.LastSPBullet == u420 then
                u410.LastSPBullet = false;
            end;
            u420.Anchored = true;
            u420.Trail.Enabled = false;
            if u422 then
                u4.Spawn(function() --[[ Line: 3576 ]]
                    -- upvalues: l__Char__85 (ref), u422 (ref), l__CombatStyleLibrary__84 (ref), u411 (ref), u4 (ref)
                    local v423 = l__CombatStyleLibrary__84["Six Pistols"]("ReturnDamage_Info", {
                        Timer = 0.2,
                        Combo = "Shoot",
                        Stand = "Six Pistols",
                        Tag = l__Char__85.Name .. "Shoot Six Pistols",
                        Hit = u422.Hit,
                        Origin = l__Char__85.HumanoidRootPart
                    });
                    if u411.MultiShot then
                        v423.IgnoreBlock = false;
                    end;
                    u4.Damage(l__Char__85, u422.Victim, v423);
                end);
            end;
            l__wait__4(u420.Trail.Lifetime);
            u420:Destroy();
        end;
    end);
    local u425 = RaycastParams.new();
    u425.FilterType = Enum.RaycastFilterType.Exclude;
    u425.FilterDescendantsInstances = { l__Char__85, workspace.IgnoreInstances };
    function u424.Duration() --[[ Line: 3685 ]]
        -- upvalues: l__Position__87 (ref), u418 (ref), u419 (ref), u415 (ref), u425 (copy), u420 (copy), u422 (ref), u424 (copy), l__ClientFX__16 (ref)
        local v426 = workspace:Raycast(l__Position__87, u418 * (u419 or u415), u425);
        local v427;
        if v426 then
            v427 = v426.Instance;
        else
            v427 = v426;
        end;
        local v428;
        if v426 then
            v428 = v426.Position;
        else
            v428 = v426;
        end;
        if v426 then
            v426 = v426.Normal;
        end;
        if v428 then
            if v427 and not v427.CanCollide then
                v428 = v428 + u418 * (u419 or u415);
            end;
        else
            v428 = l__Position__87 + u418 * (u419 or u415);
        end;
        u420.CFrame = CFrame.new(l__Position__87:Lerp(v428, 0.5), v428 + u418);
        local v429 = l__Position__87;
        l__Position__87 = v428;
        if v427 and (v427:IsDescendantOf(workspace.Living) and (v427.Parent:findFirstChild("Health") or (v427.Parent.Parent:findFirstChild("Health") or v427.Parent.Parent.Parent:findFirstChild("Health")))) then
            local l__Parent__88 = (v427.Parent:findFirstChild("Health") or (v427.Parent.Parent:findFirstChild("Health") or v427.Parent.Parent.Parent:findFirstChild("Health"))).Parent;
            if l__Parent__88.Parent == workspace.Living then
                u422 = {
                    Victim = l__Parent__88,
                    Hit = v427
                };
                u424:StopShort();
            end;
        else
            if v427 and v427.CanCollide then
                l__ClientFX__16:FireAllClients("PlaySound", {
                    Sound = "Ricochet" .. math.random(1, 2),
                    Origin = u420
                });
                u418 = u418 - 2 * u418:Dot(v426) * v426;
                u419 = u415 - (v428 - v429).Magnitude;
                return;
            end;
            u419 = u415 - (v428 - v429).Magnitude;
        end;
    end;
    u424:Start();
end;
function u4.FocusCamera(...) --[[ Line: 3731 ]]
    local v430 = ...;
    local l__Object__89 = v430.Object;
    local l__Tween__90 = v430.Tween;
    local v431 = nil;
    if typeof(l__Object__89) == "Instance" then
        v431 = Instance.new("ObjectValue");
    elseif typeof(l__Object__89) == "CFrame" then
        v431 = Instance.new("CFrameValue");
    end;
    v431.Name = "FocusCam";
    v431.Value = l__Object__89;
    if l__Tween__90 then
        local v432 = Instance.new("NumberValue");
        v432.Name = "Tween";
        v432.Value = l__Tween__90;
        v432.Parent = v431;
        if v430.Destroy then
            local v433 = Instance.new("NumberValue");
            v433.Name = "Destroy";
            v433.Value = v430.Destroy;
            v433.Parent = v431;
        end;
    end;
    return v431;
end;
function u4.ReturnIsAdmin(u434) --[[ Line: 3764 ]]
    -- upvalues: u4 (copy), l__ServerStorage__5 (copy)
    local u435 = nil;
    u4.pcall(function() --[[ Line: 3767 ]]
        -- upvalues: l__ServerStorage__5 (ref), u434 (copy), u435 (ref)
        local v436 = l__ServerStorage__5.Admins:FindFirstChild("Group");
        if game:GetService("RunService"):IsStudio() then
            v436 = nil;
        end;
        if l__ServerStorage__5.Admins:findFirstChild(u434.UserId) or v436 and (u434:IsInGroup(v436.ID.Value) and u434:GetRankInGroup(v436.ID.Value) >= v436.Rank.Value) then
            u435 = "Moderator";
        end;
        if v436 and (u434:IsInGroup(v436.ID.Value) and u434:GetRankInGroup(v436.ID.Value) >= v436.Rank2.Value) then
            u435 = "Admin";
        end;
        if u434.UserId == 73169236 then
            u435 = "Admin";
        end;
    end);
    return u435;
end;
function u4.LevelUp(p437) --[[ Line: 3790 ]]
    -- upvalues: l__ClientFX__16 (copy)
    l__ClientFX__16:FireAllClients("LevelUp", {
        NoDist = true,
        Origin = p437.UpperTorso
    });
end;
function u4.Return_Part_Material(...) --[[ Line: 3794 ]]
    -- upvalues: u4 (copy)
    local l__Filters__91 = (...).Filters;
    local u438 = {
        Name = "Concrete"
    };
    local l__FloorMaterials__92 = u4.FloorMaterials;
    local l__NameTypes__93 = u4.NameTypes;
    local function v446(p439) --[[ Line: 3805 ]]
        -- upvalues: l__FloorMaterials__92 (copy), l__NameTypes__93 (copy), u438 (ref)
        local v440 = string.lower((tostring(p439)));
        for v441 = 1, 2 do
            local v442 = v441 == 1 and l__FloorMaterials__92 or l__NameTypes__93;
            local v443 = nil;
            if v442[p439] then
                u438 = v442[p439];
                v443 = true;
            else
                for v444, v445 in pairs(v442) do
                    if string.gmatch(string.lower((tostring(v444))), v440)() then
                        u438 = v445;
                        v443 = true;
                        break;
                    end;
                end;
            end;
            if v441 == 2 and v443 then
                return u438;
            end;
        end;
    end;
    local v447 = u438;
    for _, v448 in pairs(l__Filters__91) do
        if v446(v448) == v447 then
            return v447;
        end;
    end;
    return v447;
end;
local u449 = RaycastParams.new();
u449.FilterType = Enum.RaycastFilterType.Include;
function u4.ParticleGroundRaycast(...) --[[ Line: 3846 ]]
    -- upvalues: u449 (copy)
    local v450 = ...;
    local l__Parent__94 = v450.Parent;
    local l__Range__95 = v450.Range;
    local l__Char__96 = v450.Char;
    local v451;
    if l__Char__96 then
        v451 = l__Char__96:FindFirstChild("Humanoid") or l__Char__96:FindFirstChild("AnimationController");
    else
        v451 = l__Char__96;
    end;
    local l__Origin__97 = v450.Origin;
    local l__ParentTo__98 = v450.ParentTo;
    local l__CFrame__99 = v450.CFrame;
    local v452 = l__Parent__94 and (l__Parent__94:IsA("Attachment") or l__Parent__94:IsA("BasePart")) and l__Parent__94 and l__Parent__94 or (l__Origin__97 or l__ParentTo__98);
    local v453 = l__Char__96 and l__Char__96.PrimaryPart.Size.Y + v451.HipHeight + 0.3 + l__Range__95 or typeof(v452) == "Instance" and v452:IsA("BasePart") and v452.Size.Y / 2 + l__Range__95;
    if v453 then
        l__Range__95 = v453;
    elseif typeof(v452) ~= "Instance" or not (v452:IsA("Attachment") and l__Range__95) then
        l__Range__95 = l__CFrame__99 and l__Range__95;
    end;
    local v454 = (l__Range__95 and not (l__CFrame__99 and l__CFrame__99.p) and true or false) and (not (l__Char__96 and l__Char__96.PrimaryPart.CFrame.p or v452:IsA("BasePart") and v452.CFrame.p) and v452:IsA("Attachment"));
    if v454 then
        v454 = v452.WorldPosition;
    end;
    if l__Range__95 then
        u449.FilterDescendantsInstances = { workspace:FindFirstChild("Map") };
        local v455 = v454 + Vector3.new(0, 4, 0);
        local v456 = Vector3.new(0, -l__Range__95 - 4, 0);
        local v457 = workspace:Raycast(v455, v456, u449);
        local v458;
        if v457 then
            v458 = v457.Instance;
        else
            v458 = v457;
        end;
        local v459;
        if v457 then
            v459 = v457.Position;
        else
            v459 = v457;
        end;
        if v457 then
            v457 = v457.Normal;
        end;
        return {
            Part = v458,
            Pos = v459,
            Norm = v457,
            Raycast = v456,
            Origin_Pos = v455,
            Range = l__Range__95
        };
    end;
end;
function u4.EnableParticle(p460, p461, ...) --[[ Line: 3883 ]]
    -- upvalues: u4 (copy)
    local v462 = {};
    for _, v463 in pairs(p460:GetChildren()) do
        if v463:IsA("ParticleEmitter") or (v463:IsA("Beam") or v463:IsA("Trail")) then
            table.insert(v462, v463);
        end;
    end;
    if p460:IsA("ParticleEmitter") or (p460:IsA("Beam") or p460:IsA("Trail")) then
        table.insert(v462, p460);
    end;
    for _, v464 in pairs(v462) do
        if u4.ParticleAttributeChecks({
            Ground_Raycast_Range = 1,
            Char = p461,
            Origin = p460,
            Particle = v464
        }) then
            v464.Enabled = true;
        end;
    end;
end;
function u4.ParticleAttributeChecks(...) --[[ Line: 3921 ]]
    -- upvalues: u4 (copy)
    local v465 = ...;
    local l__Parent__100 = v465.Parent;
    local l__Char__101 = v465.Char;
    local v466;
    if l__Char__101 then
        v466 = l__Char__101:FindFirstChild("Humanoid") or l__Char__101:FindFirstChild("AnimationController");
    else
        v466 = l__Char__101;
    end;
    local l__Origin__102 = v465.Origin;
    local l__ParentTo__103 = v465.ParentTo;
    local l__CFrame__104 = v465.CFrame;
    local l__Particle__105 = v465.Particle;
    local v467 = l__Particle__105:GetAttribute("Ground_Raycast_Range") or (v465.Ground_Raycast_Range or 5);
    local v468 = u4.ParticleGroundRaycast({
        Parent = l__Parent__100,
        Range = v467,
        Char = l__Char__101,
        Origin = l__Origin__102,
        ParentTo = l__ParentTo__103,
        CFrame = l__CFrame__104
    });
    local v469 = {};
    if v466 then
        local _ = v466.FloorMaterial == Enum.Material.Air;
    end;
    if l__Particle__105:GetAttribute("FloorMaterial") then
        table.insert(v469, l__Particle__105:GetAttribute("FloorMaterial"));
    end;
    if v468 and v468.Part then
        table.insert(v469, v468.Part.Material);
        table.insert(v469, v468.Part.Name);
    end;
    local v470 = u4.Return_Part_Material({
        Filters = v469
    });
    if v470 then
        v470 = v470.Name;
    end;
    local l__Color__106 = l__Particle__105.Color;
    local v471 = l__Particle__105:GetAttribute("Color") or v465.Color;
    if v471 then
        if typeof(v471) == "Color3" then
            v471 = ColorSequence.new(v471) or v471;
        end;
    else
        v471 = l__Color__106;
    end;
    local v472 = 1;
    for v473, v474 in pairs(l__Particle__105:GetAttributes()) do
        if string.gmatch(string.lower(v473), "color")() then
            if v473 == "Use_Ground_Color" and (v468 and (v468.Part and v472 <= 2)) then
                v471 = ColorSequence.new(v468.Part.Color);
                v472 = 2;
            end;
            local v475 = string.sub(v473, 0, #v473 - 6);
            if u4.FloorMaterials[v470] and u4.FloorMaterials[v470].Name == v475 or (u4.NameTypes[v470] and u4.NameTypes[v470].Name == v475 or l__Particle__105:GetAttribute("FloorMaterial") == v475) then
                if typeof(v474) == "Color3" then
                    v471 = ColorSequence.new(v474) or v474;
                else
                    v471 = v474;
                end;
                v472 = 3;
            end;
        end;
        if string.gmatch(string.lower(v473), "only")() then
            local v476 = string.sub(v473, 0, #v473 - 5);
            if v476 ~= "Ground" and (not u4.FloorMaterials[v470] or u4.FloorMaterials[v470].Name ~= v476) and ((not u4.NameTypes[v470] or u4.NameTypes[v470].Name ~= v476) and l__Particle__105:GetAttribute("FloorMaterial") ~= v476) then
                return false;
            end;
        end;
        if string.gmatch(string.lower(v473), "ignore")() then
            local v477 = string.sub(v473, 0, #v473 - 7);
            if u4.FloorMaterials[v470] and u4.FloorMaterials[v470].Name == v477 or (u4.NameTypes[v470] and u4.NameTypes[v470].Name == v477 or l__Particle__105:GetAttribute("FloorMaterial") == v477) then
                return false;
            end;
        end;
    end;
    return (not l__Particle__105:GetAttribute("Ground_Only") or v470 and v468.Part) and {
        Ground_Raycast = v468,
        Color = v471,
        Original_Color = l__Color__106,
        FloorMaterial = v470
    } or false;
end;
function u4.EmitParticle(p478, u479, u480, p481, u482, p483, p484) --[[ Line: 4024 ]]
    -- upvalues: u4 (copy), l__wait__4 (copy)
    local v485 = p484 or {};
    local l__Char__107 = v485.Char;
    local l__Color__108 = v485.Color;
    if l__Char__107 and not l__Char__107:FindFirstChild("Humanoid") then
        l__Char__107:FindFirstChild("AnimationController");
    end;
    local v486 = nil;
    if typeof(p478) == "Instance" then
        if p478:IsDescendantOf(workspace) then
            v486 = p478;
        else
            v486 = p478:Clone();
        end;
    elseif typeof(p478) == "table" then
        if u479 and (u479:IsA("Attachment") and u479) then
            v486 = u479;
        else
            v486 = Instance.new("Attachment");
        end;
        for _, v487 in pairs(p478) do
            v487.Parent = v486;
        end;
    end;
    local u488 = {};
    if v486:IsA("ParticleEmitter") then
        table.insert(u488, v486);
    end;
    for _, v489 in pairs(v486:GetDescendants()) do
        if v489:IsA("ParticleEmitter") then
            table.insert(u488, v489);
        end;
    end;
    for _, v490 in pairs(u488) do
        v490.Enabled = false;
    end;
    local l__Parent__109 = p478.Parent;
    if v486:IsA("Attachment") then
        if u479 then
            v486.Parent = u479;
            l__Parent__109 = u479;
        elseif not (v486.Parent or l__Parent__109) then
            warn("No existing Parent for the Particles!", "Set the Origin argument to an existing Parent.");
        end;
    else
        v486.Parent = u479 or (l__Parent__109 or workspace.IgnoreInstances);
    end;
    local v491 = p481 or 0;
    for _, v492 in pairs(u488) do
        local v493 = v492:GetAttribute("Repeat_Rate") or 0;
        local v494 = v493 > 0 and (v492:GetAttribute("Repeat_Count") or 0) or 0;
        local v495 = v492:GetAttribute("EmitDelay") or 0;
        local v496 = v492.Lifetime.Max / v492.TimeScale + 1 + v495;
        local v497 = v496 + v496 * (v494 * v493);
        if v491 < v497 then
            v491 = v497;
        end;
    end;
    if p483 then
        v491 = v491 + p483;
    end;
    game.Debris:AddItem(v486, v491);
    if u482 then
        if v486:IsA("BasePart") then
            v486.CFrame = u482;
        else
            l__Parent__109 = Instance.new("Part");
            game.Debris:AddItem(l__Parent__109, v491);
            l__Parent__109.Transparency = 1;
            l__Parent__109.CanCollide = false;
            l__Parent__109.CanTouch = false;
            l__Parent__109.CanQuery = false;
            l__Parent__109.Anchored = true;
            l__Parent__109.Size = Vector3.new(0, 0, 0);
            l__Parent__109.CFrame = u482;
            l__Parent__109.Parent = workspace.IgnoreInstances;
            v486.Parent = l__Parent__109;
        end;
    end;
    local function u502(u498) --[[ Line: 4135 ]]
        -- upvalues: u4 (ref), l__Char__107 (copy), u479 (copy), l__Parent__109 (ref), u482 (copy), l__Color__108 (copy), u480 (copy), l__wait__4 (ref)
        local v499 = u4.ParticleAttributeChecks({
            Parent = u498.Parent,
            Char = l__Char__107,
            Origin = u479,
            ParentTo = l__Parent__109,
            CFrame = u482,
            Particle = u498,
            Color = l__Color__108
        });
        if v499 then
            u498.Color = v499.Color;
            local u500 = u498:GetAttribute("Repeat_Rate");
            local u501 = u498:GetAttribute("Repeat_Count") or 1;
            u4.Spawn(function() --[[ Line: 4154 ]]
                -- upvalues: u501 (copy), u498 (copy), u480 (ref), u500 (copy), l__wait__4 (ref)
                for _ = 1, u501 do
                    u498:Emit(u480 or (u498:GetAttribute("EmitCount") or 1));
                    if u500 then
                        l__wait__4(u500);
                    end;
                end;
            end);
        end;
    end;
    local function u504() --[[ Line: 4166 ]]
        -- upvalues: u488 (copy), u4 (ref), u502 (copy)
        for _, u503 in pairs(u488) do
            if u503:GetAttribute("EmitDelay") then
                u4.Delay(u503:GetAttribute("EmitDelay"), function() --[[ Line: 4169 ]]
                    -- upvalues: u502 (ref), u503 (copy)
                    u502(u503);
                end);
            else
                u502(u503);
            end;
        end;
    end;
    if p483 then
        u4.Delay(p483, function() --[[ Line: 4179 ]]
            -- upvalues: u504 (copy)
            u504();
        end);
    else
        u504();
    end;
    return {
        Particles = u488,
        Origin = v486
    };
end;
function u4.EmitParticle2(p505, p506, p507) --[[ Line: 4192 ]]
    -- upvalues: l__Debris2__12 (copy)
    local v508 = p505:Clone();
    v508.Parent = workspace:FindFirstChild("IgnoreInstances") or workspace;
    l__Debris2__12:AddItem(v508, p507 or 5);
    if typeof(p506) == "Vector3" then
        v508.Position = p506;
    elseif typeof(p506) == "CFrame" then
        v508.CFrame = p506;
    end;
    local v509 = v508:FindFirstChildOfClass("Attachment");
    assert(v509 ~= nil, p505.Name .. " must have an Attachment in it");
    local v510 = {};
    for _, v511 in pairs(v509:GetChildren()) do
        if v511:IsA("ParticleEmitter") then
            local v512 = v511:GetAttribute("EmitCount") ~= nil;
            assert(v512, "No attribute named \'EmitCount\' found in " .. v511.Name);
            v511:Emit(v511:GetAttribute("EmitCount"));
            table.insert(v510, v511);
        end;
    end;
    return v510;
end;
function u4.Weld(p513, p514, p515, p516) --[[ Line: 4221 ]]
    local v517 = Instance.new("ManualWeld");
    v517.Name = p516 or "Weld";
    v517.Part0 = p513;
    v517.Part1 = p514;
    v517.Parent = p513;
    v517.C0 = p515;
    return v517;
end;
function u4.AddVelocity(p518, p519, p520, p521, p522, p523) --[[ Line: 4232 ]]
    -- upvalues: l__Debris2__12 (copy), u4 (copy)
    local v524 = Instance.new("BodyVelocity");
    v524.Name = p522 or "BodyVelocity";
    v524.MaxForce = p520;
    v524.Velocity = p519;
    local u525 = p518.Parent:FindFirstChild("Health") or p518.Parent.Parent:FindFirstChild("Health");
    local v526 = game.Players:GetPlayerFromCharacter(p518.Parent) or (game.Players:GetPlayerFromCharacter(p518.Parent.Parent) or game.Players:GetPlayerFromCharacter(p518.Parent.Parent.Parent));
    local v527 = p523 or v526 and v526.Character;
    if v527 then
        u525 = v527;
    elseif u525 then
        u525 = u525.Parent;
    end;
    if v526 then
        u525.BindableEvent:Fire("AddForce", {
            Origin = p518,
            Force = v524,
            Timer = p521
        });
    else
        v524.Parent = p518;
        l__Debris2__12:AddItem(v524, p521);
        u4.Delay(p521, function() --[[ Line: 4248 ]]
            -- upvalues: u525 (copy)
            if u525 and (u525.PrimaryPart and not u525.PrimaryPart.Anchored) then
                u525.PrimaryPart:SetNetworkOwner(nil);
            end;
        end);
    end;
end;
function u4.GetTouchingParts(p528) --[[ Line: 4256 ]]
    local v529 = p528.Touched:Connect(function() --[[ Line: 4257 ]] end);
    local v530 = p528:GetTouchingParts();
    v529:Disconnect();
    return v530;
end;
function u4.RespawnMob(u531) --[[ Line: 4265 ]]
    -- upvalues: l__CollectionService__8 (copy), u4 (copy), l__wait__4 (copy)
    if l__CollectionService__8:HasTag(u531, "Respawned") then
    else
        l__CollectionService__8:AddTag(u531, "Respawned");
        local l__Value__110 = u531.Spawn.Value;
        game:GetService("Debris"):AddItem(u531, 5);
        u4.pcall(function() --[[ Line: 4274 ]]
            -- upvalues: u531 (copy)
            if not u531:GetAttribute("Unagroed") then
                u531.BindableEvent:Fire("NilSelf");
            end;
        end);
        l__wait__4(0.5);
        u4.SpawnMob(l__Value__110);
    end;
end;
function u4.SpawnMob(u532, ...) --[[ Line: 4285 ]]
    -- upvalues: u4 (copy), l__ServerStorage__5 (copy)
    local u533 = ... or {};
    local u534 = nil;
    u4.pcall(function() --[[ Line: 4289 ]]
        -- upvalues: u532 (copy), l__ServerStorage__5 (ref), u534 (ref), u533 (copy)
        local v535 = u532;
        u534 = l__ServerStorage__5.Mobs[v535.Name]:Clone();
        if u533.v2 then
            u534.SpawnPoint.Value = v535;
            u534:SetAttribute("Unagroed2", true);
        else
            u534:SetAttribute("Unagroed", true);
        end;
        local v536 = Instance.new("ObjectValue");
        v536.Name = "Spawn";
        v536.Value = v535;
        v536.Parent = u534;
        u534:FindFirstChildWhichIsA("Humanoid");
        u534.Parent = workspace.Living;
        u534:SetPrimaryPartCFrame(v535.CFrame * CFrame.Angles(0, 3.141592653589793, 0));
        u534:SetPrimaryPartCFrame(v535.CFrame * CFrame.Angles(3.141592653589793, 0, 1.5707963267948966) * CFrame.new(0, -v535.Size.X / 2 + (u534.Humanoid.HipHeight + u534.PrimaryPart.Size.Y / 2), 0));
        local v537 = Instance.new("BindableEvent");
        v537.Name = "BindableEvent";
        v537.Parent = u534;
        local v538 = Instance.new("BindableFunction");
        v538.Name = "BindableFunction";
        v538.Parent = u534;
        local v539 = Instance.new("DoubleConstrainedValue");
        v539.Name = "Health";
        v539.MaxValue = u534.Humanoid.MaxHealth;
        v539.Value = v539.MaxValue;
        v539.Parent = u534;
    end);
    return u534;
end;
function u4.Damage(u540, u541, ...) --[[ Line: 4332 ]]
    -- upvalues: l__ReplicatedStorage__6 (copy), l__ServerStorage__5 (copy), l__CollectionService__8 (copy), u4 (copy), l__Debris2__12 (copy), l__ClientFX__16 (copy), l__wait__4 (copy), l__Players__19 (copy), l__RunService__11 (copy), l__delay__3 (copy), l__Weighted__15 (copy)
    require(l__ReplicatedStorage__6.Modules.ChannelMod);
    local l__CombatStyleLibrary__111 = require(l__ReplicatedStorage__6.Modules.CombatStyleLibrary);
    local l__StandLibrary__112 = require(l__ServerStorage__5.Modules.StandLibrary);
    local l__ChannelMod2__113 = require(l__ReplicatedStorage__6.Modules.ChannelMod2);
    local u542 = ...;
    local l__Damage__114 = u542.Damage;
    local l__BlockDamage__115 = u542.BlockDamage;
    local l__Damage__116 = u542.Damage;
    local l__Combo__117 = u542.Combo;
    local l__NoMultiplier__118 = u542.NoMultiplier;
    if u541:GetAttribute("Unagroed2") then
        u541:SetAttribute("Unagroed2", nil);
        u541.AgroFunction:Invoke();
    end;
    if u541:GetAttribute("Unagroed") then
        u541:SetAttribute("Unagroed", nil);
        return u541.Spawn.Value.BindableFunction:Invoke("Agro", {
            Attacker = u540,
            Victim = u541,
            Info = u542
        });
    else
        local u543 = u540:FindFirstChild("Master");
        local u544 = u541:FindFirstChild("Master");
        if u544 and (u542.SlaveNpc and u544.Value == u540.Name) then
        elseif u543 and (u543:GetAttribute("NoDamageMaster") and u543.Value == u541.Name) then
        elseif u543 and (u544 and u543.Value == u544.Value) then
        elseif u541:GetAttribute("BeingBarragedImmunity") and (u541:GetAttribute("BeingBarragedImmunity") ~= u540.Name and not u542.Barrage) then
        elseif l__CollectionService__8:HasTag(u541, "InD4CDimension") and not l__CollectionService__8:HasTag(u540, "InD4CDimension") or l__CollectionService__8:HasTag(u540, "InD4CDimension") and not l__CollectionService__8:HasTag(u541, "InD4CDimension") then
        elseif u542.NoDamageCancel or not l__CollectionService__8:HasTag(u540, "Ragdolled") then
            if u541.BindableFunction:Invoke("ReturnCanDamage", {
                IgnoreRagdollAbilities = u542.IgnoreRagdollAbilities,
                Combo = l__Combo__117,
                IgnoreInvincibility = u542.IgnoreInvincibility,
                Attacker = u540,
                IgnoreRagdoll = l__Damage__114 < 0 and true or u542.IgnoreRagdoll
            }) or u542.TimeStop then
                if u541.BindableFunction:Invoke("ReturnTag", u542.Tag.Name) and not u542.TimeStop then
                else
                    local u545;
                    if game.Players:GetPlayerFromCharacter(u540) then
                        u545 = game.Players:GetPlayerFromCharacter(u540);
                    else
                        u545 = nil;
                    end;
                    local v546 = u540:FindFirstChild("Health");
                    local v547 = u540:FindFirstChild("Humanoid");
                    local u548 = u540:findFirstChild("StandMorph");
                    local v549 = u548 and u548:FindFirstChild("Stand Name");
                    if v549 then
                        v549 = u548:FindFirstChild("Stand Name").Value;
                    end;
                    local v550 = u548 and u545 and (u545:FindFirstChild("StandSkillTree") and u545.StandSkillTree:FindFirstChild("Infinite Rotation"));
                    if v550 then
                        v550 = u545.StandSkillTree["Infinite Rotation"].Value;
                    end;
                    local function v557() --[[ Line: 4393 ]]
                        -- upvalues: u541 (copy), u540 (ref), u542 (copy), u544 (copy), u545 (ref), u543 (copy), l__Damage__114 (ref)
                        local v551 = u541:FindFirstChild("DamageDealed");
                        if v551 == nil then
                            v551 = Instance.new("Folder");
                            v551.Name = "DamageDealed";
                            v551.Parent = u541;
                        end;
                        local v552 = u541:FindFirstChild("Target");
                        if (not v552 or v552.Value ~= u540) and (u542.Style ~= "Unlimited Blade Works" and (not u544 or u544.Value ~= u540.Name)) then
                            if v552 then
                                v552:Destroy();
                            end;
                            local v553 = Instance.new("ObjectValue");
                            v553.Name = "Target";
                            v553.Value = u540;
                            v553.Parent = u541;
                        end;
                        local v554 = not u545 and u543;
                        if v554 then
                            v554 = game.Players:FindFirstChild(u543.Value);
                        end;
                        if v554 and (v551 and v554.Name ~= u541.Name) then
                            local v555 = v551:findFirstChild((tostring(v554.UserId)));
                            if v555 == nil then
                                local v556 = Instance.new("NumberValue");
                                v556.Name = v554.UserId;
                                v556.Value = l__Damage__114;
                                v556.Parent = v551;
                                return;
                            end;
                            if v555 ~= nil then
                                v555.Value = v555.Value + l__Damage__114;
                            end;
                        end;
                    end;
                    local u558 = u541:FindFirstChild("HumanoidRootPart");
                    local u559 = game.Players:GetPlayerFromCharacter(u541);
                    local u560 = u541:findFirstChild("Health");
                    local u561 = u560 and (u560.Value or 0) or 0;
                    local v562 = u541:FindFirstChild("Humanoid");
                    local v563;
                    if u558 then
                        v563 = u558:FindFirstChild("Shield_Indicator");
                    else
                        v563 = u558;
                    end;
                    local u564 = u541:findFirstChild("StandMorph");
                    local v565 = u564 and u564:FindFirstChild("Stand Name");
                    if v565 then
                        v565 = u564["Stand Name"].Value;
                    end;
                    if u542.Tag and (not u542.TimeStop and u542.Tag.Timer > 0) then
                        u541.BindableEvent:Fire("AddTag", u542.Tag);
                    end;
                    local v566 = u545 and u545:FindFirstChild("StandSkillTree");
                    if v566 then
                        v566 = u545.StandSkillTree:findFirstChild("Reality Overwrite");
                    end;
                    local v567 = v566 and v566.Value and (u540 and u540:FindFirstChild("SummonedStand"));
                    if v567 then
                        v567 = u540.SummonedStand.Value;
                    end;
                    local v568 = (u542.TrueDamage or (l__CollectionService__8:HasTag(u540, "Nightmarization") or (l__Damage__114 < 0 or (u541:GetAttribute("UniverseResetVictim") or (u541:GetAttribute("SoulAltered") or u541:GetAttribute("Soul Manipulated")))))) and true or v567;
                    local v569 = l__Damage__114 < 0 and true or v550;
                    local u570 = u541:GetAttribute("Enchant_Thorns_Damage");
                    if u570 and u542.Basic_Attack then
                        u4.Spawn(function() --[[ Line: 4458 ]]
                            -- upvalues: u541 (copy), u540 (ref), l__CombatStyleLibrary__111 (copy), l__Damage__114 (ref), u570 (copy), u4 (ref)
                            local v571 = l__CombatStyleLibrary__111["Humanoid Stand"]("ReturnDamage_Info", {
                                Timer = 0,
                                Combo = "Chip Damage",
                                Stand = "Mr. President",
                                Tag = u541.Name .. " Enchant_Thorns_Damage",
                                Hit = u540.PrimaryPart,
                                Origin = u541.LowerTorso
                            });
                            v571.Damage = l__Damage__114 * u570;
                            v571.Stun = nil;
                            u4.Damage(u541, u540, v571);
                        end);
                    end;
                    if u542.Style == "Crazy Diamond Heal Mode" then
                        v568 = true;
                        u542.BypassCounters = true;
                        v569 = true;
                        l__Damage__114 = l__Damage__114 / -4;
                        if u545 then
                            local v572 = 1;
                            for _, v573 in pairs(u545.StandSkillTree:GetChildren()) do
                                if v573.Name:match("Precision ") and v573.Value then
                                    v572 = v572 + 1.5;
                                end;
                            end;
                            l__Damage__114 = l__Damage__114 * v572;
                        end;
                        if u559 then
                            local v574 = false;
                            for _, v575 in pairs({ "LeftArm", "RightLeg", "LeftLeg" }) do
                                v574 = u559.PlayerStats[v575].Value ~= "Normal" and true or v574;
                                u559.PlayerStats[v575].Value = "Normal";
                            end;
                            if v574 then
                                u541.BindableEvent:Fire("UpdateLimbs");
                            end;
                        end;
                        u541.BindableEvent:Fire("StopBleed");
                        u541.BindableEvent:Fire("StopPoison");
                        u541.BindableEvent:Fire("StopBurn");
                    end;
                    if not l__CollectionService__8:HasTag(u541, "InTimeStop") or (u542.TSDamage or (u541:findFirstChild("TimeStopResistant") or (u542.Style == "Ora Beatdown" or u542.Style == "7 Page Beatdown"))) then
                        if l__CollectionService__8:HasTag(u541, "Gravitational Negation") and not u542.BypassCounters then
                            if u540.PrimaryPart and (u541.PrimaryPart and (u541.PrimaryPart.Position - u540.PrimaryPart.Position).magnitude <= 50) then
                                local v576 = Instance.new("Folder");
                                l__Debris2__12:AddItem(v576, 1);
                                v576.Name = "Gravitational Negation Activated";
                                v576.Parent = u541;
                                u4.pcall(function() --[[ Line: 4537 ]]
                                    -- upvalues: l__CollectionService__8 (ref), u540 (ref)
                                    l__CollectionService__8:HasTag(u540, "Gravitational Shift Hit");
                                end);
                                u4.Spawn(function() --[[ Line: 4543 ]]
                                    -- upvalues: u540 (ref)
                                    u540.BindableEvent:Fire("Knock", 0.3, {
                                        NoIFrames = true,
                                        IgnoreSturdiness = true
                                    });
                                    u540.BindableEvent:Fire("AddStun", {
                                        Name = "Countered",
                                        Timer = 1.6
                                    });
                                    u540.BindableEvent:Fire("AddWalkSpeed", {
                                        Name = "Countered",
                                        Timer = 1.6,
                                        Value = -100
                                    });
                                    u540.BindableEvent:Fire("AddJumpPower", {
                                        Name = "Countered",
                                        Timer = 1.6,
                                        Value = -100
                                    });
                                    u540.BindableEvent:Fire("AddAutoRotate", {
                                        Name = "Countered",
                                        Timer = 1.6
                                    });
                                end);
                                l__ClientFX__16:FireAllClients("PlaySound", {
                                    Origin = u541.PrimaryPart,
                                    Sound = { "Gravitational Negation Activated", "Gravitational Negation Voiceline" }
                                });
                                l__wait__4(0.3);
                                u4.Spawn(function() --[[ Line: 4555 ]]
                                    -- upvalues: l__ClientFX__16 (ref), u540 (ref), u541 (copy), l__ServerStorage__5 (ref), l__wait__4 (ref)
                                    l__ClientFX__16:FireAllClients("Gravitational Negation", {
                                        Duration = 1.3,
                                        Origin = u540.PrimaryPart,
                                        Countered = u540,
                                        Origin2 = u541.PrimaryPart
                                    });
                                    local v577 = u540.BindableFunction:Invoke("LoadAnimation", l__ServerStorage__5.Anims["Gravitational Negation"]);
                                    v577:Play();
                                    l__wait__4(1.3);
                                    v577:Stop(0.5);
                                end);
                                return;
                            end;
                        elseif l__CollectionService__8:HasTag(u541, "Cursed Blade") and not u542.BypassCounters then
                            if u540.PrimaryPart and (u541.PrimaryPart and (u541.PrimaryPart.Position - u540.PrimaryPart.Position).magnitude <= 50) then
                                local v578 = Instance.new("ObjectValue");
                                l__Debris2__12:AddItem(v578, 1);
                                v578.Name = "Cursed Blade Activated";
                                v578.Value = u540;
                                v578.Parent = u541;
                                return;
                            end;
                        elseif l__CollectionService__8:HasTag(u541, "Nullification: Zero") and not u542.BypassCounters then
                            if u540.PrimaryPart and (u541.PrimaryPart and (u541.PrimaryPart.Position - u540.PrimaryPart.Position).magnitude <= 50) then
                                local v579 = Instance.new("Folder");
                                l__Debris2__12:AddItem(v579, 1);
                                v579.Name = "Nullification: Zero Activated";
                                v579.Parent = u541;
                                local u580 = 3.5;
                                if u545 then
                                    local v581 = 0;
                                    for _, v582 in pairs(u545.StandSkillTree:GetChildren()) do
                                        if v582.Name:match("Enlightened ") and v582.Value then
                                            v581 = v581 + 2.5;
                                        end;
                                    end;
                                    u580 = u580 + v581;
                                end;
                                u4.Spawn(function() --[[ Line: 4603 ]]
                                    -- upvalues: u540 (ref), u580 (ref), u545 (ref)
                                    u540.BindableEvent:Fire("AddStun", {
                                        Name = "Nullification: Zero Countered",
                                        Timer = 0.6
                                    });
                                    u540.BindableEvent:Fire("AddWalkSpeed", {
                                        Name = "Nullification: Zero Countered",
                                        Value = -4,
                                        Timer = u580 + 0.3
                                    });
                                    u540.BindableEvent:Fire("AddSprintSpeed", {
                                        Name = "Nullification: Zero Countered",
                                        Value = -6,
                                        Timer = u580 + 0.3
                                    });
                                    if u545 then
                                        u540.RemoteEvent:FireClient(u545, "Perfect Block");
                                    end;
                                end);
                                l__ClientFX__16:FireAllClients("PlaySound", {
                                    Sound = "Nullification: Zero Activated",
                                    Origin = u541.PrimaryPart
                                });
                                u4.Spawn(function() --[[ Line: 4617 ]]
                                    -- upvalues: u559 (copy), u541 (copy)
                                    if u559 then
                                        u541.RemoteEvent:FireClient(u559, "Perfect Block");
                                    end;
                                end);
                                l__wait__4(0.3);
                                u4.Spawn(function() --[[ Line: 4625 ]]
                                    -- upvalues: u540 (ref), l__ClientFX__16 (ref), u541 (copy), l__ReplicatedStorage__6 (ref), l__wait__4 (ref)
                                    local _, v583, _ = u540.PrimaryPart.CFrame:ToEulerAnglesXYZ();
                                    local v584 = CFrame.new(u540.PrimaryPart.Position) * CFrame.Angles(0, v583, 0);
                                    l__ClientFX__16:FireAllClients("Nullification: Zero", {
                                        Duration = 1,
                                        CFrame = v584,
                                        Origin = u540.PrimaryPart,
                                        Countered = u540,
                                        Origin2 = u541.PrimaryPart
                                    });
                                    u540.BindableFunction:Invoke("AddTP", {
                                        CFrame = v584
                                    });
                                    local v585 = u540.BindableFunction:Invoke("LoadAnimation", l__ReplicatedStorage__6.Anims["Nullification: Zero Hit"]);
                                    v585:Play();
                                    l__wait__4(1);
                                    v585:Stop(0.5);
                                end);
                                return;
                            end;
                        else
                            if l__CollectionService__8:HasTag(u541, "Spin Reflex") and not u542.BypassCounters then
                                local v586 = Instance.new("Folder");
                                l__Debris2__12:AddItem(v586, 1);
                                v586.Name = "Spin Reflex Activated";
                                v586.Parent = u541;
                                u4.Spawn(function() --[[ Line: 4651 ]]
                                    -- upvalues: u540 (ref), u545 (ref)
                                    u540.BindableEvent:Fire("AddStun", {
                                        Name = "Spin Reflex Counter",
                                        Timer = 1
                                    });
                                    if u545 then
                                        u540.RemoteEvent:FireClient(u545, "Perfect Block");
                                    end;
                                end);
                                u4.Spawn(function() --[[ Line: 4659 ]]
                                    -- upvalues: u559 (copy), u541 (copy), l__wait__4 (ref), l__ChannelMod2__113 (copy), u4 (ref), l__CombatStyleLibrary__111 (copy), l__ClientFX__16 (ref), u540 (ref)
                                    if u559 then
                                        u541.RemoteEvent:FireClient(u559, "Perfect Block");
                                    end;
                                    l__wait__4(0.30000000000000004);
                                    local v587 = l__ChannelMod2__113.new(0.25, function() --[[ Line: 4666 ]] end);
                                    function v587.Duration() --[[ Line: 4670 ]]
                                        -- upvalues: u4 (ref), u541 (ref), l__CombatStyleLibrary__111 (ref), l__ClientFX__16 (ref), u540 (ref)
                                        local v588 = u4.SpawnRegion3(u541, {
                                            Size = Vector3.new(10, 10, 15)
                                        });
                                        for _, v589 in pairs(v588:Cast(u541, 15)) do
                                            if v589.Parent.Parent == workspace.Living or v589.Parent.Parent.Parent == workspace.Living then
                                                local l__Parent__119 = (v589.Parent:findFirstChild("Health") or v589.Parent.Parent:findFirstChild("Health")).Parent;
                                                local v590 = l__CombatStyleLibrary__111.Spin("ReturnDamage_Info", {
                                                    Timer = 2,
                                                    Combo = "Spin Reflex",
                                                    Tag = "Spin Reflex" .. l__Parent__119.Name,
                                                    Hit = l__Parent__119.HumanoidRootPart,
                                                    Origin = u541.HumanoidRootPart
                                                });
                                                if u4.Damage(u541, l__Parent__119, v590) then
                                                    l__ClientFX__16:FireAllClients("Spin Reflex", {
                                                        Origin = u541.HumanoidRootPart,
                                                        Victim = u540
                                                    });
                                                    u4.Delay(0.4, function() --[[ Line: 4693 ]]
                                                        -- upvalues: l__Parent__119 (copy), u4 (ref), u541 (ref)
                                                        l__Parent__119.BindableEvent:Fire("Knock", 1.5);
                                                        u4.AddVelocity(l__Parent__119.UpperTorso, u541.HumanoidRootPart.CFrame.lookVector * 70 + Vector3.new(0, 18, 0), Vector3.new(inf, inf, inf), 0.1, nil, l__Parent__119);
                                                    end);
                                                end;
                                            end;
                                        end;
                                    end;
                                    v587:Start();
                                end);
                                l__wait__4(0.1);
                                local v591 = u559.UserId .. os.time();
                                l__ClientFX__16:FireAllClients("Spin Reflex", {
                                    Finish = true,
                                    Origin = u541.HumanoidRootPart,
                                    Victim = u540,
                                    SteelBallId = v591
                                });
                                return;
                            end;
                            if l__CollectionService__8:HasTag(u541, "Vaporization Freezing Technique") and not u542.BypassCounters then
                                local u592 = "Vaporization Freezing Technique" .. " BeatdownVictim" .. tick();
                                local v593 = Instance.new("Folder");
                                l__Debris2__12:AddItem(v593, 1);
                                v593.Name = "Vaporization Freezing Technique Activated";
                                v593.Parent = u541;
                                u4.Spawn(function() --[[ Line: 4721 ]]
                                    -- upvalues: u540 (ref), u592 (copy), u545 (ref)
                                    u540.BindableEvent:Fire("AddStun", {
                                        Timer = 1,
                                        Name = u592 .. "#2"
                                    });
                                    u540.BindableEvent:Fire("AddUsingMove", {
                                        Timer = 1,
                                        Name = u592 .. "#2"
                                    });
                                    u540.BindableEvent:Fire("AddAutoRotate", {
                                        Timer = 1,
                                        Name = u592 .. "#2"
                                    });
                                    if u545 then
                                        u540.RemoteEvent:FireClient(u545, "Perfect Block");
                                    end;
                                end);
                                u4.Spawn(function() --[[ Line: 4731 ]]
                                    -- upvalues: u559 (copy), u541 (copy)
                                    if u559 then
                                        u541.RemoteEvent:FireClient(u559, "Perfect Block");
                                    end;
                                end);
                                u540.BindableEvent:Fire("VaporizationFreezingTechnique", {
                                    Skill = "Vaporization Freezing Technique",
                                    Victim = u541,
                                    VictimPlayer = u559,
                                    Attacker = u540,
                                    SkillTag = u592
                                });
                                return;
                            end;
                            if l__CollectionService__8:HasTag(u541, "Charisma") and not u542.BypassCounters then
                                local u594 = "Charisma" .. " BeatdownVictim" .. tick();
                                local v595 = Instance.new("Folder");
                                l__Debris2__12:AddItem(v595, 1);
                                v595.Name = "Charisma Activated";
                                v595.Parent = u541;
                                u4.Spawn(function() --[[ Line: 4756 ]]
                                    -- upvalues: u540 (ref), u594 (copy), u545 (ref)
                                    u540.BindableEvent:Fire("AddStun", {
                                        Timer = 1,
                                        Name = u594 .. "#2"
                                    });
                                    u540.BindableEvent:Fire("AddUsingMove", {
                                        Timer = 1,
                                        Name = u594 .. "#2"
                                    });
                                    u540.BindableEvent:Fire("AddAutoRotate", {
                                        Timer = 1,
                                        Name = u594 .. "#2"
                                    });
                                    if u545 then
                                        u540.RemoteEvent:FireClient(u545, "Perfect Block");
                                    end;
                                end);
                                u4.Spawn(function() --[[ Line: 4766 ]]
                                    -- upvalues: u559 (copy), u541 (copy)
                                    if u559 then
                                        u541.RemoteEvent:FireClient(u559, "Perfect Block");
                                    end;
                                end);
                                l__ClientFX__16:FireAllClients("Charisma", {
                                    Finish = true,
                                    Origin = u541.HumanoidRootPart,
                                    Victim = u540
                                });
                                task.delay(0.05, function() --[[ Line: 4774 ]]
                                    -- upvalues: u540 (ref), u541 (copy)
                                    u541.BindableEvent:Fire("AddTP", {
                                        CFrame = CFrame.new(u540.HumanoidRootPart.Position - u540.HumanoidRootPart.CFrame.lookVector * 5, u540.HumanoidRootPart.Position)
                                    });
                                end);
                                task.delay(0.25, function() --[[ Line: 4784 ]]
                                    -- upvalues: u541 (copy), l__CombatStyleLibrary__111 (copy), u4 (ref), u540 (ref), u559 (copy)
                                    local v596 = l__CombatStyleLibrary__111["Humanoid Stand"]("ReturnDamage_Info", {
                                        Timer = 0.5,
                                        Combo = "Charisma Countered",
                                        Stand = "Shadow The World",
                                        Tag = "Charisma" .. u541.Name,
                                        Hit = u541.PrimaryPart,
                                        Origin = u541.HumanoidRootPart
                                    });
                                    local v597, _ = u4.Damage(u541, u540, v596);
                                    if v597 then
                                        local v598 = u559;
                                        if v598 then
                                            v598 = u559:FindFirstChild("StandSkillTree");
                                        end;
                                        if v598 then
                                            v598 = v598:FindFirstChild("Serrated Knives");
                                        end;
                                        if v598 and v598.Value then
                                            u540.BindableEvent:Fire("Bleed", {
                                                Duration = 5,
                                                TotalDamage = 5
                                            });
                                        end;
                                    end;
                                end);
                                return;
                            end;
                            if l__CollectionService__8:HasTag(u541, "Spring Trap") and not u542.BypassCounters then
                                local u599 = "Spring Trap" .. " BeatdownVictim" .. tick();
                                l__CollectionService__8:RemoveTag(u541, "Spring Trap");
                                local v600 = Instance.new("Folder");
                                l__Debris2__12:AddItem(v600, 1);
                                v600.Name = "Spring Trap Activated";
                                v600.Parent = u541;
                                local v601 = Instance.new("Folder");
                                l__Debris2__12:AddItem(v601, 6);
                                v601.Name = "Spring Trap Activated";
                                v601.Parent = u540;
                                u4.Spawn(function() --[[ Line: 4841 ]]
                                    -- upvalues: u540 (ref), u599 (copy), u545 (ref)
                                    u540.BindableEvent:Fire("AddStun", {
                                        Timer = 4,
                                        Name = u599 .. "#2"
                                    });
                                    u540.BindableEvent:Fire("AddUsingMove", {
                                        Timer = 4,
                                        Name = u599 .. "#2"
                                    });
                                    u540.BindableEvent:Fire("AddWalkSpeed", {
                                        Timer = 4,
                                        Value = -100,
                                        Name = u599 .. "#2"
                                    });
                                    u540.BindableEvent:Fire("AddJumpPower", {
                                        Timer = 4,
                                        Value = -100,
                                        Name = u599 .. "#2"
                                    });
                                    u540.BindableEvent:Fire("AddAutoRotate", {
                                        Timer = 4,
                                        Name = u599 .. "#2"
                                    });
                                    if u545 then
                                        u540.RemoteEvent:FireClient(u545, "Perfect Block");
                                    end;
                                end);
                                u4.Spawn(function() --[[ Line: 4852 ]]
                                    -- upvalues: u559 (copy), u541 (copy)
                                    if u559 then
                                        u541.RemoteEvent:FireClient(u559, "Perfect Block");
                                    end;
                                end);
                                local u602 = u540:FindFirstChild("HumanoidRootPart");
                                local v603 = u541:FindFirstChild("HumanoidRootPart");
                                local v604 = l__Players__19:GetPlayerFromCharacter(u540);
                                if u602 and v603 then
                                    CFrame.new((v603.CFrame * CFrame.new(0, 0, -4)).Position, v603.Position);
                                    if not v604 then
                                        local u605 = Random.new();
                                        local u606 = 0;
                                        local v607 = u605:NextNumber(-12, 12);
                                        local u608 = Vector3.new(0, v607, 0);
                                        local u609 = RaycastParams.new();
                                        u609.FilterDescendantsInstances = { u540, workspace.IgnoreInstances };
                                        u609.FilterType = Enum.RaycastFilterType.Exclude;
                                        local u610 = u602:FindFirstChildOfClass("BodyGyro");
                                        if u610 then
                                            u610.MaxTorque = Vector3.new(0, 0, 0);
                                        end;
                                        local u611 = nil;
                                        u611 = l__RunService__11.Heartbeat:Connect(function(_) --[[ Line: 4890 ]]
                                            -- upvalues: u540 (ref), u602 (copy), u611 (ref), u609 (copy), u606 (ref), u605 (copy), u608 (ref)
                                            if u540 and (u540.Parent and (u602 and u602.Parent)) then
                                                if workspace:Raycast(u602.Position, Vector3.new(0, -3.5, 0), u609) and tick() - u606 >= 0.1 then
                                                    u606 = tick();
                                                    local v612 = u602;
                                                    local v613 = u605:NextNumber(-3, 3);
                                                    local v614 = u605:NextNumber(35, 65);
                                                    v612.AssemblyLinearVelocity = Vector3.new(v613, v614, u605:NextNumber(-3, 3));
                                                    local v615 = u605:NextNumber(-12, 12);
                                                    u608 = Vector3.new(0, v615, 0);
                                                end;
                                                u602.AssemblyAngularVelocity = u608;
                                            else
                                                u611:Disconnect();
                                            end;
                                        end);
                                        task.delay(4, function() --[[ Line: 4911 ]]
                                            -- upvalues: u611 (ref), u602 (copy), u610 (copy)
                                            if u611 then
                                                u611:Disconnect();
                                            end;
                                            if u602 and u602.Parent then
                                                u602.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
                                                u602.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
                                            end;
                                            if u610 and u610.Parent then
                                                u610.MaxTorque = Vector3.new(400000, 400000, 400000);
                                            end;
                                        end);
                                    end;
                                end;
                                l__ClientFX__16:FireAllClients("Spring Trap", {
                                    Finish = true,
                                    SpringDuration = 4,
                                    Origin = u541.HumanoidRootPart,
                                    Victim = u540,
                                    IsNPC = not v604
                                });
                                task.delay(0.1, function() --[[ Line: 4934 ]]
                                    -- upvalues: u541 (copy), u540 (ref), l__CombatStyleLibrary__111 (copy), u4 (ref)
                                    if u541 and u541.Parent then
                                        if u540 and u540.Parent then
                                            local v616 = u541:FindFirstChild("HumanoidRootPart");
                                            if v616 then
                                                local v617 = l__CombatStyleLibrary__111["Humanoid Stand"]("ReturnDamage_Info", {
                                                    Timer = 1,
                                                    Combo = "Spring Trap Countered",
                                                    Stand = "Diver Down",
                                                    Tag = "Spring Trap" .. u541.Name,
                                                    Hit = v616,
                                                    Origin = v616
                                                });
                                                local v618, _ = u4.Damage(u541, u540, v617);
                                                local v619 = v618 and u540:FindFirstChild("BindableEvent");
                                                if v619 then
                                                    v619:Fire("Bleed", {
                                                        Duration = 5,
                                                        TotalDamage = 15,
                                                        Attacker = u541
                                                    });
                                                end;
                                            end;
                                        end;
                                    end;
                                end);
                                return;
                            end;
                            if l__CollectionService__8:HasTag(u541, "Rage Counter") and not u542.BypassCounters then
                                if u540.PrimaryPart and (u541.PrimaryPart and (u541.PrimaryPart.Position - u540.PrimaryPart.Position).magnitude <= 50) then
                                    local v620 = Instance.new("Folder");
                                    l__Debris2__12:AddItem(v620, 1);
                                    v620.Name = "Rage Counter Activated";
                                    v620.Parent = u541;
                                    u4.Spawn(function() --[[ Line: 4969 ]]
                                        -- upvalues: u540 (ref), u545 (ref)
                                        u540.BindableEvent:Fire("AddStun", {
                                            Name = "Rage Counter Countered",
                                            Timer = 0.6
                                        });
                                        if u545 then
                                            u540.RemoteEvent:FireClient(u545, "Perfect Block");
                                        end;
                                    end);
                                    u4.Spawn(function() --[[ Line: 4977 ]]
                                        -- upvalues: u559 (copy), u541 (copy)
                                        if u559 then
                                            u541.RemoteEvent:FireClient(u559, "Perfect Block");
                                        end;
                                    end);
                                    return;
                                end;
                            else
                                if u541:FindFirstChild("LoveTrain") and (not u542.TimeStop and (not v569 and (not l__CollectionService__8:HasTag(u541, "Bites the Dust") and (not u542.LoveTrained and (not game.Players:GetPlayerFromCharacter(u540) or game.Players:GetPlayerFromCharacter(u540).UserId ~= 19919175))))) and not u542.BypassCounters then
                                    local v621 = u541:FindFirstChild("HumanoidRootPart");
                                    local v622 = {};
                                    for _, v623 in pairs(workspace.Living:GetChildren()) do
                                        local v624 = v623:FindFirstChild("HumanoidRootPart");
                                        if v624 and (v624 ~= v621 and (v624.Position - v621.Position).magnitude <= 50) then
                                            table.insert(v622, v623);
                                        end;
                                    end;
                                    if #v622 > 0 then
                                        u540 = v622[math.random(1, #v622)];
                                    end;
                                    l__ClientFX__16:FireAllClients("Love Train", {
                                        Type = "Redirection",
                                        Origin = u540:FindFirstChild("HumanoidRootPart")
                                    });
                                    u542.LoveTrained = true;
                                    u4.Damage(u541, u540, u542);
                                    return;
                                end;
                                if u541:FindFirstChild("Your Own Shadow") and (not v569 and (not u542.TimeStop and (not u542.YourOwnShadowed and (not game.Players:GetPlayerFromCharacter(u540) or game.Players:GetPlayerFromCharacter(u540).UserId ~= 19919175)))) and not u542.BypassCounters then
                                    u542.YourOwnShadowed = true;
                                    u4.Damage(u541, u540, u542);
                                    return;
                                end;
                                if u541:FindFirstChild("Gently Weeps") and (not u542.TimeStop and (not v569 and (not u542.GentlyWeeped and (not game.Players:GetPlayerFromCharacter(u540) or game.Players:GetPlayerFromCharacter(u540).UserId ~= 19919175)))) and (not u542.BypassCounters and u542.IsProjectile) then
                                    l__ClientFX__16:FireAllClients("Gently Weeps", {
                                        NoDist = true,
                                        Origin = u540.HumanoidRootPart,
                                        Victim = u540,
                                        Tag = u541:FindFirstChild("Gently Weeps").Value
                                    });
                                    u542.GentlyWeeped = true;
                                    u542.Damage = u542.Damage * 2;
                                    u542.IgnoreBlock = true;
                                    u542.PerfectBlockable = nil;
                                    l__wait__4(1);
                                    u4.Damage(u541, u540, ...);
                                    return;
                                end;
                                if u542.IsProjectile and (l__CollectionService__8:HasTag(u541, "Projectile Immunity") and (not u542.TimeStop and (not v569 and (not game.Players:GetPlayerFromCharacter(u540) or game.Players:GetPlayerFromCharacter(u540).UserId ~= 19919175)))) and not u542.BypassCounters then
                                    l__ClientFX__16:FireAllClients("PlaySound", {
                                        Sound = "Ricochet3",
                                        Origin = u558
                                    });
                                    return;
                                end;
                                if u541:GetAttribute("Epitaph") and not (l__CollectionService__8:HasTag(u541, "Bites the Dust") or (u542.TimeStop or u542.BypassCounters)) then
                                    u541:SetAttribute("Epitaph", nil);
                                    u540.BindableEvent:Fire("AddStun", {
                                        Timer = 0.5,
                                        Name = u541.Name .. " Epitaph Stun"
                                    });
                                    u540.BindableEvent:Fire("AddWalkSpeed", {
                                        Timer = 0.5,
                                        Value = -1000,
                                        Name = u541.Name .. " Epitaph Stun"
                                    });
                                    if u559 then
                                        l__ClientFX__16:FireClient(u559, "Deactivate Epitaph");
                                        l__ClientFX__16:FireClient(u559, "Epitaph");
                                    end;
                                    if u545 then
                                        l__ClientFX__16:FireClient(u545, "Epitaph");
                                    end;
                                    u541.BindableEvent:Fire("AddAutoRotate", {
                                        Name = "Epitaph Teleport",
                                        Timer = 0.5
                                    });
                                    if u559 and (u541.PrimaryPart.Position - u540.PrimaryPart.Position).magnitude > 70 then
                                        return;
                                    else
                                        u541.BindableEvent:Fire("AddTP", {
                                            CFrame = CFrame.new(u540.HumanoidRootPart.Position - u540.HumanoidRootPart.CFrame.lookVector * 5, u540.HumanoidRootPart.Position)
                                        });
                                        if u559 then
                                            local v625 = u559:FindFirstChild("StandSkillTree");
                                            if v625 then
                                                local v626 = v625:findFirstChild("Raging Demon");
                                                if v626 and (v626.Value and not u543) then
                                                    u541.BindableEvent:Fire("ActivateStandMove", {
                                                        Move = "Raging Demon",
                                                        InputType = "InputEnded"
                                                    });
                                                    return;
                                                end;
                                                local v627 = v625:findFirstChild("Chop Passive");
                                                if v627 and v627.Value then
                                                    u541.BindableEvent:Fire("ActivateStandMove", {
                                                        Move = "King Crimson Chop",
                                                        InputType = "InputEnded"
                                                    });
                                                end;
                                            end;
                                        else
                                            u541.BindableEvent:Fire("ActivateStandMove", {
                                                Move = "Raging Demon",
                                                InputType = "InputEnded"
                                            });
                                        end;
                                        return;
                                    end;
                                end;
                            end;
                        end;
                        local v628 = u541.BindableFunction:Invoke("ReturnBlock");
                        local v629 = u541:GetAttribute("MobId");
                        local v630 = u540:GetAttribute("MobId");
                        local u631 = v629 and _G.Moblist[v629].CharMod or _G.Playerlist[u541.Name].CharMod;
                        local u632 = v630 and _G.Moblist[v630].CharMod or _G.Playerlist[u540.Name].CharMod;
                        local function v633() --[[ Line: 5081 ]]
                            -- upvalues: u631 (copy), u541 (copy), u542 (copy), u632 (copy), u540 (ref), u4 (ref)
                            if u631["Atmospheric Manipulation"] == u541 and (not u542.Atmospheric_Counter and (u632[`Atmospheric Manipulation_{u541.Name}`] and (u632[`Atmospheric Manipulation_{u541.Name}`].User == u541 and u632[`Atmospheric Manipulation_{u541.Name}`].Victim == u540))) then
                                u542.Atmospheric_Counter = true;
                                u542.Knockback = nil;
                                u542.Knockback2 = nil;
                                u542.Stun = nil;
                                u542.Knock = 0;
                                u4.Damage(u541, u540, u542);
                                return true;
                            end;
                        end;
                        if v628.IsBlocking and (v628.Blocking_Capacity.Value > 0 and u542.Style ~= "Crazy Diamond Heal Mode") then
                            if u541.PrimaryPart and (u542.Origin or u540.PrimaryPart) and not u542.NoBackBlockBreaks then
                                local _ = ((u542.Origin or u540.PrimaryPart).Position - u541.PrimaryPart.Position).unit:Dot(u541.PrimaryPart.CFrame.lookVector) < -0.35;
                            end;
                            if not u542.TimeStop and (u542.PerfectBlockable and (l__CollectionService__8:HasTag(u541, "PerfectBlock") or l__CollectionService__8:HasTag(u541, "PerfectBlock2"))) and not u542.SlaveNpc then
                                u540.BindableEvent:Fire("PerfectBlock");
                                if u545 then
                                    u540.RemoteEvent:FireClient(u545, "Perfect Block");
                                end;
                                if u559 then
                                    u541.RemoteEvent:FireClient(u559, "Perfect Block");
                                    task.spawn(function() --[[ Line: 5122 ]]
                                        -- upvalues: u559 (copy), u541 (copy), u540 (ref)
                                        local v634 = u559:FindFirstChild("SpecSkillTree");
                                        if v634 then
                                            local v635 = v634:FindFirstChild("Your Next Line Is!");
                                            if v635 and v635.Value then
                                                u541.BindableEvent:Fire("YourNextLineIs", u540);
                                            end;
                                        end;
                                    end);
                                end;
                                local v636 = u541:GetAttribute("Blessing_of_Sparks_Duration");
                                if v636 then
                                    local u637 = os.time();
                                    u541:SetAttribute("Blessing_of_Sparks", u637);
                                    l__delay__3(v636, function() --[[ Line: 5144 ]]
                                        -- upvalues: u541 (copy), u637 (copy)
                                        if u541:GetAttribute("Blessing_of_Sparks") == u637 then
                                            u541:SetAttribute("Blessing_of_Sparks", nil);
                                        end;
                                    end);
                                end;
                                return nil, {
                                    PerfectBlocked = true
                                };
                            end;
                            if not (u542.TimeStop or u542.IgnoreBlock) or u542.IgnoreBlock == nil then
                                local function u645() --[[ Line: 5158 ]]
                                    -- upvalues: u542 (copy), u4 (ref), u540 (ref), u541 (copy), l__CombatStyleLibrary__111 (copy), l__Damage__114 (ref), u545 (ref)
                                    local l__Chip_Damage__120 = u542.Chip_Damage;
                                    if l__Chip_Damage__120 then
                                        u4.Spawn(function() --[[ Line: 5162 ]]
                                            -- upvalues: u540 (ref), u542 (ref), u541 (ref), l__CombatStyleLibrary__111 (ref), l__Chip_Damage__120 (copy), u4 (ref)
                                            local v638 = l__CombatStyleLibrary__111["Humanoid Stand"]("ReturnDamage_Info", {
                                                Timer = 0,
                                                Combo = "Chip Damage",
                                                Stand = "Mr. President",
                                                Tag = u540.Name .. " Chip Dmg" .. u542.Tag.Name,
                                                Hit = u541.PrimaryPart,
                                                Origin = u540.LowerTorso
                                            });
                                            v638.Damage = l__Chip_Damage__120;
                                            v638.Stun = nil;
                                            v638.ChipDamage = true;
                                            u4.Damage(u540, u541, v638);
                                        end);
                                    end;
                                    local u639 = u540:GetAttribute("Serpents_Fang");
                                    if u639 then
                                        u4.Spawn(function() --[[ Line: 5189 ]]
                                            -- upvalues: u540 (ref), u541 (ref), l__CombatStyleLibrary__111 (ref), l__Damage__114 (ref), u639 (copy), u4 (ref)
                                            local v640 = l__CombatStyleLibrary__111["Humanoid Stand"]("ReturnDamage_Info", {
                                                Timer = 0,
                                                Combo = "Chip Damage",
                                                Stand = "Mr. President",
                                                Tag = u540.Name .. " Serpent\'s Fang",
                                                Hit = u541.PrimaryPart,
                                                Origin = u540.LowerTorso
                                            });
                                            v640.Damage = l__Damage__114 * u639;
                                            v640.Stun = nil;
                                            v640.ChipDamage = true;
                                            u4.Damage(u540, u541, v640);
                                        end);
                                    end;
                                    local v641;
                                    if u542.Weapon == "Sword" then
                                        v641 = u540:FindFirstChild("Lethal Tempo");
                                    else
                                        v641 = false;
                                    end;
                                    local v642 = v641 and (not u542.Stand and u545:FindFirstChild("SpecSkillTree"));
                                    if v642 then
                                        local v643 = v642:FindFirstChild("Essence Of Shotel");
                                        if v643 and v643.Value == true then
                                            u4.Spawn(function() --[[ Line: 5218 ]]
                                                -- upvalues: u541 (ref), u540 (ref), l__CombatStyleLibrary__111 (ref), l__Damage__114 (ref), u4 (ref)
                                                local v644 = l__CombatStyleLibrary__111["Humanoid Stand"]("ReturnDamage_Info", {
                                                    Timer = 0,
                                                    Combo = "Chip Damage",
                                                    Stand = "Mr. President",
                                                    Tag = u541.Name .. "EssenceOfShotel",
                                                    Hit = u540.PrimaryPart,
                                                    Origin = u541.LowerTorso
                                                });
                                                v644.Damage = l__Damage__114 * 0.5;
                                                v644.Stun = nil;
                                                v644.ChipDamage = true;
                                                u4.Damage(u540, u541, v644);
                                            end);
                                        end;
                                    end;
                                end;
                                local function v648() --[[ Line: 5243 ]]
                                    -- upvalues: u541 (copy), u645 (copy), u545 (ref), u540 (ref)
                                    u541.BindableEvent:Fire("BreakBlock", true);
                                    u645();
                                    local v646 = u545;
                                    if v646 then
                                        v646 = u545:FindFirstChild("SpecSkillTree");
                                    end;
                                    if v646 then
                                        local v647 = v646:FindFirstChild("Your Next Line Is!");
                                        if v647 and v647.Value then
                                            u540.BindableEvent:Fire("YourNextLineIs", u541);
                                        end;
                                    end;
                                end;
                                if u542.BlockBreaker then
                                    v648();
                                elseif v628.Blocking_Capacity.Value - (l__BlockDamage__115 or l__Damage__114) <= 0 then
                                    v648();
                                else
                                    local l__BindableEvent__121 = u541.BindableEvent;
                                    local v649 = "DamageBlock";
                                    local v650 = {
                                        Damage = l__BlockDamage__115 or l__Damage__114
                                    };
                                    local l__HitEffect__122 = u542.HitEffect;
                                    if l__HitEffect__122 then
                                        l__HitEffect__122 = u542.HitEffect.Type;
                                    end;
                                    v650.HitEffect = l__HitEffect__122;
                                    l__BindableEvent__121:Fire(v649, v650);
                                    if not v633() then
                                        u645();
                                    end;
                                end;
                                return nil, {
                                    Blocked = true
                                };
                            end;
                            if not u542.IgnoreBlock2 then
                                u541.BindableEvent:Fire("BreakBlock", false);
                            end;
                        else
                            if l__Damage__114 > 0 and (u541:FindFirstChild("PassiveDodges") and u541.PassiveDodges.Value >= l__Damage__114 * 0.2) then
                                u541.PassiveDodges.Value = u541.PassiveDodges.Value - l__Damage__114 * 0.2;
                                u541.BindableEvent:Fire("AddWalkSpeed", {
                                    Timer = 0.5,
                                    Value = -1,
                                    Name = "Passive Dodge" .. u541.PassiveDodges.Value
                                });
                                u541.BindableFunction:Invoke("LoadAnimation", l__ServerStorage__5.Anims["Dodge" .. math.random(1, 2)]):Play();
                                l__ClientFX__16:FireAllClients("PlaySound", {
                                    Sound = "Dodge",
                                    Origin = u541.HumanoidRootPart
                                });
                                return;
                            end;
                            if l__Damage__114 > 0 and (u541:FindFirstChild("PassiveDodges2") and u541.PassiveDodges2.Value >= l__Damage__114 * 0.2) then
                                u541.PassiveDodges2.Value = u541.PassiveDodges2.Value - l__Damage__114 * 0.2;
                                u541.BindableEvent:Fire("AddWalkSpeed", {
                                    Timer = 0.2,
                                    Value = -1,
                                    Name = "Passive Dodge" .. u541.PassiveDodges2.Value
                                });
                                local v651 = u541.BindableFunction:Invoke("LoadAnimation", l__ServerStorage__5.Anims["Dodge" .. math.random(1, 2)]);
                                v651:Play();
                                v651:AdjustSpeed(2);
                                l__ClientFX__16:FireAllClients("PlaySound", {
                                    Sound = "Dodge",
                                    Origin = u541.HumanoidRootPart
                                });
                                return;
                            end;
                            if l__Damage__114 > 0 and u541:FindFirstChild("PassiveDodges3") then
                                for _, v652 in pairs(u541.PassiveDodges3:GetChildren()) do
                                    if v652.Value >= l__Damage__114 * 0.2 then
                                        v652.Value = v652.Value - l__Damage__114 * 0.2;
                                        u541.BindableEvent:Fire("AddWalkSpeed", {
                                            Timer = 0.5,
                                            Value = -8,
                                            Name = "Passive Dodge3" .. tick()
                                        });
                                        local v653 = u541.BindableFunction:Invoke("LoadAnimation", l__ServerStorage__5.Anims["Dodge" .. math.random(1, 2)]);
                                        v653:Play();
                                        v653:AdjustSpeed(2);
                                        l__ClientFX__16:FireAllClients("PlaySound", {
                                            Sound = "Dodge",
                                            Origin = u541.HumanoidRootPart
                                        });
                                        return;
                                    end;
                                end;
                            end;
                        end;
                        if u542.Sound then
                            if u559 and u559.PlayerStats.Stand.Value == "Paragon Platinum" then
                                l__ClientFX__16:FireAllClients("PlaySound", {
                                    Sound = "Ricochet3",
                                    Pitch = 1 * math.random(25, 175) / 100,
                                    Origin = u541.HumanoidRootPart
                                });
                            elseif u559 and l__CollectionService__8:HasTag(u541, "Golden Skin") then
                                l__ClientFX__16:FireAllClients("PlaySound", {
                                    Sound = "Ricochet3",
                                    Pitch = 1 * math.random(80, 140) / 100,
                                    Origin = u541.HumanoidRootPart
                                });
                            else
                                l__ClientFX__16:FireAllClients("PlaySound", u542.Sound);
                            end;
                        end;
                        if u542.Sound2 then
                            l__ClientFX__16:FireAllClients("PlaySound", u542.Sound2);
                        end;
                        local u654;
                        if u559 then
                            u654 = u559:FindFirstChild("PlayerStats");
                        else
                            u654 = u559;
                        end;
                        local u655 = false;
                        local u656 = false;
                        local function v717(p657, p658) --[[ Line: 5324 ]]
                            -- upvalues: u542 (copy), l__ClientFX__16 (ref), u548 (copy), u540 (ref), u545 (ref), l__NoMultiplier__118 (copy), u541 (copy), l__CollectionService__8 (ref), u656 (ref), u559 (copy), u564 (copy), u654 (copy), l__Weighted__15 (ref), u4 (ref), u655 (ref), l__Damage__116 (copy)
                            if u542.GERAwakening and p657 > 0 then
                                l__ClientFX__16:FireAllClients("HitEffect", {
                                    Type = "GER",
                                    Origin = u542.HitEffect.Origin
                                });
                                l__ClientFX__16:FireAllClients("PlaySound", {
                                    Sound = "GER_Hit" .. math.random(1, 3),
                                    Origin = u542.Sound.Origin
                                });
                                p658 = true;
                            end;
                            local v659 = u548;
                            if v659 then
                                v659 = u540:findFirstChild("Rage");
                            end;
                            if v659 and not u542.TimeStop then
                                if u540:findFirstChild("Rage Mode") then
                                    if u542.Stand and u542.Style ~= "Crazy Diamond Heal Mode" then
                                        p657 = p657 * 1.15;
                                    end;
                                else
                                    local v660 = p657 / 3;
                                    if u545 then
                                        local v661 = 1;
                                        for _, v662 in pairs(u545.StandSkillTree:GetChildren()) do
                                            if v662.Name:match("Anger Issues ") and v662.Value then
                                                v661 = v661 + 0.15;
                                            end;
                                        end;
                                        v660 = v660 * v661;
                                    end;
                                    if u545 and u545.UserId == 19919175 then
                                        v660 = p657 * 4;
                                    end;
                                    v659.Value = v659.Value + v660;
                                end;
                            end;
                            local v663 = u548;
                            if v663 then
                                v663 = u540:findFirstChild("High");
                            end;
                            if v663 and not u542.TimeStop then
                                if u540:findFirstChild("The Greatest High") then
                                    if u542.Stand and u542.Style ~= "Crazy Diamond Heal Mode" then
                                        p657 = p657 * 1.2;
                                    end;
                                else
                                    local v664 = p657 / 1.8;
                                    if u545 then
                                        local v665 = 1;
                                        for _, v666 in pairs(u545.StandSkillTree:GetChildren()) do
                                            if v666.Name:match("Bloodlust ") and v666.Value then
                                                v665 = v665 + 0.215;
                                            end;
                                        end;
                                        v664 = v664 * v665;
                                    end;
                                    if u545 and u545.UserId == 19919175 then
                                        v664 = p657 * 4;
                                    end;
                                    if u545 and p657 > 0 then
                                        v663.Value = v663.Value + v664;
                                    end;
                                end;
                            end;
                            local v667 = u548;
                            if v667 then
                                v667 = u540:findFirstChild("Dino_Full_Form");
                            end;
                            if v667 and not u542.TimeStop then
                                if u540:GetAttribute("SM_Full_Form") then
                                    local _ = u542.Stand;
                                else
                                    local v668 = p657 / 3;
                                    if u545 then
                                        local v669 = 1;
                                        for _, v670 in pairs(u545.StandSkillTree:GetChildren()) do
                                            if v670.Name:match("Form Mastery ") and v670.Value then
                                                v669 = v669 + 0.15;
                                            end;
                                        end;
                                        v668 = v668 * v669;
                                    end;
                                    if u545 and u545.UserId == 19919175 then
                                        v668 = p657 * 4;
                                    end;
                                    v667.Value = v667.Value + v668;
                                end;
                            end;
                            if u548 and (u540.SummonedStand.Value and (u542.Style ~= "Injury Overwrite" and (not u542.IgnoreDP and (p657 > 0 and (u542.Stand and (l__NoMultiplier__118 == nil and u542.ChipDamage ~= true)))))) then
                                if u545 then
                                    for _, v671 in pairs(u545.StandSkillTree:GetChildren()) do
                                        if v671.Name:match("Destructive Power ") and v671.Value then
                                            p657 = p657 * 1.1;
                                        end;
                                        if v671.Name:match("Rip and Tear") then
                                            p657 = p657 * 22;
                                        end;
                                    end;
                                elseif u540:GetAttribute("DestructivePower") then
                                    for _ = 1, u540:GetAttribute("DestructivePower") do
                                        p657 = p657 * 1.1;
                                    end;
                                end;
                            end;
                            if p657 < 0 then
                                if u541:GetAttribute("Bleeding") then
                                    p657 = p657 * 0.7;
                                elseif u541:GetAttribute("Burning") or l__CollectionService__8:HasTag(u541, "AntiHeal") then
                                    p657 = p657 * 0.6;
                                end;
                            end;
                            local v672 = u540:GetAttribute("ConsumingFlames");
                            if v672 then
                                p657 = p657 * (1 + v672 * 0.1);
                            end;
                            local v673;
                            if u542.Weapon == "Sword" then
                                v673 = u540:FindFirstChild("Lethal Tempo");
                            else
                                v673 = false;
                            end;
                            if v673 and not u542.Stand then
                                p657 = p657 * (1 + (u542.Basic_Attack and 0.085 or 0.042) * v673.Value);
                            end;
                            if u540:FindFirstChild("DamageBoosts") then
                                p657 = p657 * (#u540.DamageBoosts:GetChildren() / 3 + 1);
                            end;
                            if u541:FindFirstChild("DefenseBoosts") then
                                p657 = p657 / (#u541.DefenseBoosts:GetChildren() / 3 + 1);
                            end;
                            if u540:GetAttribute("HamonHypnosis") then
                                p657 = p657 * 0.8;
                            end;
                            if u545 then
                                local v674 = u540:findFirstChild("Spin");
                                local v675 = u540:findFirstChild("Hamon");
                                local v676 = u545.SpecSkillTree:FindFirstChild("Ripple I");
                                local v677 = u545.SpecSkillTree:FindFirstChild("Essence Of Estoc");
                                local v678 = u541:FindFirstChild("Blood");
                                if v677 and (v677.Value == true and u542.Weapon == "Sword") then
                                    p658 = not u542.Stand;
                                end;
                                if v675 then
                                    if v675.Value > 0 and not l__CollectionService__8:HasTag(u540, "Charge Frozen") then
                                        local v679 = 1;
                                        for v680, v681 in pairs({
                                            ["Hamon Punch I"] = 0.03,
                                            ["Hamon Punch II"] = 0.03,
                                            ["Hamon Punch III"] = 0.04,
                                            ["Hamon Punch IV"] = 0.05,
                                            ["Hamon Punch V"] = 0.06
                                        }) do
                                            local v682 = u545.SpecSkillTree:FindFirstChild(v680);
                                            if v682 and v682.Value then
                                                v679 = v679 + v681;
                                            end;
                                        end;
                                        p657 = p657 * v679;
                                    end;
                                    if u542.HamonType and (u542.HamonType == "Caesar" and v675.Value >= 50) then
                                        local v683 = u545.SpecSkillTree:FindFirstChild("Bubble Lenses");
                                        if v683 and v683.Value then
                                            u656 = true;
                                        end;
                                    end;
                                    if v678 and (p657 > 0 and not l__CollectionService__8:HasTag(u540, "Charge Frozen")) then
                                        local v684 = 1;
                                        local v685 = v676 and v676.Value and 0.35 or (v675.Value > 0 and 0.35 or 0);
                                        local v686 = u559;
                                        if v686 then
                                            v686 = u559:FindFirstChild("SpecSkillTree");
                                        end;
                                        if v686 then
                                            local v687 = v686:FindFirstChild("Ultraviolet Resist V");
                                            if v687 and v687.Value then
                                                v684 = 1;
                                                v685 = 0;
                                            else
                                                local v688 = 1;
                                                for v689, v690 in pairs({
                                                    ["Ultraviolet Resist I"] = 0.2,
                                                    ["Ultraviolet Resist II"] = 0.2,
                                                    ["Ultraviolet Resist III"] = 0.2,
                                                    ["Ultraviolet Resist IV"] = 0.2
                                                }) do
                                                    local v691 = v686:FindFirstChild(v689);
                                                    if v691 and v691.Value then
                                                        v688 = v688 + v690;
                                                    end;
                                                end;
                                                v685 = v685 / v688;
                                            end;
                                        end;
                                        p657 = p657 * (v684 + v685);
                                    end;
                                elseif v674 and (v674.Value > 0 and not l__CollectionService__8:HasTag(u540, "Charge Frozen")) then
                                    local v692 = 1;
                                    local v693 = 0;
                                    if u542.SpinAbility then
                                        local v694 = u545;
                                        if v694 then
                                            v694 = u545:FindFirstChild("SpecSkillTree");
                                        end;
                                        if v694 then
                                            for _, v695 in pairs(v694:GetChildren()) do
                                                if v695.Name:match("Spin Mastery ") and v695.Value then
                                                    v693 = v693 + 0.1;
                                                end;
                                                if v695.Name:match("Golden Ratio") and v695.Value then
                                                    v693 = v693 + 0.1;
                                                end;
                                            end;
                                        end;
                                    elseif u542.IsProjectile then
                                        v693 = v693 + 0.1;
                                    end;
                                    p657 = p657 * (v692 + v693);
                                end;
                            end;
                            if u564 and u541.SummonedStand.Value then
                                local v696 = u541:findFirstChild("Rage");
                                if v696 and not u541:findFirstChild("Rage Mode") then
                                    local v697 = p657 / 4;
                                    if u559 then
                                        local v698 = 1;
                                        for _, v699 in pairs(u559.StandSkillTree:GetChildren()) do
                                            if v699.Name:match("Anger Issues ") and v699.Value then
                                                v698 = v698 + 0.15;
                                            end;
                                        end;
                                        v697 = v697 * v698;
                                    end;
                                    if p657 > 0 then
                                        v696.Value = v696.Value + v697;
                                    end;
                                end;
                            end;
                            if u564 and u541.SummonedStand.Value then
                                local v700 = u541:findFirstChild("High");
                                if v700 and not u541:findFirstChild("The Greatest High") then
                                    local v701 = p657 / 1.5;
                                    if u559 then
                                        local v702 = 1;
                                        for _, v703 in pairs(u559.StandSkillTree:GetChildren()) do
                                            if v703.Name:match("Bloodlust ") and v703.Value then
                                                v702 = v702 - 0.2;
                                            end;
                                        end;
                                        v701 = v701 * v702;
                                    end;
                                    if p657 > 0 then
                                        v700.Value = v700.Value - v701;
                                    end;
                                end;
                            end;
                            u541.BindableFunction:Invoke("UpdatePhysicalDefense");
                            local v704 = u541:FindFirstChild("Physical_Defense");
                            if v704 and not p658 or v704 and (v704.Value < 0 and p658) then
                                local l__Value__123 = v704.Value;
                                local v705 = u540:GetAttribute("Serpents_Fang_PD");
                                if v705 then
                                    l__Value__123 = l__Value__123 * v705;
                                end;
                                p657 = p657 / (1 + l__Value__123);
                            end;
                            if u540:GetAttribute("MajinDamageBoost") and not p658 then
                                p657 = p657 * (1 + u540:GetAttribute("MajinDamageBoost"));
                            end;
                            if u540:FindFirstChild("Shift Awakening") then
                                p657 = p657 * 1.5;
                            end;
                            if (u654 and u654.LeftArm.Value == "Amputated" or not u541:FindFirstChild("LeftUpperArm")) and p657 > 0 then
                                p657 = p657 * 1.15;
                            end;
                            if l__CollectionService__8:HasTag(u540, "Combat Precision") then
                                p657 = p657 * 1.15;
                            end;
                            if l__CollectionService__8:HasTag(u540, "Adult Gon") then
                                p657 = p657 * 3;
                            end;
                            if l__CollectionService__8:HasTag(u540, "DiviningInformationBuff") then
                                p657 = p657 * 1.2;
                            end;
                            if l__CollectionService__8:HasTag(u540, "Triple Accel") then
                                p657 = p657 * 1.05;
                            end;
                            local v706 = u540:GetAttribute("Infinity_Edge");
                            if v706 and (p657 > 0 and u542.Weapon == "Sword") then
                                p657 = p657 * v706;
                            end;
                            local v707 = u540:GetAttribute("Last_Stand");
                            local v708 = u540:GetAttribute("Last_Stand_MaxHp");
                            if v707 and (p657 > 0 and u540.Health.Value <= u540.Health.MaxValue * v708) then
                                p657 = p657 * v707;
                            end;
                            local v709 = u540:GetAttribute("Executioner");
                            local v710 = u540:GetAttribute("Executioner_MaxHp");
                            if v709 and (p657 > 0 and u541.Health.Value <= u541.Health.MaxValue * v710) then
                                p657 = p657 * v709;
                            end;
                            local v711 = u540:GetAttribute("Piercing_Arrow");
                            if v711 and (u542.IsProjectile and p657 > 0) then
                                p657 = p657 * v711;
                            end;
                            local v712 = not u542.Basic_Attack and u542.Can_Crit;
                            if v712 then
                                v712 = p657 > 0;
                            end;
                            local v713 = u542.Stand and (u540:GetAttribute("Jeweled_Soul") and p657 > 0) and true or v712;
                            if u545 and (not u542.Stand and (u540:GetAttribute("Jeweled_Vessel") and p657 > 0) and true or v713) then
                                local v714 = l__Weighted__15.new();
                                local v715 = u4.ReturnStat({
                                    Stat = "Crit_Chance",
                                    Player = u545
                                }).Amount / 100;
                                v714:AddItem("Crit", v715);
                                v714:AddItem("Nothing", 1 - v715);
                                if v714:GetRandomItem() == "Crit" then
                                    u655 = true;
                                    p657 = p657 * (u4.Default_Crit_Damage / 100);
                                end;
                            end;
                            local v716 = u540:GetAttribute("Spirit_Visage");
                            if v716 and p657 < 0 then
                                p657 = p657 * v716;
                            end;
                            if u542.NoDamageChange then
                                p657 = l__Damage__116;
                            end;
                            return p657;
                        end;
                        if u540:FindFirstChild("Ressurection") then
                            u541.BindableEvent:Fire("Burn", 10, nil, {
                                Attacker = u540
                            });
                        end;
                        if u548 and (v549 == "Killer Queen: Bites the Dust" and (u542.Style == "Killer Queen Bomb" or u542.Style == "Zipper Punch")) then
                            local v718 = Instance.new("Folder", u541);
                            v718.Name = "Killer QueenBombHit";
                            l__Debris2__12:AddItem(v718, 1.5);
                        end;
                        if u542.AutoExecute then
                            local v719 = Instance.new("Folder", u541);
                            l__Debris2__12:AddItem(v719, 0.5);
                            v719.Name = "AutoGrip";
                        end;
                        local u720 = v717(l__Damage__114, v568);
                        local v721, v722;
                        if u560 then
                            local v723 = u541:GetAttribute("Immortalized_Health_Percent");
                            if v723 and (not u541:GetAttribute("DoingImmortalized") and (u560.Value - u720 <= u560.MaxValue * v723 and not u541.BindableFunction:Invoke("ReturnHasCD", "Immortalized"))) then
                                u541.BindableFunction:Invoke("AddCD", {
                                    Name = "Immortalized",
                                    Timer = 90
                                });
                                u541:SetAttribute("DoingImmortalized", true);
                                local v724 = u560.MaxValue * u541:GetAttribute("Immortalized_Shield_Percent");
                                u541.BindableFunction:Invoke("AddShield", {
                                    Shield = v724,
                                    Duration2 = u541:GetAttribute("Immortalized_Duration")
                                });
                                u541:SetAttribute("DoingImmortalized", nil);
                                if u558 then
                                    v563 = u558:FindFirstChild("Shield_Indicator");
                                else
                                    v563 = u558;
                                end;
                            end;
                            if v563 and l__Damage__114 > 0 then
                                local v725 = u541.BindableFunction:Invoke("ReturnShield");
                                local v726 = v717(l__Damage__114, true);
                                local v727 = u541.BindableFunction:Invoke("DamageShield", {
                                    Shield_Gui = v563,
                                    Shield = v726
                                });
                                if v727 then
                                    u720 = v727.Current >= 0 and 0 or u720 + v727.Current;
                                    if u558 then
                                        l__ClientFX__16:FireAllClients("Damage Indicator", {
                                            Shield = true,
                                            Origin = u541:FindFirstChild("UpperTorso") or u558,
                                            Damage = -math.clamp(v725.Current - v727.Current, 0, v725.Current)
                                        });
                                    end;
                                end;
                            end;
                            local l__TSDamage__124 = u542.TSDamage;
                            if l__TSDamage__124 then
                                local l__MaxHealthScale__125 = l__TSDamage__124.MaxHealthScale;
                                local l__TotalDamage__126 = l__TSDamage__124.TotalDamage;
                                if not l__TotalDamage__126[u541] then
                                    l__TotalDamage__126[u541] = 0;
                                end;
                                local v728 = u541.Health.MaxValue * l__MaxHealthScale__125;
                                local v729 = l__TotalDamage__126[u541] + u720;
                                if v728 < v729 then
                                    u720 = math.clamp(u720 - (v729 - v728), 0, u720);
                                end;
                                l__TotalDamage__126[u541] = l__TotalDamage__126[u541] + u720;
                            end;
                            if u542.ConsistentDamage then
                                u720 = u542.Damage;
                            end;
                            local v730 = u542.Stand and u545 and (u545:FindFirstChild("StandSkillTree") and u545.StandSkillTree:FindFirstChild("Dino Virus"));
                            if v730 then
                                v730 = u545.StandSkillTree["Dino Virus"].Value;
                            end;
                            if v730 and (u541:FindFirstChild("Dino_Virus") and u541.Dino_Virus.Value >= u541.Dino_Virus.MaxValue) then
                                v721 = u655;
                                v722 = u656;
                                local v731 = 0.05;
                                for _, v732 in pairs(u545.StandSkillTree:GetChildren()) do
                                    if v732.Name:match("Potent Virus ") and v732.Value then
                                        v731 = v731 + 0.035;
                                    end;
                                end;
                                if u541.Health.Value - u720 <= u541.Health.MaxValue * v731 then
                                    u541.Health.Value = 0;
                                    u540.BindableEvent:Fire("CreateZombiePlayer", {
                                        Mob_Name = "Scary Monsters Minion",
                                        Victim = u559,
                                        Char = u541,
                                        Attacker = u545,
                                        AttackerChar = u540,
                                        StandName = v565
                                    });
                                    u541:SetAttribute("DinoVirus", nil);
                                end;
                            else
                                v721 = u655;
                                v722 = u656;
                            end;
                            local l__Health__127 = u541.Health;
                            l__Health__127.Value = l__Health__127.Value - u720;
                            if u559 and u545 then
                                u541.BindableEvent:Fire("AddDamageTag", {
                                    Player = u545,
                                    Damage = u720
                                });
                                u541.BindableEvent:Fire("Update_Last_Damaged", {
                                    Player = u545,
                                    Damage = u720
                                });
                            elseif not u559 and u545 then
                                v557();
                            end;
                        elseif u560 == nil and (u559 and (v562 and (v562.Health > 0 and u541))) then
                            u559:Kick("No Exploiting! (#3)");
                            v721 = u655;
                            v722 = u656;
                        else
                            v721 = u655;
                            v722 = u656;
                        end;
                        local u733 = u540:GetAttribute("Blighted_Quiver");
                        if u733 and (l__Damage__114 > 0 and u542.IsProjectile) then
                            u4.Spawn(function() --[[ Line: 5985 ]]
                                -- upvalues: u540 (ref), l__CombatStyleLibrary__111 (copy), u720 (ref), u733 (copy), u4 (ref)
                                local v734 = l__CombatStyleLibrary__111["Humanoid Stand"]("ReturnDamage_Info", {
                                    Timer = 0,
                                    Combo = "Blighted Quiver",
                                    Stand = "Mr. President",
                                    Tag = u540.Name .. " Blighted Quiver",
                                    Hit = u540.PrimaryPart,
                                    Origin = u540.LowerTorso
                                });
                                v734.Damage = -u720 * u733;
                                v734.Stun = nil;
                                v734.TrueDamage = true;
                                u4.Damage(u540, u540, v734);
                            end);
                        end;
                        local u735 = u540:GetAttribute("Bloodthirster");
                        if u735 and (l__Damage__114 > 0 and u542.Weapon == "Sword") then
                            u4.Spawn(function() --[[ Line: 6006 ]]
                                -- upvalues: u540 (ref), l__CombatStyleLibrary__111 (copy), u720 (ref), u735 (copy), u4 (ref)
                                local v736 = l__CombatStyleLibrary__111["Humanoid Stand"]("ReturnDamage_Info", {
                                    Timer = 0,
                                    Combo = "Bloodthirster",
                                    Stand = "Mr. President",
                                    Tag = u540.Name .. " Bloodthirster",
                                    Hit = u540.PrimaryPart,
                                    Origin = u540.LowerTorso
                                });
                                v736.Damage = -u720 * u735;
                                v736.Stun = nil;
                                v736.TrueDamage = true;
                                u4.Damage(u540, u540, v736);
                            end);
                        end;
                        local u737 = u540:GetAttribute("Immortalized_Heal");
                        if u737 and (l__Damage__114 > 0 and u542.Basic_Attack) then
                            u4.Spawn(function() --[[ Line: 6027 ]]
                                -- upvalues: u540 (ref), l__CombatStyleLibrary__111 (copy), u720 (ref), u737 (copy), u4 (ref)
                                local v738 = l__CombatStyleLibrary__111["Humanoid Stand"]("ReturnDamage_Info", {
                                    Timer = 0,
                                    Combo = "Bloodthirster",
                                    Stand = "Mr. President",
                                    Tag = u540.Name .. " Immortalized",
                                    Hit = u540.PrimaryPart,
                                    Origin = u540.LowerTorso
                                });
                                v738.Damage = -u720 * u737;
                                v738.Stun = nil;
                                v738.TrueDamage = true;
                                u4.Damage(u540, u540, v738);
                            end);
                        end;
                        if u540:GetAttribute("Blessing_of_Sparks") then
                            u540.BindableEvent:Fire("Blessing_of_Sparks", {
                                Victim = u541
                            });
                        end;
                        local v739 = u559 and workspace:FindFirstChild(u559.Name .. "\'s Horse");
                        if v739 then
                            local v740 = v739:FindFirstChild("Seat");
                            local v741 = v739:FindFirstChild("Stamina");
                            local v742 = v739:FindFirstChild("Speed");
                            if v741 and (v742 and (v740 and v740.Occupant == v562)) then
                                v741.Value = v741.Value - 3;
                                v742.Value = v742.Value - 10;
                            end;
                        end;
                        if v546 == nil and (u545 and (v547 and (v547.Health > 0 and u540))) then
                            u545:Kick("No Exploiting! (#3)");
                        end;
                        if v722 == true and not (u542.TSDamage or u541:FindFirstChild("CanBeDamagedUnconscious")) then
                            u541.BindableFunction:Invoke("AddBubbleLense", {
                                Attacker = u540,
                                Damage = u720
                            });
                        end;
                        if u558 then
                            l__ClientFX__16:FireAllClients("Damage Indicator", {
                                Origin = u541:FindFirstChild("UpperTorso") or u558,
                                Damage = u720,
                                Crit = v721
                            });
                            u541.BindableEvent:Fire("UpdateLastDamaged");
                        end;
                        if u542.Stun and u542.Stun.Timer > 0 then
                            u542.Stun.VFX = not u542.HideStun;
                            u541.BindableEvent:Fire("AddStun", u542.Stun);
                        end;
                        if not u542.NoHitAnim then
                            if u559 and u559.PlayerStats.Stand.Value == "Paragon Platinum" then
                                return;
                            end;
                            local v743 = u541.BindableFunction:Invoke("LoadAnimation", u542.HitAnim or l__ServerStorage__5.Anims["Hurt" .. math.random(1, 2)]);
                            v743.Priority = Enum.AnimationPriority.Action3;
                            v743:Play();
                        end;
                        if u542.HitEffect then
                            l__ClientFX__16:FireAllClients("HitEffect", u542.HitEffect);
                            if u542.HitEffect.Origin and u542.HitEffect.Origin.Parent.Name == "Frog" then
                                local l__HitEffect__128 = u542.HitEffect;
                                l__HitEffect__128.Origin = l__HitEffect__128.Origin.Parent.Head;
                                l__ClientFX__16:FireAllClients("HitEffect", l__HitEffect__128);
                            end;
                        end;
                        if u541:findFirstChild("Stand Barraging") and u540:findFirstChild("Stand Barraging") then
                            l__ClientFX__16:FireAllClients("HitEffect", {
                                Type = "Stand Clash",
                                Origin = u542.HitEffect.Origin,
                                Origin2 = u542.Origin or u540.PrimaryPart
                            });
                        end;
                        if u542.Style == "Mes" and u541:findFirstChild("Mes") then
                            u542.Knock = 0;
                        end;
                        if u542.Knock and u542.Knock > 0 then
                            u541.BindableFunction:Invoke("Knock", u542.Knock, {
                                NoIFrames = u542.NoIFrames,
                                IgnoreSturdiness = u542.IgnoreSturdiness,
                                DontStandCrash = u542.DontStandCrash
                            });
                        end;
                        require(game.ServerStorage.Modules.Combat.Dragger);
                        if u542.Knockback then
                            if u559 and u559.PlayerStats.Stand.Value == "Paragon Platinum" then
                                return;
                            end;
                            local l__Knockback__129 = u542.Knockback;
                            if u542.TimeStop then
                                l__Knockback__129 = l__Knockback__129 * 2;
                            end;
                            local v744 = math.random(-1, 1);
                            local v745 = math.random(-1, 1);
                            local v746 = Vector3.new(v744, v745, math.random(-1, 1)) * l__Knockback__129;
                            if u542.KnockbackDirection then
                                v746 = u542.KnockbackDirection * l__Knockback__129;
                            end;
                            if u542.KnockbackDirection2 and u542.Knockback2 then
                                local l__Knockback2__130 = u542.Knockback2;
                                if u542.TimeStop then
                                    l__Knockback2__130 = l__Knockback2__130 * 2;
                                end;
                                v746 = v746 + u542.KnockbackDirection2 * l__Knockback2__130;
                            end;
                            local v747 = u542.Style == "Finisher" and Vector3.new(inf, inf, inf) or Vector3.new(100000, 100000, 100000);
                            local v748 = u541:FindFirstChild("UpperTorso") or (u541:FindFirstChild("Torso") or u541:FindFirstChild("HumanoidRootPart"));
                            u4.AddVelocity(v748, v746, v747, 0.1, nil, u541);
                        end;
                        if u542.Style == "Star Finger" and u559 then
                            local v749 = 4;
                            if u542.Style == "Star Finger" then
                                v749 = v749 / 2;
                            end;
                            u541.RemoteEvent:FireClient(u559, "Eye Gouge Hit", v749);
                        elseif u542.Style == "Dazing" and u559 then
                            u541.RemoteEvent:FireClient(u559, "Eye Gouge Hit", 2.5);
                        elseif u542.Style == "Boomerang Bash" then
                            u541.BindableEvent:Fire("Bleed", {
                                Duration = 5,
                                TotalDamage = 5
                            });
                            if u559 then
                                u541.RemoteEvent:FireClient(u559, "Eye Gouge Hit", 2);
                            end;
                        elseif u542.Style == "Erasure" then
                            u541.BindableEvent:Fire("RemoveLimb", "Random", 25);
                        elseif u542.Style == "Void Ball" then
                            u541.BindableEvent:Fire("RemoveLimb", "Random", 20);
                        elseif u542.Style == "7 Page Beatdown" and (not u544 and (u541.PrimaryPart and not u541:FindFirstChild("Beatdowned"))) then
                            local l__StandAttach__131 = u548.PrimaryPart.StandAttach;
                            l__StandAttach__131.AlignOrientation.Attachment0 = nil;
                            l__StandAttach__131.AlignPosition.Attachment0 = nil;
                            u548.PrimaryPart.Anchored = true;
                            u548.PrimaryPart.CFrame = u540.PrimaryPart.CFrame * CFrame.new(0, 0, -4);
                            local l__CFrame__132 = u540.PrimaryPart.CFrame;
                            local l__CFrame__133 = u548.PrimaryPart.CFrame;
                            local u750 = l__CFrame__133 + l__CFrame__133.lookVector * 5 + Vector3.new(0, 1, 0);
                            local v751, v752 = u4.ReturnStandArms({
                                UseChar = false,
                                Despawn = 5.05,
                                StandInFolder = l__ServerStorage__5.Stands["Gold Experience"].StandMorph,
                                Char = u540
                            });
                            local u753 = v751;
                            local u754 = v752;
                            u4.Spawn(function() --[[ Line: 6222 ]]
                                -- upvalues: l__Debris2__12 (ref), u750 (copy), u541 (copy), u558 (copy), l__CFrame__133 (copy), u559 (copy)
                                local v755 = Instance.new("BodyPosition");
                                l__Debris2__12:AddItem(v755, 6.05);
                                v755.Name = "7 Page Beatdown Force";
                                v755.MaxForce = Vector3.new(inf, inf, inf);
                                v755.Position = u750.p;
                                u541.BindableEvent:Fire("AddForce", {
                                    Origin = u558,
                                    Force = v755
                                });
                                local v756 = Instance.new("BodyGyro");
                                l__Debris2__12:AddItem(v756, 6.05);
                                v756.Name = "7 Page Beatdown Force";
                                v756.MaxTorque = Vector3.new(inf, inf, inf);
                                v756.D = 5;
                                v756.P = 1000;
                                v756.CFrame = CFrame.new(u750.p, l__CFrame__133.p);
                                u541.BindableEvent:Fire("AddForce", {
                                    Origin = u558,
                                    Force = v756
                                });
                                u541.BindableEvent:Fire("AddStun", {
                                    Name = "7 Page Beatdown",
                                    Timer = 6.05
                                });
                                u541.BindableEvent:Fire("AddAutoRotate", {
                                    Value = false,
                                    Name = "7 Page Beatdown",
                                    Timer = 6.05
                                });
                                u541.BindableEvent:Fire("AddInvincibility", {
                                    Name = "7 Page Beatdown",
                                    Timer = 6.05
                                });
                                if u559 then
                                    u541.RemoteEvent:FireClient(u559, "Ora Beatdown", {
                                        Duration = 5
                                    });
                                end;
                                local v757 = Instance.new("Folder");
                                l__Debris2__12:AddItem(v757, 7.05);
                                v757.Name = "Beatdowned";
                                v757.Parent = u541;
                            end);
                            u4.Spawn(function() --[[ Line: 6254 ]]
                                -- upvalues: l__Debris2__12 (ref), l__CFrame__132 (copy), u540 (ref), l__ReplicatedStorage__6 (ref), u4 (ref), u545 (ref)
                                local v758 = Instance.new("BodyPosition");
                                l__Debris2__12:AddItem(v758, 5.05);
                                v758.MaxForce = Vector3.new(inf, inf, inf);
                                v758.Position = l__CFrame__132.p;
                                u540.BindableEvent:Fire("AddForce", {
                                    Origin = u540.HumanoidRootPart,
                                    Force = v758
                                });
                                local v759 = Instance.new("BodyGyro");
                                l__Debris2__12:AddItem(v759, 5.05);
                                v759.MaxTorque = Vector3.new(inf, inf, inf);
                                v759.CFrame = l__CFrame__132 + l__CFrame__132.lookVector;
                                u540.BindableEvent:Fire("AddForce", {
                                    Origin = u540.HumanoidRootPart,
                                    Force = v759
                                });
                                u540.BindableEvent:Fire("AddStun", {
                                    Name = "7 Page Beatdown",
                                    Timer = 5.55
                                });
                                u540.BindableEvent:Fire("AddAutoRotate", {
                                    Value = false,
                                    Name = "7 Page Beatdown",
                                    Timer = 5.05
                                });
                                u540.BindableEvent:Fire("AddInvincibility", {
                                    Name = "7 Page Beatdown",
                                    Timer = 5.55
                                });
                                local u760 = u540.BindableFunction:Invoke("LoadAnimation", l__ReplicatedStorage__6.Stands["Gold Experience"].PlayerIdle);
                                u760:Play();
                                u4.Delay(5.05, function() --[[ Line: 6274 ]]
                                    -- upvalues: u760 (copy)
                                    u760:Stop();
                                end);
                                if u545 then
                                    u540.RemoteEvent:FireClient(u545, "Ora Beatdown", {
                                        Duration = 5
                                    });
                                end;
                            end);
                            local v761 = l__ClientFX__16;
                            local v762 = "7 Page Beatdown";
                            local v763 = {
                                Windup = 0.5,
                                Duration = 4,
                                NoDist = true
                            };
                            local v764;
                            if l__StandAttach__131 then
                                v764 = l__StandAttach__131.Parent;
                            else
                                v764 = l__StandAttach__131;
                            end;
                            v763.Origin = v764;
                            v763.Victim = u541;
                            v763.Char = u540;
                            v763.Stand = u548;
                            v761:FireAllClients(v762, v763);
                            l__wait__4(0.5);
                            local v768 = l__ChannelMod2__113.new(4, function() --[[ Line: 6287 ]]
                                -- upvalues: l__wait__4 (ref), u4 (ref), l__CollectionService__8 (ref), u540 (ref), u548 (copy), l__StandAttach__131 (copy), u545 (ref), l__StandLibrary__112 (copy), u541 (copy), u560 (copy), u561 (copy), u558 (copy), l__CombatStyleLibrary__111 (copy)
                                l__wait__4(0.55);
                                u4.Spawn(function() --[[ Line: 6290 ]]
                                    -- upvalues: l__CollectionService__8 (ref), u540 (ref), u548 (ref), l__StandAttach__131 (ref), u545 (ref), l__StandLibrary__112 (ref)
                                    l__CollectionService__8:RemoveTag(u540, "7 Page Beatdown");
                                    u548.HumanoidRootPart.CFrame = u540.PrimaryPart.CFrame;
                                    l__StandAttach__131.AlignOrientation.Attachment0 = l__StandAttach__131;
                                    l__StandAttach__131.AlignPosition.Attachment0 = l__StandAttach__131;
                                    u548.HumanoidRootPart.Anchored = false;
                                    if u545 then
                                        u548.PrimaryPart:SetNetworkOwner(u545);
                                    end;
                                    u540.PrimaryPart.StandAttach.Position = l__StandLibrary__112.Stands["Gold Experience"].SummonedPos;
                                end);
                                u4.Spawn(function() --[[ Line: 6305 ]]
                                    -- upvalues: u541 (ref)
                                    for _, v765 in pairs(u541:GetDescendants()) do
                                        if v765.Name == "7 Page Beatdown Force" then
                                            v765:Destroy();
                                        end;
                                    end;
                                end);
                                local v766 = u4.ReturnScalingIncrease(15.527000000000001, 1.3, u560.MaxValue, u561);
                                local v767 = l__CombatStyleLibrary__111["Humanoid Stand"]("ReturnDamage_Info", {
                                    Timer = 0,
                                    Combo = "Finisher",
                                    Stand = "Star Platinum: The World",
                                    Tag = "7 Page Beatdown Pt3" .. u540.Name,
                                    Hit = u558,
                                    Origin = u540.HumanoidRootPart
                                });
                                v767.IgnoreInvincibility = true;
                                v767.Damage = 6.211 + v766;
                                v767.NoHitAnim = true;
                                v767.BlockBreaker = true;
                                v767.PerfectBlockable = false;
                                u4.Damage(u540, u541, v767);
                            end);
                            local u769 = nil;
                            function v768.Duration() --[[ Line: 6337 ]]
                                -- upvalues: u769 (ref), u4 (ref), l__ClientFX__16 (ref), u548 (copy), u753 (ref), u754 (ref), u540 (ref), u558 (copy), l__CombatStyleLibrary__111 (copy), u541 (copy)
                                if not u769 or tick() - u769 >= 0.1 then
                                    u769 = tick();
                                    u4.Spawn(function() --[[ Line: 6341 ]]
                                        -- upvalues: l__ClientFX__16 (ref), u548 (ref), u753 (ref), u754 (ref)
                                        l__ClientFX__16:FireAllClients("Stand Barrage", {
                                            UseChar = false,
                                            Origin = u548.PrimaryPart,
                                            RightArmClone = u753,
                                            LeftArmClone = u754
                                        });
                                        l__ClientFX__16:FireAllClients("PlaySound", {
                                            Origin = u548.HumanoidRootPart,
                                            Sound = "Swing" .. math.random(1, 2)
                                        });
                                    end);
                                    local v770 = l__CombatStyleLibrary__111["Humanoid Stand"]("ReturnDamage_Info", {
                                        Timer = 0,
                                        Combo = 1,
                                        Stand = "Gold Experience",
                                        Tag = "7 Page Beatdown Pt2" .. u540.Name,
                                        Hit = u558,
                                        Origin = u540.HumanoidRootPart
                                    });
                                    v770.Damage = 0.23290000000000002;
                                    v770.IgnoreInvincibility = true;
                                    v770.Knockback = false;
                                    v770.Knockback2 = false;
                                    v770.NoHitAnim = true;
                                    v770.BlockBreaker = true;
                                    v770.PerfectBlockable = false;
                                    v770.Stun.Timer = 0.5;
                                    u4.Damage(u540, u541, v770);
                                end;
                            end;
                            v768:Start();
                        elseif u542.Style == "Ora Beatdown" and not (u544 or u541:FindFirstChild("Beatdowned")) then
                            local u771 = Instance.new("Attachment");
                            l__Debris2__12:AddItem(u771, 15);
                            local u772 = Vector3.new(0, 0, -(u548.HumanoidRootPart.Size.Z * 4 + u541.HumanoidRootPart.Size.Z * 4));
                            u4.pcall(function() --[[ Line: 6391 ]]
                                -- upvalues: u771 (copy), u772 (copy)
                                u771.Position = u772;
                            end);
                            u771.Parent = u548.HumanoidRootPart;
                            for u773 = 1, 2 do
                                local u774, u775;
                                if u773 == 1 then
                                    u774 = u559;
                                    u775 = u541;
                                else
                                    u774 = u545;
                                    u775 = u540;
                                end;
                                u4.Spawn(function() --[[ Line: 6406 ]]
                                    -- upvalues: u775 (ref), u774 (ref), l__CollectionService__8 (ref), u541 (copy), l__wait__4 (ref), u540 (ref), l__StandLibrary__112 (copy), u548 (copy), u4 (ref), l__Debris2__12 (ref)
                                    u775.BindableEvent:Fire("AddStun", {
                                        Name = "Ora BeatdownSTUN"
                                    });
                                    u775.BindableEvent:Fire("AddAutoRotate", {
                                        Value = false,
                                        Name = "Ora Beatdown"
                                    });
                                    u775.BindableEvent:Fire("AddInvincibility", {
                                        Name = "Ora Beatdown"
                                    });
                                    if u774 then
                                        u775.RemoteEvent:FireClient(u774, "Ora Beatdown", {
                                            Duration = 9.1
                                        });
                                    end;
                                    l__CollectionService__8:AddTag(u775, "Ora Beatdown");
                                    if u775 == u541 then
                                        u541.BindableEvent:Fire("ToggleStand", false, {
                                            ForcedSummon = true
                                        });
                                    end;
                                    l__wait__4(9.1);
                                    if u540 == u775 then
                                        u775.HumanoidRootPart.StandAttach.Position = l__StandLibrary__112.Stands["Star Platinum: The World"].SummonedPos;
                                        if u548 and u548.Parent then
                                            u4.pcall(function() --[[ Line: 6430 ]]
                                                -- upvalues: u548 (ref), u774 (ref)
                                                u548.PrimaryPart:SetNetworkOwner(u774);
                                            end);
                                        end;
                                    else
                                        local v776 = Instance.new("Folder");
                                        l__Debris2__12:AddItem(v776, 2);
                                        v776.Name = "Beatdowned";
                                        v776.Parent = u541;
                                    end;
                                    l__CollectionService__8:RemoveTag(u775, "Ora Beatdown");
                                    u775.BindableEvent:Fire("RemoveAutoRotate", "Ora Beatdown");
                                    u775.BindableEvent:Fire("RemoveInvincibility", "Ora Beatdown");
                                    u775.BindableEvent:Fire("RemoveStun", "Ora BeatdownSTUN");
                                    if not u774 then
                                        u4.pcall(function() --[[ Line: 6449 ]]
                                            -- upvalues: u775 (ref)
                                            u775.HumanoidRootPart:SetNetworkOwner(nil);
                                        end);
                                    end;
                                end);
                                local l__CFrame__134 = u548.HumanoidRootPart.CFrame;
                                local u777 = l__CFrame__134 * CFrame.new(0, 0, -(u548.HumanoidRootPart.Size.Z * 4 + u541.HumanoidRootPart.Size.Z * 4));
                                u4.pcall(function() --[[ Line: 6456 ]]
                                    -- upvalues: l__Debris2__12 (ref), u773 (copy), u777 (copy), u548 (copy), u775 (ref), l__CFrame__134 (copy)
                                    local v778 = Instance.new("BodyPosition");
                                    l__Debris2__12:AddItem(v778, 8.5);
                                    v778.MaxForce = Vector3.new(inf, inf, inf);
                                    v778.D = 50;
                                    if u773 == 1 then
                                        v778.Position = CFrame.new(u777.p, u548.PrimaryPart.CFrame.p).p;
                                        v778.Parent = u775.HumanoidRootPart;
                                    else
                                        v778.Position = l__CFrame__134.p;
                                        v778.Parent = u548.HumanoidRootPart;
                                    end;
                                    local v779 = Instance.new("BodyGyro");
                                    l__Debris2__12:AddItem(v779, 8.5);
                                    v779.MaxTorque = Vector3.new(inf, inf, inf);
                                    v779.D = 5;
                                    v779.P = 100000;
                                    if u773 == 1 then
                                        v779.CFrame = CFrame.new(u777.p, u548.PrimaryPart.CFrame.p);
                                        v779.Parent = u775.HumanoidRootPart;
                                    else
                                        v779.CFrame = l__CFrame__134;
                                        v779.Parent = u548.HumanoidRootPart;
                                    end;
                                end);
                            end;
                            local v780, v781 = u4.ReturnStandArms({
                                Despawn = 14.1,
                                StandInFolder = l__ServerStorage__5.Stands[v549].StandMorph,
                                Char = u540
                            });
                            l__ClientFX__16:FireAllClients("Ora Beatdown", {
                                NoDist = true,
                                RightArmClone = v780,
                                LeftArmClone = v781,
                                Origin = u540.HumanoidRootPart,
                                Victim = u541,
                                Stand = u548,
                                Attachment = u771
                            });
                            u4.Spawn(function() --[[ Line: 6495 ]]
                                -- upvalues: u548 (copy), l__ReplicatedStorage__6 (ref), u541 (copy), u540 (ref)
                                u548:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(l__ReplicatedStorage__6.Anims.OraBeatdownAssets.StandBeatdown):Play();
                                u541.Humanoid:LoadAnimation(l__ReplicatedStorage__6.Anims.OraBeatdownAssets.VictimBeatdown):Play();
                                u540.Humanoid:LoadAnimation(l__ReplicatedStorage__6.Anims.OraBeatdownAssets.UserBeatdown):Play();
                            end);
                            u4.Delay(0.5, function() --[[ Line: 6506 ]]
                                -- upvalues: u540 (ref), u558 (copy), l__CombatStyleLibrary__111 (copy), u4 (ref), u541 (copy)
                                local v782 = l__CombatStyleLibrary__111["Humanoid Stand"]("ReturnDamage_Info", {
                                    Timer = 0,
                                    Combo = "Finisher",
                                    Stand = "Star Platinum: The World",
                                    Tag = "Ora Beatdown Pt2" .. u540.Name,
                                    Hit = u558,
                                    Origin = u540.HumanoidRootPart
                                });
                                v782.IgnoreInvincibility = true;
                                v782.Knockback = false;
                                v782.Knockback2 = false;
                                v782.Knock = 0;
                                v782.Sound = nil;
                                v782.HitEffect = nil;
                                v782.PerfectBlockable = false;
                                v782.BlockBreaker = true;
                                v782.NoHitAnim = true;
                                v782.Damage = 5;
                                u4.Damage(u540, u541, v782);
                            end);
                            u4.Delay(2.9, function() --[[ Line: 6530 ]]
                                -- upvalues: u540 (ref), u558 (copy), l__CombatStyleLibrary__111 (copy), u4 (ref), u541 (copy)
                                local v783 = l__CombatStyleLibrary__111["Humanoid Stand"]("ReturnDamage_Info", {
                                    Timer = 0,
                                    Combo = "Finisher",
                                    Stand = "Star Platinum: The World",
                                    Tag = "Ora Beatdown Pt2" .. u540.Name,
                                    Hit = u558,
                                    Origin = u540.HumanoidRootPart
                                });
                                v783.IgnoreInvincibility = true;
                                v783.Knockback = false;
                                v783.Knockback2 = false;
                                v783.Knock = 0;
                                v783.Sound = nil;
                                v783.HitEffect = nil;
                                v783.PerfectBlockable = false;
                                v783.BlockBreaker = true;
                                v783.NoHitAnim = true;
                                v783.Damage = 5;
                                u4.Damage(u540, u541, v783);
                            end);
                            u4.Delay(3.37, function() --[[ Line: 6554 ]]
                                -- upvalues: u540 (ref), u558 (copy), l__CombatStyleLibrary__111 (copy), u4 (ref), u541 (copy)
                                local v784 = l__CombatStyleLibrary__111["Humanoid Stand"]("ReturnDamage_Info", {
                                    Timer = 0,
                                    Combo = "Finisher",
                                    Stand = "Star Platinum: The World",
                                    Tag = "Ora Beatdown Pt2" .. u540.Name,
                                    Hit = u558,
                                    Origin = u540.HumanoidRootPart
                                });
                                v784.IgnoreInvincibility = true;
                                v784.Knockback = false;
                                v784.Knockback2 = false;
                                v784.Knock = 0;
                                v784.Sound = nil;
                                v784.HitEffect = nil;
                                v784.PerfectBlockable = false;
                                v784.BlockBreaker = true;
                                v784.NoHitAnim = true;
                                v784.Damage = 5;
                                u4.Damage(u540, u541, v784);
                            end);
                            u4.Delay(3.8, function() --[[ Line: 6578 ]]
                                -- upvalues: u4 (ref), u540 (ref), u558 (copy), l__CombatStyleLibrary__111 (copy), u541 (copy), l__wait__4 (ref)
                                for _ = 1, 30 do
                                    u4.Spawn(function() --[[ Line: 6582 ]]
                                        -- upvalues: u540 (ref), u558 (ref), l__CombatStyleLibrary__111 (ref), u4 (ref), u541 (ref)
                                        local v785 = l__CombatStyleLibrary__111["Humanoid Stand"]("ReturnDamage_Info", {
                                            Timer = 0,
                                            Combo = 1,
                                            Stand = "Star Platinum: The World",
                                            Tag = "Ora Beatdown Pt2" .. u540.Name,
                                            Hit = u558,
                                            Origin = u540.HumanoidRootPart
                                        });
                                        v785.Damage = 0.26666666666666666;
                                        v785.IgnoreInvincibility = true;
                                        v785.Knockback = false;
                                        v785.Knockback2 = false;
                                        v785.PerfectBlockable = false;
                                        v785.BlockBreaker = true;
                                        v785.Sound = nil;
                                        v785.HitEffect = nil;
                                        v785.NoHitAnim = true;
                                        u4.Damage(u540, u541, v785);
                                    end);
                                    l__wait__4(0.14);
                                end;
                            end);
                            u4.Spawn(function() --[[ Line: 6609 ]]
                                -- upvalues: l__wait__4 (ref), u4 (ref), u560 (copy), u561 (copy), u540 (ref), u558 (copy), l__CombatStyleLibrary__111 (copy), u541 (copy)
                                l__wait__4(8.5);
                                local v786 = u4.ReturnScalingIncrease(28, 1.3, u560.MaxValue, u561);
                                local v787 = l__CombatStyleLibrary__111["Humanoid Stand"]("ReturnDamage_Info", {
                                    Timer = 0,
                                    Combo = "Finisher",
                                    Stand = "Star Platinum: The World",
                                    Tag = "Ora Beatdown Pt2" .. u540.Name,
                                    Hit = u558,
                                    Origin = u540.HumanoidRootPart
                                });
                                v787.IgnoreInvincibility = true;
                                v787.PerfectBlockable = false;
                                v787.BlockBreaker = true;
                                v787.Sound = nil;
                                v787.HitEffect = nil;
                                v787.NoHitAnim = true;
                                v787.Knockback = v787.Knockback * 1.3;
                                v787.Damage = 5 + v786;
                                if u4.Damage(u540, u541, v787) then
                                    u540.BindableEvent:Fire("AddUltRagdollCD");
                                end;
                            end);
                        elseif u542.Style == "Gaebolg" then
                            u541.BindableEvent:Fire("RemoveLimb", "Random");
                            u541.BindableEvent:Fire("Bleed", {
                                Duration = 12,
                                TotalDamage = 30
                            });
                        elseif u542.Style == "Vaporization Freezing Strike" then
                            local v788 = 2;
                            if u545 then
                                for _, v789 in pairs(u545.SpecSkillTree:GetChildren()) do
                                    if v789.Name:match("Superhuman Strength II") and v789.Value then
                                        v788 = v788 * 1.5;
                                    end;
                                end;
                            end;
                            u541.BindableEvent:Fire("AddAutoRotate", {
                                Name = u542.Style .. u540.Name,
                                Timer = v788
                            });
                            u541.BindableEvent:Fire("AddRoot", {
                                Name = u542.Style .. u540.Name,
                                Timer = v788
                            });
                            l__ClientFX__16:FireAllClients("Vaporization Freezing Strike Hit", {
                                Origin = u558,
                                Duration = v788
                            });
                        elseif u542.Style == "Kidnap" and u545 then
                            local v790 = 1;
                            if u545 then
                                for _, v791 in pairs(u545.StandSkillTree:GetChildren()) do
                                    if v791.Name:match("Kidnapping ") and v791.Value then
                                        v790 = v790 + 0.35;
                                    end;
                                end;
                            end;
                            local v792 = 7 * v790;
                            if u559 and not u540:FindFirstChild("InCocoJumbo") then
                                if u4.OwnCocoJumbo(u545) then
                                    local l__CFrame__135 = u541.PrimaryPart.CFrame;
                                    local u793 = u4.EnterCocoJumbo(u541, u545.Name, v792, u540);
                                    if l__ReplicatedStorage__6.Game_Modes["1v1s"].PlaceIds:FindFirstChild(game.PlaceId) or (l__ReplicatedStorage__6.Game_Modes["2v2s"].PlaceIds:FindFirstChild(game.PlaceId) or l__ReplicatedStorage__6.Game_Modes["Metal Ball Run"].PlaceIds:FindFirstChild(game.PlaceId)) then
                                        u4.Delay(v792, function() --[[ Line: 6702 ]]
                                            -- upvalues: u793 (copy), u4 (ref), u541 (copy), u545 (ref), l__CFrame__135 (copy)
                                            if u793 and u793.Parent then
                                                u4.ExitCocoJumbo(u541, u545.Name, l__CFrame__135);
                                            end;
                                        end);
                                    end;
                                end;
                            else
                                u541.BindableEvent:Fire("AddStun", {
                                    VFX = true,
                                    Name = "KidnapNPCStun" .. u545.Name,
                                    Timer = 1 * v790
                                });
                            end;
                        elseif u542.Style == "Red Bind" or (u542.Style == "Crossfire Hurricane Special" or u542.Style == "Crossfire Hurricane") then
                            local v794 = 3;
                            if u545 then
                                local v795 = 1;
                                for _, v796 in pairs(u545.StandSkillTree:GetChildren()) do
                                    if v796.Name:match("Pyrokinesis ") and v796.Value then
                                        v795 = v795 + 0.35;
                                    end;
                                end;
                                v794 = v794 * v795;
                            end;
                            u541.BindableEvent:Fire("Burn", v794, nil, {
                                Attacker = u540
                            });
                        elseif u542.Style == "Marionette Control" then
                            local v797 = 1.5;
                            if u545 then
                                local v798 = 0;
                                for _, v799 in pairs(u545.StandSkillTree:GetChildren()) do
                                    if v799.Name:match("Puppet Master ") and v799.Value then
                                        v798 = v798 + 0.5;
                                    end;
                                end;
                                v797 = v797 + v798;
                            end;
                            l__ClientFX__16:FireAllClients(u542.Style, {
                                Origin = u541.HumanoidRootPart,
                                AttackerOrigin = u548.HumanoidRootPart,
                                Duration = v797
                            });
                            if u559 then
                                u541.BindableEvent:Fire("AddSprintSpeed", {
                                    Value = -8,
                                    Name = u542.Style .. u540.Name .. " Marionette Controlled",
                                    Timer = v797
                                });
                                u541.BindableEvent:Fire("AddMoveStun", {
                                    Name = u542.Style .. u540.Name .. " Marionette Controlled",
                                    Timer = v797
                                });
                                u541.RemoteEvent:FireClient(u559, u542.Style, {
                                    Duration = v797,
                                    Origin = u548.HumanoidRootPart
                                });
                            else
                                u541.BindableEvent:Fire("AddWalkSpeed", {
                                    Value = -100,
                                    Name = u542.Style .. u540.Name .. " Marionette Controlled",
                                    Timer = v797
                                });
                            end;
                            local v800 = Instance.new("Folder");
                            l__Debris2__12:AddItem(v800, v797);
                            v800.Name = "DontStandCrash";
                            v800.Parent = u541;
                        elseif u542.Style == "Mes" and u541:findFirstChild("Mes") == nil then
                            Instance.new("Folder", u541).Name = "Mes";
                            local v801 = l__ServerStorage__5.Objects.Heart:Clone();
                            v801.Name = u541.Name .. "\'s Heart";
                            v801.Victim.Value = u541;
                            v801.Parent = u545.Backpack;
                        elseif u542.Style == "Incinerate" then
                            u541.BindableEvent:Fire("Burn", 10, nil, {
                                Attacker = u540
                            });
                        elseif u542.Style == "Life Giver" then
                            local v802 = 2;
                            if u545.StandSkillTree then
                                for _, v803 in pairs(u545.StandSkillTree:GetChildren()) do
                                    if v803.Name:match("Life Manipulation ") and v803.Value then
                                        v802 = v802 + 0.75;
                                    end;
                                end;
                            end;
                            local v804 = l__ServerStorage__5.Objects.Frog:Clone();
                            l__Debris2__12:AddItem(v804, v802);
                            for _, v805 in pairs(v804:GetDescendants()) do
                                if v805:IsA("BasePart") then
                                    v805.CollisionGroup = "Mobs";
                                end;
                            end;
                            v804.Parent = u541;
                            v804.PrimaryPart.CFrame = u541.HumanoidRootPart.CFrame;
                            v804.Script.Disabled = false;
                            l__ClientFX__16:FireAllClients("PlaySound", {
                                Sound = "Gold Experience Heal",
                                Origin = u541.HumanoidRootPart
                            });
                            l__ClientFX__16:FireAllClients("Life Giver", {
                                Origin = v804.PrimaryPart
                            });
                            u541:FindFirstChild("BindableEvent"):Fire("Poison", {
                                Duration = 10,
                                TotalDamage = 10,
                                Attacker = u540
                            });
                            u541.BindableEvent:Fire("RemoveLimb", "Random", v802);
                        elseif u542.Style == "Injury Overwrite" then
                            l__ClientFX__16:FireAllClients("PlaySound", {
                                Sound = "Overwrite1",
                                Origin = u541:FindFirstChild("HumanoidRootPart")
                            });
                            if u559 then
                                for _, v806 in pairs({ "LeftArm", "RightLeg", "LeftLeg" }) do
                                    u559.PlayerStats[v806].Value = "Normal";
                                end;
                                u541.BindableEvent:Fire("UpdateLimbs");
                                u541.BindableEvent:Fire("StopBleed");
                                u541.BindableEvent:Fire("StopPoison");
                                u541.BindableEvent:Fire("StopBurn");
                            end;
                        elseif u542.Style == "Gold Experience Distribution" and u559 then
                            for _, v807 in pairs({ "LeftArm", "RightLeg", "LeftLeg" }) do
                                u559.PlayerStats[v807].Value = "Normal";
                            end;
                            u541.BindableEvent:Fire("UpdateLimbs");
                            u541.BindableEvent:Fire("StopBleed");
                            u541.BindableEvent:Fire("StopPoison");
                            u541.BindableEvent:Fire("StopBurn");
                        elseif u542.Style == "Sensory Acceleration" and (u559 and u541 ~= u540) then
                            local v808 = 2;
                            if u545.StandSkillTree then
                                for _, v809 in pairs(u545.StandSkillTree:GetChildren()) do
                                    if v809.Name:match("Sensory Acceleration ") and v809.Value then
                                        v808 = v808 + 0.8;
                                    end;
                                end;
                            end;
                            u541.RemoteEvent:FireClient(u559, "Gold Experience Soul Knock", {
                                Timer = v808
                            });
                            l__wait__4(0.1);
                            u541.BindableEvent:Fire("AddWalkSpeed", {
                                Name = "Senses Accelerated",
                                Value = -4,
                                Timer = v808
                            });
                            u541.BindableEvent:Fire("AddSprintSpeed", {
                                Name = "Senses Accelerated",
                                Value = -8,
                                Timer = v808
                            });
                            u541.BindableEvent:Fire("AddJumpPower", {
                                Name = "Senses Accelerated",
                                Value = -100,
                                Timer = v808
                            });
                            u541.BindableEvent:Fire("AddAutoRotate", v808);
                            u4.AddVelocity(u541.LowerTorso, u540.HumanoidRootPart.CFrame.lookVector * 35, Vector3.new(100000, 100000, 100000), 0.1);
                        end;
                        print("Damage:", l__Damage__114);
                        return true, {
                            VictimOriginHealth = u561
                        };
                    end;
                    u541.BindableEvent:Fire("AddTimeStopDamage", {
                        Attacker = u540,
                        Victim = u541,
                        Info = u542
                    });
                end;
            end;
        end;
    end;
end;
_G.VisualizeHitbox = false;
function u4.SpawnRegion3(p810, ...) --[[ Line: 6878 ]]
    -- upvalues: l__RegionMod__18 (copy), l__Debris2__12 (copy)
    local v811 = ... or {};
    local l__Origin__136 = v811.Origin;
    if not l__Origin__136 then
        if p810 then
            l__Origin__136 = p810:FindFirstChild("HumanoidRootPart");
        else
            l__Origin__136 = p810;
        end;
    end;
    if l__Origin__136 then
        if p810 then
            p810 = p810:FindFirstChild("HumanoidRootPart");
        end;
        local l__Size__137 = l__Origin__136.Size;
        local l__Size__138 = v811.Size;
        local v812 = (v811.CFrame or l__Origin__136.CFrame) * (v811.TweakCFrame or CFrame.new(0, 0, 0));
        if l__Origin__136.Name == "HumanoidRootPart" then
            local l__Velocity__139 = l__Origin__136.Velocity;
            local v813 = l__Velocity__139.magnitude > 0 and l__Velocity__139.unit or Vector3.new(0, 0, 0);
            local v814 = v813:Dot(v812.lookVector);
            local v815 = v812.rightVector:Dot(v813);
            v812.upVector:Dot(v813);
            if not v811.IgnoreVelocity then
                v812 = v812 * CFrame.new(0, 0, -(l__Size__138.Z / 2 + l__Size__137.Z / 2));
            end;
            if not v811.DontFillGap and p810 then
                v812 = v812 * CFrame.new(0, 0, p810.Size.Z);
                l__Size__138 = l__Size__138 + Vector3.new(0, 0, p810.Size.Z);
            end;
            if not (v811.IgnoreVelocity or v811.IgnoreVelocity2) then
                if v814 ~= 0 and math.floor(v814) then
                    if math.floor(v814 + 0.5) == 1 then
                        v812 = v812 * CFrame.new(0, 0, -(l__Size__138.Z / 2 + l__Size__137.Z / 2));
                    else
                        local _ = math.floor(v814 + 0.5) == -1;
                    end;
                end;
                if v815 ~= 0 and math.floor(v815) then
                    if math.floor(v815 + 0.5) == 1 then
                        v812 = v812 * CFrame.new(l__Size__138.X / 2 + l__Size__137.X / 2, 0, 0);
                    elseif math.floor(v815 + 0.5) == -1 then
                        v812 = v812 * CFrame.new(-(l__Size__138.X / 2 + l__Size__137.X / 2), 0, 0);
                    end;
                end;
            end;
        end;
        local v816 = l__RegionMod__18.new(v812, l__Size__138);
        if script:GetAttribute("VisualizeHitbox") == true or _G.VisualizeHitbox == true then
            local l__RunService__140 = game:GetService("RunService");
            local v817 = Instance.new("Part", workspace);
            local v818;
            if l__RunService__140:IsClient() then
                v818 = BrickColor.Gray();
            else
                v818 = BrickColor.Random();
            end;
            v817.BrickColor = v818;
            v817.Material = "SmoothPlastic";
            v817.Anchored = true;
            v817.CanCollide = false;
            v817.CanTouch = false;
            v817.CastShadow = false;
            v817.Size = v816.Size;
            v817.CFrame = v816.CFrame;
            v817.Transparency = 0.8;
            l__Debris2__12:AddItem(v817, 1);
        end;
        return v816;
    end;
end;
function u4.Split(p819, p820) --[[ Line: 6957 ]]
    -- upvalues: l__Debris2__12 (copy)
    local v821 = {};
    for _ = 1, p820 do
        local v822 = p819:Clone();
        l__Debris2__12:AddItem(v822, 1);
        v822.Size = p819.Size / 4;
        v822.CFrame = p819.CFrame;
        v822.CanCollide = false;
        v822.Anchored = false;
        v822.Parent = workspace;
        table.insert(v821, v822);
    end;
    return v821;
end;
function u4.Spawn(u823) --[[ Line: 6972 ]]
    -- upvalues: l__create__2 (copy), u1 (copy), u2 (copy), l__resume__1 (copy)
    local u824 = nil;
    local u825 = debug.info(2, "s");
    local u826 = debug.info(2, "l");
    u824 = l__create__2(function() --[[ Line: 6978 ]]
        -- upvalues: u824 (ref), u1 (ref), u823 (copy), u825 (ref), u826 (ref), u2 (ref)
        u824 = nil;
        local v827, v828 = u1(function() --[[ Line: 6981 ]]
            -- upvalues: u823 (ref)
            u823();
        end);
        if not v827 then
            print("Lib.Spawn Error:", v828, " | DEBUG INFO:", u825, u826);
        end;
        u825 = nil;
        u826 = nil;
        if u2.running() then
            u2.yield();
        else
            u2.close();
        end;
    end);
    l__resume__1(u824);
end;
function u4.Delay(u829, u830) --[[ Line: 7004 ]]
    -- upvalues: l__create__2 (copy), u1 (copy), l__wait__4 (copy), u2 (copy), l__resume__1 (copy)
    local u831 = nil;
    local u832 = debug.info(2, "s");
    local u833 = debug.info(2, "l");
    u831 = l__create__2(function() --[[ Line: 7010 ]]
        -- upvalues: u831 (ref), u1 (ref), u829 (copy), l__wait__4 (ref), u830 (copy), u832 (ref), u833 (ref), u2 (ref)
        u831 = nil;
        local v834, v835 = u1(function() --[[ Line: 7013 ]]
            -- upvalues: u829 (ref), l__wait__4 (ref), u830 (ref)
            if u829 >= 1 then
                l__wait__4(u829);
            else
                l__wait__4(u829);
            end;
            u830();
        end);
        if not v834 then
            print("Lib.Delay Error:", v835, " | DEBUG INFO:", u832, u833);
        end;
        u832 = nil;
        u833 = nil;
        if u2.running() then
            u2.yield();
        else
            u2.close();
        end;
    end);
    l__resume__1(u831);
end;
function u4.pcall(u836) --[[ Line: 7043 ]]
    -- upvalues: u1 (copy)
    local v837 = debug.info(2, "s");
    local v838 = debug.info(2, "l");
    local v839, v840 = u1(function() --[[ Line: 7047 ]]
        -- upvalues: u836 (copy)
        u836();
    end);
    if not v839 then
        print("Lib.pcall Error:", v840, " | DEBUG INFO:", v837, v838);
    end;
    return v839, v840;
end;
function u4.SplitPart(...) --[[ Line: 7058 ]]
    -- upvalues: l__ClientFX__16 (copy)
    local v841 = ...;
    local l__Part__141 = v841.Part;
    local l__Player__142 = v841.Player;
    local l__Splitter__143 = require(script.Splitter);
    local v842 = l__Splitter__143.ReturnLongestAxis(l__Part__141);
    local v843 = l__Splitter__143.ReturnLongestAxis(l__Part__141, true);
    local v844 = l__Splitter__143.SplitPart(l__Part__141, l__Player__142, v841);
    if v844 then
        l__ClientFX__16:FireAllClients("SplitPart", {
            Part = l__Part__141,
            LongestAxis = v842,
            Axis = v843
        });
    end;
    return v844;
end;
if l__ReplicatedStorage__6.Game_Modes["1v1s"].PlaceIds:FindFirstChild(game.PlaceId) then
    u4.Default_Crit_Chance = 0;
    u4.Default_Crit_Damage = 100;
else
    u4.Default_Crit_Chance = 10;
    u4.Default_Crit_Damage = 150;
end;
function u4.ReturnStat(...) --[[ Line: 7085 ]]
    -- upvalues: u4 (copy), l__ServerStorage__5 (copy), l__CollectionService__8 (copy)
    local u845 = ... or {};
    local l__Stat__144 = u845.Stat;
    local l__Player__145 = u845.Player;
    local l__self__146 = u845.self;
    local u846 = l__self__146 and l__self__146.Char;
    if not u846 then
        if l__Player__145 then
            u846 = l__Player__145.Character;
        else
            u846 = l__Player__145;
        end;
    end;
    local u847;
    if u846 then
        u847 = u846:FindFirstChild("Health");
    else
        u847 = u846;
    end;
    local u848;
    if u846 then
        u848 = u846:FindFirstChild("InTimeStop");
    else
        u848 = u846;
    end;
    local u849;
    if u846 then
        u849 = u846:FindFirstChild("HumanoidRootPart");
    else
        u849 = u846;
    end;
    local u850;
    if u846 then
        u850 = u846:FindFirstChild("Blood");
    else
        u850 = u846;
    end;
    local u851;
    if u846 then
        u851 = u846:FindFirstChild("RemoteFunction");
    else
        u851 = u846;
    end;
    local u852;
    if u846 then
        u852 = u846:FindFirstChild("BindableFunction");
    else
        u852 = u846;
    end;
    local u853;
    if l__Player__145 then
        u853 = l__Player__145:FindFirstChild("CharacterSkillTree");
    else
        u853 = l__Player__145;
    end;
    local u854;
    if l__Player__145 then
        u854 = l__Player__145:FindFirstChild("StandSkillTree");
    else
        u854 = l__Player__145;
    end;
    local u855;
    if l__Player__145 then
        u855 = l__Player__145:FindFirstChild("SpecSkillTree");
    else
        u855 = l__Player__145;
    end;
    local v884 = {
        Max_Health = function() --[[ Line: 7105 ]]
            -- upvalues: u846 (copy), l__Player__145 (copy)
            local l__MaxHealth__147 = u846.Humanoid.MaxHealth;
            if l__Player__145 then
                if l__Player__145.CharacterSkillTree then
                    for _, v856 in pairs(l__Player__145.CharacterSkillTree:GetChildren()) do
                        if v856.Name:match("Vitality ") and v856.Value then
                            l__MaxHealth__147 = l__MaxHealth__147 + 10.5;
                        end;
                        if v856.Name:match("Meat Shield ") and v856.Value then
                            l__MaxHealth__147 = l__MaxHealth__147 + 17;
                        end;
                    end;
                end;
                if l__Player__145.StandSkillTree then
                    for _, v857 in pairs(l__Player__145.StandSkillTree:GetChildren()) do
                        if v857.Name:match("Vitality ") and v857.Value then
                            l__MaxHealth__147 = l__MaxHealth__147 + 10.5;
                        end;
                        if v857.Name:match("Determination") then
                            l__MaxHealth__147 = l__MaxHealth__147 + 700;
                        end;
                    end;
                end;
                if l__Player__145.SpecSkillTree then
                    for _, v858 in pairs(l__Player__145.SpecSkillTree:GetChildren()) do
                        if v858.Name:match("Vitality ") and v858.Value then
                            l__MaxHealth__147 = l__MaxHealth__147 + 10.5;
                        end;
                        if v858.Name:match("Meat Shield ") and v858.Value then
                            l__MaxHealth__147 = l__MaxHealth__147 + 17;
                        end;
                        if v858.Name == "Joestar Resolve V" and v858.Value then
                            l__MaxHealth__147 = l__MaxHealth__147 + 10;
                        end;
                    end;
                end;
            end;
            local v859 = u846:GetAttribute("Goliath");
            if v859 then
                l__MaxHealth__147 = l__MaxHealth__147 * v859;
            end;
            return {
                Amount = l__MaxHealth__147
            };
        end,
        Crit_Chance = function() --[[ Line: 7162 ]]
            -- upvalues: u4 (ref), l__Player__145 (copy)
            local l__Default_Crit_Chance__148 = u4.Default_Crit_Chance;
            for _, v860 in pairs(_G.Playerlist[l__Player__145.Name].CharMod.CritChance) do
                if v860.Value then
                    l__Default_Crit_Chance__148 = l__Default_Crit_Chance__148 + v860.Value;
                end;
            end;
            return {
                Amount = l__Default_Crit_Chance__148
            };
        end,
        Crit_Damage = function() --[[ Line: 7176 ]]
            -- upvalues: u4 (ref)
            return {
                Amount = u4.Default_Crit_Damage
            };
        end,
        RagdollSturdiness = function() --[[ Line: 7184 ]]
            -- upvalues: u853 (copy), u854 (copy)
            local v861 = 0;
            for _, v862 in pairs(u853:GetChildren()) do
                if v862.Name:match("Sturdiness") and v862.Value then
                    v861 = v861 - 0.15;
                end;
            end;
            for _, v863 in pairs(u854:GetChildren()) do
                if v863.Name:match("Determination") and v863.Value then
                    v861 = v861 - 6.5;
                end;
            end;
            return {
                Amount = v861
            };
        end,
        Block = function() --[[ Line: 7204 ]]
            -- upvalues: u846 (copy)
            return {
                Blocking_Capacity = u846:FindFirstChild("Blocking_Capacity")
            };
        end,
        DashPower = function() --[[ Line: 7212 ]]
            -- upvalues: u845 (copy), l__Player__145 (copy), u853 (copy), u854 (copy), u855 (copy), u850 (copy), l__self__146 (copy), l__ServerStorage__5 (ref), u4 (ref), u846 (copy), l__CollectionService__8 (ref)
            local l__Viewing__149 = u845.Viewing;
            local v864 = 50;
            local v865 = nil;
            local v866 = Vector3.new(0, 0, 0);
            local v867 = nil;
            if l__Player__145 then
                local v868 = 1;
                for _, v869 in pairs(u853:GetChildren()) do
                    if v869.Name:match("Agility ") and v869.Value then
                        v868 = v868 + 0.05;
                    end;
                end;
                for _, v870 in pairs(u854:GetChildren()) do
                    if v870.Name:match("Dash Mastery ") and v870.Value then
                        v868 = v868 + 0.07;
                    end;
                    if v870.Name:match("Agility ") and v870.Value then
                        v868 = v868 + 0.05;
                    end;
                    if v870.Name:match("Lithe ") and v870.Value then
                        v868 = v868 + 0.1;
                    end;
                end;
                for _, v871 in pairs(u855:GetChildren()) do
                    if v871.Name:match("Dash Mastery ") and v871.Value then
                        v868 = v868 + 0.07;
                    end;
                end;
                v864 = v864 * v868;
                if u850 and u850.Value > 0 then
                    local v872 = 1.25;
                    v864 = v864 * math.clamp(v872 * (u850.Value / (u850.MaxValue * 0.75)), 1, v872);
                end;
                if v864 > 100 then
                    v864 = 100;
                end;
            end;
            local l__MobileDashDirection__150 = u845.MobileDashDirection;
            if u845.Hold_daA or l__MobileDashDirection__150 == "Left" then
                v866 = v866 + -l__self__146.Root.CFrame.rightVector;
                v867 = l__ServerStorage__5.Anims["Dash Left"];
                l__self__146.RolledLeft = true;
                u4.Delay(0.5, function() --[[ Line: 7278 ]]
                    -- upvalues: l__self__146 (ref)
                    l__self__146.RolledLeft = nil;
                end);
                v865 = 90;
            elseif u845.HoldD or l__MobileDashDirection__150 == "Right" then
                v866 = v866 + l__self__146.Root.CFrame.rightVector;
                v867 = l__ServerStorage__5.Anims["Dash Right"];
                l__self__146.RolledRight = true;
                u4.Delay(0.5, function() --[[ Line: 7287 ]]
                    -- upvalues: l__self__146 (ref)
                    l__self__146.RolledRight = nil;
                end);
                v865 = -90;
            elseif u845.HoldW or l__MobileDashDirection__150 == "Forward" then
                v864 = v864 / 1.1;
                v866 = v866 + l__self__146.Root.CFrame.lookVector;
                v867 = l__ServerStorage__5.Anims["Dash Forward"];
                v865 = 0;
            elseif not l__Viewing__149 then
                v864 = v864 / 1.1;
                v866 = v866 + -l__self__146.Root.CFrame.lookVector;
                v867 = l__ServerStorage__5.Anims["Dash Backward"];
                l__self__146.RolledBack = true;
                u4.Delay(0.5, function() --[[ Line: 7302 ]]
                    -- upvalues: l__self__146 (ref)
                    l__self__146.RolledBack = nil;
                end);
                v865 = 180;
            end;
            local v873;
            if u846:FindFirstChild("Godspeed") or (l__CollectionService__8:HasTag(u846, "Double Accel") or l__CollectionService__8:HasTag(u846, "Electrify")) then
                v864 = 17.5;
                v873 = true;
            else
                v873 = nil;
            end;
            return {
                Amount = v864,
                Vector = v866,
                Anim = v867,
                Direction = v865,
                Blink = v873
            };
        end,
        HealthRegen = function() --[[ Line: 7327 ]]
            -- upvalues: l__ServerStorage__5 (ref), u852 (copy), u851 (copy), u845 (copy), u846 (copy), u849 (copy), u848 (copy), l__CollectionService__8 (ref), u847 (copy)
            local v874 = l__ServerStorage__5 and u852:Invoke("ReturnHealthRegen") or u851:InvokeServer("ReturnHealthRegen");
            local l__Viewing__151 = u845.Viewing;
            if u845.NoRegen then
                return {
                    Rate = 4
                };
            end;
            local v875 = 0;
            local v876 = 1;
            local v877 = 1;
            if u846:GetAttribute("Invigorated") and not u849:findFirstChild("Menacing") then
                v876 = v876 * 4;
                v877 = v877 / 4;
            end;
            local v878;
            if u849:findFirstChild("Menacing") and not u848 then
                v875 = v875 + 2;
                v878 = true;
                v877 = 1;
            else
                v878 = nil;
            end;
            local v879 = u846:FindFirstChild("Blood");
            if u846:GetAttribute("Bleeding") and not v879 then
                v876 = math.clamp(v876 - 0.7, 0, 999);
            elseif u846:GetAttribute("Burning") or l__CollectionService__8:HasTag(u846, "AntiHeal") then
                v876 = math.clamp(v876 - 0.6, 0, 999);
            end;
            local v880 = u846:GetAttribute("Spirit_Visage");
            if v880 then
                v876 = v876 + (v880 - 1);
            end;
            local v881 = not v878 and v879;
            local v882;
            if v881 and (v881.Value > 0 and u846.Humanoid.Health < u846.Humanoid.MaxHealth * 0.75) then
                local v883 = 1.656 / (1.1 + v874.HyperRegeneration * 0.1);
                if not l__Viewing__151 then
                    v881.Value = v881.Value - v883;
                end;
                v877 = v877 / 3;
                v882 = (v875 + 0.5) * 3;
            else
                v882 = v875 + v874.HealthRegenUpgrades;
            end;
            return {
                Rate = 4,
                RegenRate = v877,
                Regen = (v882 + 0.4) * v876 / 100 * u847.MaxValue
            };
        end
    };
    return v884[l__Stat__144] and v884[l__Stat__144]() or {};
end;
local u885 = {};
function u4.GuiHoverAnimate(...) --[[ Line: 7415 ]]
    -- upvalues: l__ReplicatedStorage__6 (copy), u1 (copy), u885 (copy), u4 (copy)
    local v886 = ...;
    local l__Gui__152 = v886.Gui;
    local u887 = v886.TweenTime or 0.5;
    local u888 = v886.Color1 or Color3.fromRGB(255, 200, 0);
    local u889 = v886.Color2 or Color3.fromRGB(255, 200, 0);
    local function u908(p890) --[[ Line: 7425 ]]
        -- upvalues: l__Gui__152 (copy), l__ReplicatedStorage__6 (ref), u887 (copy), u1 (ref), u888 (copy), u889 (copy)
        local u891 = math.abs(p890.AbsoluteSize.X) / math.abs(l__Gui__152.AbsoluteSize.X);
        local v892 = math.abs(l__Gui__152.AbsolutePosition.X) / math.abs(p890.AbsolutePosition.X);
        if u891 <= 0 or (v892 <= 0 or (u891 > 1 or v892 > 1)) then
        elseif p890:GetAttribute("IgnoreGradient") == true then
        else
            local u893 = {};
            for _, v894 in pairs(p890:GetChildren()) do
                if v894:IsA("UIGradient") then
                    u893[v894] = v894.Parent;
                    v894.Parent = l__ReplicatedStorage__6;
                end;
            end;
            local v895 = u887;
            local _ = v892 == 1;
            local u896 = v895 * v892;
            local u897 = Instance.new("UIGradient");
            u897.Parent = p890;
            local u898 = nil;
            local u899 = tick();
            u898 = game:GetService("RunService").Heartbeat:connect(function() --[[ Line: 7455 ]]
                -- upvalues: u899 (copy), u896 (copy), u891 (copy), u1 (ref), u897 (copy), u888 (ref), u889 (ref), u898 (ref), u893 (copy)
                local u900 = (tick() - u899) / u896;
                local u901 = u900 * 1.5;
                local u902 = u900 * 2 / u891;
                local u903 = u900 * 4 / u891;
                local u904 = (u903 + u902) / 2;
                local v905, _ = u1(function() --[[ Line: 7463 ]]
                    -- upvalues: u897 (ref), u900 (copy), u901 (copy), u888 (ref), u902 (copy), u889 (ref), u904 (copy), u903 (copy)
                    u897.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                        ColorSequenceKeypoint.new(math.clamp(u900, 0.001, 0.997), Color3.new(1, 1, 1)),
                        ColorSequenceKeypoint.new(math.clamp(u901, 0.0011, 0.9971), u888),
                        ColorSequenceKeypoint.new(math.clamp(u902, 0.1, 0.998), u889),
                        ColorSequenceKeypoint.new(math.clamp(u904, 0.1, 0.9989), u888),
                        ColorSequenceKeypoint.new(math.clamp(u903, 0.25, 0.999), Color3.new(1, 1, 1)),
                        ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
                    });
                end);
                if not v905 then
                    u898:Disconnect();
                    u898 = nil;
                    u897:Destroy();
                end;
                if u896 <= tick() - u899 then
                    u898:Disconnect();
                    u898 = nil;
                    u897:Destroy();
                    for v906, v907 in pairs(u893) do
                        if v906 and v906.Parent then
                            v906.Parent = v907;
                        end;
                    end;
                end;
            end);
        end;
    end;
    if u885[l__Gui__152] then
    else
        u885[l__Gui__152] = true;
        for _, u909 in pairs(l__Gui__152:GetDescendants()) do
            u4.Spawn(function() --[[ Line: 7506 ]]
                -- upvalues: u909 (copy), u908 (copy)
                if u909:IsA("GuiObject") then
                    u908(u909);
                end;
            end);
        end;
        u908(l__Gui__152);
        u4.Delay(u887, function() --[[ Line: 7515 ]]
            -- upvalues: u885 (ref), l__Gui__152 (copy)
            u885[l__Gui__152] = nil;
        end);
    end;
end;
function u4.GuiHoverHint(...) --[[ Line: 7520 ]]
    local l__LocalPlayer__153 = game.Players.LocalPlayer;
    local v910 = ... or {};
    local l__Gui__154 = v910.Gui;
    local v911 = l__Gui__154:FindFirstAncestorOfClass("ScreenGui");
    local u912 = v910.Mouse or l__LocalPlayer__153:GetMouse();
    local v913 = v910.Description or (l__Gui__154:GetAttribute("HoverHint") or "Description: ?");
    if #v913 <= 0 then
    else
        local v914 = 0;
        for v915 = 1, #v913 do
            if string.sub(v913, v915, v915) ~= " " then
                v914 = v914 + 1;
            end;
        end;
        local v916 = math.clamp(v914 / 35, 1, 2);
        local v917 = 0;
        local v918 = 1;
        for v919 = 1, #v913 do
            if string.sub(v913, v919, v919) ~= " " then
                v917 = v917 + 1;
                if v917 >= 35 then
                    v918 = v918 + 1;
                    v917 = 0;
                end;
            end;
        end;
        local v920 = v910.Size or UDim2.new(v916 * 0.2, 0, v918 * 0.03, 0);
        local u921 = Instance.new("ScreenGui");
        u921.DisplayOrder = v911.DisplayOrder;
        u921.IgnoreGuiInset = true;
        u921.Parent = l__LocalPlayer__153.PlayerGui;
        local u922 = Instance.new("ImageLabel");
        u922.BackgroundTransparency = 0.5;
        u922.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        u922.Size = v920;
        local v923 = Instance.new("UICorner");
        v923.CornerRadius = UDim.new(0.1, 0);
        v923.Parent = u922;
        local v924 = Instance.new("UIAspectRatioConstraint");
        v924.AspectRatio = v916 * 12.2 / v918;
        v924.Parent = u922;
        local u925 = Instance.new("TextLabel");
        u925.TextColor3 = Color3.fromRGB(255, 255, 255);
        u925.TextStrokeTransparency = 0;
        u925.BackgroundTransparency = 1;
        u925.Text = v913;
        u925.AnchorPoint = Vector2.new(0.5, 0.5);
        u925.Position = UDim2.new(0.5, 0, 0.5, 0);
        u925.Size = UDim2.new(0.9, 0, 0.9, 0);
        u925.TextScaled = true;
        u925.Parent = u922;
        local v926 = Instance.new("UITextSizeConstraint");
        v926.MaxTextSize = 24;
        v926.Parent = u925;
        local u927 = nil;
        local u928 = nil;
        u928 = game:GetService("RunService").Heartbeat:connect(function() --[[ Line: 7604 ]]
            -- upvalues: u921 (copy), u928 (ref), u912 (copy), u922 (copy), u925 (copy)
            if u921 and u921.Parent then
                local l__X__155 = u912.X;
                local l__Y__156 = u912.Y;
                local v929 = Vector2.new(l__X__155, l__Y__156) - workspace.CurrentCamera.ViewportSize / 2;
                local v930 = (-u921.AbsolutePosition.X + l__X__155) / u921.AbsoluteSize.X;
                local v931 = (-u921.AbsolutePosition.Y + l__Y__156) / u921.AbsoluteSize.Y;
                local v932 = 10;
                if v929.x > 0 then
                    u922.AnchorPoint = Vector2.new(1, u922.AnchorPoint.Y);
                    u925.TextXAlignment = Enum.TextXAlignment.Right;
                    v932 = -10;
                else
                    u922.AnchorPoint = Vector2.new(0, u922.AnchorPoint.Y);
                    u925.TextXAlignment = Enum.TextXAlignment.Left;
                end;
                if v929.y > 0 then
                    u922.AnchorPoint = Vector2.new(u922.AnchorPoint.X, 1);
                    u925.TextYAlignment = Enum.TextYAlignment.Bottom;
                else
                    u922.AnchorPoint = Vector2.new(u922.AnchorPoint.X, 0);
                    u925.TextYAlignment = Enum.TextYAlignment.Top;
                end;
                u922.Position = UDim2.new(v930, v932, v931, 0);
                u922.Parent = u921;
            else
                u928:Disconnect();
                u928 = nil;
            end;
        end);
        u927 = l__Gui__154.MouseLeave:connect(function() --[[ Line: 7650 ]]
            -- upvalues: u927 (ref), u921 (copy)
            u927:Disconnect();
            u927 = nil;
            u921:Destroy();
        end);
    end;
end;
function u4.GuiClickAnimation(...) --[[ Line: 7658 ]]
    -- upvalues: l__ReplicatedStorage__6 (copy), l__TweenService__7 (copy), u4 (copy), l__Debris2__12 (copy), l__wait__4 (copy)
    local l__LocalPlayer__157 = game.Players.LocalPlayer;
    local u933 = ... or {};
    local u934 = u933.Gui:FindFirstAncestorOfClass("ScreenGui");
    local u935 = u933.Mouse or l__LocalPlayer__157:GetMouse();
    local u948 = {
        Default = function() --[[ Line: 7676 ]]
            -- upvalues: u933 (copy), l__ReplicatedStorage__6 (ref), u934 (copy), l__LocalPlayer__157 (copy), u935 (copy), l__TweenService__7 (ref), u4 (ref), l__Debris2__12 (ref)
            local v936 = u933.Size or UDim2.new(0.07, 0, 0.07, 0);
            local v937 = l__ReplicatedStorage__6.Objects.CircleGuiClick:Clone();
            v937.DisplayOrder = u934.DisplayOrder;
            v937.IgnoreGuiInset = true;
            local l__ImageLabel__158 = v937.ImageLabel;
            l__ImageLabel__158.Size = UDim2.new(0, 0, 0, 0);
            l__ImageLabel__158.AnchorPoint = Vector2.new(0.5, 0.5);
            l__ImageLabel__158.Position = UDim2.new(0, 0, 0, 0);
            l__ImageLabel__158.Parent = nil;
            l__ImageLabel__158.Visible = true;
            v937.Parent = l__LocalPlayer__157.PlayerGui;
            l__ImageLabel__158.Position = UDim2.new((-v937.AbsolutePosition.X + u935.X) / v937.AbsoluteSize.X, 0, (-v937.AbsolutePosition.Y + u935.Y) / v937.AbsoluteSize.Y, 0);
            l__ImageLabel__158.Parent = v937;
            local u938 = l__TweenService__7:Create(l__ImageLabel__158, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = UDim2.new(v936.X.Scale * 1, 0, v936.Y.Scale * 1, 0)
            });
            u938:Play();
            u4.Delay(u938.TweenInfo.Time * 0.2, function() --[[ Line: 7701 ]]
                -- upvalues: l__TweenService__7 (ref), l__ImageLabel__158 (copy), u938 (copy), l__Debris2__12 (ref)
                local v939 = l__TweenService__7:Create(l__ImageLabel__158, TweenInfo.new(u938.TweenInfo.Time * 0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
                    ImageTransparency = 1
                });
                v939:Play();
                l__Debris2__12:AddItem(v939, 1);
            end);
            l__Debris2__12:AddItems({ u938, v937 }, 1);
        end,
        SparkleCircle = function() --[[ Line: 7713 ]]
            -- upvalues: u933 (copy), l__ReplicatedStorage__6 (ref), u934 (copy), l__LocalPlayer__157 (copy), u935 (copy), l__wait__4 (ref), l__Debris2__12 (ref)
            local v940 = u933.Size or UDim2.new(0.2, 0, 0.2, 0);
            local v941 = l__ReplicatedStorage__6.Objects.SparkleCircleGuiClick:Clone();
            v941.DisplayOrder = u934.DisplayOrder;
            v941.IgnoreGuiInset = true;
            local v942 = #v941:GetChildren();
            local v943 = {};
            for _, v944 in pairs(v941:GetChildren()) do
                v943[tonumber(v944.Name)] = v944;
                v944.Size = v940;
                v944.AnchorPoint = Vector2.new(0.5, 0.5);
                v944.Position = UDim2.new(0, 0, 0, 0);
                v944.Parent = nil;
                v944.Visible = true;
                v944.ImageTransparency = 0;
                Instance.new("UIAspectRatioConstraint").Parent = v944;
            end;
            v941.Parent = l__LocalPlayer__157.PlayerGui;
            local v945 = UDim2.new((-v941.AbsolutePosition.X + u935.X) / v941.AbsoluteSize.X, 0, (-v941.AbsolutePosition.Y + u935.Y) / v941.AbsoluteSize.Y, 0);
            for v946 = 1, v942 do
                local v947 = v943[v946];
                (v946 == 1 and v947 and v947 or v943[v946 - 1]).Visible = false;
                v947.Position = v945;
                v947.Parent = v941;
                l__wait__4(0);
            end;
            v943[v942].Visible = false;
            l__Debris2__12:AddItem(v941, 1);
        end
    };
    u4.Spawn(function() --[[ Line: 7760 ]]
        -- upvalues: u948 (copy), u933 (copy)
        u948[u933.Animation or "Default"]();
    end);
end;
return u4;