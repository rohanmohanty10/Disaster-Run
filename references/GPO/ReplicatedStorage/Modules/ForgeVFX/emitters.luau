 

local u1 = require("./effects/beam")
local u2 = require("./effects/spin")
local u3 = require("./effects/mesh")
local u4 = require("./effects/sound")
local u5 = require("./effects/bezier")
local u6 = require("./effects/screen")
local u7 = require("./effects/particle")
local u8 = require("./effects/lightning")
local u9 = require("./effects/camera_shake")
local u10 = require("./effects/tweener")
local u11 = require("./effects/randomizer")
local u12 = require("./effects/shockwave_ring")
local u13 = require("./effects/shockwave_line")
local u14 = require("./effects/shockwave_debris")
local u15 = require("./mod/attributes")
require("./types")
local u16 = require("./mod/utility")
local u17 = require("./pkg/Promise")
local u18 = {}
local function u25(p19, p20) --[[ Line: 24 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u11
    --]]
    local v21 = p19:QueryDescendants((("> RayValue.%*"):format(u16.PROPERTY_RANDOMIZER_TAG)))
    local v22 = p19:QueryDescendants((("> RayValue.%*"):format(u16.ATTRIBUTE_RANDOMIZER_TAG)))
    if p19:IsA("RayValue") then
        if p19:HasTag(u16.PROPERTY_RANDOMIZER_TAG) then
            table.insert(v21, p19)
        elseif p19:HasTag(u16.ATTRIBUTE_RANDOMIZER_TAG) then
            table.insert(v22, p19)
        end
    end
    for _, v23 in v21 do
        u16.try("failed to emit property randomizer with error: %s", u11.emit, v23, p20, false)
    end
    for _, v24 in v22 do
        u16.try("failed to emit attribute randomizer with error: %s", u11.emit, v24, p20, true)
    end
end
function u18.particle(p26, p27, u28, p29, p30) --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u15
        [2] = u16
        [3] = u7
    --]]
    local v31 = u15.get(p26, "EmitCount", u16.PLUGIN_CONTEXT and 1 or nil)
    local v32 = u15.get(p26, "EmitDuration", 0, true)
    if v31 and (v31 > 0 or v32 > 0) then
        if p26:IsDescendantOf(workspace) then
            u16.try("failed to emit particle with error: %s", u7.emit, p26, p26, p27, p30)
            return
        else
            local v33, u34 = u16.cloneParticleAncestry(p26, p29)
            if v33 then
                local v35 = p26:Clone()
                v35.Archivable = false
                v35.Parent = v33
                if u28[u34] then
                    u28[u34] = u28[u34] + 1
                else
                    u34.Parent = workspace.Terrain
                    u28[u34] = 1
                end
                table.insert(p27, function() --[[ Line: 78 ]]
                    --[[
                    Upvalues:
                        [1] = u28
                        [2] = u34
                    --]]
                    local v36 = u28
                    local v37 = u34
                    v36[v37] = v36[v37] - 1
                    if u28[u34] <= 0 then
                        u34:Destroy()
                    end
                end)
                u16.try("failed to emit particle with error: %s", u7.emit, p26, v35, p27, p30)
            end
        end
    else
        return
    end
end
function u18.beam(p38, p39, p40) --[[ Line: 92 ]]
    --[[
    Upvalues:
        [1] = u15
        [2] = u16
        [3] = u1
    --]]
    local v41 = p38.Attachment0
    local v42 = p38.Attachment1
    if v41 and v42 then
        local v43 = p38:Clone()
        v43.Archivable = false
        v43.Parent = workspace.Terrain
        local v44 = NumberRange.new(1, 1)
        if u15.get(p38, "Length_Scale_Start", v44, true) ~= v44 or u15.get(p38, "Length_Scale_End", v44, true) ~= v44 then
            local v45 = v41:Clone()
            local v46 = v42:Clone()
            table.insert(p39, v45)
            table.insert(p39, v46)
            v45.Name = "_ForgeTempAttachment"
            v46.Name = "_ForgeTempAttachment"
            v45:AddTag(u16.EMIT_EXCLUDE_TAG)
            v46:AddTag(u16.EMIT_EXCLUDE_TAG)
            v43.Attachment0 = v45
            v43.Attachment1 = v46
            v45.Parent = v41.Parent
            v46.Parent = v42.Parent
        end
        table.insert(p39, v43)
        u16.try("failed to emit beam with error: %s", u1.emit, p38, v43, p39, p40)
    end
