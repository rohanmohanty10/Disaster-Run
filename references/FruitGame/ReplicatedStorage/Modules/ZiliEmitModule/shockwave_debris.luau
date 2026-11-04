 

local u1 = game:GetService("RunService")
local u2 = game:GetService("CollectionService")
local u3 = require("./mod/tween")
local u4 = require("./mod/utility")
require("./obj/ObjectCache")
local u5 = require(script.Parent.obj.Promise)
local u6 = Random.new()
local v7 = {}
local u8 = {}
local u9 = nil
local u10 = nil
function v7.init(p11) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u9
        [3] = u1
        [4] = u8
    --]]
    if not u10 then
        u9 = p11
        if u1:IsStudio() and script:FindFirstAncestorOfClass("Plugin") then
            u10 = u1.RenderStepped:Connect(function(p12) --[[ Line: 26 ]]
                --[[
                Upvalues:
                    [1] = u8
                --]]
                if #u8 ~= 0 then
                    workspace:StepPhysics(p12, u8)
                end
            end)
        end
    end
end
function v7.deinit() --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u9
        [3] = u8
    --]]
    if u10 then
        u10:Disconnect()
        u10 = nil
    end
    u9 = nil
    for _, v13 in u8 do
        v13:Destroy()
    end
    table.clear(u8)
