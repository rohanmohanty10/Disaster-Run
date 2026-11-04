 

local v1 = {}
local u2 = {}
game:GetService("RunService")
local u3 = game:GetService("TweenService")
require(game.ReplicatedStorage.Modules.BindToRender)
function resizeModel(p4, p5)
    local v6 = p4.PrimaryPart.Position
    for _, v7 in p4:GetChildren() do
        if v7:IsA("BasePart") then
            v7.Position = v6:Lerp(v7.Position, p5)
            v7.Size = v7.Size * p5
        end
    end
end
function v1.TweenResize(_, p8, p9, p10, p11, p12) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    u2[p8] = {
        p10 - 1,
        0,
        0,
        p9,
        p11,
        p12,
        p8
    }
end
game["Run Service"].Heartbeat:Connect(function(p13) --[[ Name: renderFunction, Line 26 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    for v14, v15 in u2 do
        local v16, v17, v18, v19, v20, v21, v22 = unpack(v15)
        if v22.Parent == nil or v17 >= 1 then
            u2[v14] = nil
        else
            local v23 = u2[v22]
            local v24 = v17 + p13 / v19
            v23[2] = math.min(v24, 1)
            local v25 = u3:GetValue(v17, v20, v21)
            resizeModel(v22, (v25 * v16 + 1) / (v18 * v16 + 1))
            u2[v22][3] = v25
        end
    end
end)
return v1