end
function u18.trail(p47) --[[ Line: 133 ]]
    p47.Enabled = true
end
function u18.bezier(p48, p49, p50) --[[ Line: 137 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u5
    --]]
    local v51 = p48:FindFirstChildOfClass("Part")
    if v51 then
        if not p50 and p48:GetAttribute("Enabled") then
            p48:SetAttribute("Enabled", false)
        end
        local v52 = v51:Clone()
        v52.Locked = true
        table.insert(p49, v52)
        u16.try("failed to emit bezier with error: %s", u5.emit, p48, v52, p49, p50)
    end
end
function u18.lightning(p53, p54, p55) --[[ Line: 156 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u8
    --]]
    local v56 = p53:FindFirstChildOfClass("Part")
    if v56 then
        if not p55 and p53:GetAttribute("Enabled") then
            p53:SetAttribute("Enabled", false)
        end
        local v57 = v56:Clone()
        v57.Locked = true
        table.insert(p54, v57)
        u16.try("failed to emit lightning with error: %s", u8.emit, p53, v57, p54, p55)
    end
end
function u18.mesh(u58, u59, u60, u61, u62) --[[ Line: 175 ]]
    --[[
    Upvalues:
        [1] = u15
        [2] = u17
        [3] = u16
        [4] = u3
    --]]
    local u63 = u58:FindFirstChild("Start")
    if u63 then
        if not u62 and u58:GetAttribute("Enabled") then
            u58:SetAttribute("Enabled", false)
        end
        local v64 = {}
        for _ = 1, u15.get(u58, "EmitCount", 1) do
            local v65 = u17.new
            local function v67(p66) --[[ Line: 197 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u3
                    [3] = u58
                    [4] = u63
                    [5] = u59
                    [6] = u60
                    [7] = u61
                    [8] = u62
                --]]
                u16.try("failed to emit mesh with error: %s", u3.emit, u58, u16.assembleMeshVFX(u63, u59, u60), u59, u61, u62)
                p66()
            end
            table.insert(v64, v65(v67))
        end
        u17.all(v64):await()
    end
end
function u18.spin(p68, p69) --[[ Line: 216 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u2
    --]]
    if not u16.lock(p68) then
        u16.try("failed to emit spinning model with error: %s", u2.emit, p68, p69)
        u16.unlock(p68)
    end
end
function u18.camera_shake(p70, p71) --[[ Line: 225 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u9
    --]]
    u16.try("failed to emit camera shake with error: %s", u9.emit, p70, p71)
end
function u18.property_tweener(p72, p73) --[[ Line: 229 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u10
    --]]
    if p72.Parent and not u16.lock(p72) then
        u16.try("failed to emit property tweener with error: %s", u10.emit, p72, p73, false)
        u16.unlock(p72)
    end
end
function u18.attribute_tweener(p74, p75) --[[ Line: 238 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u10
    --]]
    if p74.Parent and not u16.lock(p74) then
        u16.try("failed to emit attribute tweener with error: %s", u10.emit, p74.Parent, p74, p75, true)
        u16.unlock(p74)
    end
end
function u18.screen(p76, p77) --[[ Line: 247 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u6
    --]]
    local v78, v79 = u16.try("failed to emit screen effect with error: %s", u6.emit, p76, p77)
    if v78 then
        return v79
    else
        return false
    end
end
function u18.shockwave_ring(p80, p81, p82) --[[ Line: 253 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u12
    --]]
    u16.try("failed to emit shockwave ring with error: %s", u12.emit, p80, p81, p82)
end
function u18.shockwave_debris(p83, p84, p85) --[[ Line: 257 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u14
    --]]
    u16.try("failed to emit shockwave debris with error: %s", u14.emit, p83, p84, p85)
