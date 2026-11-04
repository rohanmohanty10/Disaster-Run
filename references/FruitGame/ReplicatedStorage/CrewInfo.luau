 

local u1 = {}
local u2 = {}
function u1.AddInfo(_, p3, p4) --[[ Line: 3 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p4 then
        if type(p4) == "string" then
            u2[p3] = nil
            return
        end
        u2[p3] = p4
        if game:GetService("RunService"):IsServer() == true then
            script.RemoteEvent:FireAllClients(p3, p4)
        end
    end
end
function u1.Get(_, p5) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u2[p5] then
        return u2[p5]
    end
end
function u1.UpdateCache(_, p6, p7) --[[ Line: 23 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if game:GetService("RunService"):IsServer() == true then
        script.RemoteEvent:FireAllClients(p6, p7)
        if p7 == "offload" then
            u2[p6] = nil
        else
            u2[p6] = p7
        end
    else
        if u2[p6] then
            u2[p6] = nil
        end
        if p7 ~= "offload" then
            u2[p6] = p7
        end
    end
end
if game:GetService("RunService"):IsServer() == false then
    script.RemoteEvent.OnClientEvent:Connect(function(p8, p9) --[[ Line: 43 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        u1:UpdateCache(p8, p9)
    end)
end
return u1