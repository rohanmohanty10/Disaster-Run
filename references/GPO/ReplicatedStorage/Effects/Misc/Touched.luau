 

local v1 = {}
local u2 = game["Run Service"]:IsServer()
local function u9(p3, p4) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    local v5 = p4 or 0
    local v6 = string.rep(" ", v5)
    for v7, v8 in pairs(p3) do
        if type(v8) == "table" then
            print(v6 .. tostring(v7) .. ":")
            u9(v8, v5 + 4)
        else
            print(v6 .. tostring(v7) .. " = " .. tostring(v8))
        end
    end
end
function v1.start(_, u10, p11, u12, u13, u14) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local u15 = nil
    local u16 = p11 == nil and { workspace.Env, workspace.Ships, workspace.Islands } or p11
    local function u19(p17) --[[ Line: 24 ]]
        --[[
        Upvalues:
            [1] = u16
        --]]
        for v18 = 1, #u16 do
            if u16[v18] then
                if p17 == u16[v18] then
                    return true
                end
                if p17:IsDescendantOf(u16[v18]) or p17 == u16[v18] then
                    return true
                end
            end
        end
        return false
    end
    if u2 == false then
        u10 = _G.awaitObject(u10)
    end
    local _ = u10.Touched:Connect(function(p20) --[[ Line: 58 ]]
        --[[
        Upvalues:
            [1] = u19
            [2] = u15
            [3] = u14
            [4] = u10
            [5] = u2
            [6] = u12
            [7] = u13
        --]]
        if u19(p20) == true then
            u15:Disconnect()
            u15 = nil
            if u14 == nil then
                u10.Anchored = true
            end
            if u2 == false then
                u12:FireServer(u10, u10.CFrame, p20)
                local v21 = u13 and _G.clientimpacts[game.ReplicatedStorage.ClientImpacts:FindFirstChild(u13)]
                if v21 then
                    v21:start({
                        ["obj"] = u10,
                        ["cf"] = u10.CFrame,
                        ["hit"] = p20
                    })
                    return
                end
            else
                u12(nil, u10, u10.CFrame, p20)
            end
        end
    end)
end
return v1