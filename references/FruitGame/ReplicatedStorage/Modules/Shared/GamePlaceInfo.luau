 

local u1 = {
    [648454481] = {
        [3978370137] = "First Sea",
        [7465136166] = "Second Sea",
        [6811831486] = "Trade Hub",
        [10218387007] = "VC Trade Hub"
    },
    [2097989947] = {
        [5875630735] = "First Sea",
        [7122743591] = "Second Sea",
        [6729320818] = "Trade Hub"
    }
}
return {
    ["GetGameIds"] = function(_) --[[ Name: GetGameIds, Line 18 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        return u1
    end,
    ["GetPlaceIds"] = function(_) --[[ Name: GetPlaceIds, Line 22 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        return u1[game.GameId]
    end
}