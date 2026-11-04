 
 

local v1 = {
    Spins = {
        [2835474063] = 499,
        [2839604508] = 899,
        [2839604808] = 1199,
        [2835473863] = 499,
        [2839604242] = 899,
        [2839604664] = 1199
    },
    Packs = {
        Emotes = {
            Price = 1500,
            ID = 3225772125
        },
        GoalEffects = {
            Price = 2500,
            ID = 3225772327
        },
        Cards = {
            Price = 2000,
            ID = 3250140273
        }
    },
    CashProducts = {
        Cash1 = {
            Value = 5000,
            ID = 2838788938
        },
        Cash2 = {
            Value = 10000,
            ID = 2838789087
        },
        Cash3 = {
            Value = 25000,
            ID = 2838789218
        },
        Cash4 = {
            Value = 100000,
            ID = 2838789495
        }
    }
};
v1.AllProducts = { v1.CashProducts, v1.Packs, v1.Spins };

return v1;