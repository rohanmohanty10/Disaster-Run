 

local v1 = {}
local u2 = {}
local function u12(p3, p4) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u2[p3] == nil then
        u2[p3] = {}
    end
    local v5 = Instance.new("Attachment")
    v5.Position = Vector3.new(0, 0.1, 0)
    v5.Parent = p4
    local v6 = v5:Clone()
    v6.Position = Vector3.new(0, -0.1, 0)
    v6.Parent = p4
    local v7 = script.Trail:Clone()
    v7.Parent = p4
    v7.Attachment0 = v5
    v7.Attachment1 = v6
    local v8 = { v5, v6, v7 }
    for v9 = 1, #v8 do
        local v10 = u2[p3]
        local v11 = v8[v9]
        table.insert(v10, v11)
    end
end
function v1.start(_, p13, p14, p15) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u2
    --]]
    if p13 ~= game.Players.LocalPlayer then
        p14:WaitForChild("LeftHand", 10)
        p14:WaitForChild("RightHand", 10)
        p14:WaitForChild("RightFoot", 10)
        p14:WaitForChild("LeftFoot", 10)
        u12(p14, p14.RightHand)
        u12(p14, p14.LeftHand)
        u12(p14, p14.RightFoot)
        u12(p14, p14.LeftFoot)
        repeat
            game["Run Service"].Heartbeat:Wait()
        until p15.Parent == nil
        if u2[p14] then
            for v16 = 1, #u2[p14] do
                if u2[p14][v16]:IsA("Trail") == true then
                    u2[p14][v16].Enabled = false
                end
                _G.destroy(u2[p14][v16], 0.25)
            end
            u2[p14] = nil
        end
    end
end
return v1