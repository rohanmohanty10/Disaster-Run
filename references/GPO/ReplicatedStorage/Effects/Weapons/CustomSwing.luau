 

local v1 = {}
local u2 = {}
local v3 = {
    ["times"] = {
        ["1"] = 0.2833333333333333,
        ["2"] = 0.25,
        ["3"] = 0.2833333333333333,
        ["4"] = 0.25,
        ["5"] = 0.31666666666666665,
        ["Air-4"] = 0.31666666666666665,
        ["Air-5"] = 0.25
    },
    ["speedMulti"] = 1.35
}
u2["Demon Jester\'s Scythe"] = v3
local v4 = {
    ["times"] = {
        ["1"] = 0.3,
        ["2"] = 0.3,
        ["3"] = 0.3,
        ["4"] = 0.3,
        ["5"] = 0.26666666666666666,
        ["Air-4"] = 0.3,
        ["Air-5"] = 0.3
    },
    ["speedMulti"] = 1.75
}
u2.DragonClaw = v4
local v5 = {
    ["times"] = {
        ["1"] = 0.4166666666666667,
        ["2"] = 0.4166666666666667,
        ["3"] = 0.4166666666666667,
        ["4"] = 0.4166666666666667,
        ["5"] = 0.4166666666666667,
        ["Air-4"] = 0.3,
        ["Air-5"] = 0.3
    },
    ["speedMulti"] = 1.4
}
u2["World Ender"] = v5
local v6 = {
    ["times"] = {
        ["1"] = 0.1,
        ["2"] = 0.1,
        ["3"] = 0.1,
        ["4"] = 0.2,
        ["5"] = 0.2,
        ["Air-4"] = 0.1,
        ["Air-5"] = 0.1,
        ["Dash"] = 0.1
    },
    ["speedMulti"] = 1
}
u2["Hollow\'s Halberd"] = v6
local v7 = {
    ["times"] = {
        ["1"] = 0.14,
        ["2"] = 0.15,
        ["3"] = 0.14,
        ["4"] = 0.15,
        ["5"] = 0.13,
        ["Air-4"] = 0.1,
        ["Air-5"] = 0.1,
        ["Dash"] = 0.19
    },
    ["speedMulti"] = 2
}
u2["Stark Gun"] = v7
local v8 = {
    ["times"] = {
        ["1"] = 0.1,
        ["2"] = 0.1,
        ["3"] = 0.1,
        ["4"] = 0.2,
        ["5"] = 0.2,
        ["Air-4"] = 0.1,
        ["Air-5"] = 0.1,
        ["Dash"] = 0.1
    },
    ["speedMulti"] = 1
}
u2["Sunken Anchor"] = v8
local v9 = {
    ["times"] = {
        ["1"] = 0.267,
        ["2"] = 0.277,
        ["3"] = 0.264,
        ["4"] = 0.261,
        ["5"] = 0.33,
        ["Air-4"] = 0.267,
        ["Air-5"] = 0.267,
        ["Dash"] = 0.267
    },
    ["speedMulti"] = 1.86
}
u2["Blood Scythe"] = v9
local v10 = {
    ["times"] = {
        ["1"] = 0.1,
        ["2"] = 0.1,
        ["3"] = 0.1,
        ["4"] = 0.1,
        ["5"] = 0.1,
        ["Air-4"] = 0.1,
        ["Air-5"] = 0.1,
        ["Dash"] = 0.1
    },
    ["speedMulti"] = 1
}
u2["Cupid\'s Bow"] = v10
local v11 = {
    ["times"] = {
        ["1"] = 0,
        ["2"] = 0,
        ["3"] = 0,
        ["4"] = 0,
        ["5"] = 0,
        ["Air-4"] = 0,
        ["Air-5"] = 0,
        ["Dash"] = 0
    },
    ["speedMulti"] = 1
}
u2["Ghost Princess\'s Umbrella"] = v11
local v12 = {
    ["times"] = {
        ["1"] = 0.4166666666666667,
        ["2"] = 0.4166666666666667,
        ["3"] = 0.4166666666666667,
        ["4"] = 0.4166666666666667,
        ["5"] = 0.4166666666666667,
        ["Air-4"] = 0.3,
        ["Air-5"] = 0.3
    },
    ["speedMulti"] = 1.4
}
u2["World Ender 2"] = v12
local v13 = {
    ["times"] = {
        ["1"] = 0.2,
        ["2"] = 0.2,
        ["3"] = 0.2,
        ["4"] = 0.2,
        ["5"] = 0.2,
        ["Air-4"] = 0.2,
        ["Air-5"] = 0.2
    },
    ["speedMulti"] = 1.2
}
u2["Sickle of Sorrow"] = v13
u2["World Ender 2"] = u2["World Ender"]
u2["Hollow\'s World Ender"] = u2["World Ender"]
u2["Prestige World Ender"] = u2["World Ender"]
u2["Blessed Cupid\'s Bow"] = table.clone(u2["Cupid\'s Bow"])
function v1.start(_, p14, p15) --[[ Line: 156 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p15 and p15 == game.Players.LocalPlayer then
        return
    else
        local u16, u17, u18, u19, u20 = unpack(p14)
        if u2[u18] == nil then
            return
        elseif u16.PrimaryPart == nil then
            return
        elseif _G.checkRenderDistance(u16.PrimaryPart.Position) ~= false then
            task.spawn(function() --[[ Line: 171 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u19
                    [3] = u2
                    [4] = u18
                    [5] = u17
                    [6] = u20
                --]]
                local v21 = u16:FindFirstChild("BusoMelee")
                local v22 = u19 == "Air" and "Air-" or ""
                local v23 = u2[u18].times[v22 .. u17] == nil and "" or v22
                if u20 == true and u2[u18].times.Dash ~= nil then
                    task.wait(u2[u18].times.Dash / u2[u18].speedMulti)
                else
                    task.wait(u2[u18].times[v23 .. u17] / u2[u18].speedMulti)
                end
                if u16 == nil then
                    return
                elseif u16.PrimaryPart == nil then
                    return
                elseif not u16:FindFirstChild("Blocking") and _G.check:inspect(u16) ~= false then
                    _G.PlayEffect(u18 .. "M1Slash", nil, v23 .. u17, u16.HumanoidRootPart, v21, u20)
                end
            end)
        end
    end
end
return v1