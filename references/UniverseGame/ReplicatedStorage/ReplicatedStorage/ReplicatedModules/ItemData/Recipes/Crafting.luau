  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.OnStart():await();
local u1 = Knit.GetService("AchievementService");

return {
    Crafting = {
        RECIPE_1 = {
            Input = {
                UCoins = 3500000,
                Items = {
                    ITEM_87 = 1
                },
                Shards = {
                    ABILITY_911 = 3
                }
            },
            Output = {
                Items = {
                    ITEM_84 = 1
                }
            }
        },
        RECIPE_3 = {
            Input = {
                Shards = {
                    ABILITY_70 = 3,
                    ABILITY_701 = 4
                }
            },
            Output = {
                Items = {
                    ITEM_51 = 1
                }
            }
        },
        RECIPE_5 = {
            Input = {
                Items = {
                    ITEM_76 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_456073 = 1
                }
            }
        },
        RECIPE_6 = {
            Input = {
                UCoins = 200000,
                Shards = {
                    ABILITY_22 = 5
                }
            },
            Output = {
                Items = {
                    ABILITY_22 = 1
                }
            }
        },
        RECIPE_7 = {
            Input = {
                Shards = {
                    ABILITY_24 = 3
                },
                Items = {
                    ITEM_3 = 1
                }
            },
            Output = {
                Items = {
                    ITEM_90 = 1
                }
            }
        },
        RECIPE_8 = {
            Input = {
                Shards = {
                    ABILITY_2000 = 4
                }
            },
            Output = {
                Items = {
                    ABILITY_2000 = 1
                }
            }
        },
        RECIPE_9 = {
            Input = {
                Shards = {
                    ABILITY_1300 = 5
                },
                Items = {
                    ABILITY_22 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_1300 = 1
                }
            }
        },
        RECIPE_10 = {
            Input = {
                Shards = {
                    ABILITY_19 = 5
                },
                Items = {
                    ABILITY_22 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_19 = 1
                }
            }
        },
        RECIPE_11 = {
            Input = {
                Shards = {
                    ABILITY_77 = 4
                }
            },
            Output = {
                Items = {
                    ITEM_26 = 1
                }
            }
        },
        RECIPE_12 = {
            Input = {
                UCoins = 50000,
                Shards = {
                    ABILITY_50923 = 5
                }
            },
            Output = {
                Items = {
                    ABILITY_50923 = 1
                }
            }
        },
        RECIPE_13 = {
            Input = {
                Shards = {
                    ABILITY_33 = 3
                },
                Items = {
                    ITEM_1 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_33 = 1
                }
            }
        },
        RECIPE_14 = {
            Input = {
                Items = {
                    ITEM_25 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_7955 = 1
                }
            }
        },
        RECIPE_15 = {
            Input = {
                Items = {
                    ABILITY_2 = 1,
                    ITEM_15 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_2421 = 1
                },

                Callback = function(p2) -- Line: 246, Name: Callback
                    -- upvalues: u1 (copy)
                    u1.IncrementAchievement(p2, "CursedAbility");
                end
            }
        },
        RECIPE_17 = {
            Input = {
                Shards = {
                    ABILITY_10019 = 3
                },
                Items = {
                    ITEM_1 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_10019 = 1
                }
            }
        },
        RECIPE_18 = {
            Input = {
                Shards = {
                    ABILITY_41321 = 3
                }
            },
            Output = {
                Items = {
                    ABILITY_41321 = 1
                }
            }
        },
        RECIPE_19 = {
            Input = {
                Shards = {
                    ABILITY_140404 = 3
                },
                Items = {
                    ITEM_36 = 1,
                    ABILITY_2 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_140404 = 1
                }
            }
        },
        RECIPE_20 = {
            Input = {
                Shards = {
                    ABILITY_21 = 3
                },
                Items = {
                    ITEM_1 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_21 = 1
                }
            }
        },
        RECIPE_21 = {
            Input = {
                Shards = {
                    ABILITY_4 = 5
                },
                Items = {
                    ABILITY_10019 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_4 = 1
                }
            }
        },
        RECIPE_22 = {
            Input = {
                Shards = {
                    ABILITY_5 = 3
                },
                Items = {
                    ABILITY_4 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_5 = 1
                }
            }
        },
        RECIPE_24 = {
            Input = {
                Shards = {
                    ABILITY_73 = 3
                },
                Items = {
                    ITEM_1 = 5
                }
            },
            Output = {
                Items = {
                    ABILITY_73 = 1
                }
            }
        },
        RECIPE_25 = {
            Input = {
                Shards = {
                    ABILITY_300000 = 3
                },
                Items = {
                    ITEM_1 = 3
                }
            },
            Output = {
                Items = {
                    ABILITY_300000 = 1
                }
            }
        },
        RECIPE_26 = {
            Input = {
                Items = {
                    ABILITY_9 = 1,
                    ITEM_530 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_684 = 1
                }
            }
        },
        RECIPE_27 = {
            Input = {
                Shards = {
                    ABILITY_420 = 3
                },
                Items = {
                    ITEM_42 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_420 = 1
                }
            }
        },
        RECIPE_28 = {
            Input = {
                Shards = {
                    ABILITY_421 = 3
                },
                Items = {
                    ITEM_41 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_421 = 1
                }
            }
        },
        RECIPE_29 = {
            Input = {
                Shards = {
                    ABILITY_80086 = 3
                },
                Items = {
                    ITEM_1 = 5
                }
            },
            Output = {
                Items = {
                    ABILITY_80086 = 1
                }
            }
        },
        RECIPE_30 = {
            Input = {
                Items = {
                    ITEM_35 = 7
                }
            },
            Output = {
                Items = {
                    ABILITY_732 = 1
                }
            }
        },
        RECIPE_31 = {
            Input = {
                Shards = {
                    ABILITY_12 = 3
                },
                Items = {
                    ITEM_1 = 15,
                    ITEM_96 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_12 = 1
                }
            }
        },
        RECIPE_32 = {
            Input = {
                Shards = {
                    ABILITY_7 = 3
                },
                Items = {
                    ITEM_1 = 2
                }
            },
            Output = {
                Items = {
                    ABILITY_7 = 1
                }
            }
        },
        RECIPE_33 = {
            Input = {
                Items = {
                    ABILITY_7 = 1,
                    ITEM_39 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_2319 = 1
                }
            }
        },
        RECIPE_34 = {
            Input = {
                Shards = {
                    ABILITY_6 = 3
                },
                Items = {
                    ITEM_1 = 3
                }
            },
            Output = {
                Items = {
                    ABILITY_6 = 1
                }
            }
        },
        RECIPE_35 = {
            Input = {
                Shards = {
                    ABILITY_9 = 3
                },
                Items = {
                    ITEM_1 = 3
                }
            },
            Output = {
                Items = {
                    ABILITY_9 = 1
                }
            }
        },
        RECIPE_36 = {
            Input = {
                Shards = {
                    ABILITY_27 = 3
                },
                Items = {
                    ABILITY_24 = 1,
                    ITEM_2 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_27 = 1
                }
            }
        },
        RECIPE_37 = {
            Input = {
                Shards = {
                    ABILITY_2555 = 1
                },
                Items = {
                    ABILITY_4 = 1,
                    ITEM_22 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_2555 = 1
                }
            }
        },
        RECIPE_38 = {
            Input = {
                Shards = {
                    ABILITY_658 = 2
                },
                Items = {
                    ITEM_30 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_658 = 1
                }
            }
        },
        RECIPE_39 = {
            Input = {
                Shards = {
                    ABILITY_666 = 5
                },
                Items = {
                    ITEM_4 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_666 = 1
                }
            }
        },
        RECIPE_40 = {
            Input = {
                Items = {
                    ABILITY_10019 = 1,
                    ITEM_15 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_26 = 1
                },

                Callback = function(p3) -- Line: 610, Name: Callback
                    -- upvalues: u1 (copy)
                    u1.IncrementAchievement(p3, "CursedAbility");
                end
            }
        },
        RECIPE_41 = {
            Input = {
                Shards = {
                    ABILITY_10 = 3
                },
                Items = {
                    ITEM_1 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_10 = 1
                }
            }
        },
        RECIPE_42 = {
            Input = {
                Shards = {
                    ABILITY_2 = 3
                },
                Items = {
                    ITEM_1 = 3
                }
            },
            Output = {
                Items = {
                    ABILITY_2 = 1
                }
            }
        },
        RECIPE_43 = {
            Input = {
                Shards = {
                    ABILITY_14 = 2
                },
                Items = {
                    ITEM_1 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_14 = 1
                }
            }
        },
        RECIPE_45 = {
            Input = {
                Shards = {
                    ABILITY_23 = 3
                }
            },
            Output = {
                Items = {
                    ABILITY_23 = 1
                }
            }
        },
        RECIPE_46 = {
            Input = {
                Shards = {
                    ABILITY_12789 = 3
                },
                Items = {
                    ITEM_77 = 1,
                    ITEM_557 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_12789 = 1
                }
            }
        },
        RECIPE_47 = {
            Input = {
                Shards = {
                    ABILITY_69 = 3
                },
                Items = {
                    ITEM_23 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_69 = 1
                }
            }
        },
        RECIPE_48 = {
            Input = {
                Items = {
                    ITEM_37 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_8881 = 1
                }
            }
        },
        RECIPE_49 = {
            Input = {
                Shards = {
                    ABILITY_350 = 3
                },
                Items = {
                    ITEM_18 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_350 = 1
                }
            }
        },
        RECIPE_50 = {
            Input = {
                Shards = {
                    ABILITY_911111 = 3
                },
                Items = {
                    ITEM_92 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_911111 = 1
                }
            }
        },
        RECIPE_51 = {
            Input = {
                Shards = {
                    ABILITY_100000 = 3
                },
                Items = {
                    ITEM_20 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_100000 = 1
                }
            }
        },
        RECIPE_52 = {
            Input = {
                Items = {
                    ITEM_15 = 1,
                    ITEM_79 = 3
                }
            },
            Output = {
                Items = {
                    ABILITY_42 = 1
                }
            }
        },
        RECIPE_53 = {
            Input = {
                Shards = {
                    ABILITY_3701 = 3
                }
            },
            Output = {
                Items = {
                    ABILITY_3701 = 1
                }
            }
        },
        RECIPE_54 = {
            Input = {
                Shards = {
                    ABILITY_119 = 3
                }
            },
            Output = {
                Items = {
                    ABILITY_119 = 1
                }
            }
        },
        RECIPE_55 = {
            Input = {
                Items = {
                    ITEM_93 = 6
                }
            },
            Output = {
                Items = {
                    ABILITY_119 = 1
                }
            }
        },
        RECIPE_56 = {
            Input = {
                Items = {
                    ITEM_97 = 1
                },
                Shards = {
                    ABILITY_9111 = 3
                }
            },
            Output = {
                Items = {
                    ITEM_86 = 1
                }
            }
        },
        RECIPE_57 = {
            Input = {
                Items = {
                    ITEM_69 = 1,
                    ITEM_73 = 1
                }
            },
            Output = {
                Items = {
                    ITEM_98 = 1
                }
            }
        },
        RECIPE_58 = {
            Input = {
                Items = {
                    ITEM_531 = 1,
                    ITEM_5 = 1
                }
            },
            Output = {
                Items = {
                    ITEM_9 = 1
                }
            }
        },
        RECIPE_59 = {
            Input = {
                Items = {
                    ITEM_4 = 1,
                    ITEM_6 = 1,
                    ITEM_7 = 1,
                    ITEM_8 = 1,
                    ITEM_9 = 1,
                    ITEM_23 = 1
                }
            },
            Output = {
                Items = {
                    ITEM_10 = 1
                }
            }
        },
        RECIPE_60 = {
            Input = {
                Items = {
                    ITEM_10 = 1,
                    ITEM_11 = 1
                }
            },
            Output = {
                Items = {
                    ITEM_12 = 1
                }
            }
        },
        RECIPE_61 = {
            Input = {
                Items = {
                    ITEM_551 = 3,
                    ITEM_552 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_320003 = 1
                }
            }
        },
        RECIPE_62 = {
            Input = {
                Items = {
                    ITEM_553 = 3,
                    ITEM_554 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_32003 = 1
                }
            }
        },
        RECIPE_63 = {
            Input = {
                Items = {
                    ITEM_555 = 3,
                    ITEM_556 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_1231 = 1
                }
            }
        },
        RECIPE_64 = {
            Input = {
                Items = {
                    ITEM_582 = 1,
                    ITEM_583 = 1
                }
            },
            Output = {
                Items = {
                    ABILITY_6666666 = 1
                }
            }
        },
        RECIPE_65 = {
            Input = {
                UCoins = 200000,
                Shards = {
                    ABILITY_70 = 5
                }
            },
            Output = {
                Items = {
                    ABILITY_70 = 1
                }
            }
        },
        RECIPE_66 = {
            Input = {
                Items = {
                    ITEM_74 = 6
                }
            },
            Output = {
                Items = {
                    ITEM_75 = 1
                }
            }
        },
        RECIPE_67 = {
            Input = {
                Items = {
                    ITEM_809 = 1,
                    ITEM_810 = 5
                }
            },
            Output = {
                Items = {
                    ITEM_811 = 1
                }
            }
        },
        RECIPE_68 = {
            Input = {
                Items = {
                    ITEM_811 = 10,
                    ITEM_812 = 2
                }
            },
            Output = {
                Items = {
                    ITEM_814 = 1
                }
            }
        },
        RECIPE_69 = {
            Input = {
                Items = {
                    ITEM_811 = 5,
                    ITEM_812 = 1
                }
            },
            Output = {
                Items = {
                    ITEM_818 = 1
                }
            }
        },
        RECIPE_70 = {
            Input = {
                Items = {
                    ITEM_811 = 5,
                    ITEM_812 = 1
                }
            },
            Output = {
                Items = {
                    ITEM_817 = 1
                }
            }
        },
        RECIPE_71 = {
            Input = {
                Items = {
                    ITEM_811 = 4,
                    ITEM_812 = 4
                }
            },
            Output = {
                Items = {
                    ITEM_816 = 1
                }
            }
        },
        RECIPE_72 = {
            Input = {
                Items = {
                    ITEM_811 = 3,
                    ITEM_812 = 3
                }
            },
            Output = {
                Items = {
                    ITEM_819 = 1
                }
            }
        },
        RECIPE_73 = {
            Input = {
                Items = {
                    ITEM_811 = 3,
                    ITEM_812 = 3
                }
            },
            Output = {
                Items = {
                    ITEM_815 = 1
                }
            }
        },
        RECIPE_74 = {
            Input = {
                Items = {
                    ITEM_815 = 1,
                    ITEM_816 = 1,
                    ITEM_817 = 1,
                    ITEM_818 = 1,
                    ITEM_819 = 1,
                    ITEM_814 = 1,
                    ITEM_813 = 50
                }
            },
            Output = {
                Items = {
                    ITEM_820 = 1
                }
            }
        },
        RECIPE_75 = {
            Input = {
                Items = {
                    ITEM_830 = 1,
                    ITEM_831 = 1,
                    ITEM_832 = 1,
                    ITEM_833 = 1,
                    ITEM_834 = 1,
                    ITEM_835 = 1,
                    ITEM_836 = 1,
                    ITEM_837 = 1
                }
            },
            Output = {
                Items = {
                    ITEM_838 = 1
                }
            }
        },
        RECIPE_76 = {
            Input = {
                Items = {
                    ITEM_939 = 1,
                    ITEM_942 = 1
                }
            },
            Output = {
                Items = {
                    ITEM_941 = 1
                }
            }
        },
        RECIPE_77 = {
            Input = {
                Items = {
                    ITEM_943 = 1,
                    ITEM_941 = 1
                }
            },
            Output = {
                Items = {
                    ITEM_940 = 1
                }
            }
        },
        RECIPE_78 = {
            Input = {
                Items = {
                    ITEM_945 = 1,
                    ITEM_944 = 1
                }
            },
            Output = {
                Items = {
                    ITEM_943 = 1
                }
            }
        },
        RECIPE_79 = {
            Input = {
                Items = {
                    ITEM_98 = 1,
                    ITEM_933 = 1
                }
            },
            Output = {
                Items = {
                    ITEM_942 = 1
                }
            }
        },
        RECIPE_80 = {
            Input = {
                UCoins = 1000000,
                Items = {
                    ITEM_23 = 1
                }
            },
            Output = {
                Items = {
                    ITEM_1000 = 1
                }
            }
        }
    }
};