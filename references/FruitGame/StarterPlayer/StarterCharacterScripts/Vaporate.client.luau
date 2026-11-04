 

local u1 = script.Parent
local function u5(p2) --[[ Line: 3 ]]
    local v3 = p2:GetDescendants()
    for v4 = 1, #v3 do
        if v3[v4]:IsA("Attachment") then
            v3[v4].Visible = false
        else
            v3[v4]:Destroy()
        end
    end
end
u1:GetAttributeChangedSignal("Vaporated"):Connect(function() --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u5
    --]]
    local u6 = u1:GetDescendants()
    local v7 = _G.getAccessorys(u1)
    if v7 then
        for v8 = 1, #v7 do
            local v9 = v7[v8]
            table.insert(u6, v9)
        end
    end
    for u10 = 1, #u6 do
        if u6[u10]:IsA("BasePart") then
            u6[u10].Transparency = 1
            task.spawn(function() --[[ Line: 25 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u6
                    [3] = u10
                --]]
                u5(u6[u10])
            end)
            if u6[u10].Parent == u1 then
                u6[u10].Anchored = true
            end
        end
    end
end)