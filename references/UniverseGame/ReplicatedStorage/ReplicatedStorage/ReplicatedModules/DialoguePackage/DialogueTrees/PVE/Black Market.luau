  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u1 = Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");
local u2 = Knit.GetService("ShopService");
local u3 = {
    Culler = {
        GunParts = 2,
        UCoins = 2000000
    },
    Sealer = {
        GunParts = 2,
        UCoins = 1500000
    },
    Contender = {
        GunParts = 1,
        UCoins = 1000000
    },
    Flintlock = {
        GunParts = 2,
        UCoins = 125000
    }
};
local u4 = {
    Response = "Nevermind.",
    Next = nil
};

return {
    Start = "start",
    Title = "Black Market",
    Nodes = {
        start = {
            Mutable = true,
            Text = "yo... pst.. got any items?",
            Options = {
                {
                    Response = "got anything you can make me?",

                    Callback = function(p5, p6) -- Line: 48, Name: Callback
                        -- upvalues: u1 (copy)
                        if u1:CheckRequirement("CheckAbilityLevel", 50):expect() then
                            p6.Next = "gun_options";

                            return;
                        end;

                        p6.Next = "gun_reject";
                    end,

                    Next = Dialogue.PLACEHOLDER
                },
                {
                    Response = "yeah i gotchu bro",

                    Callback = function(p7) -- Line: 61, Name: Callback
                        -- upvalues: ReplicatedStorage (copy)
                        ReplicatedStorage.Remotes.ClientUIOutput:Fire("ShowBlackMarket");
                    end,

                    Next = Dialogue.PLACEHOLDER
                },
                u4
            }
        },
        gun_reject = {
            Text = "sorry but.. come ask again when you\'ve gained some more experience <Color=RareBlue>(LEVEL 50 ABILITY NEEDED)<Color=/>",
            Options = { u4 }
        },
        gun_options = {
            Mutable = true,
            Text = "sure, if you bring me some <TextColor3=255,150,75>Gun Parts<TextColor3=/> I could provide you with some weapons",
            Options = {
                {
                    Response = "I got some",

                    Callback = function(p8, p9) -- Line: 82, Name: Callback
                        -- upvalues: u1 (copy), u3 (copy), u2 (copy), u4 (copy), Dialogue (copy)
                        local v10 = u1:CheckRequirement("ItemCountCheck", "ITEM_580"):expect();

                        if typeof(v10) ~= "number" or v10 <= 0 then
                            p9.Next = {
                                Text = "No, you do not <Color=RareBlue>(REQUIRED IN INVENTORY)<Color=/>",
                                Options = { u4 }
                            };

                            return;
                        end;

                        local v11 = {};

                        for i, v in u3 do
                            local v15 = {
                                Response = `<font color="rgb(195,155,255)">{i}</font> - {v.GunParts}x <font color="rgb(255,150,75)">Gun Parts</font> & <font color="rgb(255,205,88)">{v.UCoins} UCoins</font>`,

                                Callback = function(p12, p13) -- Line: 91, Name: Callback
                                    -- upvalues: u2 (ref), i (copy), u4 (ref)
                                    local v14 = u2:RequestBlackMarketPurchase(i):expect();

                                    if not v14 then
                                        p13.Next = {
                                            Text = "Come back when you can fullfil my offer.",
                                            Options = { u4 }
                                        };

                                        return;
                                    end;

                                    if v14 and typeof(v14) == "string" then
                                        p13.Next = {
                                            Text = v14,
                                            Options = { u4 }
                                        };

                                        return;
                                    end;

                                    if v14 and typeof(v14) ~= "string" then
                                        p13.Next = {
                                            Text = "Enjoy",
                                            Options = { {
                                                    Response = "Thanks",
                                                    Next = nil
                                                } }
                                        };
                                    end;
                                end,

                                Next = Dialogue.PLACEHOLDER
                            };
                            table.insert(v11, v15);
                        end;

                        table.insert(v11, u4);
                        p9.Next = {
                            Text = "Good, now take your pick",
                            Options = v11
                        };
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        }
    }
};