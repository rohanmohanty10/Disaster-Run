 

local u1 = require(script.Octree)
local u2 = Random.new(os.clock() * os.time())
local v3 = {}
local u4 = {
    ["Depth"] = 4,
    ["Size"] = 512
}
local u5 = {}
u5.__index = u5
function u5.AddStatic(p6, p7, p8) --[[ Line: 25 ]]
    local v9 = p6._trash
    local v10 = p6.Tree
    table.insert(v9, v10:CreateNode(p8 or Vector3.new(0, 0, 0), p7))
end
function u5.Add(p11, p12, p13) --[[ Line: 29 ]]
    p11.Entries[p12] = p11.Tree:CreateNode(p13 or Vector3.new(0, 0, 0), p12)
end
function u5.Track(u14, u15, p16) --[[ Line: 48 ]]
    local v17 = typeof(u15) == "Instance"
    assert(v17, "Object must be an instance")
    local u18 = true
    local u19 = math.clamp(p16 or 0.1, 0, 10)
    if u15:IsA("Model") then
        task.defer(function() --[[ Line: 55 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u18
                [3] = u15
                [4] = u19
            --]]
            while u14.Update and u18 do
                pcall(function() --[[ Line: 57 ]]
                    --[[
                    Upvalues:
                        [1] = u14
                        [2] = u15
                    --]]
                    u14.Tracked[u15]:Destroy()
                end)
                u14.Tracked[u15] = u14.Tree:CreateNode(u15.PrimaryPart.Position, u15)
                task.wait(u19)
            end
        end)
    else
        task.defer(function() --[[ Line: 65 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u18
                [3] = u15
                [4] = u19
            --]]
            while u14.Update and u18 do
                pcall(function() --[[ Line: 67 ]]
                    --[[
                    Upvalues:
                        [1] = u14
                        [2] = u15
                    --]]
                    u14.Tracked[u15]:Destroy()
                end)
                u14.Tracked[u15] = u14.Tree:CreateNode(u15.Position, u15)
                task.wait(u19)
            end
        end)
    end
    return {
        ["Destroy"] = function() --[[ Name: Destroy, Line 77 ]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u19
                [3] = u14
                [4] = u15
            --]]
            u18 = false
            task.wait(u19)
            pcall(function() --[[ Line: 80 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u15
                --]]
                u14.Tracked[u15]:Destroy()
            end)
            u14.Tracked[u15] = nil
        end
    }
end
function u5.Remove(p20, p21) --[[ Line: 86 ]]
    if p20.Entries[p21] then
        p20.Entries[p21]:Destroy()
    end
    p20.Entries[p21] = nil
end
function u5.UpdateFor(p22, p23, p24) --[[ Line: 93 ]]
    if p22.Entries[p23] then
        p22.Entries[p23]:Destroy()
    end
    p22:Add(p23, p24)
end
function u5.Destroy(p25) --[[ Line: 101 ]]
    p25.Update = false
    for _, v26 in p25._trash do
        v26:Destroy()
    end
    for _, v27 in p25.Entries do
        v27:Destroy()
    end
    p25.Tree = nil
end
function u5._init(p28) --[[ Line: 115 ]]
    p28.Update = true
end
function v3.New(p29, p30, p31) --[[ Line: 122 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
        [3] = u4
        [4] = u5
    --]]
    local v32 = {
        ["Name"] = p29 or "Unnamed DOS Grid ~~" .. u2:NextInteger(1000, 9999),
        ["Tree"] = u1.new(p30 or u4.Depth, p31 or u4.Size),
        ["Update"] = false,
        ["Entries"] = {},
        ["Tracked"] = {},
        ["_trash"] = {}
    }
    local v33 = u5
    local v34 = setmetatable(v32, v33)
    v34:_init()
    return v34
end
return v3