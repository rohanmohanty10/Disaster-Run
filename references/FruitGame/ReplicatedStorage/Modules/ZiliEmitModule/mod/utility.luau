 

local u1 = game:GetService("RunService")
local u2 = game:GetService("PhysicsService")
local u3 = require("./logger")
local u4 = {
    ["DEG_TO_RAD"] = 0.017453292519943295,
    ["BEZIER_TAG"] = "BezierParticle",
    ["SHOCKWAVE_TAG"] = "Shockwave",
    ["SCREENSHAKE_TAG"] = "CameraShake",
    ["ENABLED_VFX_TAG"] = "ConstantVFX",
    ["TEXTURE_LOAD_TAG"] = "LoadVFXTextures",
    ["RENDER_PRIORITY"] = Enum.RenderPriority.Camera.Value + 1
}
local v5 = {
    ["StudioSelectable"] = {},
    ["ForgeDebris"] = {
        ["ForgeDebris"] = false
    },
    ["ForgeMouseIgnore"] = {
        ["StudioSelectable"] = false
    }
}
u4.COLLISION_GROUPS = v5
u4.COPY_SPECIALMESH_PROPERTIES = {
    "MeshId",
    "MeshType",
    "Offset",
    "Scale",
    "TextureId",
    "VertexColor"
}
u4.COPY_PART_PROPERTIES = {
    "CastShadow",
    "Color",
    "Material",
    "MaterialVariant",
    "Reflectance",
    "Shape",
    "FrontSurface",
    "BackSurface",
    "LeftSurface",
    "RightSurface",
    "TopSurface",
    "BottomSurface"
}
u4.COPY_EXTENDED_PART_PROPERTIES = {
    "Size",
    "Transparency",
    "CanCollide",
    "CanQuery",
    "CanTouch",
    "CollisionGroup"
}
local u6 = setmetatable({}, {
    ["__mode"] = "k"
})
function u4.lock(p7) --[[ Line: 75 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    if u6[p7] then
        return true
    end
    u6[p7] = coroutine.running()
    return false
end
function u4.unlock(p8, p9) --[[ Line: 85 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u3
    --]]
    local v10 = u6[p8]
    if coroutine.running() ~= v10 and p9 ~= v10 then
        u3.error("attempt to unlock an instance owned by a different thread")
    end
    u6[p8] = nil
end
function u4.setCollisionGroups(p11) --[[ Line: 95 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local v12 = {}
    for v13, v14 in p11 do
        u2:RegisterCollisionGroup(v13)
        if not v13:match("Studio") or u1:IsStudio() then
            v12[v13] = v14
        end
    end
    for v15, v16 in v12 do
        for v17, v18 in v16 do
            if not v17:match("Studio") or u1:IsStudio() then
                u2:CollisionGroupSetCollidable(v15, v17, v18)
            end
        end
    end
end
local u19 = 0
function u4.getRanomId() --[[ Line: 119 ]]
    --[[
    Upvalues:
        [1] = u19
    --]]
    u19 = u19 + 1
    return u19
end
function u4.copyProperties(p20, p21, p22) --[[ Line: 124 ]]
    for _, v23 in p22 do
        p21[v23] = p20[v23]
    end
end
function u4.lerp(p24, p25, p26) --[[ Line: 130 ]]
    return p24 + (p25 - p24) * p26
end
function u4.try(u27, p28, ...) --[[ Line: 134 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v30 = { xpcall(p28, function(p29) --[[ Line: 135 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u27
            --]]
            u3.warn(string.format(u27, p29))
        end, ...) }
    return v30[1], table.unpack(v30, 2)
end
function u4.reboundfn(u31, u32) --[[ Line: 142 ]]
    local u33 = nil
    return function(...) --[[ Line: 145 ]]
        --[[
        Upvalues:
            [1] = u33
            [2] = u31
            [3] = u32
        --]]
        if u33 then
            task.cancel(u33)
        end
        local u34 = { ... }
        u33 = task.delay(u31, function() --[[ Line: 152 ]]
            --[[
            Upvalues:
                [1] = u33
                [2] = u32
                [3] = u34
            --]]
            u33 = nil
            local v35 = u34
            u32(table.unpack(v35))
        end)
    end
end
function u4.randomUnitVector(p36, p37, p38) --[[ Line: 159 ]]
    local v39 = p38 or Random.new()
    local v40 = v39:NextNumber(p36.X, p37.X)
    local v41 = v39:NextNumber(p36.Y, p37.Y)
    local v42 = p36.Z
    local v43 = p37.Z
    return Vector3.new(v40, v41, v39:NextNumber(v42, v43))
end
function u4.getImpulseForce(p44, p45, p46) --[[ Line: 167 ]]
    local v47 = (p45 - p44) / p46
    local v48 = workspace.Gravity * p46 * 0.5
    return v47 + Vector3.new(0, v48, 0)
end
function u4.isMeshVFX(p49) --[[ Line: 171 ]]
    local v50 = p49 and (p49:IsA("Model") and p49:FindFirstChild("Start") and (p49.Start:IsA("BasePart") and p49:FindFirstChild("End")))
    if v50 then
        v50 = p49.End:IsA("BasePart")
    end
    return v50
end
function u4.cleanupScope(p51) --[[ Line: 180 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    for _, v52 in p51 do
        local v53 = typeof(v52)
        if v53 == "Instance" then
            v52:Destroy()
        elseif v53 == "RBXScriptConnection" then
            v52:Disconnect()
        elseif v53 == "thread" then
            if coroutine.status(v52) ~= "dead" then
                task.cancel(v52)
            end
        elseif v53 == "function" then
            task.spawn(v52)
        elseif v53 == "table" then
            u4.cleanupScope(v52)
        end
    end
    table.clear(p51)
end
function u4.protectParent(p54, u55) --[[ Line: 202 ]]
    local v56 = u55.AncestryChanged
    table.insert(p54, v56:Connect(function(_, _) --[[ Line: 205 ]]
        --[[
        Upvalues:
            [1] = u55
        --]]
        if u55.Parent ~= workspace.Terrain then
            u55.Parent = workspace.Terrain
        end
    end))
end
function u4.findFirstClassWithTag(p57, p58, p59) --[[ Line: 215 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    if p57 and p57.Parent ~= game then
        if p57.ClassName == p58 and p57:HasTag(p59) then
            return p57
        else
            return u4.findFirstClassWithTag(p57.Parent, p58, p59)
        end
    else
        return
    end
end
function u4.cloneParticleAncestry(u60, u61) --[[ Line: 227 ]]
    if u60:FindFirstAncestorWhichIsA("BasePart") or u60:FindFirstAncestorOfClass("Attachment") then
        local function u63(p62) --[[ Line: 232 ]]
            --[[
            Upvalues:
                [1] = u63
            --]]
            if p62.Parent and (p62.Parent:IsA("BasePart") or p62.Parent:IsA("Attachment")) then
                p62 = u63(p62.Parent)
            end
            return p62
        end
        local function u72(p64) --[[ Line: 242 ]]
            --[[
            Upvalues:
                [1] = u61
                [2] = u60
                [3] = u63
                [4] = u72
            --]]
            local v65 = u61[p64]
            if v65 then
                if p64 == u60 then
                    return v65, u61[p64.Parent]
                end
                local v66 = u61
                local v67 = p64.Parent
                if v67.Parent and (v67.Parent:IsA("BasePart") or v67.Parent:IsA("Attachment")) then
                    v67 = u63(v67.Parent)
                end
                return v65, v66[v67] or u61[p64]
            end
            local v68 = Instance.fromExisting(p64)
            v68.Archivable = false
            if v68:IsA("BasePart") then
                v68.Locked = true
            end
            if u61 then
                u61[p64] = v68
            end
            local v69
            if p64.Parent and (p64.Parent:IsA("BasePart") or p64.Parent:IsA("Attachment")) then
                local v70, v71 = u72(p64.Parent)
                v69 = v71 or v68
                if v70 then
                    v68.Parent = v70
                end
            else
                v69 = v68
            end
            return v68, v69
        end
        return u72(u60.Parent)
    end
end
function u4.getAttribute(p73, p74, p75, p76) --[[ Line: 280 ]]
    local v77 = p73:GetAttribute(p74)
    if v77 ~= nil and typeof(v77) == typeof(p75) then
        p75 = v77
    end
    if not p76 then
        p73:SetAttribute(p74, p75)
    end
    return p75
end
function u4.getRangeAttribute(p78, p79, p80, p81, p82) --[[ Line: 294 ]]
    local v83 = p78:GetAttribute(p79)
    if typeof(v83) ~= "NumberRange" then
        v83 = p80
    end
    if p81 then
        local v84 = NumberRange.new
        local v85 = v83.Min
        local v86 = p81.Min
        local v87 = p81.Max
        local v88 = math.clamp(v85, v86, v87)
        local v89 = v83.Max
        local v90 = p81.Min
        local v91 = p81.Max
        v83 = v84(v88, (math.clamp(v89, v90, v91)))
    end
    if not p82 then
        p78:SetAttribute(p79, v83)
    end
    return v83
end
function u4.getEnumAttribute(p92, p93, p94, p95, p96) --[[ Line: 322 ]]
    local v97 = p92:GetAttribute(p93)
    if v97 ~= nil and table.find(p95, v97) then
        p94 = v97
    end
    if not p96 then
        p92:SetAttribute(p93, p94)
    end
    return p94
end
function u4.getMeshDecals(p98, p99) --[[ Line: 336 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v100 = {}
    local v101 = {}
    local v102 = {}
    local function v106(p103) --[[ Line: 343 ]]
        local v104 = {}
        for _, v105 in p103 do
            if v105:IsA("Decal") then
                table.insert(v104, v105)
            end
        end
        return v104
    end
    if u4.getAttribute(p98, "Flipbook", false, true) then
        return v106(p99:GetChildren()), v101, v102
    end
    local v107 = p98:FindFirstChild("End")
    if v107 then
        for _, v108 in p99:GetChildren() do
            if v108:IsA("Decal") then
                local v109 = v107:FindFirstChild(v108.Name)
                if v109 and v109:IsA("Decal") then
                    table.insert(v100, v108)
                    v102[v108] = v109
                    local v110 = v108:GetChildren()
                    local v111 = 0
                    for v112 = 1, #v110 do
                        local v113 = v112 - v111
                        if not v110[v113]:IsA("Decal") then
                            table.remove(v110, v113)
                            v111 = v111 + 1
                        end
                    end
                    if #v110 ~= 0 then
                        table.sort(v110, function(p114, p115) --[[ Line: 399 ]]
                            local v116 = p114.Name
                            local v117 = tonumber(v116:match("%d+")) or 0
                            local v118 = p115.Name
                            return v117 < (tonumber(v118:match("%d+")) or 0)
                        end)
                        local v119 = {}
                        for _, v120 in v110 do
                            local v121 = v120.Texture
                            local v122 = tonumber(v121:match("%d+")) or 0
                            table.insert(v119, v122)
                            v120:Destroy()
                        end
                        local v123 = u4.serializeFlipbook(v119)
                        v108:SetAttribute("FlipbookEnabled", true)
                        v108:SetAttribute("FlipbookTextures", buffer.tostring(v123))
                    end
                    if v108:GetAttribute("FlipbookEnabled") then
                        v101[v108] = u4.deserializeFlipbook(v108:GetAttribute("FlipbookTextures"))
                    else
                        table.insert(v100, v108)
                    end
                end
            end
        end
    end
    return v100, v101, v102
end
function u4.getBezierPoints(p124, p125) --[[ Line: 428 ]]
    local v126 = p124:GetChildren()
    table.sort(v126, function(p127, p128) --[[ Line: 431 ]]
        local v129 = p127.Name
        local v130 = tonumber(v129)
        local v131 = p128.Name
        return v130 < tonumber(v131)
    end)
    local v132 = {}
    local v133 = {}
    local v134 = {}
    for v135, v136 in v126 do
        local v137 = v136:FindFirstChild("T0")
        local v138 = v136:FindFirstChild("T1")
        if v135 == 1 then
            local v139 = p124.WorldCFrame:PointToObjectSpace(v136.WorldPosition)
            local v140 = v139.X
            local v141 = v139.Y
            local v142 = v139.Z
            local v143 = vector.create(v140, v141, v142)
            table.insert(v132, v143)
            if p125 then
                v133[v136] = v143
                table.insert(v134, v136)
            end
        end
        if v135 ~= 1 then
            if v138 then
                local v144 = p124.WorldCFrame:PointToObjectSpace(v138.WorldPosition)
                local v145 = v144.X
                local v146 = v144.Y
                local v147 = v144.Z
                local v148 = vector.create(v145, v146, v147)
                table.insert(v132, v148)
                if p125 then
                    v133[v138] = v148
                    table.insert(v134, v138)
                end
            else
                local v149 = p124.WorldCFrame:PointToObjectSpace(v136.WorldPosition)
                local v150 = v149.X
                local v151 = v149.Y
                local v152 = v149.Z
                local v153 = vector.create(v150, v151, v152)
                table.insert(v132, v153)
                if p125 then
                    v133[v136] = v153
                    table.insert(v134, v136)
                end
            end
        end
        if v135 ~= 1 and v135 ~= #v126 then
            local v154 = p124.WorldCFrame:PointToObjectSpace(v136.WorldPosition)
            local v155 = v154.X
            local v156 = v154.Y
            local v157 = v154.Z
            local v158 = vector.create(v155, v156, v157)
            table.insert(v132, v158)
            if p125 then
                v133[v136] = v158
                table.insert(v134, v136)
            end
        end
        if v135 ~= #v126 then
            if v137 then
                local v159 = p124.WorldCFrame:PointToObjectSpace(v137.WorldPosition)
                local v160 = v159.X
                local v161 = v159.Y
                local v162 = v159.Z
                local v163 = vector.create(v160, v161, v162)
                table.insert(v132, v163)
                if p125 then
                    v133[v137] = v163
                    table.insert(v134, v137)
                end
            else
                local v164 = p124.WorldCFrame:PointToObjectSpace(v136.WorldPosition)
                local v165 = v164.X
                local v166 = v164.Y
                local v167 = v164.Z
                local v168 = vector.create(v165, v166, v167)
                table.insert(v132, v168)
                if p125 then
                    v133[v136] = v168
                    table.insert(v134, v136)
                end
            end
        end
        if v135 == #v126 then
            local v169 = p124.WorldCFrame:PointToObjectSpace(v136.WorldPosition)
            local v170 = v169.X
            local v171 = v169.Y
            local v172 = v169.Z
            local v173 = vector.create(v170, v171, v172)
            table.insert(v132, v173)
            if p125 then
                v133[v136] = v173
                table.insert(v134, v136)
            end
        end
    end
    return v132, v134, v133
end
function u4.scaleNumberSequence(p174, p175) --[[ Line: 491 ]]
    if p175 == 1 then
        return p174
    end
    local v176 = {}
    for _, v177 in p174.Keypoints do
        local v178, v179
        if typeof(p175) == "function" then
            v178, v179 = p175(v177.Value, v177.Envelope)
        else
            v178 = v177.Value * p175
            v179 = v177.Envelope * p175
        end
        local v180 = NumberSequenceKeypoint.new
        local v181 = v177.Time
        table.insert(v176, v180(v181, v178, v179))
    end
    return NumberSequence.new(v176)
end
function u4.serializePath(p182) --[[ Line: 516 ]]
    local v183 = buffer.create(#p182 * 4 * 6)
    local v184 = 0
    for v185, v186 in p182 do
        local v187 = v186.Position.X.Scale
        local v188 = v186.Position.Y.Scale
        if v185 ~= 1 then
            local v189 = v187 + v186.LeftTangent.X.Scale
            buffer.writef32(v183, v184, v189)
            local v190 = v184 + 4
            local v191 = v188 + v186.LeftTangent.Y.Scale
            buffer.writef32(v183, v190, v191)
            v184 = v184 + 8
        end
        buffer.writef32(v183, v184, v187)
        local v192 = v184 + 4
        buffer.writef32(v183, v192, v188)
        v184 = v184 + 8
        if v185 ~= #p182 then
            local v193 = v187 + v186.RightTangent.X.Scale
            buffer.writef32(v183, v184, v193)
            local v194 = v184 + 4
            local v195 = v188 + v186.RightTangent.Y.Scale
            buffer.writef32(v183, v194, v195)
            v184 = v184 + 8
        end
    end
    return v183
end
function u4.deserializePath(p196) --[[ Line: 549 ]]
    if typeof(p196) == "string" then
        p196 = buffer.fromstring(p196) or p196
    end
    local v197 = buffer.len(p196) / 24
    local v198 = {}
    for v199 = 0, v197 - 1 do
        local v200 = v199 * 4 * 6
        local v201 = buffer.readf32(p196, v200)
        local v202 = v200 + 4
        local v203 = buffer.readf32(p196, v202)
        local v204 = vector.create(v201, v203)
        table.insert(v198, v204)
        if v199 ~= v197 - 1 then
            local v205 = v200 + 8
            local v206 = buffer.readf32(p196, v205)
            local v207 = v200 + 12
            local v208 = buffer.readf32(p196, v207)
            local v209 = v200 + 16
            local v210 = buffer.readf32(p196, v209)
            local v211 = v200 + 20
            local v212 = buffer.readf32(p196, v211)
            local v213 = vector.create(v206, v208)
            table.insert(v198, v213)
            local v214 = vector.create(v210, v212)
            table.insert(v198, v214)
        end
    end
    return v198
end
function u4.serializeFlipbook(p215) --[[ Line: 579 ]]
    local v216 = buffer.create(#p215 * 8)
    for v217, v218 in p215 do
        local v219 = (v217 - 1) * 8
        buffer.writef64(v216, v219, v218)
    end
    return v216
end
function u4.deserializeFlipbook(p220) --[[ Line: 590 ]]
    if typeof(p220) == "string" then
        p220 = buffer.fromstring(p220) or p220
    end
    local v221 = {}
    for v222 = 0, buffer.len(p220) / 8 - 1 do
        local v223 = v222 * 8
        local v224 = buffer.readf64(p220, v223)
        table.insert(v221, v224)
    end
    return v221
end
u4.default_bezier = buffer.tostring(u4.serializePath({ Path2DControlPoint.new(UDim2.fromScale(0, 1), UDim2.new(), UDim2.fromScale(0.215, -0.61)), Path2DControlPoint.new(UDim2.fromScale(1, 0), UDim2.fromScale(-0.645, 0), UDim2.new()) }))
u4.linear_bezier = buffer.tostring(u4.serializePath({ Path2DControlPoint.new(UDim2.fromScale(0, 1)), Path2DControlPoint.new(UDim2.fromScale(1, 0)) }))
return u4