 

local u1 = game:GetService("RunService")
local u2 = require("../mod/attributes")
local u3 = require("../mod/tween")
require("../types")
local u4 = require("../mod/utility")
local u5 = require("../mod/common/flipbook")
local u6 = require("../mod/color/Oklab")
local u7 = require("../pkg/Promise")
local u8 = Random.new()
return {
    ["emit"] = function(u9, u10, p11, p12, p13) --[[ Name: emit, Line 17 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u8
            [3] = u4
            [4] = u3
            [5] = u1
            [6] = u6
            [7] = u5
            [8] = u7
        --]]
        local v14 = u9:FindFirstChild("Start")
        local v15 = u9:FindFirstChild("End")
        if v14 and (v15 and (v14:IsA("BasePart") and (v15:IsA("BasePart") and (not u9:GetAttribute("Enabled") or p13)))) then
            local v16 = u2.get(u9, "Duration", 1, true)
            local v17 = u2.getRange(u9, "EffectDuration", NumberRange.new(v16, v16), NumberRange.new(0, (1 / 0)))
            local v18 = u8:NextNumber(v17.Min, v17.Max)
            local v19 = u2.get(u9, "EmitDelay", 0)
            local v20 = u2.get(u9, "DestroyDelay", 0)
            local v21 = u2.get(u9, "EmitDuration", 0)
            local v22 = u2.get(u9, "Flipbook", false, true)
            local u23 = u2.get(u9, "FlipbookFadeOffset", 0, true)
            local v24 = (v22 or not v14:FindFirstChildOfClass("Decal")) and "Mesh_" or "Decal_"
            local v25 = u9:GetAttribute("StartTransparency")
            if v25 ~= nil then
                u9:SetAttribute(v24 .. "StartTransparency", v25)
                u9:SetAttribute("StartTransparency", nil)
            end
            local v26 = u9:GetAttribute("EndTransparency")
            if v26 ~= nil then
                u9:SetAttribute(v24 .. "EndTransparency", v26)
                u9:SetAttribute("EndTransparency", nil)
            end
            local v27 = u9:GetAttribute("Enabled") ~= nil and u9:HasTag(u4.ENABLED_VFX_TAG)
            if v27 then
                v27 = v18 > 0
            end
            local u28 = u2.get(u9, "Decal_StartTransparency", 0, true)
            local u29 = u2.get(u9, "Decal_EndTransparency", 1, true)
            local v30 = 0
            local v31
            if v14 then
                v31 = v14:FindFirstChildOfClass("Decal")
            else
                v31 = v14
            end
            local v32 = v31 and 1 or v30
            local v33 = u2.get(u9, "Mesh_StartTransparency", v32, true)
            local v34 = u2.get(u9, "Mesh_EndTransparency", v32, true)
            local u35 = u2.get(u9, "SyncPosition", false)
            local u36 = u2.get(u9, "Speed_Start", 1)
            local u37 = u2.get(u9, "Speed_End", 1)
            local u38 = u2.get(u9, "Part_Transparency_Start", v33)
            local u39 = u2.get(u9, "Part_Transparency_End", v34)
            local v40 = u2.get(u9, "SpreadAngle", Vector3.new(0, 0, 0))
            local v41 = u2.getRange(u9, "Part_RotSpeed_Start", NumberRange.new(0, 0))
            local v42 = u2.getRange(u9, "Part_RotSpeed_End", NumberRange.new(0, 0))
            local u43 = u2.get(u9, "RotAroundOrigin", false)
            local v44 = u2.get(u9, "MinInitRot", Vector3.new(0, 0, 0))
            local v45 = u2.get(u9, "MaxInitRot", Vector3.new(0, 0, 0))
            local u46 = u8:NextNumber(v41.Min, v41.Max)
            local u47 = u8:NextNumber(v42.Min, v42.Max)
            local v48 = u8:NextNumber(v44.x, v45.x)
            local v49 = u8:NextNumber(v44.y, v45.y)
            local v50 = u8
            local v51 = v44.z
            local v52 = v45.z
            local u53 = vector.create(v48, v49, v50:NextNumber(v51, v52)) * u4.DEG_TO_RAD
            task.wait(v19)
            if v27 and not p13 then
                u2.trigger(u9, "Enabled", true)
                if u36 ~= u37 then
                    u2.setState(u9, "SpeedTweening", true)
                    local v54 = u3.fromParams
                    local v55 = u2.get(u9, "Speed_Curve", u4.default_bezier)
                    local v56 = u2.get(u9, "Speed_Duration", 0.1)
                    local function v59(p57, p58) --[[ Line: 132 ]]
                        --[[
                        Upvalues:
                            [1] = u2
                            [2] = u9
                            [3] = u4
                            [4] = u36
                            [5] = u37
                        --]]
                        u2.setState(u9, "SpeedOverride", u4.lerp(u36, u37, p57))
                        return p58
                    end
                    local function v60() --[[ Line: 137 ]]
                        --[[
                        Upvalues:
                            [1] = u2
                            [2] = u9
                        --]]
                        u2.setState(u9, "SpeedTweening", nil)
                    end
                    table.insert(p11, v54(v55, v56, v59, nil, v60))
                end
                task.wait(v21)
                u2.trigger(u9, "Enabled", false)
                u2.clearState(u9)
            else
                local u61 = u9:FindFirstAncestorOfClass("Attachment") or v14
                local u62
                if typeof(u10) == "table" then
                    u62 = u10._getReal() or u10
                else
                    u62 = u10
                end
                local u63 = u4.getTransformedOriginExtents(u61)
                local u64 = v14.CFrame:ToObjectSpace(v15.CFrame)
                local u65 = u36
                local u66 = u46
                local u67 = CFrame.fromOrientation(u53.x, u53.y, u53.z)
                local u68 = CFrame.identity
                local v69 = CFrame.fromOrientation
                local v70 = u8:NextNumber(-v40.x, v40.x)
                local v71 = math.rad(v70)
                local v72 = u8:NextNumber(-v40.y, v40.y)
                local u73 = v69(v71, math.rad(v72), 0)
                local function v78(p74) --[[ Line: 170 ]]
                    --[[
                    Upvalues:
                        [1] = u35
                        [2] = u4
                        [3] = u61
                        [4] = u63
                        [5] = u53
                        [6] = u66
                        [7] = u67
                        [8] = u43
                        [9] = u73
                        [10] = u68
                        [11] = u10
                    --]]
                    local v75 = u35 and u4.getTransformedOriginExtents(u61) or u63
                    local v76 = u53:Sign() * u66 * p74
                    u67 = u67 * CFrame.fromOrientation(v76.x, v76.y, v76.z)
                    local v77
                    if u43 then
                        v77 = v75 * u73 * u67 * u68
                    else
                        v77 = v75 * u73 * u68 * u67
                    end
                    u10.CFrame = v77 * u67
                end
                v78(0)
                local u79 = u4.getRandomId()
                u1:BindToRenderStep(u79, u4.RENDER_PRIORITY + p11.depth, v78)
                local function v80() --[[ Line: 196 ]]
                    --[[
                    Upvalues:
                        [1] = u1
                        [2] = u79
                    --]]
                    u1:UnbindFromRenderStep(u79)
                end
                table.insert(p11, v80)
                local v81 = {}
                local v82 = p11.effects.prepareEmitOnFinish(u10, p11)
                local v83 = p11.effects.emitNested(u10, p11.depth + 1).Finished
                table.insert(v81, v83)
                local u84
                if u36 == u37 or u2.getState(u9, "SpeedOverride", nil) then
                    u84 = nil
                else
                    u84 = u3.fromParams(u2.get(u9, "Speed_Curve", u4.default_bezier), u2.get(u9, "Speed_Duration", 0.1), function(p85, p86) --[[ Line: 214 ]]
                        --[[
                        Upvalues:
                            [1] = u65
                            [2] = u4
                            [3] = u36
                            [4] = u37
                        --]]
                        u65 = u4.lerp(u36, u37, p85)
                        return p86
                    end)
                    table.insert(p11, u84)
                end
                if u64 ~= CFrame.identity then
                    local v87 = u3.fromParams
                    local v88 = u2.get(u9, "Part_CFrame_Curve", u4.default_bezier)
                    local function v91(p89, p90) --[[ Line: 226 ]]
                        --[[
                        Upvalues:
                            [1] = u68
                            [2] = u64
                            [3] = u2
                            [4] = u9
                            [5] = u65
                        --]]
                        u68 = CFrame.identity:Lerp(u64, p89)
                        return p90 * u2.getState(u9, "SpeedOverride", u65)
                    end
                    table.insert(p11, v87(v88, v18, v91, u84))
                end
                if u46 ~= u47 then
                    local v92 = u3.fromParams
                    local v93 = u2.get(u9, "Part_RotSpeed_Curve", u4.default_bezier)
                    local function v96(p94, p95) --[[ Line: 239 ]]
                        --[[
                        Upvalues:
                            [1] = u66
                            [2] = u4
                            [3] = u46
                            [4] = u47
                            [5] = u2
                            [6] = u9
                            [7] = u65
                        --]]
                        u66 = u4.lerp(u46, u47, p94)
                        return p95 * u2.getState(u9, "SpeedOverride", u65)
                    end
                    table.insert(p11, v92(v93, v18, v96, u84))
                end
                if u38 == u39 then
                    u10.Transparency = u38
                else
                    local v97 = u3.fromParams
                    local v98 = u2.get(u9, "Part_Transparency_Curve", u4.default_bezier)
                    local function v101(p99, p100) --[[ Line: 254 ]]
                        --[[
                        Upvalues:
                            [1] = u10
                            [2] = u4
                            [3] = u38
                            [4] = u39
                            [5] = u2
                            [6] = u9
                            [7] = u65
                        --]]
                        u10.Transparency = u4.lerp(u38, u39, p99)
                        return p100 * u2.getState(u9, "SpeedOverride", u65)
                    end
                    table.insert(p11, v97(v98, v18, v101, u84))
                end
                local u102 = v14.Size * p12
                local u103 = v15.Size * p12
                if u102 == u103 then
                    u10.Size = u102
                else
                    local u104 = -1
                    local v105 = u3.fromParams
                    local v106 = u2.get(u9, "Part_Size_Curve", u4.default_bezier)
                    local function v111(p107, p108) --[[ Line: 272 ]]
                        --[[
                        Upvalues:
                            [1] = u2
                            [2] = u9
                            [3] = u65
                            [4] = u104
                            [5] = u10
                            [6] = u102
                            [7] = u103
                        --]]
                        local v109 = u2.getState(u9, "SpeedOverride", u65)
                        local v110 = p107 - u104
                        if math.abs(v110) < 0.005 then
                            return p108 * v109
                        end
                        u104 = p107
                        u10.Size = u102:Lerp(u103, p107)
                        return p108 * v109
                    end
                    table.insert(p11, v105(v106, v18, v111, u84))
                end
                local v112 = v14:FindFirstChildOfClass("SpecialMesh")
                local v113 = v15:FindFirstChildOfClass("SpecialMesh")
                local u114 = u10:FindFirstChildOfClass("SpecialMesh")
                if u114 then
                    if v112 and v113 then
                        local u115 = v112.Scale * p12
                        local u116 = v113.Scale * p12
                        if u115 ~= u116 then
                            local v117 = u3.fromParams
                            local v118 = u2.get(u9, "Mesh_Scale_Curve", u4.default_bezier)
                            local function v121(p119, p120) --[[ Line: 305 ]]
                                --[[
                                Upvalues:
                                    [1] = u114
                                    [2] = u4
                                    [3] = u115
                                    [4] = u116
                                    [5] = u2
                                    [6] = u9
                                    [7] = u65
                                --]]
                                u114.Scale = u4.lerp(u115, u116, p119)
                                return p120 * u2.getState(u9, "SpeedOverride", u65)
                            end
                            table.insert(p11, v117(v118, v18, v121, u84))
                        end
                    else
                        u114.Parent = nil
                        table.insert(p11, function() --[[ Line: 316 ]]
                            --[[
                            Upvalues:
                                [1] = u114
                                [2] = u62
                            --]]
                            u114.Parent = u62
                        end)
                    end
                end
                local u122, v123, v124 = u4.getMeshDecals(u9, u10)
                local v125 = 0
                if v22 then
                    table.sort(u122, function(p126, p127) --[[ Line: 327 ]]
                        local v128 = p126.Name:match("%d+") or 0
                        local v129 = p127.Name:match("%d+") or 0
                        return tonumber(v128) < tonumber(v129)
                    end)
                    local u130 = Instance.new("Decal")
                    u130.Parent = u62
                    table.insert(p11, u130)
                    if u23 > 0 and u28 ~= u29 then
                        local v131 = u3.fromParams
                        local v132 = u4.default_bezier
                        local v133 = v18 + u23
                        local function v136(p134, p135) --[[ Line: 343 ]]
                            --[[
                            Upvalues:
                                [1] = u130
                                [2] = u4
                                [3] = u28
                                [4] = u29
                                [5] = u2
                                [6] = u9
                                [7] = u65
                            --]]
                            u130.Transparency = u4.lerp(u28, u29, p134)
                            return p135 * u2.getState(u9, "SpeedOverride", u65)
                        end
                        table.insert(p11, v131(v132, v133, v136, u84))
                    end
                    local v137 = u3.fromParams
                    local v138 = u4.default_bezier
                    local function v144(p139, p140) --[[ Line: 353 ]]
                        --[[
                        Upvalues:
                            [1] = u122
                            [2] = u130
                            [3] = u23
                            [4] = u4
                            [5] = u28
                            [6] = u29
                            [7] = u2
                            [8] = u9
                            [9] = u65
                        --]]
                        local v141 = #u122 * p139
                        local v142 = math.round(v141)
                        local v143 = u122[math.max(v142, 1)]
                        u130.Texture = v143.Texture
                        u130.Color3 = v143.Color3
                        u130.ZIndex = v143.ZIndex
                        if u23 == 0 then
                            u130.Transparency = u4.lerp(u28, u29, p139)
                            u130.ZIndex = v143.ZIndex
                        end
                        return p140 * u2.getState(u9, "SpeedOverride", u65)
                    end
                    table.insert(p11, v137(v138, v18, v144, u84))
                else
                    for _, u145 in u122 do
                        local u146 = v124[u145]
                        local u147 = u2.get(u145, "Transparency_Start", u28)
                        local u148 = u2.get(u145, "Transparency_End", u29)
                        if u147 == u148 then
                            u145.Transparency = u147
                        else
                            local v149 = u3.fromParams
                            local v150 = u2.get(u145, "Transparency_Curve", u4.default_bezier)
                            local function v153(p151, p152) --[[ Line: 384 ]]
                                --[[
                                Upvalues:
                                    [1] = u145
                                    [2] = u4
                                    [3] = u147
                                    [4] = u148
                                    [5] = u2
                                    [6] = u9
                                    [7] = u65
                                --]]
                                u145.Transparency = u4.lerp(u147, u148, p151)
                                return p152 * u2.getState(u9, "SpeedOverride", u65)
                            end
                            table.insert(p11, v149(v150, v18, v153, u84))
                        end
                        if u145.Color3 ~= u146.Color3 then
                            local v154 = u3.fromParams
                            local v155 = u2.get(u145, "Color_Curve", u4.default_bezier)
                            local function v160(p156, p157) --[[ Line: 398 ]]
                                --[[
                                Upvalues:
                                    [1] = u6
                                    [2] = u145
                                    [3] = u146
                                    [4] = u145
                                    [5] = u2
                                    [6] = u9
                                    [7] = u65
                                --]]
                                local v158 = u6.fromSRGB(u145.Color3)
                                local v159 = u6.fromSRGB(u146.Color3)
                                u145.Color3 = u6.toSRGB(v158:Lerp(v159, p156), true)
                                return p157 * u2.getState(u9, "SpeedOverride", u65)
                            end
                            table.insert(p11, v154(v155, v18, v160, u84))
                        end
                        local v161 = v123[u145]
                        if v161 then
                            local v163 = {
                                ["ref"] = u145,
                                ["frames"] = v161,
                                ["speedTween"] = u84,
                                ["effectDuration"] = v18,
                                ["curve"] = u2.get(u145, "Flipbook_Change_Curve", u4.linear_bezier),
                                ["duration"] = u2.get(u145, "Flipbook_Change_Duration", v18),
                                ["getSpeed"] = function() --[[ Name: getSpeed, Line 421 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u2
                                        [2] = u9
                                        [3] = u65
                                    --]]
                                    return u2.getState(u9, "SpeedOverride", u65)
                                end,
                                ["setTexture"] = function(p162) --[[ Name: setTexture, Line 425 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u145
                                    --]]
                                    u145.Texture = p162
                                end
                            }
                            local v164 = u5.getChangeDuration(v163)
                            if v125 < v164 then
                                v125 = v164
                            end
                            local v165 = u3.fromParams
                            local v166 = v163.curve
                            local v167 = u5.createUpdateCallback(v163)
                            table.insert(p11, v165(v166, v164, v167, u84))
                        end
                    end
                end
                u3.timer(math.max(v18, v125) + u23 + v20, function(p168, p169) --[[ Line: 446 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u9
                        [3] = u65
                        [4] = u84
                    --]]
                    local v170 = u2.getState(u9, "SpeedOverride", u65)
                    u65 = v170
                    if v170 > 0 then
                        ::l2::
                        return p168 * v170
                    else
                        if p169 > 0 then
                            local v171
                            if u84 then
                                v171 = u84.Connected
                            else
                                v171 = u2.getState(u9, "SpeedTweening", false)
                            end
                            if v171 then
                                goto l2
                            end
                        end
                        return nil
                    end
                end, u84, p11)
                u7.all(v81):await()
                p11.effects.emitOnFinish(v82, u62, p11.depth + 1).Finished:await()
            end
        else
            return
        end
    end
}