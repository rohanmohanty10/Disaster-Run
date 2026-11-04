 

local v1 = {}
local function u5(p2, p3) --[[ Line: 3 ]]
    for _, v4 in pairs(p2:GetDescendants()) do
        if v4:IsA("ParticleEmitter") then
            v4.Enabled = p3
        end
    end
end
function v1.start(_, p6) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    if _G.checkRenderDistance(p6.Character.PrimaryPart.Position) ~= false then
        local v7 = script.roar.Middle:Clone()
        v7.Parent = _G.getBone(p6.Character, "jaw")
        u5(v7, true)
        task.wait(p6.Duration)
        u5(v7, false)
    end
end
return v1