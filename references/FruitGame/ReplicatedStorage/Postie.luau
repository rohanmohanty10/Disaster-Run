 

local u1 = game:GetService("HttpService")
local v2 = game:GetService("RunService")
game:GetService("ReplicatedStorage")
if not script:FindFirstChild("Sent") then
    local v3 = Instance.new("RemoteEvent")
    v3.Name = "Sent"
    v3.Parent = script
end
if not script:FindFirstChild("Received") then
    local v4 = Instance.new("RemoteEvent")
    v4.Name = "Received"
    v4.Parent = script
end
local u5 = script.Sent
local u6 = script.Received
local u7 = v2:IsServer()
local u8 = {}
local u9 = {}
local function u16(u10, ...) --[[ Line: 97 ]]
    local v11 = Instance.new("BindableEvent")
    local u12 = table.pack(...)
    v11.Event:Connect(function() --[[ Line: 100 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u12
        --]]
        local v13 = u10
        local v14 = u12
        local v15 = u12.n
        v13(table.unpack(v14, 1, v15))
    end)
    v11:Fire()
    v11:Destroy()
end
local v45 = {
    ["InvokeClient"] = function(p17, u18, u19, ...) --[[ Name: InvokeClient, Line 112 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u9
            [3] = u1
            [4] = u16
            [5] = u5
        --]]
        local v20 = u7
        assert(v20, "Postie.InvokeClient can only be called from the server")
        local v21 = typeof(p17) == "string"
        assert(v21, "bad argument #1 to Postie.InvokeClient, expects string")
        local v22
        if typeof(u18) == "Instance" then
            v22 = u18:IsA("Player")
        else
            v22 = false
        end
        assert(v22, "bad argument #2 to Postie.InvokeClient, expects Instance<Player>")
        local v23 = typeof(u19) == "number"
        assert(v23, "bad argument #3 to Postie.InvokeClient, expects number")
        local u24 = Instance.new("BindableEvent")
        local u25 = false
        local u26 = #u9 + 1
        local u27 = u1:GenerateGUID(false)
        u9[u26] = function(p28, p29, ...) --[[ Line: 123 ]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u27
                [3] = u25
                [4] = u9
                [5] = u26
                [6] = u24
            --]]
            if p28 ~= u18 or p29 ~= u27 then
                return false
            end
            u25 = true
            table.remove(u9, u26)
            u24:Fire(true, ...)
            return true
        end
        u16(function() --[[ Line: 131 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u25
                [3] = u9
                [4] = u26
                [5] = u24
            --]]
            task.wait(u19)
            if not u25 then
                table.remove(u9, u26)
                u24:Fire(false)
            end
        end)
        u5:FireClient(u18, p17, u27, ...)
        return u24.Event:Wait()
    end,
    ["InvokeServer"] = function(p30, u31, ...) --[[ Name: InvokeServer, Line 143 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u9
            [3] = u1
            [4] = u16
            [5] = u5
        --]]
        local v32 = not u7
        assert(v32, "Postie.InvokeServer can only be called from the client")
        local v33 = typeof(p30) == "string"
        assert(v33, "bad argument #1 to Postie.InvokeServer, expects string")
        local v34 = typeof(u31) == "number"
        assert(v34, "bad argument #2 to Postie.InvokeServer, expects number")
        local u35 = Instance.new("BindableEvent")
        local u36 = false
        local u37 = #u9 + 1
        local u38 = u1:GenerateGUID(false)
        u9[u37] = function(p39, ...) --[[ Line: 153 ]]
            --[[
            Upvalues:
                [1] = u38
                [2] = u36
                [3] = u9
                [4] = u37
                [5] = u35
            --]]
            if p39 ~= u38 then
                return false
            end
            u36 = true
            table.remove(u9, u37)
            u35:Fire(true, ...)
            return true
        end
        u16(function() --[[ Line: 161 ]]
            --[[
            Upvalues:
                [1] = u31
                [2] = u36
                [3] = u9
                [4] = u37
                [5] = u35
            --]]
            task.wait(u31)
            if not u36 then
                table.remove(u9, u37)
                u35:Fire(false)
            end
        end)
        u5:FireServer(p30, u38, ...)
        return u35.Event:Wait()
    end,
    ["SetCallback"] = function(p40, p41) --[[ Name: SetCallback, Line 173 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        local v42 = typeof(p40) == "string"
        assert(v42, "bad argument #1 to Postie.SetCallback, expects string")
        u8[p40] = p41
    end,
    ["GetCallback"] = function(p43) --[[ Name: GetCallback, Line 179 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        local v44 = typeof(p43) == "string"
        assert(v44, "bad argument #1 to Postie.GetCallback, expects string")
        return u8[p43]
    end
}
if u7 then
    u6.OnServerEvent:Connect(function(...) --[[ Line: 189 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        for _, v46 in u9 do
            if v46(...) then
                return
            end
        end
    end)
    u5.OnServerEvent:Connect(function(p47, p48, p49, ...) --[[ Line: 195 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u6
        --]]
        local v50 = u8[p48]
        local v51 = u6
        if v50 then
            v50 = v50(p47, ...)
        end
        v51:FireClient(p47, p49, v50)
    end)
    return v45
else
    u6.OnClientEvent:Connect(function(...) --[[ Line: 201 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        for _, v52 in u9 do
            if v52(...) then
                return
            end
        end
    end)
    u5.OnClientEvent:Connect(function(p53, p54, ...) --[[ Line: 207 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u6
        --]]
        local v55 = u8[p53]
        local v56 = u6
        if v55 then
            v55 = v55(...)
        end
        v56:FireServer(p54, v55)
    end)
    return v45
end