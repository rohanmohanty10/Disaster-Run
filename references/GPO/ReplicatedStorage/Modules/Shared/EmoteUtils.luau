 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("Players")
game:GetService("MarketplaceService")
local u2 = game:GetService("RunService")
local u3 = require(game.ReplicatedStorage.Modules.Trove)
local v4 = v1.Modules.Shared.AnimationPacks:GetChildren()
local u5 = {}
local u6 = {}
local u7 = {}
for v8 = 1, #v4 do
    local v9 = require(v4[v8])
    for v10, v11 in pairs(v9) do
        u5[v10] = v11[1]
        u5[v10].Pack = v4[v8].Name
    end
end
function u6.GetAnimationData(_, p12) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    return u5[p12]
end
function u6.GetAnimationID(_, p13) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    return u5[p13].id
end
function u6.PlayEmote(_, p14) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u7
        [3] = u3
        [4] = u2
    --]]
    local v15 = game.Players.LocalPlayer
    local v16 = u6:GetAnimationID(p14)
    if v16 ~= nil then
        if u7[v15] then
            u7[v15]:Destroy()
            u7[v15] = nil
        end
        local u17 = game.Players.LocalPlayer.Character
        local u18 = u3.new()
        local v19 = u18:Add(Instance.new("Animation"))
        v19.AnimationId = v16
        v19.Parent = u17
        local u20 = u18:Add(u17.Humanoid:LoadAnimation(v19))
        u20.Priority = Enum.AnimationPriority.Action4
        u20:Play()
        u18:Add(function() --[[ Line: 54 ]]
            --[[
            Upvalues:
                [1] = u20
            --]]
            u20:Stop()
            u20:Destroy()
        end)
        u18:Connect(u2.Heartbeat, function(_) --[[ Line: 59 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u18
            --]]
            if (u17.Humanoid.MoveDirection ~= Vector3.new() or (_G.check:inspect(u17) == false or _G.canuse == false)) and u17:FindFirstChild("matchWon") == nil then
                u18:Destroy()
            end
        end)
        u18:AttachToInstance(u17)
        u7[v15] = u18
    end
end
return u6