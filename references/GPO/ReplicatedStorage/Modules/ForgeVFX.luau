 

local u1 = game:GetService("RunService")
local u2 = game:GetService("CollectionService")
local u3 = game:GetService("ReplicatedStorage")
local u4 = require("@self/mod/logger")
local u5 = require("@self/mod/utility")
local u6 = require("@self/mod/attributes")
local u7 = require("@self/effects/sound")
local u8 = require("@self/effects/bezier")
local u9 = require("@self/effects/lightning")
local u10 = require("@self/effects/camera_shake")
local u11 = require("@self/effects/shockwave_ring")
local u12 = require("@self/effects/shockwave_line")
local u13 = require("@self/effects/shockwave_debris")
local u14 = require("@self/services/caches")
local u15 = require("@self/services/effects")
local u16 = require("@self/services/texture_loader")
local u17 = require("@self/services/enabled_effects")
local u18 = u5.PLUGIN_CONTEXT
local u19 = u5.SERVER_CONTEXT
local u24 = {
    ["scope"] = {},
    ["setup"] = false,
    ["init"] = function(_) --[[ Name: init, Line 117 ]]
        --[[
        Upvalues:
            [1] = u24
            [2] = u19
            [3] = u5
            [4] = u4
            [5] = u1
            [6] = u18
            [7] = u14
            [8] = u15
            [9] = u16
            [10] = u17
            [11] = u7
            [12] = u10
            [13] = u8
            [14] = u9
            [15] = u11
            [16] = u12
            [17] = u13
        --]]
        if u24.setup then
            return
        else
            if u19 then
                task.spawn(function() --[[ Line: 123 ]]
                    --[[
                    Upvalues:
                        [1] = u5
                        [2] = u4
                    --]]
                    local v20 = 0
                    while true do
                        v20 = v20 + 1
                        local v21, v22 = pcall(u5.setCollisionGroups, u5.COLLISION_GROUPS)
                        if not v21 then
                            task.wait(v20)
                        end
                        if v21 or v20 >= 5 then
                            if not v21 then
                                u4.warn((("couldn\'t register necessary collision groups after %* tries with the last error being: %*"):format(v20, v22)))
                            end
                            return
                        end
                    end
                end)
            end
            u24.setup = true
            if not u1:IsServer() or u18 then
                u24.caches = u14.init(u24.scope)
                shared.vfx = u24
                u15.init(u24)
                u16.init(u24.scope)
                u17.init(u24.scope, u24.caches.shared_part, u15)
                u7.init()
                u10.init()
                u8.init(u24.caches.shared_part)
                u9.init(u24.caches.shared_part)
                u11.init(u24.caches.shared_part)
                u12.init(u24.caches.shared_part)
                u13.init(u24.caches.shared_part)
            end
        end
    end,
    ["deinit"] = function() --[[ Name: deinit, Line 177 ]]
        --[[
        Upvalues:
            [1] = u24
            [2] = u1
            [3] = u18
            [4] = u5
            [5] = u15
            [6] = u7
            [7] = u8
            [8] = u9
            [9] = u10
            [10] = u11
            [11] = u12
            [12] = u13
            [13] = u2
        --]]
        if u24.setup then
            u24.setup = false
            shared.vfx = nil
            if not u1:IsServer() or u18 then
                u5.cleanupScope(u24.scope)
                u15.deinit()
                u7.deinit()
                u8.deinit()
                u9.deinit()
                u10.deinit()
                u11.deinit()
                u12.deinit()
                u13.deinit()
                for _, v23 in u2:GetTagged(u5.CLEANUP_TAG) do
                    v23:Destroy()
                end
            end
        else
            return
        end
    end
}
local function u26(_, p25, ...) --[[ Line: 209 ]]
    --[[
    Upvalues:
        [1] = u24
        [2] = u4
        [3] = u15
    --]]
    if not u24.setup then
        u4.error("not initialized")
    end
    return u15.emit(p25, ...)
end
function u24.emit(p27, ...) --[[ Line: 217 ]]
    --[[
    Upvalues:
        [1] = u26
    --]]
    if typeof(p27) == "number" then
        return u26(p27, 0, ...)
    else
        return u26(1, 0, p27, ...)
    end
end
function u24.emitWithDepth(p28, ...) --[[ Line: 225 ]]
    --[[
    Upvalues:
        [1] = u26
    --]]
    return u26(1, p28, ...)
end
function u24.cacheAttributes(p29) --[[ Line: 229 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u4
        [3] = u3
        [4] = u6
    --]]
    if u5.SERVER_CONTEXT then
        u4.error("attributes can only be cached in a client-side context")
    end
    if not p29:IsDescendantOf(u3) then
        u4.error("attributes can only be cached for VFX inside ReplicatedStorage")
    end
    for _, v30 in p29:GetDescendants() do
        u6.cache(v30)
    end
end
function u24.restoreAttributes(p31) --[[ Line: 243 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u4
        [3] = u6
    --]]
    if u5.SERVER_CONTEXT then
        u4.error("attributes can only be restored in a client-side context")
    end
    for _, v32 in p31:GetDescendants() do
        u6.restore(v32)
    end
end
local function u35(p33, p34) --[[ Line: 253 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    if p33:IsA("ParticleEmitter") or p33:IsA("Beam") then
        p33.Enabled = p34
        return
    elseif u6.isCached(p33) then
        u6.trigger(p33, "Enabled", p34)
    else
        p33:SetAttribute("Enabled", p34)
    end
end
function u24.enable(p36) --[[ Line: 266 ]]
    --[[
    Upvalues:
        [1] = u35
    --]]
    u35(p36, true)
    for _, v37 in p36:GetDescendants() do
        u35(v37, true)
    end
end
function u24.disable(p38) --[[ Line: 274 ]]
    --[[
    Upvalues:
        [1] = u35
    --]]
    u35(p38, false)
    for _, v39 in p38:GetDescendants() do
        u35(v39, false)
    end
end
u24.retime = require("@self/mod/retime").batch
u24.resize = require("@self/mod/resize").batch
u24.recolor = require("@self/mod/recolor")
return u24