 

local u1 = require(script.Parent.Parent:WaitForChild("Styles"))
function OFA(u2)
    --[[
    Upvalues:
        [1] = u1
    --]]
    task.spawn(function() --[[ Line: 5 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local v3 = {
            ["Angle"] = { 45, 65 },
            ["Tilt"] = { -15, 15 },
            ["Height"] = { -0.5, 0.8 },
            ["BlockSize"] = { 1.25, 2 },
            ["PartCount"] = 20,
            ["Radius"] = 10,
            ["IterateSpeed"] = {
                ["Entrance"] = 0.1,
                ["EntranceDivision"] = 2,
                ["Exit"] = 0.25,
                ["ExitDivision"] = 2
            }
        }
        u1.ChunkCrater(u2, v3)
    end)
    task.spawn(function() --[[ Line: 22 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local v4 = {
            ["Radius"] = 15,
            ["PartCount"] = 15,
            ["BlockSize"] = { 0.25, 3 },
            ["Height"] = { 15, 25 },
            ["Angle"] = { -5, 5 },
            ["Tilt"] = { -5, 5 },
            ["Width"] = { -35, 35 },
            ["IterateSpeed"] = {
                ["Entrance"] = 0.1,
                ["EntranceDivision"] = 2,
                ["Exit"] = 0.25,
                ["ExitDivision"] = 2
            }
        }
        u1.Break(u2, v4)
    end)
    local v5 = {
        ["Angle"] = { 45, 65 },
        ["Tilt"] = { -15, 15 },
        ["Height"] = { -0.5, 0.8 },
        ["BlockSize"] = { 2, 3 },
        ["PartCount"] = 20,
        ["Radius"] = 15,
        ["IterateSpeed"] = {
            ["Entrance"] = 0.1,
            ["EntranceDivision"] = 2,
            ["Exit"] = 0.25,
            ["ExitDivision"] = 2
        }
    }
    u1.ChunkCrater(u2, v5)
end
return OFA