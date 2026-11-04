 

local u1 = game:GetService("RunService")
local u2 = game:GetService("CollectionService")
local u3 = require("../mod/attributes")
require("../types")
local u4 = require("../mod/utility")
local u5 = require("../emitters")
return {
    ["init"] = function(p6, u7, u8) --[[ Name: init, Line 11 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u5
            [3] = u3
            [4] = u1
            [5] = u2
        --]]
        local u9 = {}
        local function v12(p10) --[[ Line: 14 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u4
            --]]
            local v11 = u9[p10]
            if v11 then
                u4.cleanupScope(v11)
            end
            u9[p10] = nil
        end
        local function u33(u13) --[[ Line: 24 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u9
                [3] = u33
                [4] = u4
                [5] = u3
                [6] = u1
                [7] = u8
                [8] = u7
            --]]
            local u14 = nil
            for _, v15 in u5.enabled_registry do
                if v15.check(u13) then
                    u14 = v15
                    break
                end
            end
            if u14 then
                local u16 = {}
                local v17 = {}
                table.insert(v17, u16)
                u9[u13] = v17
                local v18 = u13.AncestryChanged
                local function v21() --[[ Line: 48 ]]
                    --[[
                    Upvalues:
                        [1] = u13
                        [2] = u9
                        [3] = u33
                        [4] = u4
                    --]]
                    if u13:IsDescendantOf(workspace) or u13.Parent and u13.Parent:HasTag("AllowEmitting") then
                        if not u9[u13] then
                            u33(u13)
                            return
                        end
                    else
                        local v19 = u13
                        local v20 = u9[v19]
                        if v20 then
                            u4.cleanupScope(v20)
                        end
                        u9[v19] = nil
                    end
                end
                table.insert(v17, v18:Connect(v21))
                if not u13:IsDescendantOf(workspace) then
                    local v22
                    if u13.Parent then
                        v22 = not u13.Parent:HasTag("AllowEmitting")
                    else
                        v22 = false
                    end
                    if v22 then
                        return
                    end
                end
                local function v31(p23) --[[ Line: 63 ]]
                    --[[
                    Upvalues:
                        [1] = u3
                        [2] = u13
                        [3] = u16
                        [4] = u1
                        [5] = u8
                        [6] = u14
                        [7] = u7
                        [8] = u4
                    --]]
                    if p23 == nil then
                        p23 = u3.get(u13, "Enabled", true)
                    end
                    if p23 then
                        local u24 = 0
                        local v25 = u16
                        local v26 = u1.RenderStepped
                        local function v30() --[[ Line: 73 ]]
                            --[[
                            Upvalues:
                                [1] = u3
                                [2] = u13
                                [3] = u24
                                [4] = u8
                                [5] = u14
                                [6] = u7
                                [7] = u4
                            --]]
                            local v27 = u3.get(u13, "Rate", 5)
                            local v28 = u3.getState(u13, "SpeedOverride", 1)
                            if v28 == 0 then
                                return
                            elseif os.clock() - u24 > 1 / v27 / v28 then
                                u24 = os.clock()
                                local v29 = {
                                    ["depth"] = 0,
                                    ["effects"] = u8
                                }
                                u14.emit(u13, v29, u7)
                                u4.cleanupScope(v29)
                            end
                        end
                        table.insert(v25, v26:Connect(v30))
                    else
                        u4.cleanupScope(u16)
                    end
                end
                local v32 = u3.hook
                table.insert(v17, v32(u13, "Enabled", v31))
                v31()
            end
        end
        for _, v34 in u2:GetTagged(u4.ENABLED_VFX_TAG) do
            u33(v34)
        end
        u2:GetInstanceAddedSignal(u4.ENABLED_VFX_TAG):Connect(u33)
        u2:GetInstanceRemovedSignal(u4.ENABLED_VFX_TAG):Connect(v12)
        local function v36() --[[ Line: 113 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u4
            --]]
            for _, v35 in u9 do
                u4.cleanupScope(v35)
            end
        end
        table.insert(p6, v36)
    end
}