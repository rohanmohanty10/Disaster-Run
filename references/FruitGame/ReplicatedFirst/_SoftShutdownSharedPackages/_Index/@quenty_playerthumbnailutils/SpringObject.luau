 

local v1 = require(script.Parent.loader).load(script)
local u2 = game:GetService("RunService")
local u3 = v1("Spring")
local u4 = v1("Maid")
local u5 = v1("Signal")
local u6 = v1("StepUtils")
local u7 = v1("Observable")
local u8 = v1("SpringUtils")
local u9 = v1("Blend")
local u10 = v1("Rx")
local u11 = {
    ["ClassName"] = "SpringObject"
}
u11.__index = u11
function u11.new(p12, p13, p14) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
        [3] = u11
    --]]
    local v15 = {
        ["_maid"] = u4.new(),
        ["Changed"] = u5.new()
    }
    local v16 = u11
    local v17 = setmetatable(v15, v16)
    v17._maid:GiveTask(v17.Changed)
    if p12 then
        v17.Target = p12
    else
        v17:_getSpringForType(0)
    end
    if p13 then
        v17.Speed = p13
    end
    if p14 then
        v17.Damper = p14
    end
    return v17
end
function u11.isSpringObject(p18) --[[ Line: 64 ]]
    --[[
    Upvalues:
        [1] = u11
    --]]
    local v19
    if type(p18) == "table" then
        v19 = getmetatable(p18) == u11
    else
        v19 = false
    end
    return v19
