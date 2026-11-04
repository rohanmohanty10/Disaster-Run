 

require("../types")
local u1 = require("../mod/logger")
local u2 = require("../mod/utility")
local u3 = require("../emitters")
local u4 = require("../pkg/Promise")
local u5 = table.concat({
    "Beam",
    "Trail",
    "Sound",
    "ParticleEmitter",
    (".%*"):format(u2.BEZIER_TAG),
    (".%*"):format(u2.LIGHTNING_TAG),
    "Model",
    "RayValue",
    "BasePart[$Enabled=true]",
    "#Rings > Part",
    "#Lines > Part",
    "#Debris > Part"
}, ",")
local u6 = {}
local u7 = nil
function u6.init(p8) --[[ Line: 39 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    u7 = p8
end
function u6.deinit() --[[ Line: 43 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    u7 = nil
end
function u6.emit(p9, ...) --[[ Line: 47 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u1
        [3] = u4
        [4] = u5
        [5] = u2
        [6] = u6
        [7] = u3
    --]]
    if not (u7 and u7.setup) then
        u1.error("effects service not initialized")
        return {
            ["Finished"] = u4.resolve()
        }
    end
    local u10 = {}
    local u11 = {}
    local function v31(p12, p13) --[[ Line: 61 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u2
            [3] = u6
            [4] = u3
            [5] = u10
            [6] = u11
            [7] = u7
        --]]
        local v14 = p12:QueryDescendants(u5)
        local v15 = #v14
        if v15 == 0 then
            return {}
        end
        local v16 = table.create(v15)
        local v17 = {}
        local v18 = {}
        v17[p12] = false
        v18[p12] = p13
        for _, u19 in v14 do
            local v20 = u19.Parent
            local v21 = {}
            while v18[v20] == nil do
                table.insert(v21, v20)
                v20 = v20.Parent
            end
            local v22 = v17[v20]
            local v23 = v18[v20]
            for v24 = #v21, 1, -1 do
                local v25 = v21[v24]
                v23 = v23 + 1
                v18[v25] = v23
                v22 = v22 or (u2.shouldSkipNested(v25) or v25:HasTag(u2.EMIT_EXCLUDE_TAG))
                v17[v25] = v22
            end
            if not v22 then
                local v26 = u2.createEmitPromise
                local v27 = u6
                local v28 = v18[u19.Parent]
                local function v30(p29) --[[ Line: 105 ]]
                    --[[
                    Upvalues:
                        [1] = u3
                        [2] = u19
                        [3] = u10
                        [4] = u11
                        [5] = u7
                    --]]
                    u3.dispatch(u19, p29, u10, u11, u7.caches.shared_part, 1)
                end
                table.insert(v16, v26(v27, u19, v28, v30))
            end
        end
        return v16
    end
    local v32 = {}
    for _, u33 in { ... } do
        if u33:IsA("BasePart") and (u33:GetAttribute("Enabled") and not u2.findFirstClassWithTag(u33, "Attachment", u2.SHOCKWAVE_TAG)) then
            if not u2.lock(u33) then
                local v34 = u33:FindFirstAncestorOfClass("Model")
                if not v34 or u2.isSpinModelStatic(v34) then
                    local u35 = coroutine.running()
                    local u36 = {
                        ["depth"] = p9,
                        ["effects"] = u6
                    }
                    if u3.screen(u33, u36) then
                        local v37 = v31(u33, p9 + 1)
                        if #v37 > 0 then
                            local v38 = u4.all(v37)
                            local function v39() --[[ Line: 146 ]]
                                --[[
                                Upvalues:
                                    [1] = u2
                                    [2] = u33
                                    [3] = u35
                                    [4] = u36
                                --]]
                                u2.unlock(u33, u35)
                                u2.cleanupScope(u36)
                            end
                            table.insert(v32, v38:finally(v39))
                        else
                            u2.unlock(u33, u35)
                            u2.cleanupScope(u36)
                        end
                    end
                end
            end
        else
            local v40 = u2.createEmitPromise
            local v41 = u6
            local function v43(p42) --[[ Line: 160 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u33
                    [3] = u10
                    [4] = u11
                    [5] = u7
                --]]
                u3.dispatch(u33, p42, u10, u11, u7.caches.shared_part, 1)
            end
            table.insert(v32, v40(v41, u33, p9, v43))
            if not u2.shouldSkipNested(u33) then
                for _, v44 in v31(u33, p9 + 1) do
                    table.insert(v32, v44)
                end
            end
        end
    end
    return {
        ["Finished"] = u4.all(v32)
    }
end
function u6.prepareEmitFolder(p45, p46, p47) --[[ Line: 182 ]]
    local v48 = p45:FindFirstChild(p46)
    if not (v48 and v48:IsA("Folder")) then
        return nil
    end
    v48.Parent = nil
    table.insert(p47, v48)
    return v48
end
function u6.prepareEmitOnFinish(p49, p50) --[[ Line: 194 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    return u6.prepareEmitFolder(p49, "EmitOnFinish", p50)
end
function u6.emitNested(p51, p52) --[[ Line: 198 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u4
        [3] = u6
    --]]
    if not (u7 and u7.setup) then
        return {
            ["Finished"] = u4.resolve()
        }
    end
    local v53 = p51:GetChildren()
    return #v53 == 0 and {
        ["Finished"] = u4.resolve()
    } or u6.emit(p52, table.unpack(v53))
end
function u6.emitFromFolder(p54, p55, p56) --[[ Line: 212 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u6
    --]]
    if not p54 then
        return {
            ["Finished"] = u4.resolve()
        }
    end
    local v57 = p54:GetChildren()
    if #v57 == 0 then
        return {
            ["Finished"] = u4.resolve()
        }
    end
    for _, v58 in v57 do
        v58.Parent = p55
    end
    return u6.emit(p56, table.unpack(v57))
end
function u6.emitOnFinish(p59, p60, p61) --[[ Line: 230 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    return u6.emitFromFolder(p59, p60, p61)
end
return u6