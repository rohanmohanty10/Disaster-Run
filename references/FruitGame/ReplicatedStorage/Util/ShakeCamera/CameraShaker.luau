 

local u1 = {}
u1.__index = u1
local u2 = debug.profilebegin
local u3 = debug.profileend
local v4 = Vector3.new
local u5 = CFrame.new
local u6 = CFrame.Angles
local u7 = math.rad
local u8 = v4()
local u9 = require(script.CameraShakeInstance)
local u10 = u9.CameraShakeState
u1.CameraShakeInstance = u9
u1.Presets = require(script.CameraShakePresets)
function u1.new(p11, p12) --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u1
    --]]
    local v13 = type(p11) == "number"
    assert(v13, "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)")
    local v14 = type(p12) == "function"
    assert(v14, "Callback must be a function")
    local v15 = {
        ["_running"] = false,
        ["_renderName"] = "CameraShaker",
        ["_renderPriority"] = p11,
        ["_posAddShake"] = u8,
        ["_rotAddShake"] = u8,
        ["_camShakeInstances"] = {},
        ["_removeInstances"] = {},
        ["_callback"] = p12
    }
    local v16 = u1
    return setmetatable(v15, v16)
end
function u1.Start(u17) --[[ Line: 48 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if not u17._running then
        u17._running = true
        local u18 = u17._callback
        game:GetService("RunService"):BindToRenderStep(u17._renderName, u17._renderPriority, function(p19) --[[ Line: 52 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u17
                [3] = u3
                [4] = u18
            --]]
            u2("CameraShakerUpdate")
            local v20 = u17:Update(p19)
            u3()
            u18(v20)
        end)
    end
end
function u1.Stop(p21) --[[ Line: 61 ]]
    if p21._running then
        game:GetService("RunService"):UnbindFromRenderStep(p21._renderName)
        p21._running = false
    end
end
function u1.Update(p22, p23) --[[ Line: 68 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u10
        [3] = u5
        [4] = u6
        [5] = u7
    --]]
    local v24 = u8
    local v25 = u8
    local v26 = p22._camShakeInstances
    local v27 = math.clamp(p23, 0, 0.016666666666666666)
    for v28 = 1, #v26 do
        local v29 = v26[v28]
        local v30 = v29:GetState()
        if v30 == u10.Inactive and v29.DeleteOnInactive then
            p22._removeInstances[#p22._removeInstances + 1] = v28
        elseif v30 ~= u10.Inactive then
            v24 = v24 + v29:UpdateShake(v27) * v29.PositionInfluence
            v25 = v25 + v29:UpdateShake(v27) * v29.RotationInfluence
        end
    end
    for v31 = #p22._removeInstances, 1, -1 do
        local v32 = p22._removeInstances[v31]
        table.remove(v26, v32)
        p22._removeInstances[v31] = nil
    end
    return u5(v24) * u6(0, u7(v25.Y), 0) * u6(u7(v25.X), 0, (u7(v25.Z)))
end
function u1.Shake(p33, p34) --[[ Line: 104 ]]
    local v35
    if type(p34) == "table" then
        v35 = p34._camShakeInstance
    else
        v35 = false
    end
    assert(v35, "ShakeInstance must be of type CameraShakeInstance")
    p33._camShakeInstances[#p33._camShakeInstances + 1] = p34
    return p34
end
function u1.ShakeSustain(p36, p37) --[[ Line: 111 ]]
    local v38
    if type(p37) == "table" then
        v38 = p37._camShakeInstance
    else
        v38 = false
    end
    assert(v38, "ShakeInstance must be of type CameraShakeInstance")
    p36._camShakeInstances[#p36._camShakeInstances + 1] = p37
    p37:StartFadeIn(p37.fadeInDuration)
    return p37
end
function u1.ShakeOnce(p39, p40, p41, p42, p43, p44, p45) --[[ Line: 119 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    local v46 = u9.new(p40, p41, p42, p43)
    v46.PositionInfluence = typeof(p44) == "Vector3" and p44 and p44 or Vector3.new(0.15, 0.15, 0.15)
    v46.RotationInfluence = typeof(p45) == "Vector3" and p45 and p45 or Vector3.new(1, 1, 1)
    p39._camShakeInstances[#p39._camShakeInstances + 1] = v46
    return v46
end
function u1.StartShake(p47, p48, p49, p50, p51, p52) --[[ Line: 128 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    local v53 = u9.new(p48, p49, p50)
    v53.PositionInfluence = typeof(p51) == "Vector3" and p51 and p51 or Vector3.new(0.15, 0.15, 0.15)
    v53.RotationInfluence = typeof(p52) == "Vector3" and p52 and p52 or Vector3.new(1, 1, 1)
    v53:StartFadeIn(p50)
    p47._camShakeInstances[#p47._camShakeInstances + 1] = v53
    return v53
end
return u1