end
function v7.emit(p14, p15, u16) --[[ Line: 51 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u4
        [3] = u2
        [4] = u6
        [5] = u8
        [6] = u3
        [7] = u5
    --]]
    if u9 then
        local v17 = u4.getAttribute(p15, "InheritanceEnabled", true)
        local v18 = u4.getAttribute(p15, "InheritanceRadius", 5)
        local v19
        if v17 then
            local v20 = u4.getAttribute(p15, "InheritanceMaxResults", 5)
            local v21 = u4.getAttribute(p14, "RayCollisionGroup", "Default")
            local v22 = u4.getAttribute(p14, "FilterTag", "")
            local v23 = u4.getAttribute(p14, "FilterType", "Exclude")
            local v24 = u4.getAttribute(p14, "IgnoreCanCollide", false)
            v19 = OverlapParams.new()
            v19.MaxParts = v20
            v19.CollisionGroup = v21
            v19.RespectCanCollide = not v24
            v19.FilterType = Enum.RaycastFilterType[v23]
            v19.FilterDescendantsInstances = u2:GetTagged(v22)
            if v23 == "Exclude" then
                v19:AddToFilter({ workspace.Terrain })
            end
        else
            v19 = nil
        end
        local v25 = u4.getAttribute(p15, "EmitDelay", 0)
        local v26 = u4.getRangeAttribute(p15, "Amount", NumberRange.new(5, 10), NumberRange.new(0, (1 / 0)))
        local v27 = u4.getRangeAttribute(p15, "Lifetime", NumberRange.new(2, 3), NumberRange.new(0, (1 / 0)))
        local v28 = u4.getRangeAttribute(p15, "Airtime", NumberRange.new(0.5, 0.5), NumberRange.new(0, (1 / 0)))
        local v29 = u4.getRangeAttribute(p15, "LinearMagnitude", NumberRange.new(15, 25))
        local v30 = u4.getRangeAttribute(p15, "AngularMagnitude", NumberRange.new(5, 15))
        local u31 = u4.getAttribute(p15, "SizeScaleEnd", Vector3.new(0, 0, 0))
        local v32 = u4.getAttribute(p15, "MinSize", Vector3.new(2, 1, 2))
        local v33 = u4.getAttribute(p15, "MaxSize", Vector3.new(3, 2, 3))
        local v34 = u4.getAttribute(p15, "MinDirection", Vector3.new(-1, -1, -1))
        local v35 = u4.getAttribute(p15, "MaxDirection", Vector3.new(1, 1, 1))
        local v36 = u6:NextInteger(v26.Min, v26.Max)
        local u37 = u4.getAttribute(p15, "Size_Curve", u4.default_bezier)
        local u38 = u4.getAttribute(p15, "Transparency_Curve", u4.default_bezier)
        local u39 = u4.getAttribute(p15, "Transparency_Duration", 0.5)
        local u40 = u4.getAttribute(p15, "Size_Duration", 0.5)
        local u41 = u4.getAttribute(p15, "Transparency_Start", 0)
        local u42 = u4.getAttribute(p15, "Transparency_End", 1)
        local v43 = {}
        local v44 = {}
        p15.CanCollide = false
        if v19 then
            for _, v45 in workspace:GetPartBoundsInRadius(p14.WorldPosition, v18, v19) do
                if v45.Transparency ~= 1 then
                    table.insert(v43, v45)
                end
            end
        end
        task.wait(v25)
        for _ = 1, v36 do
            local v46
            if #v43 == 0 then
                v46 = false
            else
                v46 = v43[u6:NextInteger(1, #v43)]
            end
            local u47 = u4.getRanomId()
            local u48 = u9:get(u47)
            local u49 = u48._getReal()
            u4.copyProperties(p15, u49, u4.COPY_PART_PROPERTIES)
            u4.copyProperties(p15, u49, u4.COPY_EXTENDED_PART_PROPERTIES)
            if #p15:GetChildren() ~= 0 then
                local v50 = p15:Clone()
                for _, v51 in v50:GetChildren() do
                    v51.Parent = u49
                end
                v50:Destroy()
            end
            u48.Anchored = false
            u48.CanCollide = true
            u48.Transparency = u41
            if u48.CollisionGroup == "Default" then
                u48.CollisionGroup = "ForgeDebris"
            end
            u48.CFrame = CFrame.new(p14.WorldPosition)
            local v52 = u6:NextNumber(v32.X, v33.X)
            local v53 = u6:NextNumber(v32.Y, v33.Y)
            local v54 = u6
            local v55 = v32.Z
            local v56 = v33.Z
            local u57 = Vector3.new(v52, v53, v54:NextNumber(v55, v56))
            u48.Size = u57
            if v46 then
                u48.Material = v46.Material
                u48.Color = v46.Color
                u48.Transparency = v46.Transparency
            end
            local function v59() --[[ Line: 176 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u49
                    [3] = u9
                    [4] = u47
                --]]
                local v58 = table.find(u8, u49)
                if v58 then
                    table.remove(u8, v58)
                end
                if u9 then
                    u9:free(u47)
                end
            end
            table.insert(u16, v59)
            local v60 = u8
            table.insert(v60, u49)
            u48.AssemblyLinearVelocity = p14.WorldCFrame:VectorToWorldSpace(u48.AssemblyLinearVelocity)
            local v61 = u4.randomUnitVector(v34, v35)
            local v62 = p14.WorldCFrame:VectorToWorldSpace(v61)
            u48:ApplyImpulse(u48.AssemblyMass * u4.getImpulseForce(p14.WorldPosition, p14.WorldPosition + v62.Unit * u6:NextNumber(v29.Min, v29.Max), u6:NextNumber(v28.Min, v28.Max)))
            u48:ApplyAngularImpulse(u48.AssemblyMass * u6:NextUnitVector() * u6:NextNumber(v30.Min, v30.Max))
            if shared.vfx and #u48:GetChildren() ~= 0 then
                local v63 = shared.vfx.emit(u48).Finished
                table.insert(v44, v63)
            end
            task.delay(u6:NextNumber(v27.Min, v27.Max), function() --[[ Line: 211 ]]
                --[[
                Upvalues:
                    [1] = u48
                    [2] = u57
                    [3] = u31
                    [4] = u16
                    [5] = u3
                    [6] = u37
                    [7] = u40
                    [8] = u41
                    [9] = u42
                    [10] = u38
                    [11] = u39
                    [12] = u4
                --]]
                local u64 = u48.Size
                if u64 ~= u57 * u31 then
                    local v65 = u16
                    local v66 = u3.fromParams
                    local v67 = u37
                    local v68 = u40
                    local function v71(p69, p70) --[[ Line: 217 ]]
                        --[[
                        Upvalues:
                            [1] = u48
                            [2] = u64
                            [3] = u57
                            [4] = u31
                        --]]
                        u48.Size = u64:Lerp(u57 * u31, p69)
                        return p70
                    end
                    table.insert(v65, v66(v67, v68, v71))
                end
                if u41 == u42 then
                    u48.Transparency = u41
                else
                    local v72 = u16
                    local v73 = u3.fromParams
                    local v74 = u38
                    local v75 = u39
                    local function v78(p76, p77) --[[ Line: 227 ]]
                        --[[
                        Upvalues:
                            [1] = u48
                            [2] = u4
                            [3] = u41
                            [4] = u42
                        --]]
                        u48.Transparency = u4.lerp(u41, u42, p76)
                        return p77
                    end
                    table.insert(v72, v73(v74, v75, v78))
                end
            end)
        end
        task.wait(v27.Max + math.max(u39, u40))
        u5.all(v44):await()
    end
end
return v7