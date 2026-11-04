 

local v1 = {}
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Sparks]
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.RockDebs]
function v1.start(_, p2) --[[ Line: 4 ]]
    local v3 = p2.char
    local v4 = p2.cf
    if v4 == nil then
        return
    elseif typeof(v4) == "CFrame" then
        if v4 and _G.checkRenderDistance(v4.Position) == false then
            return
        elseif v3 == nil then
            return
        else
            v3:WaitForChild("Head", 10)
            if v3:FindFirstChild("Head") ~= nil then
                local v5 = script["GeppoNew" .. math.random(1, 2)]:Clone()
                v5.Parent = v3.Head
                v5:Play()
                _G.destroy(v5, 3)
                local v6 = script.GeppoVFX:Clone()
                v6.CFrame = v4 * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, -3, 0)
                v6.Parent = workspace.Effects
                _G.customEmit(v6)
                _G.destroy(v6, 3)
            end
        end
    else
        return
    end
end
return v1