end
function u18.shockwave_line(p86, p87, p88) --[[ Line: 261 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u13
    --]]
    u16.try("failed to emit shockwave line with error: %s", u13.emit, p86, p87, p88)
end
function u18.sound(p89, p90) --[[ Line: 265 ]]
    --[[
    Upvalues:
        [1] = u15
        [2] = u16
        [3] = u4
    --]]
    if u15.get(p89, "EmitCount", 1, true) > 0 then
        u16.try("failed to emit sound with error: %s", u4.emit, p89, p90)
    end
end
function u18.dispatch(p91, p92, p93, p94, p95, p96) --[[ Line: 276 ]]
    --[[
    Upvalues:
        [1] = u25
        [2] = u18
        [3] = u16
    --]]
    local v97 = p91.ClassName
    u25(p91, p92)
    if v97 == "ParticleEmitter" then
        u18.particle(p91, p92, p93, p94, p96)
        return
    elseif v97 == "Beam" then
        u18.beam(p91, p92, p96)
        return
    elseif v97 == "Trail" then
        u18.trail(p91)
        return
    elseif v97 == "Sound" then
        u18.sound(p91, p92)
        return
    elseif v97 == "RayValue" then
        if p91:HasTag(u16.SCREENSHAKE_TAG) then
            u18.camera_shake(p91, p92)
            return
        elseif p91:HasTag(u16.ATTRIBUTE_TWEENER_TAG) then
            u18.attribute_tweener(p91, p92)
        elseif not p91:HasTag(u16.PROPERTY_RANDOMIZER_TAG) then
            if p91:HasTag(u16.ATTRIBUTE_RANDOMIZER_TAG) then
                return
            end
            u18.property_tweener(p91, p92)
        end
    elseif p91:HasTag(u16.BEZIER_TAG) then
        u18.bezier(p91, p92)
        return
    elseif p91:HasTag(u16.LIGHTNING_TAG) then
        u18.lightning(p91, p92)
        return
    elseif v97 == "Model" then
        if u16.isMeshVFX(p91) then
            u18.mesh(p91, p92, p95, p96)
        else
            u18.spin(p91, p92)
        end
    else
        local v98 = v97 == "Part" and u16.findFirstClassWithTag(p91, "Attachment", u16.SHOCKWAVE_TAG)
        if v98 then
            local v99 = p91.Parent and (p91.Parent.Name or "") or ""
            if v99 == "Rings" then
                u18.shockwave_ring(v98, p91, p92)
                return
            end
            if v99 == "Debris" then
                u18.shockwave_debris(v98, p91, p92)
                return
            end
            if v99 == "Lines" then
                u18.shockwave_line(v98, p91, p92)
            end
        end
        return
    end
end
local v110 = {
    ["mesh"] = {
        ["check"] = function(p100) --[[ Name: check, Line 360 ]]
            --[[
            Upvalues:
                [1] = u16
            --]]
            return u16.isMeshVFX(p100)
        end,
        ["emit"] = function(p101, p102, p103) --[[ Name: emit, Line 363 ]]
            --[[
            Upvalues:
                [1] = u18
            --]]
            u18.mesh(p101, p102, p103, 1, true)
        end
    },
    ["bezier"] = {
        ["check"] = function(p104) --[[ Name: check, Line 369 ]]
            --[[
            Upvalues:
                [1] = u16
            --]]
            return p104:HasTag(u16.BEZIER_TAG)
        end,
        ["emit"] = function(p105, p106, _) --[[ Name: emit, Line 372 ]]
            --[[
            Upvalues:
                [1] = u18
            --]]
            u18.bezier(p105, p106, true)
        end
    },
    ["lightning"] = {
        ["check"] = function(p107) --[[ Name: check, Line 378 ]]
            --[[
            Upvalues:
                [1] = u16
            --]]
            return p107:HasTag(u16.LIGHTNING_TAG)
        end,
        ["emit"] = function(p108, p109, _) --[[ Name: emit, Line 381 ]]
            --[[
            Upvalues:
                [1] = u18
            --]]
            u18.lightning(p108, p109, true)
        end
    }
}
u18.enabled_registry = v110
return u18