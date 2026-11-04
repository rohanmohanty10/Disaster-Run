 

local u1 = game:GetService("RunService")
local u2 = game:GetService("PhysicsService")
local u3 = require("./attributes")
local u4 = require("./logger")
local u5 = require("../pkg/Promise")
local u6 = {}
local v7 = not script:FindFirstAncestorOfClass("Plugin") and u1:IsStudio()
if v7 then
    v7 = not u1:IsRunning()
end
u6.PLUGIN_CONTEXT = v7
u6.SERVER_CONTEXT = u1:IsServer() or u6.PLUGIN_CONTEXT
u6.DEG_TO_RAD = 0.017453292519943295
u6.BEZIER_TAG = "BezierParticle"
u6.LIGHTNING_TAG = "LightningBolt"
u6.SHOCKWAVE_TAG = "Shockwave"
u6.SCREENSHAKE_TAG = "CameraShake"
u6.PROPERTY_TWEENER_TAG = "PropertyTweener"
u6.PROPERTY_RANDOMIZER_TAG = "PropertyRandomizer"
u6.ATTRIBUTE_TWEENER_TAG = "AttributeTweener"
u6.ATTRIBUTE_RANDOMIZER_TAG = "AttributeRandomizer"
u6.ENABLED_VFX_TAG = "ConstantVFX"
u6.TEXTURE_LOAD_TAG = "LoadVFXTextures"
u6.CLEANUP_TAG = "__forge__cleanupOnExit"
u6.EMIT_EXCLUDE_TAG = "__forge_excludeFromEmit"
u6.RENDER_PRIORITY = Enum.RenderPriority.Camera.Value + 1
u6.COLLISION_GROUPS = {
    ["StudioSelectable"] = {},
    ["ForgeDebris"] = {
        ["ForgeDebris"] = false
    },
    ["ForgeMouseIgnore"] = {
        ["StudioSelectable"] = false
    }
}
u6.COPY_SPECIALMESH_PROPERTIES = {
    "MeshId",
    "MeshType",
    "Offset",
    "Scale",
    "TextureId",
    "VertexColor"
}
u6.COPY_PART_PROPERTIES = {
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
u6.COPY_EXTENDED_PART_PROPERTIES = {
    "Size",
    "Transparency",
    "CustomPhysicalProperties",
    "CanCollide",
    "CanQuery",
    "CanTouch",
    "CollisionGroup"
}
local u8 = setmetatable({}, {
    ["__mode"] = "k"
})
function u6.lock(p9) --[[ Line: 94 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    if u8[p9] then
        return true
    end
    u8[p9] = coroutine.running()
    return false
end
function u6.unlock(p10, p11) --[[ Line: 104 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u4
    --]]
    local v12 = u8[p10]
    if coroutine.running() ~= v12 and p11 ~= v12 then
        u4.error("attempt to unlock an instance owned by a different thread")
    end
    u8[p10] = nil
end
function u6.setCollisionGroups(p13) --[[ Line: 114 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local v14 = {}
    for v15, v16 in p13 do
        u2:RegisterCollisionGroup(v15)
        if not v15:match("Studio") or u1:IsStudio() then
            v14[v15] = v16
        end
    end
    for v17, v18 in v14 do
        for v19, v20 in v18 do
            if not v19:match("Studio") or u1:IsStudio() then
                u2:CollisionGroupSetCollidable(v17, v19, v20)
            end
        end
    end
end
local u21 = 0
function u6.getRandomId() --[[ Line: 138 ]]
    --[[
    Upvalues:
        [1] = u21
    --]]
    u21 = u21 + 1
    local v22 = u21
    return tostring(v22)
end
function u6.copyProperties(p23, p24, p25) --[[ Line: 143 ]]
    for _, v26 in p25 do
        p24[v26] = p23[v26]
    end
end
function u6.lerp(p27, p28, p29) --[[ Line: 149 ]]
    return p27 + (p28 - p27) * p29
end
function u6.try(u30, p31, ...) --[[ Line: 153 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v33 = { xpcall(p31, function(p32) --[[ Line: 154 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u30
            --]]
            u4.warn(string.format(u30, p32))
        end, ...) }
    return v33[1], table.unpack(v33, 2)
end
function u6.reboundfn(u34, u35) --[[ Line: 161 ]]
    local u36 = nil
    return function(...) --[[ Line: 164 ]]
        --[[
        Upvalues:
            [1] = u36
            [2] = u34
            [3] = u35
        --]]
        if u36 then
            task.cancel(u36)
        end
        local u37 = { ... }
        u36 = task.delay(u34, function() --[[ Line: 171 ]]
            --[[
            Upvalues:
                [1] = u36
                [2] = u35
                [3] = u37
            --]]
            u36 = nil
            local v38 = u37
            u35(table.unpack(v38))
        end)
    end
end
function u6.randomUnitVector(p39, p40, p41) --[[ Line: 178 ]]
    local v42 = p41 or Random.new()
    local v43 = v42:NextNumber(p39.X, p40.X)
    local v44 = v42:NextNumber(p39.Y, p40.Y)
    local v45 = p39.Z
    local v46 = p40.Z
    return Vector3.new(v43, v44, v42:NextNumber(v45, v46))
end
function u6.getImpulseForce(p47, p48, p49) --[[ Line: 183 ]]
    local v50 = (p48 - p47) / p49
    local v51 = workspace.Gravity * p49 * 0.5
    return v50 + Vector3.new(0, v51, 0)
end
function u6.isMeshVFX(p52) --[[ Line: 187 ]]
    local v53 = p52 and (p52:IsA("Model") and p52:FindFirstChild("Start") and (p52.Start:IsA("BasePart") and p52:FindFirstChild("End")))
    if v53 then
        v53 = p52.End:IsA("BasePart")
    end
    return v53
end
function u6.isSpinModelStatic(p54) --[[ Line: 196 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v55
    if u3.get(p54, "SpinRotation", Vector3.new(0, 0, 0), true) == Vector3.new(0, 0, 0) and (u3.get(p54, "Scale_Start", 1, true) == 1 and u3.get(p54, "Scale_End", 1, true) == 1) then
        v55 = u3.get(p54, "SyncPosition", false, true) == false
    else
        v55 = false
    end
    return v55
end
function u6.shouldSkipNested(p56) --[[ Line: 203 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local v57 = not p56:IsA("Beam") and (not (p56:HasTag(u6.BEZIER_TAG) or p56:HasTag(u6.LIGHTNING_TAG)) and (not u6.isMeshVFX(p56) and p56:IsA("BasePart")))
    if v57 then
        v57 = u6.findFirstClassWithTag(p56, "Attachment", u6.SHOCKWAVE_TAG) ~= nil
    end
    return v57
end
function u6.getTarget(p58) --[[ Line: 211 ]]
    local v59 = p58:FindFirstChildOfClass("ObjectValue")
    if v59 and v59.Value then
        return v59.Value
    end
    local v60 = p58.Parent
    if not v60 then
        return nil
    end
    while v60:IsA("Folder") do
        v60 = v60.Parent
        if not v60 then
            return nil
        end
    end
    return v60
end
function u6.createEmitPromise(u61, _, u62, u63) --[[ Line: 235 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
    --]]
    return u5.new(function(p64) --[[ Line: 236 ]]
        --[[
        Upvalues:
            [1] = u62
            [2] = u61
            [3] = u63
            [4] = u6
        --]]
        local v65 = {
            ["depth"] = u62,
            ["effects"] = u61
        }
        u63(v65)
        u6.cleanupScope(v65)
        p64()
    end)
end
function u6.cleanupScope(p66) --[[ Line: 249 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    for v67, v68 in p66 do
        if v67 ~= "depth" and v67 ~= "effects" then
            local v69 = typeof(v68)
            if v69 == "Instance" then
                v68:Destroy()
            elseif v69 == "RBXScriptConnection" then
                v68:Disconnect()
            elseif v69 == "thread" then
                if coroutine.status(v68) ~= "dead" then
                    task.cancel(v68)
                end
            elseif v69 == "function" then
                task.spawn(v68)
            elseif v69 == "table" then
                u6.cleanupScope(v68)
            end
        end
    end
    table.clear(p66)
end
function u6.protectParent(p70, u71) --[[ Line: 276 ]]
    local v72 = u71.AncestryChanged
    table.insert(p70, v72:Connect(function(_, _) --[[ Line: 279 ]]
        --[[
        Upvalues:
            [1] = u71
        --]]
        if u71.Parent ~= workspace.Terrain then
            u71.Parent = workspace.Terrain
        end
    end))
end
function u6.findFirstClassWithTag(p73, p74, p75) --[[ Line: 289 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    if p73 and p73.Parent ~= game then
        if p73.ClassName == p74 and p73:HasTag(p75) then
            return p73
        else
            return u6.findFirstClassWithTag(p73.Parent, p74, p75)
        end
    else
        return
    end
end
function u6.cloneParticleAncestry(u76, u77) --[[ Line: 301 ]]
    if u76:FindFirstAncestorWhichIsA("BasePart") or u76:FindFirstAncestorOfClass("Attachment") then
        local function u79(p78) --[[ Line: 309 ]]
            --[[
            Upvalues:
                [1] = u79
            --]]
            if p78 then
                if p78.Parent and (p78.Parent:IsA("BasePart") or p78.Parent:IsA("Attachment")) then
                    p78 = u79(p78.Parent)
                end
                return p78
            end
        end
        local function u88(p80) --[[ Line: 323 ]]
            --[[
            Upvalues:
                [1] = u77
                [2] = u76
                [3] = u79
                [4] = u88
            --]]
            if p80 then
                local v81 = u77[p80]
                if v81 then
                    if p80 == u76 then
                        return v81, u77[p80.Parent]
                    end
                    local v82 = u77
                    local v83 = p80.Parent
                    if v83 then
                        if v83.Parent and (v83.Parent:IsA("BasePart") or v83.Parent:IsA("Attachment")) then
                            v83 = u79(v83.Parent)
                        end
                    else
                        v83 = nil
                    end
                    return v81, v82[v83] or u77[p80]
                end
                local v84 = Instance.fromExisting(p80)
                v84.Archivable = false
                if v84:IsA("BasePart") then
                    v84.Locked = true
                end
                if u77 then
                    u77[p80] = v84
                end
                local v85
                if p80.Parent and (p80.Parent:IsA("BasePart") or p80.Parent:IsA("Attachment")) then
                    local v86, v87 = u88(p80.Parent)
                    v85 = v87 or v84
                    if v86 then
                        v84.Parent = v86
                    end
                else
                    v85 = v84
                end
                return v84, v85
            end
        end
        return u88(u76.Parent)
    end
end
function u6.getTransformedOriginExtents(p89) --[[ Line: 365 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u6
    --]]
    local v90 = CFrame.identity
    local v91 = Vector3.new(0, 0, 0)
    if p89:IsA("BasePart") then
        local v92 = p89.Size
        return p89.CFrame, v92
    else
        if p89:IsA("Attachment") then
            v90 = p89.WorldCFrame
            local v93 = p89.Parent
            local v94 = u3.get(p89, "PositionScale", Vector3.new(0, 0, 0), true)
            if v93 and (v93:IsA("BasePart") and v94 ~= Vector3.new(0, 0, 0)) then
                v90 = v90 + v93.Size / 2 * v94
            end
            local v95 = u3.get(p89, "OverrideWorldRotation", false, true)
            local v96 = u3.get(p89, "WorldRotation", Vector3.new(0, 0, 0), true)
            if v95 then
                local v97 = v96 * u6.DEG_TO_RAD
                local v98 = v90.Position
                v90 = CFrame.new(v98) * CFrame.fromOrientation(v97.X, v97.Y, v97.Z)
            end
        end
        return v90, v91
    end
end
function u6.getMeshDecals(p99, p100) --[[ Line: 401 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u6
    --]]
    local v101 = {}
    local v102 = {}
    local v103 = {}
    local function v107(p104) --[[ Line: 408 ]]
        local v105 = {}
        for _, v106 in p104 do
            if v106:IsA("Decal") then
                table.insert(v105, v106)
            end
        end
        return v105
    end
    if u3.get(p99, "Flipbook", false, true) then
        return v107(p100:GetChildren()), v102, v103
    end
    local v108 = p99:FindFirstChild("End")
    local v109 = p99:FindFirstChild("Start")
    if v108 then
        for _, v110 in p100:GetChildren() do
            if v110:IsA("Decal") then
                local v111 = v108:FindFirstChild(v110.Name)
                if v111 and v111:IsA("Decal") then
                    table.insert(v101, v110)
                    v103[v110] = v111
                    if v110:GetAttribute("FlipbookEnabled") then
                        v102[v110] = u6.deserializeFlipbook(v110:GetAttribute("FlipbookTextures"))
                    else
                        table.insert(v101, v110)
                    end
                end
            end
        end
        for _, v112 in v109:GetChildren() do
            if v112:IsA("Decal") then
                local v113 = v112:GetChildren()
                local v114 = 0
                for v115 = 1, #v113 do
                    local v116 = v115 - v114
                    if not v113[v116]:IsA("Decal") then
                        table.remove(v113, v116)
                        v114 = v114 + 1
                    end
                end
                if #v113 ~= 0 then
                    table.sort(v113, function(p117, p118) --[[ Line: 479 ]]
                        local v119 = p117.Name
                        local v120 = tonumber(v119:match("%d+")) or 0
                        local v121 = p118.Name
                        return v120 < (tonumber(v121:match("%d+")) or 0)
                    end)
                    local v122 = {}
                    for _, v123 in v113 do
                        local v124 = v123.Texture
                        local v125 = tonumber(v124:match("%d+")) or 0
                        table.insert(v122, v125)
                        v123:Destroy()
                    end
                    local v126 = u6.serializeFlipbook(v122)
                    v112:SetAttribute("FlipbookEnabled", true)
                    v112:SetAttribute("FlipbookTextures", buffer.tostring(v126))
                end
            end
        end
    end
    return v101, v102, v103
end
function u6.assembleMeshVFX(p127, p128, u129) --[[ Line: 502 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local u130 = u6.getRandomId()
    if not p127:IsA("Part") then
        local v131 = p127:Clone()
        v131.Archivable = false
        v131.Locked = true
        v131.Parent = workspace.Terrain
        v131:AddTag(u6.CLEANUP_TAG)
        table.insert(p128, v131)
        return v131
    end
    local v132 = u129:get(u130)
    v132.CFrame = p127.CFrame
    local v133 = v132._getReal()
    u6.copyProperties(p127, v133, u6.COPY_PART_PROPERTIES)
    u6.copyProperties(p127, v133, u6.COPY_EXTENDED_PART_PROPERTIES)
    local v134 = p127:Clone()
    for _, v135 in v134:GetChildren() do
        v135.Parent = v133
    end
    v134:Destroy()
    table.insert(p128, function() --[[ Line: 522 ]]
        --[[
        Upvalues:
            [1] = u129
            [2] = u130
        --]]
        u129:free(u130)
    end)
    return v132
end
function u6.getBezierPoints(p136, p137) --[[ Line: 541 ]]
    local v138 = p136:GetChildren()
    table.sort(v138, function(p139, p140) --[[ Line: 544 ]]
        local v141 = p139.Name
        local v142 = tonumber(v141)
        local v143 = p140.Name
        return v142 < tonumber(v143)
    end)
    local v144 = {}
    local v145 = {}
    local v146 = {}
    for v147, v148 in v138 do
        local v149 = v148:FindFirstChild("T0")
        local v150 = v148:FindFirstChild("T1")
        if v147 == 1 then
            local v151 = p136.WorldCFrame:PointToObjectSpace(v148.WorldPosition)
            local v152 = v151.X
            local v153 = v151.Y
            local v154 = v151.Z
            local v155 = vector.create(v152, v153, v154)
            table.insert(v144, v155)
            if p137 then
                v145[v148] = v155
                table.insert(v146, v148)
            end
        end
        if v147 ~= 1 then
            if v150 then
                local v156 = p136.WorldCFrame:PointToObjectSpace(v150.WorldPosition)
                local v157 = v156.X
                local v158 = v156.Y
                local v159 = v156.Z
                local v160 = vector.create(v157, v158, v159)
                table.insert(v144, v160)
                if p137 then
                    v145[v150] = v160
                    table.insert(v146, v150)
                end
            else
                local v161 = p136.WorldCFrame:PointToObjectSpace(v148.WorldPosition)
                local v162 = v161.X
                local v163 = v161.Y
                local v164 = v161.Z
                local v165 = vector.create(v162, v163, v164)
                table.insert(v144, v165)
                if p137 then
                    v145[v148] = v165
                    table.insert(v146, v148)
                end
            end
        end
        if v147 ~= 1 and v147 ~= #v138 then
            local v166 = p136.WorldCFrame:PointToObjectSpace(v148.WorldPosition)
            local v167 = v166.X
            local v168 = v166.Y
            local v169 = v166.Z
            local v170 = vector.create(v167, v168, v169)
            table.insert(v144, v170)
            if p137 then
                v145[v148] = v170
                table.insert(v146, v148)
            end
        end
        if v147 ~= #v138 then
            if v149 then
                local v171 = p136.WorldCFrame:PointToObjectSpace(v149.WorldPosition)
                local v172 = v171.X
                local v173 = v171.Y
                local v174 = v171.Z
                local v175 = vector.create(v172, v173, v174)
                table.insert(v144, v175)
                if p137 then
                    v145[v149] = v175
                    table.insert(v146, v149)
                end
            else
                local v176 = p136.WorldCFrame:PointToObjectSpace(v148.WorldPosition)
                local v177 = v176.X
                local v178 = v176.Y
                local v179 = v176.Z
                local v180 = vector.create(v177, v178, v179)
                table.insert(v144, v180)
                if p137 then
                    v145[v148] = v180
                    table.insert(v146, v148)
                end
            end
        end
        if v147 == #v138 then
            local v181 = p136.WorldCFrame:PointToObjectSpace(v148.WorldPosition)
            local v182 = v181.X
            local v183 = v181.Y
            local v184 = v181.Z
            local v185 = vector.create(v182, v183, v184)
            table.insert(v144, v185)
            if p137 then
                v145[v148] = v185
                table.insert(v146, v148)
            end
        end
    end
    return v144, v146, v145
end
function u6.scaleNumberSequence(p186, p187) --[[ Line: 604 ]]
    if p187 == 1 then
        return p186
    end
    local v188 = {}
    for _, v189 in p186.Keypoints do
        local v190, v191
        if typeof(p187) == "function" then
            v190, v191 = p187(v189.Value, v189.Envelope)
        else
            v190 = v189.Value * p187
            v191 = v189.Envelope * p187
        end
        local v192 = NumberSequenceKeypoint.new
        local v193 = v189.Time
        table.insert(v188, v192(v193, v190, v191))
    end
    return NumberSequence.new(v188)
end
function u6.serializePath(p194) --[[ Line: 629 ]]
    local v195 = buffer.create(#p194 * 4 * 6)
    local v196 = 0
    for v197, v198 in p194 do
        local v199 = v198.Position.X.Scale
        local v200 = v198.Position.Y.Scale
        if v197 ~= 1 then
            local v201 = v199 + v198.LeftTangent.X.Scale
            buffer.writef32(v195, v196, v201)
            local v202 = v196 + 4
            local v203 = v200 + v198.LeftTangent.Y.Scale
            buffer.writef32(v195, v202, v203)
            v196 = v196 + 8
        end
        buffer.writef32(v195, v196, v199)
        local v204 = v196 + 4
        buffer.writef32(v195, v204, v200)
        v196 = v196 + 8
        if v197 ~= #p194 then
            local v205 = v199 + v198.RightTangent.X.Scale
            buffer.writef32(v195, v196, v205)
            local v206 = v196 + 4
            local v207 = v200 + v198.RightTangent.Y.Scale
            buffer.writef32(v195, v206, v207)
            v196 = v196 + 8
        end
    end
    return v195
end
function u6.deserializePath(p208) --[[ Line: 661 ]]
    if typeof(p208) == "string" then
        p208 = buffer.fromstring(p208) or p208
    end
    local v209 = buffer.len(p208) / 24
    local v210 = {}
    for v211 = 0, v209 - 1 do
        local v212 = v211 * 4 * 6
        local v213 = buffer.readf32(p208, v212)
        local v214 = v212 + 4
        local v215 = buffer.readf32(p208, v214)
        local v216 = vector.create(v213, v215)
        table.insert(v210, v216)
        if v211 ~= v209 - 1 then
            local v217 = v212 + 8
            local v218 = buffer.readf32(p208, v217)
            local v219 = v212 + 12
            local v220 = buffer.readf32(p208, v219)
            local v221 = v212 + 16
            local v222 = buffer.readf32(p208, v221)
            local v223 = v212 + 20
            local v224 = buffer.readf32(p208, v223)
            local v225 = vector.create(v218, v220)
            table.insert(v210, v225)
            local v226 = vector.create(v222, v224)
            table.insert(v210, v226)
        end
    end
    return v210
end
local v227 = require("./common/flipbook")
u6.serializeFlipbook = v227.serialize
u6.deserializeFlipbook = v227.deserialize
u6.default_bezier = buffer.tostring(u6.serializePath({ Path2DControlPoint.new(UDim2.fromScale(0, 1), UDim2.new(), UDim2.fromScale(0.215, -0.61)), Path2DControlPoint.new(UDim2.fromScale(1, 0), UDim2.fromScale(-0.645, 0), UDim2.new()) }))
u6.linear_bezier = buffer.tostring(u6.serializePath({ Path2DControlPoint.new(UDim2.fromScale(0, 1)), Path2DControlPoint.new(UDim2.fromScale(1, 0)) }))
function u6.scaleAttribute(p228, p229, p230) --[[ Line: 707 ]]
    local v231 = p228:GetAttribute(p230)
    if v231 ~= nil then
        if typeof(v231) == "number" or typeof(v231) == "Vector3" then
            p228:SetAttribute(p230, v231 * p229)
            return
        end
        if typeof(v231) == "NumberRange" then
            p228:SetAttribute(p230, NumberRange.new(v231.Min * p229, v231.Max * p229))
        end
    end
end
function u6.scaleAttachmentDistance(p232, p233, p234) --[[ Line: 719 ]]
    if p232 and p233 then
        local v235 = (p232.Position + p233.Position) / 2
        p232.Position = v235 + (p232.Position - v235) * p234
        p233.Position = v235 + (p233.Position - v235) * p234
    end
end
return u6