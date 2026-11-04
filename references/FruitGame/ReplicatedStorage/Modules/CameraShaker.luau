 

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
function u1.new(p11, p12, p13) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u1
    --]]
    local v14 = type(p11) == "number"
    assert(v14, "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)")
    local v15 = type(p12) == "function"
    assert(v15, "Callback must be a function")
    local v16 = {
        ["_running"] = false,
        ["_renderName"] = "CameraShaker",
        ["_renderPriority"] = p11,
        ["_posAddShake"] = u8,
        ["_rotAddShake"] = u8,
        ["_camShakeInstances"] = {},
        ["_removeInstances"] = {},
        ["_callback"] = p12,
        ["_forceShake"] = p13
    }
    local v17 = u1
    return setmetatable(v16, v17)
end
function u1.Start(u18) --[[ Line: 47 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if not u18._running then
        u18._running = true
        local u19 = u18._callback
        game:GetService("RunService"):BindToRenderStep(u18._renderName, u18._renderPriority, function(p20) --[[ Line: 52 ]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u2
                [3] = u3
                [4] = u19
            --]]
            if _G.cameraShakeEnabled ~= false or u18._forceShake ~= nil then
                u2("CameraShakerUpdate")
                local v21 = u18:Update(p20)
                u3()
                u19(v21)
            end
        end)
    end
end
function u1.Stop(p22) --[[ Line: 64 ]]
    if p22._running then
        game:GetService("RunService"):UnbindFromRenderStep(p22._renderName)
        p22._running = false
    end
end
function u1.StopSustained(p23, p24) --[[ Line: 71 ]]
    for _, v25 in pairs(p23._camShakeInstances) do
        if v25.fadeOutDuration == 0 then
            v25:StartFadeOut(p24 or v25.fadeInDuration)
        end
    end
end
function u1.Update(p26, p27) --[[ Line: 80 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u10
        [3] = u5
        [4] = u6
        [5] = u7
    --]]
    local v28 = p26._camShakeInstances
    if _G.cameraShakeEnabled == false and p26._forceShake == nil then
        for v29 = 1, #v28 do
            p26._removeInstances[#p26._removeInstances + 1] = v29
        end
        for v30 = #p26._removeInstances, 1, -1 do
            local v31 = p26._removeInstances[v30]
            table.remove(v28, v31)
            p26._removeInstances[v30] = nil
        end
        return CFrame.new()
    end
    local v32 = u8
    local v33 = u8
    local v34 = math.clamp(p27, 0, 0.016666666666666666)
    for v35 = 1, #v28 do
        local v36 = v28[v35]
        local v37 = v36:GetState()
        if v37 == u10.Inactive and v36.DeleteOnInactive then
            p26._removeInstances[#p26._removeInstances + 1] = v35
        elseif v37 ~= u10.Inactive then
            local v38 = v36:UpdateShake(v34)
            v32 = v32 + v38 * v36.PositionInfluence
            v33 = v33 + v38 * v36.RotationInfluence
        end
    end
    for v39 = #p26._removeInstances, 1, -1 do
        local v40 = p26._removeInstances[v39]
        table.remove(v28, v40)
        p26._removeInstances[v39] = nil
    end
    return u5(v32) * u6(0, u7(v33.Y), 0) * u6(u7(v33.X), 0, (u7(v33.Z)))
end
function u1.Shake(p41, p42) --[[ Line: 132 ]]
    local v43
    if type(p42) == "table" then
        v43 = p42._camShakeInstance
    else
        v43 = false
    end
    assert(v43, "ShakeInstance must be of type CameraShakeInstance")
    p41._camShakeInstances[#p41._camShakeInstances + 1] = p42
    return p42
end
function u1.ShakeSustain(p44, p45) --[[ Line: 139 ]]
    local v46
    if type(p45) == "table" then
        v46 = p45._camShakeInstance
    else
        v46 = false
    end
    assert(v46, "ShakeInstance must be of type CameraShakeInstance")
    p44._camShakeInstances[#p44._camShakeInstances + 1] = p45
    p45:StartFadeIn(p45.fadeInDuration)
    return p45
end
function u1.ShakeOnce(p47, p48, p49, p50, p51, p52, p53) --[[ Line: 147 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    local v54 = u9.new(p48, p49, p50, p51)
    v54.PositionInfluence = typeof(p52) == "Vector3" and p52 and p52 or Vector3.new(0.15, 0.15, 0.15)
    v54.RotationInfluence = typeof(p53) == "Vector3" and p53 and p53 or Vector3.new(1, 1, 1)
    p47._camShakeInstances[#p47._camShakeInstances + 1] = v54
    return v54
end
function u1.StartShake(p55, p56, p57, p58, p59, p60) --[[ Line: 159 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    local v61 = u9.new(p56, p57, p58)
    v61.PositionInfluence = typeof(p59) == "Vector3" and p59 and p59 or Vector3.new(0.15, 0.15, 0.15)
    v61.RotationInfluence = typeof(p60) == "Vector3" and p60 and p60 or Vector3.new(1, 1, 1)
    v61:StartFadeIn(p58)
    p55._camShakeInstances[#p55._camShakeInstances + 1] = v61
    return v61
end
return u1