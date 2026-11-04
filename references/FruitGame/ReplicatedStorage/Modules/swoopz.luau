 

workspace:WaitForChild("Effects")
workspace:WaitForChild("Effects")
local u1 = {}
u1.__index = u1
local _ = table.insert
game:GetService("ContentProvider")
local u2 = require(game:GetService("ReplicatedStorage").Modules.sBeat)
local u3 = {}
local v4 = {}
for _, v5 in script:GetChildren() do
    u3[v5.Name] = {
        ["ft"] = v5.config.frametime.Value * 60,
        ["tf"] = v5.config.frames.Value,
        ["ids"] = {}
    }
    local v6 = v5.texs:GetChildren()
    local v7 = {}
    for v8 = 1, #v6 do
        local v9 = v6[v8].Name
        local v10 = string.find(v9, "_") + 1
        local v11 = string.sub(v9, v10)
        v7[v8] = tonumber(v11)
    end
    table.sort(v7)
    for v12 = 1, #v7 do
        local v13 = v5.texs["Decal_" .. v7[v12]]
        u3[v5.Name].ids[v12] = v13.Texture
        v13.Texture = "rbxassetid://" .. math.random(100000, 10000000)
    end
    v5:Destroy()
end
function u1.new(p14, p15) --[[ Line: 39 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
    --]]
    local v16 = {
        ["part"] = p15,
        ["info"] = u3[p14]
    }
    local v17 = u1
    return setmetatable(v16, v17)
end
function u1.Do(u18) --[[ Line: 47 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u19 = u18.part
    task.spawn(function() --[[ Line: 50 ]]
        --[[
        Upvalues:
            [1] = u18
            [2] = u19
            [3] = u2
        --]]
        for u20 = 1, u18.info.tf do
            pcall(function() --[[ Line: 52 ]]
                --[[
                Upvalues:
                    [1] = u19
                    [2] = u18
                    [3] = u20
                --]]
                u19.Decal.Texture = u18.info.ids[u20]
            end)
            u2(u18.info.ft)
        end
        u19:Destroy()
    end)
end
function v4.Do(p21, p22) --[[ Line: 64 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    return u1.new(p21, p22):Do()
end
return v4