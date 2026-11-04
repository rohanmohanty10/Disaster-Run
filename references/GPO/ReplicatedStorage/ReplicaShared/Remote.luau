 

local v1 = game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local v3 = v1:IsStudio()
local u4 = v1:IsServer()
local u5 = {}
local u6 = nil
local u7
if u4 == true then
    u7 = u2:FindFirstChild("RemoteEvents")
    if u7 == nil then
        u7 = Instance.new("Folder")
        u7.Name = "RemoteEvents"
        u7.Parent = u2
    elseif v3 == true then
        warn((("[%*]: ReplicatedStorage \"RemoteEvents\" container was already defined"):format(script.Name)))
    end
else
    u7 = u2:FindFirstChild("RemoteEvents")
    if u7 == nil then
        local u8 = Instance.new("BindableEvent")
        task.spawn(function() --[[ Line: 50 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u2
                [3] = u8
            --]]
            while task.wait() do
                u7 = u2:FindFirstChild("RemoteEvents")
                if u7 ~= nil then
                    u8:Fire()
                    return
                end
            end
        end)
        u6 = u8
    end
end
local u9 = {}
u9.__index = u9
function u9.New(p10) --[[ Line: 71 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    local v11 = u9
    return setmetatable({
        ["fn"] = p10,
        ["is_disconnected"] = false,
        ["real_connection"] = nil
    }, v11)
end
function u9.Disconnect(p12) --[[ Line: 79 ]]
    p12.is_disconnected = true
    if p12.real_connection ~= nil then
        p12.real_connection:Disconnect()
    end
end
local u13 = {}
u13.__index = u13
function u13.New(u14, p15) --[[ Line: 89 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
        [3] = u7
        [4] = u9
        [5] = u13
        [6] = u6
    --]]
    if type(u14) ~= "string" then
        error((("[%*]: name must be a string"):format(script.Name)))
    end
    if u4 == true then
        if u5[u14] ~= nil then
            error((("[%*]: RemoteEvent %* was already defined"):format(script.Name, u14)))
        end
        u5[u14] = true
        local v16 = Instance.new(p15 == true and "UnreliableRemoteEvent" or "RemoteEvent")
        v16.Name = u14
        v16.Parent = u7
        return v16
    end
    local u17 = u7
    if u17 then
        u17 = u7:FindFirstChild(u14)
    end
    if u17 ~= nil then
        return u17
    end
    local u18 = {}
    local v22 = {
        ["OnClientEvent"] = {
            ["Connect"] = function(_, p19) --[[ Name: Connect, Line 121 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u9
                    [3] = u18
                --]]
                if u17 ~= nil then
                    return u17.OnClientEvent:Connect(p19)
                end
                local v20 = u9.New(p19)
                local v21 = u18
                table.insert(v21, v20)
                return v20
            end
        },
        ["OnServerEvent"] = {
            ["Connect"] = function() --[[ Name: Connect, Line 134 ]]
                error((("[%*]: Can\'t connect to \"OnServerEvent\" client-side"):format(script.Name)))
            end
        },
        ["RemoteEvent"] = nil
    }
    local v23 = u13
    local u24 = setmetatable(v22, v23)
    local function u27() --[[ Line: 141 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u7
            [3] = u14
            [4] = u18
            [5] = u24
        --]]
        local v25 = os.clock()
        while true do
            u17 = u7:FindFirstChild(u14)
            if u17 ~= nil then
                break
            end
            if v25 ~= nil and os.clock() - v25 > 20 then
                warn((("[%*]: RemoteEvent \"%*\" hasn\'t been defined server-side"):format(script.Name, u14)))
                v25 = nil
            end
            task.wait()
        end
        for _, v26 in ipairs(u18) do
            if v26.is_disconnected == false then
                v26.real_connection = u17.OnClientEvent:Connect(v26.fn)
            end
        end
        u24.RemoteEvent = u17
        u18 = nil
    end
    if u7 == nil then
        local u28 = nil
        u28 = u6.Event:Connect(function() --[[ Line: 173 ]]
            --[[
            Upvalues:
                [1] = u28
                [2] = u27
            --]]
            u28:Disconnect()
            u27()
        end)
    else
        task.spawn(u27)
    end
    return u24
end
function u13.FireServer(p29, ...) --[[ Line: 185 ]]
    if p29.RemoteEvent ~= nil then
        p29.RemoteEvent:FireServer(...)
    end
end
function u13.FireClient(_) --[[ Line: 191 ]]
    error((("[%*]: Can\'t use \"FireClient\" client-side"):format(script.Name)))
end
function u13.FireAllClients(_) --[[ Line: 195 ]]
    error((("[%*]: Can\'t use \"FireAllClients\" client-side"):format(script.Name)))
end
return u13