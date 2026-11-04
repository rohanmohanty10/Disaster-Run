 

local function u5(p1) --[[ Line: 2 ]]
    local v2 = {}
    for _, v3 in p1 do
        local v4 = {
            ["Chance"] = v3.Chance or 100,
            ["Items"] = v3.Items or {
                {
                    ["Name"] = v3.Name,
                    ["Amount"] = v3.Amount or 1
                }
            }
        }
        table.insert(v2, v4)
    end
    return {
        ["ItemPool"] = v2
    }
end
local v6 = {}
local v7 = {}
local v8 = {
    ["Chance"] = 100,
    ["Items"] = {
        {
            ["Name"] = "2x EXP",
            ["Amount"] = 60
        },
        {
            ["Name"] = "Race Reroll",
            ["Amount"] = 10
        }
    }
}
__set_list(v7, 1, {v8})
local v9 = {}
local v10 = {
    ["Chance"] = 100,
    ["Items"] = {
        {
            ["Name"] = "2x EXP",
            ["Amount"] = 60
        },
        {
            ["Name"] = "Race Reroll",
            ["Amount"] = 10
        }
    }
}
__set_list(v9, 1, {v10})
local v11 = {}
local v12 = {
    ["Chance"] = 100,
    ["Items"] = {
        {
            ["Name"] = "2x EXP",
            ["Amount"] = 60
        },
        {
            ["Name"] = "Race Reroll",
            ["Amount"] = 10
        }
    }
}
__set_list(v11, 1, {v12})
__set_list(v6, 1, {(function(p13) --[[ Name: FruitPool, Line 18 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v14 = {}
    for _, v15 in p13 do
        table.insert(v14, {
            ["Chance"] = 100,
            ["Name"] = v15,
            ["Amount"] = 1
        })
    end
    return u5(v14)
end)({
    "Bari",
    "Bomb",
    "Mero",
    "Gomu",
    "Horo"
}), u5(v7), u5({
    {
        ["Chance"] = 5,
        ["Name"] = "Race Reroll",
        ["Amount"] = 25
    },
    {
        ["Chance"] = 35,
        ["Name"] = "Dark Root",
        ["Amount"] = 1
    },
    {
        ["Chance"] = 50,
        ["Name"] = "2x EXP",
        ["Amount"] = 30
    },
    {
        ["Chance"] = 100,
        ["Name"] = "SP Reset Essence",
        ["Amount"] = 1
    }
}), u5(v9), u5({
    {
        ["Chance"] = 5,
        ["Name"] = "2x EXP",
        ["Amount"] = 60
    },
    {
        ["Chance"] = 25,
        ["Name"] = "Race Reroll",
        ["Amount"] = 8
    },
    {
        ["Chance"] = 100,
        ["Name"] = "SP Reset Essence",
        ["Amount"] = 2
    }
}), u5(v11), (u5({
    {
        ["Chance"] = 100,
        ["Name"] = "Mythical Fruit Chest",
        ["Amount"] = 1
    }
}))})
return v6