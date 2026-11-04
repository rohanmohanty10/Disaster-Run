 
 

local function item(p1, p2, p3) -- Line: 1
    return {
        Category = p1,
        Item = p2,
        Name = p3
    };
end;

local v4 = {
    Id = "chest_offer",
    ItemName = "Candy Chest",
    Icon = 134738015262271,
    Candy = 100,
    ProductId = 3724946703,
    DisplayRobux = "—",
    Enabled = true,
    RobuxEnabled = true,
    DuplicateReward = {
        Category = "Candy",
        Amount = 100,
        Name = "100 Candy"
    },
    Rewards = { {
            Category = "GoalEffects",
            Item = "Ghost Tornado",
            Name = "Ghost Score Effect",
            Chance = 2
        }, {
            Category = "LuckySpins",
            Amount = 5,
            Name = "5 Lucky Style Spins",
            Chance = 5,
            Icon = 111333169806568
        }, {
            Category = "Cosmetics",
            Item = "Killer",
            Name = "Killer Knife Cosmetic",
            Chance = 13
        }, {
            Category = "Cosmetics",
            Item = "Head Cover",
            Name = "Head Cover Cosmetic",
            Chance = 25
        }, {
            Category = "Cards",
            Item = "Spooky Pal",
            Name = "Spooky Pals Score Card",
            Chance = 55
        } }
};
local u5 = {
    Enabled = true,
    EventId = "Halloween2026",
    RequestInterval = 0.35,
    ReceiptSaveTimeout = 15,
    CandyChest = v4,
    LegacyProducts = {
        [3723835079] = { "chest_offer", "reward_8" }
    },
    Pickups = {
        PacingDuration = 440,
        Lifetime = 45,
        FadeDuration = 0.25,
        MaxActive = 3,
        MaxCommandAmount = 50,
        CollectDistance = 4.5,
        CourtMargin = 8,
        HoverHeight = 2.6,
        RotationSpeed = 0.7,
        SpawnTargets = { {
                Players = 2,
                Spawns = 20.8
            }, {
                Players = 4,
                Spawns = 31.2
            }, {
                Players = 6,
                Spawns = 41.6
            }, {
                Players = 8,
                Spawns = 52
            }, {
                Players = 10,
                Spawns = 62.4
            } },
        DropChances = { {
                Players = 2,
                Rewards = { {
                        Amount = 1,
                        Chance = 60
                    }, {
                        Amount = 5,
                        Chance = 25
                    }, {
                        Amount = 10,
                        Chance = 10
                    }, {
                        Amount = 15,
                        Chance = 4
                    }, {
                        Amount = 20,
                        Chance = 1
                    } }
            }, {
                Players = 6,
                Rewards = { {
                        Amount = 1,
                        Chance = 45
                    }, {
                        Amount = 5,
                        Chance = 30
                    }, {
                        Amount = 10,
                        Chance = 16
                    }, {
                        Amount = 15,
                        Chance = 7
                    }, {
                        Amount = 20,
                        Chance = 2
                    } }
            }, {
                Players = 10,
                Rewards = { {
                        Amount = 1,
                        Chance = 35
                    }, {
                        Amount = 5,
                        Chance = 33
                    }, {
                        Amount = 10,
                        Chance = 20
                    }, {
                        Amount = 15,
                        Chance = 9
                    }, {
                        Amount = 20,
                        Chance = 3
                    } }
            } },
        Tilt = CFrame.Angles(-0.13962634015954636, 0, -0.20943951023931956)
    },
    Sounds = {
        Open = 134462380544316,
        Music = 109239203271260,
        Chime = 139190048645306,
        Lightning = 117301779018599,
        Bats = 123932192153890,
        Pickup = 96714684883752,
        Candy = 103725517122059
    },
    Wheel = {
        Enabled = false,
        ZoneReward = "Scary",
        Rewards = { { "LimitedItem", "Werewolf Howl Emote", {
                    Type = "Emotes",
                    Name = "Werewolf Howl",
                    LuckySpins = 10
                }, 0.1 }, { "LimitedItem", "Thriller Dance Emote Cutscene", {
                    Type = "Emotes",
                    Name = "Thriller",
                    Money = 15000
                }, 15 }, { "LuckySpins", "Lucky Spins", 5, 1.9 }, { "LuckySpins", "Lucky Spins", 3, 6 }, { "MoreMoney", "Money", 15000, 27 }, { "Money", "Money", 5000, 50 } }
    },
    LimitedShop = {
        Enabled = false,
        LimitedExpiryTime = 0,
        MythicExpiryTime = 0,
        Items = { {
                ItemName = "Skeleton Arm",
                ItemType = "GoalEffects",
                ItemTypeDisplay = "Arm Score Effect",
                ProductId = 0
            }, {
                ItemName = "Zombie Walk",
                ItemType = "Emotes",
                ItemTypeDisplay = "Zombie Walk Emote",
                ProductId = 0
            }, {
                ItemName = "Pumpkin Head",
                ItemType = "Cosmetics",
                ItemTypeDisplay = "Pumpkin Head Cosmetic",
                ProductId = 0
            }, {
                ItemName = "Spooky Face",
                ItemType = "Cards",
                ItemTypeDisplay = "Spooky Face Score Card",
                ProductId = 0
            } }
    },
    Chest = {
        Id = "bat_chest",
        ItemName = "Bat Bundle",
        Candy = 5000,
        Enabled = true,
        Grants = { {
                Category = "GoalEffects",
                Item = "Bat Swarm",
                Name = "Bat Score Effect"
            }, {
                Category = "Emotes",
                Item = "Bat Aura",
                Name = "Bat Aura Emote"
            }, {
                Category = "Cosmetics",
                Item = "Bat Wings",
                Name = "Bat Wings Cosmetic"
            }, {
                Category = "Emotes",
                Item = "Bat Wings",
                Name = "Bat Wings Emote"
            } }
    },
    Rows = {
        {
            v4,
            {
                Id = "reward_8",
                ItemName = "Witch\'s Broom Ride Emote",
                Candy = 2000,
                ProductId = 3724946869,
                DisplayRobux = "—",
                RobuxEnabled = true,
                Enabled = true,
                Reward = {
                    Category = "Emotes",
                    Item = "Witch\'s Broom",
                    Name = "Witch\'s Broom Ride Emote"
                }
            }
        },
        { {
                Id = "reward_3",
                ItemName = "Scream Mask Cosmetic",
                Candy = 250,
                Enabled = true,
                Reward = {
                    Category = "Cosmetics",
                    Item = "Ghost Mask",
                    Name = "Scream Mask Cosmetic"
                }
            }, {
                Id = "reward_4",
                ItemName = "Reaper Cosmetic",
                Candy = 350,
                Enabled = true,
                Reward = {
                    Category = "Cosmetics",
                    Item = "Reaper",
                    Name = "Reaper Cosmetic"
                }
            }, {
                Id = "reward_5",
                ItemName = "5 Lucky Zones",
                Candy = 500,
                Enabled = true,
                Icon = 71537410313776,
                Reward = {
                    Category = "ZoneLuckySpins",
                    Amount = 5,
                    Name = "5 Lucky Zones"
                }
            } },
        { {
                Id = "reward_6",
                ItemName = "Coffin Emote",
                Candy = 700,
                Enabled = true,
                Reward = {
                    Category = "Emotes",
                    Item = "Coffin",
                    Name = "Coffin Emote"
                }
            }, {
                Id = "reward_7",
                ItemName = "Scream Emote",
                Candy = 1000,
                Enabled = true,
                Reward = {
                    Category = "Emotes",
                    Item = "Wazzup!",
                    Name = "Scream Emote"
                }
            }, {
                Id = "reward_2",
                ItemName = "Bat Score Card",
                Candy = 100,
                Enabled = true,
                Reward = {
                    Category = "Cards",
                    Item = "Bats",
                    Name = "Bat Score Card"
                }
            } }
    }
};
u5.Offers = { u5.Chest };

