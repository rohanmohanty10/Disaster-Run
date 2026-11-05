  

 

return {
    Cooldowns = {
        UI = 60,
        MUI = 60
    },
    Health = {
        Base = 485,
        SSJ = 495,
        SSJ2 = 505,
        SSJ3 = 515,
        SSJ4 = 535,
        SSJG = 545,
        SSJB = 560,
        SSJBK = 585,
        UI = 600,
        MUI = 600,
        Egg = 1
    },
    ["Ki Requirement"] = {
        SSJ = 10,
        SSJ2 = 15,
        SSJ3 = 20,
        SSJ4 = 25,
        SSJG = 30,
        SSJB = 35,
        UI = 100,
        MUI = 100
    },
    ["Ki Drain"] = {
        SSJ = 0.4,
        SSJ2 = 0.5,
        SSJ3 = 0.6,
        SSJ4 = 1.5,
        SSJG = 2,
        SSJB = 3,
        SSJBK = 1.85,
        UI = 5,
        MUI = 5
    },
    ["HP Regen"] = {
        SSJG = 0.05,
        SSJB = 0.075,
        SSJBK = -1.9
    },
    Converter = {
        Base = "SSJ",
        SSJ = "SSJ2",
        SSJ2 = "SSJ3",
        SSJ3 = "SSJ4",
        SSJ4 = "SSJG",
        SSJG = "SSJB",
        SSJB = "SSJBK",
        SSJBK = "UI",
        UI = "MUI",
        MUI = "Base"
    },
    Titles = {
        SSJ = "Super Saiyan",
        SSJ2 = "Super Saiyan 2",
        SSJ3 = "Super Saiyan 3",
        SSJ4 = "Super Saiyan 4",
        SSJG = "Super Saiyan God",
        SSJB = "Super Saiyan Blue",
        SSJBK = "Super Saiyan Blue Kaioken",
        UI = "Ultra Instinct",
        MUI = "Mastered Ultra Instinct",
        Egg = "All Powerful"
    },
    DamageMultipliers = {
        Base = 1,
        SSJ = 1.1,
        SSJ2 = 1.2,
        SSJ3 = 1.3,
        SSJ4 = 1.4,
        SSJG = 1.5,
        SSJB = 1.6,
        SSJBK = 2,
        UI = 1.75,
        MUI = 1.75,
        Egg = 7.5
    },
    Kamehameha = {
        SSJ4 = "rbxassetid://7146890804"
    },
    ["LMB Colors"] = {
        SSJ = Color3.new(1, 1, 0),
        SSJ2 = Color3.new(1, 1, 0),
        SSJ3 = Color3.new(1, 1, 0),
        SSJ4 = Color3.new(1, 0, 0),
        SSJG = Color3.new(1, 0, 0),
        SSJB = Color3.new(0, 1, 1),
        SSJBK = Color3.new(0, 1, 1)
    },
    Quotes = {
        Base = { { "I\'m Goku a saiyan raised on earth, or so they tell me", "rbxassetid://7139716070", {
                    ["I\'m Goku a saiyan raised on earth,"] = 0.85
                }, 2, 2.5 }, { "I\'m Goku a saiyan raised on earth, Or so they tell me.", "rbxassetid://6807817509", {
                    ["I\'m Goku a saiyan raised on earth,"] = 0.85
                }, 2 }, { "HEY IT\'S ME GOKU!", "rbxassetid://6807816001", {}, 2 } },
        SSJ = { { "I am a warrior pure of heart awakened by rage, I AM THE LEGENDARY SUPER SAIYAN, SON GOKU", "rbxassetid://7139747905", {
                    ["I\'m Goku a saiyan raised on earth,"] = 0.85
                }, 2, 2.5 }, { "I haven\'t been this pumped for a fight in a long time", "rbxassetid://7139748317", {
                    ["I\'m Goku a saiyan raised on earth,"] = 0.85
                }, 2 }, { "This is a Super saiyan.", "rbxassetid://7139750743", {}, 2 } },
        SSJ2 = { { "You\'re so calm it\'s almost scary", "rbxassetid://7139755727", {
                    ["I\'m Goku a saiyan raised on earth,"] = 0.85
                }, 2, 2.5 }, { "Woah your energy it keeps getting higher and higher!", "rbxassetid://7139885028", {
                    ["I\'m Goku a saiyan raised on earth,"] = 0.85,
                    {},
                    2
                } } },
        SSJ3 = { { "I\'ll put some effort into this one", "rbxassetid://7139890475", {
                    ["I\'m Goku a saiyan raised on earth,"] = 0.85
                }, 2, 2.5 }, { "This isn\'t gonna be a easy fight.", "rbxassetid://7139904537", {
                    ["I\'m Goku a saiyan raised on earth,"] = 0.85
                }, 2 } },
        SSJ4 = { { "I\'m a bit stronger than I was before.", "rbxassetid://7139910801", {
                    ["I\'m Goku a saiyan raised on earth,"] = 0.85
                }, 2, 2.5 }, { "I\'m surprised too I didn\'t think I had this much power.", "rbxassetid://7139911589", {
                    ["I\'m Goku a saiyan raised on earth,"] = 0.85
                }, 4, 3.6 }, {} }
    }
};