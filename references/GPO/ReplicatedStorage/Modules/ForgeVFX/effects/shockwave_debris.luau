 

local u1 = game:GetService("RunService")
local u2 = game:GetService("CollectionService")
local u3 = require("../mod/attributes")
local u4 = require("../mod/tween")
require("../types")
local u5 = require("../mod/utility")
local u6 = require("../pkg/Promise")
require("../obj/ObjectCache")
local u7 = Random.new()
local v8 = {}
local u9 = {}
local u10 = nil
local u11 = nil
function v8.init(p12) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u10
        [3] = u5
        [4] = u1
        [5] = u9
    --]]
    if not u11 then
        u10 = p12
        if u5.PLUGIN_CONTEXT then
            u11 = u1.RenderStepped:Connect(function(p13) --[[ Line: 28 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                if #u9 ~= 0 then
                    workspace:StepPhysics(p13, u9)
                end
            end)
        end
    end
end
function v8.deinit() --[[ Line: 38 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u10
        [3] = u9
    --]]
    if u11 then
        u11:Disconnect()
        u11 = nil
    end
    u10 = nil
    for _, v14 in u9 do
        v14:Destroy()
    end
    table.clear(u9)
end
function v8.emit(p15, p16, u17) --[[ Line: 53 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u3
        [3] = u2
        [4] = u7
        [5] = u5
        [6] = u9
        [7] = u4
        [8] = u6
    --]]
    if u10 then
        local v18 = u3.get(p16, "InheritanceEnabled", true)
        local v19 = u3.get(p16, "InheritanceRadius", 5)
        local v20 = u3.get(p15, "RayCollisionGroup", "Default")
        local u21 = u3.get(p15, "FilterTag", "")
        local u22 = u3.get(p15, "FilterType", "Exclude")
        local u23 = u3.get(p15, "IgnoreCanCollide", false)
        local v24
        if v18 then
            local v25 = u3.get(p16, "InheritanceMaxResults", 5)
            v24 = OverlapParams.new()
            v24.MaxParts = v25
            v24.CollisionGroup = v20
            v24.RespectCanCollide = not u23
            v24.FilterType = Enum.RaycastFilterType[u22]
            v24.FilterDescendantsInstances = u2:GetTagged(u21)
            if u22 == "Exclude" then
                v24:AddToFilter({ workspace.Terrain })
            end
        else
            v24 = nil
        end
        local v26 = u3.get(p16, "EmitDelay", 0)
        local v27 = u3.getRange(p16, "Amount", NumberRange.new(5, 10), NumberRange.new(0, (1 / 0)))
        local v28 = u3.getRange(p16, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)))
        local v29 = u3.getRange(p16, "Airtime", NumberRange.new(0.5, 0.5), NumberRange.new(0, (1 / 0)))
        local v30 = u3.getRange(p16, "LinearMagnitude", NumberRange.new(15, 25))
        local v31 = u3.getRange(p16, "AngularMagnitude", NumberRange.new(5, 15))
        local u32 = u3.get(p16, "SizeScaleEnd", Vector3.new(0, 0, 0))
        local v33 = u3.get(p16, "MinSize", Vector3.new(2, 1, 2))
        local v34 = u3.get(p16, "MaxSize", Vector3.new(3, 2, 3))
        local v35 = u3.get(p16, "MinDirection", Vector3.new(-1, -1, -1))
        local v36 = u3.get(p16, "MaxDirection", Vector3.new(1, 1, 1))
        local v37 = u7:NextInteger(v27.Min, v27.Max)
        local u38 = u3.get(p16, "Size_Curve", u5.default_bezier)
        local u39 = u3.get(p16, "Transparency_Curve", u5.default_bezier)
        local u40 = u3.get(p16, "Transparency_Duration", 0.5)
        local u41 = u3.get(p16, "Size_Duration", 0.5)
        local v42 = u3.get(p16, "Transparency_Start", 0)
        local u43 = u3.get(p16, "Transparency_End", 1)
        local v44 = {}
        local u45 = {}
        p16.CanCollide = false
        local v46 = u5.getTransformedOriginExtents(p15)
        local v47 = v46.Position
        if v24 then
            for _, v48 in workspace:GetPartBoundsInRadius(v47, v19, v24) do
                if v48.Transparency ~= 1 then
                    table.insert(v44, v48)
                end
            end
        end
        task.wait(v26)
        for _ = 1, v37 do
            local v49
            if #v44 == 0 then
                v49 = false
            else
                v49 = v44[u7:NextInteger(1, #v44)]
            end
            local u50 = u5.getRandomId()
            local u51 = u10:get(u50)
            local u52 = u51._getReal()
            u5.copyProperties(p16, u52, u5.COPY_PART_PROPERTIES)
            u5.copyProperties(p16, u52, u5.COPY_EXTENDED_PART_PROPERTIES)
            if #p16:GetChildren() ~= 0 then
                local v53 = p16:Clone()
                for _, v54 in v53:GetChildren() do
                    v54.Parent = u52
                end
                v53:Destroy()
            end
            local u55 = u17.effects.prepareEmitOnFinish(u52, u17)
            local u56 = u17.effects.prepareEmitFolder(u52, "EmitOnImpact", u17)
            if u56 and #u56:GetChildren() > 0 then
                local u57 = nil
                u57 = u52.Touched:Connect(function(p58) --[[ Line: 162 ]]
                    --[[
                    Upvalues:
                        [1] = u23
                        [2] = u52
                        [3] = u22
                        [4] = u21
                        [5] = u57
                        [6] = u17
                        [7] = u56
                        [8] = u45
                    --]]
                    if (u23 or p58:CanCollideWith(u52)) and (not p58:IsDescendantOf(workspace.Terrain) and (u22 ~= "Exclude" or not p58:HasTag(u21))) then
                        u57:Disconnect()
                        local v59 = u45
                        local v60 = u17.effects.emitFromFolder(u56, u52, u17.depth + 1).Finished
                        table.insert(v59, v60)
                    end
                end)
                local function v61() --[[ Line: 177 ]]
                    --[[
                    Upvalues:
                        [1] = u57
                    --]]
                    if u57 then
                        u57:Disconnect()
                        u57 = nil
                    end
                end
                table.insert(u17, v61)
            end
            u51.Anchored = false
            u51.CanCollide = true
            if u51.CollisionGroup == "Default" then
                u51.CollisionGroup = "ForgeDebris"
            end
            u51.CFrame = CFrame.new(v47)
            local v62 = u7:NextNumber(v33.X, v34.X)
            local v63 = u7:NextNumber(v33.Y, v34.Y)
            local v64 = u7
            local v65 = v33.Z
            local v66 = v34.Z
            local u67 = Vector3.new(v62, v63, v64:NextNumber(v65, v66))
            u51.Size = u67
            if v49 then
                u51.Material = v49.Material
                u51.Color = v49.Color
                u51.Transparency = v49.Transparency
            else
                u51.Transparency = v42
            end
            local function v69() --[[ Line: 210 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u52
                    [3] = u10
                    [4] = u50
                --]]
                local v68 = table.find(u9, u52)
                if v68 then
                    table.remove(u9, v68)
                end
                if u10 then
                    u10:free(u50)
                end
            end
            table.insert(u17, v69)
            local v70 = u9
            table.insert(v70, u52)
            u51.AssemblyLinearVelocity = v46:VectorToWorldSpace(u51.AssemblyLinearVelocity)
            local v71 = v46:VectorToWorldSpace((u5.randomUnitVector(v35, v36)))
            u51:ApplyImpulse(u51.AssemblyMass * u5.getImpulseForce(v47, v47 + v71.Unit * u7:NextNumber(v30.Min, v30.Max), u7:NextNumber(v29.Min, v29.Max)))
            u51:ApplyAngularImpulse(u51.AssemblyMass * u7:NextUnitVector() * u7:NextNumber(v31.Min, v31.Max))
            local v72 = u17.effects.emitNested(u52, u17.depth + 1).Finished
            table.insert(u45, v72)
            task.delay(u7:NextNumber(v28.Min, v28.Max), function() --[[ Line: 243 ]]
                --[[
                Upvalues:
                    [1] = u51
                    [2] = u67
                    [3] = u32
                    [4] = u17
                    [5] = u4
                    [6] = u38
                    [7] = u41
                    [8] = u43
                    [9] = u39
                    [10] = u40
                    [11] = u5
                    [12] = u55
                    [13] = u52
                    [14] = u45
                --]]
                local u73 = u51.Size
                local u74 = u51.Transparency
                if u73 ~= u67 * u32 then
                    local v75 = u17
                    local v76 = u4.fromParams
                    local v77 = u38
                    local v78 = u41
                    local function v81(p79, p80) --[[ Line: 250 ]]
                        --[[
                        Upvalues:
                            [1] = u51
                            [2] = u73
                            [3] = u67
                            [4] = u32
                        --]]
                        u51.Size = u73:Lerp(u67 * u32, p79)
                        return p80
                    end
                    table.insert(v75, v76(v77, v78, v81))
                end
                if u74 ~= u43 then
                    local v82 = u17
                    local v83 = u4.fromParams
                    local v84 = u39
                    local v85 = u40
                    local function v88(p86, p87) --[[ Line: 260 ]]
                        --[[
                        Upvalues:
                            [1] = u51
                            [2] = u5
                            [3] = u74
                            [4] = u43
                        --]]
                        u51.Transparency = u5.lerp(u74, u43, p86)
                        return p87
                    end
                    table.insert(v82, v83(v84, v85, v88))
                end
                local v89 = u45
                local v90 = u17.effects.emitOnFinish(u55, u52, u17.depth + 1).Finished
                table.insert(v89, v90)
            end)
        end
        task.wait(v28.Max + math.max(u40, u41))
        u6.all(u45):await()
    end
end
return v8