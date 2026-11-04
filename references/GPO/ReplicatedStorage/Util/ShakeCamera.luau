 

local u1 = workspace.CurrentCamera
local u2 = require(script:WaitForChild("CameraShaker"))
local u4 = u2.new(Enum.RenderPriority.Camera.Value, function(p3) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1.CFrame = u1.CFrame * p3
end)
u4:Start()
return function(p5) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    local v6 = p5 or {}
    if _G.cameraShakeEnabled == false then
        return
    elseif type(v6) == "table" then
        local v7 = v6.RotationInfluence or Vector3.new(0, 1, 1)
        local v8 = v6.PositionInfluence or Vector3.new(0.25, 0.25, 0.25)
        u4:ShakeOnce(v6.Magnitude or 5, v6.Roughness or 5, v6.FadeIn or 1, v6.FadeOut or 1, v8, v7)
    elseif type(v6) == "string" then
        u4:Shake(u2.Presets[v6])
    end
end