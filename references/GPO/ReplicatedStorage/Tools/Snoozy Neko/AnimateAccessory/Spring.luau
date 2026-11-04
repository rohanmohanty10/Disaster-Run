 

local u1 = {}
u1.__index = u1
function u1.new(p2, p3) --[[ Line: 74 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v4 = p2 or 0
    local v5 = p3 or os.clock
    local v6 = {
        ["_clock"] = v5,
        ["_time0"] = v5(),
        ["_position0"] = v4,
        ["_velocity0"] = 0 * v4,
        ["_target"] = v4,
        ["_damper"] = 1,
        ["_speed"] = 1
    }
    local v7 = u1
    return setmetatable(v6, v7)
end
function u1.Impulse(p8, p9) --[[ Line: 96 ]]
    p8.Velocity = p8.Velocity + p9
end
function u1.TimeSkip(p10, p11) --[[ Line: 105 ]]
    local v12 = p10._clock()
    local v13, v14 = p10:_positionVelocity(v12 + p11)
    p10._position0 = v13
    p10._velocity0 = v14
    p10._time0 = v12
end
function u1.SetTarget(p15, p16, p17) --[[ Line: 119 ]]
    if p17 then
        local v18 = p15._clock()
        p15._position0 = p16
        p15._velocity0 = 0 * p16
        p15._target = p16
        p15._time0 = v18
    else
        p15.Target = p16
    end
end
function u1.__index(p19, p20) --[[ Line: 212 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if u1[p20] then
        return u1[p20]
    end
    if p20 == "Value" or (p20 == "Position" or p20 == "p") then
        local v21, _ = p19:_positionVelocity(p19._clock())
        return v21
    end
    if p20 == "Velocity" or p20 == "v" then
        local _, v22 = p19:_positionVelocity(p19._clock())
        return v22
    end
    if p20 == "Target" or p20 == "t" then
        return p19._target
    end
    if p20 == "Damper" or p20 == "d" then
        return p19._damper
    end
    if p20 == "Speed" or p20 == "s" then
        return p19._speed
    end
    if p20 == "Clock" then
        return p19._clock
    end
    error(string.format("%q is not a valid member of Spring", (tostring(p20))), 2)
end
function u1.__newindex(p23, p24, p25) --[[ Line: 234 ]]
    local v26 = p23._clock()
    if p24 == "Value" or (p24 == "Position" or p24 == "p") then
        local _, v27 = p23:_positionVelocity(v26)
        p23._position0 = p25
        p23._velocity0 = v27
        p23._time0 = v26
        return
    elseif p24 == "Velocity" or p24 == "v" then
        local v28, _ = p23:_positionVelocity(v26)
        p23._position0 = v28
        p23._velocity0 = p25
        p23._time0 = v26
        return
    elseif p24 == "Target" or p24 == "t" then
        local v29, v30 = p23:_positionVelocity(v26)
        p23._position0 = v29
        p23._velocity0 = v30
        p23._target = p25
        p23._time0 = v26
        return
    elseif p24 == "Damper" or p24 == "d" then
        local v31, v32 = p23:_positionVelocity(v26)
        p23._position0 = v31
        p23._velocity0 = v32
        p23._damper = p25
        p23._time0 = v26
        return
    elseif p24 == "Speed" or p24 == "s" then
        local v33, v34 = p23:_positionVelocity(v26)
        p23._position0 = v33
        p23._velocity0 = v34
        p23._speed = p25 < 0 and 0 or p25
        p23._time0 = v26
        return
    elseif p24 == "Clock" then
        local v35, v36 = p23:_positionVelocity(v26)
        p23._position0 = v35
        p23._velocity0 = v36
        p23._clock = p25
        p23._time0 = p25()
    else
        error(string.format("%q is not a valid member of Spring", (tostring(p24))), 2)
    end
end
function u1._positionVelocity(p37, p38) --[[ Line: 276 ]]
    local v39 = p37._position0
    local v40 = p37._velocity0
    local v41 = p37._target
    local v42 = p37._damper
    local v43 = p37._speed
    local v44 = v43 * (p38 - p37._time0)
    local v45 = v42 * v42
    local v46, v47, v48
    if v45 < 1 then
        local v49 = 1 - v45
        v46 = math.sqrt(v49)
        local v50 = -v42 * v44
        local v51 = math.exp(v50) / v46
        local v52 = v46 * v44
        v47 = v51 * math.cos(v52)
        local v53 = v46 * v44
        v48 = v51 * math.sin(v53)
    elseif v45 == 1 then
        v46 = 1
        local v54 = -v42 * v44
        v47 = math.exp(v54) / v46
        v48 = v47 * v44
    else
        local v55 = v45 - 1
        v46 = math.sqrt(v55)
        local v56 = (-v42 + v46) * v44
        local v57 = math.exp(v56) / (2 * v46)
        local v58 = (-v42 - v46) * v44
        local v59 = math.exp(v58) / (2 * v46)
        v47 = v57 + v59
        v48 = v57 - v59
    end
    local v60 = v46 * v47 + v42 * v48
    local v61 = 1 - (v46 * v47 + v42 * v48)
    local v62 = v48 / v43
    local v63 = -v43 * v48
    local v64 = v43 * v48
    local v65 = v46 * v47 - v42 * v48
    return v60 * v39 + v61 * v41 + v62 * v40, v63 * v39 + v64 * v41 + v65 * v40
end
return u1