end
function u11.ObserveRenderStepped(p20) --[[ Line: 72 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    return p20:ObserveOnSignal(u2.RenderStepped)
end
function u11.ObserveVelocityOnRenderStepped(p21) --[[ Line: 76 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    return p21:ObserveVelocityOnSignal(u2.RenderStepped)
end
function u11.ObserveVelocityOnSignal(u22, u23) --[[ Line: 80 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u4
        [3] = u6
        [4] = u8
    --]]
    return u7.new(function(u24) --[[ Line: 81 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u6
            [3] = u23
            [4] = u8
            [5] = u22
        --]]
        local v25 = u4.new()
        local v27, v28 = u6.bindToSignal(u23, function() --[[ Line: 84 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u22
                [3] = u24
            --]]
            local v26 = u8.animating(u22._currentSpring)
            if v26 then
                u24:Fire(u8.fromLinearIfNeeded(u22._currentSpring.Velocity))
                return v26
            else
                u24:Fire(u8.fromLinearIfNeeded(0 * u22._currentSpring.Velocity))
                return v26
            end
        end)
        v25:GiveTask(v28)
        v25:GiveTask(u22.Changed:Connect(v27))
        v27()
        return v25
    end)
end
function u11.ObserveOnSignal(u29, u30) --[[ Line: 107 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u4
        [3] = u6
        [4] = u8
    --]]
    return u7.new(function(u31) --[[ Line: 108 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u6
            [3] = u30
            [4] = u8
            [5] = u29
        --]]
        local v32 = u4.new()
        local v35, v36 = u6.bindToSignal(u30, function() --[[ Line: 111 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u29
                [3] = u31
            --]]
            local v33, v34 = u8.animating(u29._currentSpring)
            u31:Fire(u8.fromLinearIfNeeded(v34))
            return v33
        end)
        v32:GiveTask(v36)
        v32:GiveTask(u29.Changed:Connect(v35))
        v35()
        return v32
    end)
end
function u11.IsAnimating(p37) --[[ Line: 129 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    return u8.animating(p37._currentSpring)
end
function u11.Impulse(p38, p39) --[[ Line: 140 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    p38._currentSpring:Impulse(u8.toLinearIfNeeded(p39))
    p38.Changed:Fire()
end
function u11.TimeSkip(p40, p41) --[[ Line: 150 ]]
    local v42 = type(p41) == "number"
    assert(v42, "Bad delta")
    p40._currentSpring:TimeSkip(p41)
    p40.Changed:Fire()
end
function u11.__index(p43, p44) --[[ Line: 157 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u11
    --]]
    if p44 == "Value" or (p44 == "Position" or p44 == "p") then
        return u8.fromLinearIfNeeded(p43._currentSpring.Value)
    end
    if p44 == "Velocity" or p44 == "v" then
        return u8.fromLinearIfNeeded(p43._currentSpring.Velocity)
    end
    if p44 == "Target" or p44 == "t" then
        return u8.fromLinearIfNeeded(p43._currentSpring.Target)
    end
    if p44 == "Damper" or p44 == "d" then
        return p43._currentSpring.Damper
    end
    if p44 == "Speed" or p44 == "s" then
        return p43._currentSpring.Speed
    end
    if p44 == "Clock" then
        return p43._currentSpring.Clock
    end
    if u11[p44] then
        return u11[p44]
    end
    error(("%q is not a member of SpringObject"):format((tostring(p44))))
end
function u11.__newindex(u45, p46, p47) --[[ Line: 177 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u10
        [3] = u8
    --]]
    if p46 == "Value" or (p46 == "Position" or p46 == "p") then
        local v48 = u9.toPropertyObservable(p47) or u10.of(p47)
        u45._maid._valueSub = v48:Subscribe(function(p49) --[[ Line: 181 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u45
            --]]
            local v50 = u8.toLinearIfNeeded(p49)
            u45:_getSpringForType(v50).Value = v50
            u45.Changed:Fire()
        end)
        return
    elseif p46 == "Velocity" or p46 == "v" then
        local v51 = u9.toPropertyObservable(p47) or u10.of(p47)
        u45._maid._velocitySub = v51:Subscribe(function(p52) --[[ Line: 189 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u45
            --]]
            local v53 = u8.toLinearIfNeeded(p52)
            u45:_getSpringForType(0 * v53).Velocity = v53
            u45.Changed:Fire()
        end)
        return
    elseif p46 == "Target" or p46 == "t" then
        local v54 = u9.toPropertyObservable(p47) or u10.of(p47)
        u45._maid._targetSub = v54:Subscribe(function(p55) --[[ Line: 198 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u45
            --]]
            local v56 = u8.toLinearIfNeeded(p55)
            u45:_getSpringForType(v56).Target = v56
            u45.Changed:Fire()
        end)
        return
    elseif p46 == "Damper" or p46 == "d" then
        local v57 = u9.toNumberObservable(p47)
        local v58 = assert(v57, "Invalid damper")
        u45._maid._damperSub = v58:Subscribe(function(p59) --[[ Line: 207 ]]
            --[[
            Upvalues:
                [1] = u45
            --]]
            local v60 = type(p59) == "number"
            assert(v60, "Bad damper")
            u45._currentSpring.Damper = p59
            u45.Changed:Fire()
        end)
        return
    elseif p46 == "Speed" or p46 == "s" then
        local v61 = u9.toNumberObservable(p47)
        local v62 = assert(v61, "Invalid speed")
        u45._maid._speedSub = v62:Subscribe(function(p63) --[[ Line: 216 ]]
            --[[
            Upvalues:
                [1] = u45
            --]]
            local v64 = type(p63) == "number"
            assert(v64, "Bad damper")
            u45._currentSpring.Speed = p63
            u45.Changed:Fire()
        end)
        return
    elseif p46 == "Clock" then
        local v65 = type(p47) == "function"
        assert(v65, "Bad clock value")
        u45._currentSpring.Clock = p47
        u45.Changed:Fire()
    else
        error(("%q is not a member of SpringObject"):format((tostring(p46))))
    end
end
function u11._getSpringForType(p66, p67) --[[ Line: 231 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u8
    --]]
    if rawget(p66, "_currentSpring") == nil then
        local v68 = u3.new
        rawset(p66, "_currentSpring", v68(p67))
        return p66._currentSpring
    end
    local v69 = u8.fromLinearIfNeeded
    local v70 = p66._currentSpring.Value
    if typeof(v69(v70)) == typeof(p67) then
        return p66._currentSpring
    end
    local v71 = p66._currentSpring.d
    local v72 = p66._currentSpring.s
    p66._currentSpring = u3.new(p67)
    p66._currentSpring.Speed = v72
    p66._currentSpring.Damper = v71
    return p66._currentSpring
end
function u11.Destroy(p73) --[[ Line: 255 ]]
    p73._maid:DoCleaning()
    setmetatable(p73, nil)
end
return u11