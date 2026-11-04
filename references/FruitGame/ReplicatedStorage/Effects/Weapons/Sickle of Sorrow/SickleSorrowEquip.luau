 

local v1 = {}
game:GetService("RunService")
local u2 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
function v1.start(_, p3) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v4 = p3.char
    local v5 = p3.sword
    if v5 then
        if p3.startTime then
            local v6 = p3.startTime
            local v7 = workspace:GetServerTimeNow() - v6
            local v8 = p3.delayTime
            task.wait(v8 - v7)
        end
        local v9 = script.Sword
        local v10 = v9:FindFirstChild("Middle")
        local v11 = v5:WaitForChild("Middle", 1)
        if v10 and v11 then
            if not p3.startTime or (not v5 or v5.Name ~= "swordGone") then
                for _, v12 in ipairs({ "BladePart", "HandlePart" }) do
                    local v13 = v9:FindFirstChild(v12)
                    if v13 then
                        local v14 = v10.CFrame:Inverse() * v13.CFrame
                        local v15 = v13:Clone()
                        v15.CFrame = v11.CFrame * v14
                        v15.Parent = workspace.Effects
                        u2.apply(v15, v4)
                        _G.customWeld(v15, v11, v14, v15)
                        _G.customEmit(v15)
                        _G.destroy(v15, 3)
                    end
                end
            end
        else
            return
        end
    else
        return
    end
end
return v1