 

local v1 = {}
local u2 = game:GetService("RunService")
local u3 = require(script.Parent.Assert)
local v4 = require(script.Parent.Parent.Event)
local u5 = v4.Reliable
local u6 = v4.Unreliable
local u7 = v4.Request
local u8 = require(script.Parent.Parent.Signal)("Warp_OnSpamSignal")
local u9 = {}
local u10 = {}
local u11 = {}
setmetatable(u11, {
    ["__index"] = u9,
    ["__newindex"] = function(_, p12, p13) --[[ Name: __newindex, Line 14 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u9
            [3] = u8
        --]]
        if not u10[p12] then
            u10[p12] = os.clock()
        end
        if os.clock() - u10[p12] >= 1 then
            u10[p12] = os.clock()
            u9[p12] = 1
            return
        elseif p13 >= 100 then
            u8:Fire(p12)
        else
            u9[p12] = p13
        end
    end
})
local function u16(p14) --[[ Line: 31 ]]
    --[[
    Upvalues:
        [1] = u11
    --]]
    if u11[p14] then
        local v15 = u11
        v15[p14] = v15[p14] + 1
    else
        u11[p14] = 1
    end
end
function v1.create(p17, u18, u19) --[[ Line: 39 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u5
    --]]
    u3(typeof(p17) == "string", "Identifier must a string type.")
    if u2:IsServer() then
        u3(typeof(u18) == "number", "entrance must a number type.")
        u3(u18 > 0, "entrance must above 0.")
        u5:SetAttribute(p17 .. "_ent", u18)
        u5:SetAttribute(p17 .. "_int", u19)
    else
        while not (u5:GetAttribute(p17 .. "_ent") and u5:GetAttribute(p17 .. "_int")) do
            task.wait(0.1)
        end
        local v20 = u5
        local v21 = p17 .. "_ent"
        u18 = tonumber(v20:GetAttribute(v21))
        local v22 = u5
        local v23 = p17 .. "_int"
        u19 = tonumber(v22:GetAttribute(v23))
    end
    local u24 = 0
    return function(p25) --[[ Line: 54 ]]
        --[[
        Upvalues:
            [1] = u24
            [2] = u19
            [3] = u18
        --]]
        if u24 == 0 then
            task.delay(u19, function() --[[ Line: 56 ]]
                --[[
                Upvalues:
                    [1] = u24
                --]]
                u24 = 0
            end)
        end
        u24 = u24 + (p25 or 1)
        return u24 <= u18
    end
end
function v1.Protect() --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u5
        [3] = u6
        [4] = u7
        [5] = u16
    --]]
    if u2:IsServer() and not (u5:GetAttribute("Protected") or (u6:GetAttribute("Protected") or u7:GetAttribute("Protected"))) then
        u5:SetAttribute("Protected", true)
        u6:SetAttribute("Protected", true)
        u7:SetAttribute("Protected", true)
        u5.OnServerEvent:Connect(u16)
        u6.OnServerEvent:Connect(u16)
        u7.OnServerEvent:Connect(u16)
    end
end
return v1