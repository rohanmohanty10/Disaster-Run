 

local u1 = game:GetService("RunService")
local u2 = game:GetService("CollectionService")
local u3 = require("./mod/tween")
local u4 = require("./mod/utility")
local u5 = require("./mod/color/Oklab")
local u6 = require("./obj/Promise")
local u7 = Random.new()
return {
    ["emit"] = function(u8, u9, p10, p11, p12) --[[ Name: emit, Line 14 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u7
            [3] = u3
            [4] = u1
            [5] = u5
            [6] = u2
            [7] = u6
        --]]
        local v13 = u8:FindFirstChild("Start")
        local v14 = u8:FindFirstChild("End")
        if not v13 or (not v14 or (not v13:IsA("BasePart") or (not v14:IsA("BasePart") or u8:GetAttribute("Enabled") and not p12))) then
            return
        end
        local v15 = u4.getAttribute(u8, "Duration", 1, true)
        local v16 = u4.getRangeAttribute(u8, "EffectDuration", NumberRange.new(v15, v15), NumberRange.new(0, (1 / 0)))
        local v17 = u7:NextNumber(v16.Min, v16.Max)
        local v18 = u4.getAttribute(u8, "EmitDelay", 0)
        local v19 = u4.getAttribute(u8, "EmitDuration", 0, true)
        local v20 = u4.getAttribute(u8, "Flipbook", false, true)
        local u21 = u4.getAttribute(u8, "FlipbookFadeOffset", 0, true)
        local v22 = (v20 or not v13:FindFirstChildOfClass("Decal")) and "Mesh_" or "Decal_"
        local v23 = u8:GetAttribute("StartTransparency")
        if v23 ~= nil then
            u8:SetAttribute(v22 .. "StartTransparency", v23)
            u8:SetAttribute("StartTransparency", nil)
        end
        local v24 = u8:GetAttribute("EndTransparency")
        if v24 ~= nil then
            u8:SetAttribute(v22 .. "EndTransparency", v24)
            u8:SetAttribute("EndTransparency", nil)
        end
        local v25 = u8:GetAttribute("Enabled") ~= nil and u8:HasTag(u4.ENABLED_VFX_TAG)
        if v25 then
            v25 = v17 > 0
        end
        local u26 = u4.getAttribute(u8, "Decal_StartTransparency", 0, true)
        local u27 = u4.getAttribute(u8, "Decal_EndTransparency", 1, true)
        local v28 = 0
        local v29
        if v13 then
            v29 = v13:FindFirstChildOfClass("Decal")
        else
            v29 = v13
        end
        local v30 = v29 and 1 or v28
        local v31 = u4.getAttribute(u8, "Mesh_StartTransparency", v30, true)
        local v32 = u4.getAttribute(u8, "Mesh_EndTransparency", v30, true)
        local u33 = u4.getAttribute(u8, "SyncPosition", false)
        local u34 = u4.getAttribute(u8, "Speed_Start", 1)
        local u35 = u4.getAttribute(u8, "Speed_End", 1)
        local u36 = u4.getAttribute(u8, "Part_Transparency_Start", v31)
        local u37 = u4.getAttribute(u8, "Part_Transparency_End", v32)
        local v38 = u4.getAttribute(u8, "SpreadAngle", Vector3.new(0, 0, 0))
        local v39 = u4.getRangeAttribute(u8, "Part_RotSpeed_Start", NumberRange.new(0, 0))
        local v40 = u4.getRangeAttribute(u8, "Part_RotSpeed_End", NumberRange.new(0, 0))
        local u41 = u4.getAttribute(u8, "RotAroundOrigin", false)
        local v42 = u4.getAttribute(u8, "MinInitRot", Vector3.new(0, 0, 0))
        local v43 = u4.getAttribute(u8, "MaxInitRot", Vector3.new(0, 0, 0))
        local u44 = u7:NextNumber(v39.Min, v39.Max)
        local u45 = u7:NextNumber(v40.Min, v40.Max)
        local v46 = u7:NextNumber(v42.x, v43.x)
        local v47 = u7:NextNumber(v42.y, v43.y)
        local v48 = u7
        local v49 = v42.z
        local v50 = v43.z
        local u51 = vector.create(v46, v47, v48:NextNumber(v49, v50)) * u4.DEG_TO_RAD
        task.wait(v18)
        if v25 and not p12 then
            u8:SetAttribute("Enabled", true)
            if u34 ~= u35 then
                u8:SetAttribute("SpeedTweening", true)
                local v52 = u3.fromParams
                local v53 = u4.getAttribute(u8, "Speed_Curve", u4.default_bezier)
                local v54 = u4.getAttribute(u8, "Speed_Duration", 0.1)
                local function v57(p55, p56) --[[ Line: 128 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                        [2] = u4
                        [3] = u34
                        [4] = u35
                    --]]
                    u8:SetAttribute("SpeedOverride", u4.lerp(u34, u35, p55))
                    return p56
                end
                table.insert(p10, v52(v53, v54, v57, nil, function() --[[ Line: 133 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                    --]]
                    u8:SetAttribute("SpeedTweening", nil)
                end))
            end
            task.wait(v19)
            u8:SetAttribute("Enabled", false)
            u8:SetAttribute("SpeedOverride", nil)
            return
        end
        local u58 = u8:FindFirstAncestorOfClass("Attachment") or v13
        local u59
        if typeof(u9) == "table" then
            u59 = u9._getReal() or u9
        else
            u59 = u9
        end
        local u60 = u58:IsA("Attachment") and u58.WorldCFrame or u58.CFrame
        local u61 = v13.CFrame:ToObjectSpace(v14.CFrame)
        local u62 = u34
        local u63 = u44
        local u64 = CFrame.fromOrientation(u51.x, u51.y, u51.z)
        local u65 = CFrame.identity
        local v66 = CFrame.fromOrientation
        local v67 = u7:NextNumber(-v38.x, v38.x)
        local v68 = math.rad(v67)
        local v69 = u7:NextNumber(-v38.y, v38.y)
        local u70 = v66(v68, math.rad(v69), 0)
        local function v75(p71) --[[ Line: 170 ]]
            --[[
            Upvalues:
                [1] = u33
                [2] = u58
                [3] = u60
                [4] = u51
                [5] = u63
                [6] = u64
                [7] = u41
                [8] = u70
                [9] = u65
                [10] = u9
            --]]
            local v72 = u33 and (u58:IsA("Attachment") and u58.WorldCFrame or u58.CFrame) or u60
            local v73 = u51:Sign() * u63 * p71
            u64 = u64 * CFrame.fromOrientation(v73.x, v73.y, v73.z)
            local v74
            if u41 then
                v74 = v72 * u70 * u64 * u65
            else
                v74 = v72 * u70 * u65 * u64
            end
            u9.CFrame = v74 * u64
        end
        v75(0)
        local u76 = u4.getRanomId()
        u1:BindToRenderStep(u76, u4.RENDER_PRIORITY + p10.depth, v75)
        local function v77() --[[ Line: 196 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u76
            --]]
            u1:UnbindFromRenderStep(u76)
        end
        table.insert(p10, v77)
        local v78 = {}
        local v79 = u9:FindFirstChild("EmitOnFinish")
        if v79 then
            v79.Parent = nil
        end
        if shared.vfx and #u9:GetChildren() ~= 0 then
            local v80 = shared.vfx.emit(u9).Finished
            table.insert(v78, v80)
        end
        local u81
        if u34 == u35 or u8:GetAttribute("SpeedOverride") then
            u81 = nil
        else
            u81 = u3.fromParams(u4.getAttribute(u8, "Speed_Curve", u4.default_bezier), u4.getAttribute(u8, "Speed_Duration", 0.1), function(p82, p83) --[[ Line: 220 ]]
                --[[
                Upvalues:
                    [1] = u62
                    [2] = u4
                    [3] = u34
                    [4] = u35
                --]]
                u62 = u4.lerp(u34, u35, p82)
                return p83
            end)
            table.insert(p10, u81)
        end
        if u61 ~= CFrame.identity then
            local v84 = u3.fromParams
            local v85 = u4.getAttribute(u8, "Part_CFrame_Curve", u4.default_bezier)
            table.insert(p10, v84(v85, v17, function(p86, p87) --[[ Line: 235 ]]
                --[[
                Upvalues:
                    [1] = u65
                    [2] = u61
                    [3] = u8
                    [4] = u62
                --]]
                u65 = CFrame.identity:Lerp(u61, p86)
                return p87 * (u8:GetAttribute("SpeedOverride") or u62)
            end, u81))
        end
        if u44 ~= u45 then
            local v88 = u3.fromParams
            local v89 = u4.getAttribute(u8, "Part_RotSpeed_Curve", u4.default_bezier)
            local function v92(p90, p91) --[[ Line: 250 ]]
                --[[
                Upvalues:
                    [1] = u63
                    [2] = u4
                    [3] = u44
                    [4] = u45
                    [5] = u8
                    [6] = u62
                --]]
                u63 = u4.lerp(u44, u45, p90)
                return p91 * (u8:GetAttribute("SpeedOverride") or u62)
            end
            table.insert(p10, v88(v89, v17, v92, u81))
        end
        if u36 == u37 then
            u9.Transparency = u36
        else
            local v93 = u3.fromParams
            local v94 = u4.getAttribute(u8, "Part_Transparency_Curve", u4.default_bezier)
            local function v97(p95, p96) --[[ Line: 265 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u4
                    [3] = u36
                    [4] = u37
                    [5] = u8
                    [6] = u62
                --]]
                u9.Transparency = u4.lerp(u36, u37, p95)
                return p96 * (u8:GetAttribute("SpeedOverride") or u62)
            end
            table.insert(p10, v93(v94, v17, v97, u81))
        end
        local u98 = v13.Size * p11
        local u99 = v14.Size * p11
        if u98 == u99 then
            u9.Size = u98
        else
            local v100 = u3.fromParams
            local v101 = u4.getAttribute(u8, "Part_Size_Curve", u4.default_bezier)
            table.insert(p10, v100(v101, v17, function(p102, p103) --[[ Line: 284 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u98
                    [3] = u99
                    [4] = u8
                    [5] = u62
                --]]
                u9.Size = u98:Lerp(u99, p102)
                return p103 * (u8:GetAttribute("SpeedOverride") or u62)
            end, u81))
        end
        local v104 = v13:FindFirstChildOfClass("SpecialMesh")
        local v105 = v14:FindFirstChildOfClass("SpecialMesh")
        local u106 = u9:FindFirstChildOfClass("SpecialMesh")
        if u106 then
            if v104 and v105 then
                local u107 = v104.Scale * p11
                local u108 = v105.Scale * p11
                if u107 ~= u108 then
                    local v109 = u3.fromParams
                    local v110 = u4.getAttribute(u8, "Mesh_Scale_Curve", u4.default_bezier)
                    local function v113(p111, p112) --[[ Line: 310 ]]
                        --[[
                        Upvalues:
                            [1] = u106
                            [2] = u4
                            [3] = u107
                            [4] = u108
                            [5] = u8
                            [6] = u62
                        --]]
                        u106.Scale = u4.lerp(u107, u108, p111)
                        return p112 * (u8:GetAttribute("SpeedOverride") or u62)
                    end
                    table.insert(p10, v109(v110, v17, v113, u81))
                end
            else
                u106.Parent = nil
                table.insert(p10, function() --[[ Line: 321 ]]
                    --[[
                    Upvalues:
                        [1] = u106
                        [2] = u59
                    --]]
                    u106.Parent = u59
                end)
            end
        end
        local u114, v115, v116 = u4.getMeshDecals(u8, u9)
        local v117 = 0
        if v20 then
            table.sort(u114, function(p118, p119) --[[ Line: 332 ]]
                local v120 = p118.Name:match("%d+") or 0
                local v121 = p119.Name:match("%d+") or 0
                return tonumber(v120) < tonumber(v121)
            end)
            local u122 = Instance.new("Decal")
            u122.Parent = u59
            table.insert(p10, u122)
            if u21 > 0 and u26 ~= u27 then
                local v123 = u3.fromParams
                local v124 = u4.default_bezier
                local v125 = v17 + u21
                local function v128(p126, p127) --[[ Line: 348 ]]
                    --[[
                    Upvalues:
                        [1] = u122
                        [2] = u4
                        [3] = u26
                        [4] = u27
                        [5] = u8
                        [6] = u62
                    --]]
                    u122.Transparency = u4.lerp(u26, u27, p126)
                    return p127 * (u8:GetAttribute("SpeedOverride") or u62)
                end
                table.insert(p10, v123(v124, v125, v128, u81))
            end
            local v129 = u3.fromParams
            local v130 = u4.default_bezier
            local function v136(p131, p132) --[[ Line: 358 ]]
                --[[
                Upvalues:
                    [1] = u114
                    [2] = u122
                    [3] = u21
                    [4] = u4
                    [5] = u26
                    [6] = u27
                    [7] = u8
                    [8] = u62
                --]]
                local v133 = #u114 * p131
                local v134 = math.round(v133)
                local v135 = u114[math.max(v134, 1)]
                u122.Texture = v135.Texture
                u122.Color3 = v135.Color3
                u122.ZIndex = v135.ZIndex
                if u21 == 0 then
                    u122.Transparency = u4.lerp(u26, u27, p131)
                    u122.ZIndex = v135.ZIndex
                end
                return p132 * (u8:GetAttribute("SpeedOverride") or u62)
            end
            table.insert(p10, v129(v130, v17, v136, u81))
        else
            for _, u137 in u114 do
                local u138 = v116[u137]
                local u139 = u4.getAttribute(u137, "Transparency_Start", u26)
                local u140 = u4.getAttribute(u137, "Transparency_End", u27)
                if u139 == u140 then
                    u137.Transparency = u139
                else
                    local v141 = u3.fromParams
                    local v142 = u4.getAttribute(u137, "Transparency_Curve", u4.default_bezier)
                    local function v145(p143, p144) --[[ Line: 389 ]]
                        --[[
                        Upvalues:
                            [1] = u137
                            [2] = u4
                            [3] = u139
                            [4] = u140
                            [5] = u8
                            [6] = u62
                        --]]
                        u137.Transparency = u4.lerp(u139, u140, p143)
                        return p144 * (u8:GetAttribute("SpeedOverride") or u62)
                    end
                    table.insert(p10, v141(v142, v17, v145, u81))
                end
                if u137.Color3 ~= u138.Color3 then
                    local v146 = u3.fromParams
                    local v147 = u4.getAttribute(u137, "Color_Curve", u4.default_bezier)
                    local function v152(p148, p149) --[[ Line: 406 ]]
                        --[[
                        Upvalues:
                            [1] = u5
                            [2] = u137
                            [3] = u138
                            [4] = u137
                            [5] = u8
                            [6] = u62
                        --]]
                        local v150 = u5.fromSRGB(u137.Color3)
                        local v151 = u5.fromSRGB(u138.Color3)
                        u137.Color3 = u5.toSRGB(v150:Lerp(v151, p148), true)
                        return p149 * (u8:GetAttribute("SpeedOverride") or u62)
                    end
                    table.insert(p10, v146(v147, v17, v152, u81))
                end
                local u153 = v115[u137]
                if u153 then
                    local v154 = u4.getAttribute(u137, "Flipbook_Change_Duration", v17)
                    if u4.getAttribute(u137, "SyncDuration", false) then
                        v154 = v17
                    end
                    if v117 < v154 then
                        v117 = v154
                    end
                    local u155 = false
                    if u1:IsStudio() then
                        for _, v156 in u2:GetTags(u137) do
                            if v156:match("^_local_flipbook_") then
                                u155 = true
                                break
                            end
                        end
                    end
                    local v157 = u3.fromParams
                    local v158 = u4.getAttribute(u137, "Flipbook_Change_Curve", u4.linear_bezier)
                    local function v163(p159, p160) --[[ Line: 448 ]]
                        --[[
                        Upvalues:
                            [1] = u153
                            [2] = u137
                            [3] = u155
                            [4] = u8
                            [5] = u62
                        --]]
                        local v161 = #u153 * p159
                        local v162 = math.round(v161)
                        u137.Texture = ("%*%*"):format(u155 and "rbxtemp://" or "rbxassetid://", u153[math.max(v162, 1)])
                        return p160 * (u8:GetAttribute("SpeedOverride") or u62)
                    end
                    table.insert(p10, v157(v158, v154, v163, u81))
                end
            end
        end
        u3.timer(math.max(v17, v117) + u21, function(p164, p165) --[[ Line: 461 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u62
                [3] = u81
            --]]
            local v166 = u8:GetAttribute("SpeedOverride") or u62
            u62 = v166
            if v166 > 0 then
                ::l4::
                return p164 * v166
            else
                if p165 > 0 then
                    local v167
                    if u81 then
                        v167 = u81.Connected
                    else
                        v167 = u8:GetAttribute("SpeedTweening")
                    end
                    if v167 then
                        goto l4
                    end
                end
                return nil
            end
        end, u81, p10)
        u6.all(v78):await()
        if v79 then
            v79 = v79:GetChildren()
        end
        if v79 and #v79 ~= 0 then
            for _, v168 in v79 do
                v168.Parent = u59
            end
            shared.vfx.emit(table.unpack(v79)).Finished:await()
        end
    end
}