for _, v in u5.Rows do
    for _, v2 in v do
        table.insert(u5.Offers, v2);
    end;
end;

for i, v in u5.LimitedShop.Items do
    local Offers = u5.Offers;
    local v6 = {
        RequiresDaily = false,
        Id = "limited_" .. tostring(i),
        ItemName = v.ItemTypeDisplay,
        ProductId = v.ProductId,
        Enabled = u5.LimitedShop.Enabled,
        RobuxEnabled = u5.LimitedShop.Enabled,
        Expires = u5.LimitedShop.LimitedExpiryTime,
        Reward = {
            Category = v.ItemType,
            Item = v.ItemName,
            Name = v.ItemTypeDisplay
        }
    };
    table.insert(Offers, v6);
end;

function u5.GetOffer(p7) -- Line: 136
    -- upvalues: u5 (copy)
    for _, v in u5.Offers do
        if v.Id == p7 then
            return v;
        end;
    end;
end;

function u5.GetProductOffers(p8) -- Line: 142
    -- upvalues: u5 (copy)
    local v9 = {};

    if typeof(p8) ~= "number" or p8 <= 0 then
        return v9;
    end;

    for _, v in u5.Offers do
        if v.ProductId == p8 then
            table.insert(v9, v);
        end;
    end;

    for _, v in u5.LegacyProducts[p8] or {} do
        local Offer = u5.GetOffer(v);

        if Offer and not table.find(v9, Offer) then
            table.insert(v9, Offer);
        end;
    end;

    return v9;
end;

function u5.GetProductOffer(p10) -- Line: 155
    -- upvalues: u5 (copy)
    local ProductOffers = u5.GetProductOffers(p10);

    if #ProductOffers == 1 then
        return ProductOffers[1];
    end;
end;

function u5.GetCreditKey(p11, p12) -- Line: 160
    -- upvalues: u5 (copy)
    local v13 = p12 or p11.ProductId;

    if v13 and #u5.GetProductOffers(v13) > 1 then
        return "product_" .. tostring(v13);
    end;

    return p11.Id;
end;

function u5.GetCreditKeys(p14) -- Line: 168
    -- upvalues: u5 (copy)
    local v15 = { p14.Id };
    local CreditKey = u5.GetCreditKey(p14);

    if CreditKey ~= p14.Id then
        table.insert(v15, CreditKey);
    end;

    for i, v in u5.LegacyProducts do
        if table.find(v, p14.Id) then
            local CreditKey2 = u5.GetCreditKey(p14, i);

            if not table.find(v15, CreditKey2) then
                table.insert(v15, CreditKey2);
            end;
        end;
    end;

    return v15;
end;

function u5.IsOfferForProduct(p16, p17) -- Line: 181
    -- upvalues: u5 (copy)
    for _, v in u5.GetProductOffers(p17) do
        if v.Id == p16 then
            return true;
        end;
    end;

    return false;
end;

u5.Broom = u5.GetOffer("reward_8");

return u5;