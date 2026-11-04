 

local u1 = {}
local u2 = {}
local u3 = {
    { "Draw Internal Bone", "Draws a sphere with the specified radius of the bone around where SmartBone believes the bone is.", "DRAW_BONE" },
    { "Draw Physical Bone", "Draws the actual bone objects CFrame with axis arrows.", "DRAW_PHYSICAL_BONE" },
    { "Draw Root Part", "Draws a bounding box and fills in the root part.", "DRAW_ROOT_PART" },
    { "Draw Bounding Box", "Draws the bounding box used for frustum culling.", "DRAW_BOUNDING_BOX" },
    { "Draw Axis Limits", "Draws the axis limits for each bone.", "DRAW_AXIS_LIMITS" },
    { "Draw Rotation Limits", "Draws the rotation limits for each bone.", "DRAW_ROTATION_LIMITS" },
    { "Draw Acceleration Info", "Draws the acceleration and the required values to derive it.", "DRAW_ACCELERATION_INFO" },
    { "Draw Colliders", "Draws all the colliders this root object can collide with.", "DRAW_COLLIDERS" },
    { "Draw Collider Influence", "Shows the sphere of influence around each collider.", "DRAW_COLLIDER_INFLUENCE" },
    { "Draw Collider Awake", "Shows if a collider is awake or asleep.", "DRAW_COLLIDER_AWAKE" },
    { "Draw Collider BroadPhase", "Shows if a collider isn\'t reaching NarrowPhase.", "DRAW_COLLIDER_BROADPHASE" },
    { "Draw Fill Colliders", "Fills all colliders this root object can collide with.", "DRAW_FILL_COLLIDERS" },
    { "Draw Contacts", "Draws the position and normal of the points which bones collide with colliders.", "DRAW_CONTACTS" }
}
local function u6(p4, p5) --[[ Line: 25 ]]
    p4.PushConfig({
        ["TextColor"] = p4._config.TextDisabledColor
    })
    p4.Text({ p5 })
    p4.PopConfig()
end
local function u10(p7, p8) --[[ Line: 31 ]]
    p7.PushConfig({
        ["TextColor"] = p7._config.TextDisabledColor
    })
    local v9 = p7.Text({ "(?)" })
    p7.PopConfig()
    p7.PushConfig({
        ["ContentWidth"] = UDim.new(0, 350)
    })
    if v9.hovered() then
        p7.Tooltip({ p8 })
    end
    p7.PopConfig()
end
local function u20(p11, p12) --[[ Line: 43 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v13 = p11.Window({ (("Editing bone: %*"):format(p12.Bone.Name)) })
    v13.isOpened.value = true
    p12.Radius = p11.InputNum({
        "Radius",
        0.1,
        0,
        (1 / 0),
        "%.3f"
    }, {
        ["number"] = p12.Radius
    }).number.value
    p12.RotationLimit = p11.InputNum({
        "Rotation Limit",
        0.1,
        0,
        180,
        "%.3f"
    }, {
        ["number"] = p12.RotationLimit
    }).number.value
    p12.Anchored = p11.Checkbox({ "Anchored" }, {
        ["isChecked"] = p12.Anchored
    }).isChecked.value
    p11.Text("Axis Lock")
    p11.Indent()
    p11.SameLine()
    p11.Text("X: ")
    local v14 = p11.Checkbox({ "" }, {
        ["isChecked"] = p12.AxisLocked[1]
    })
    p11.Text("Y: ")
    local v15 = p11.Checkbox({ "" }, {
        ["isChecked"] = p12.AxisLocked[2]
    })
    p11.Text("Z: ")
    local v16 = p11.Checkbox({ "" }, {
        ["isChecked"] = p12.AxisLocked[3]
    })
    p11.End()
    p11.End()
    local v17 = p11.State(Vector2.new(p12.XAxisLimits.Min, p12.XAxisLimits.Max))
    local v18 = p11.State(Vector2.new(p12.YAxisLimits.Min, p12.YAxisLimits.Max))
    local v19 = p11.State(Vector2.new(p12.ZAxisLimits.Min, p12.ZAxisLimits.Max))
    p11.Text("Axis Limits")
    p11.Indent()
    p11.DragVector2({
        "X Axis Limit",
        0.05,
        nil,
        nil,
        { "Min: %.2f", "Max: %.2f" }
    }, {
        ["number"] = v17
    })
    p11.DragVector2({
        "Y Axis Limit",
        0.05,
        nil,
        nil,
        { "Min: %.2f", "Max: %.2f" }
    }, {
        ["number"] = v18
    })
    p11.DragVector2({
        "Z Axis Limit",
        0.05,
        nil,
        nil,
        { "Min: %.2f", "Max: %.2f" }
    }, {
        ["number"] = v19
    })
    p11.End()
    p11.End()
    p12.AxisLocked[1] = v14.isChecked.value
    p12.AxisLocked[2] = v15.isChecked.value
    p12.AxisLocked[3] = v16.isChecked.value
    p12.XAxisLimits = NumberRange.new(v17:get().X, v17:get().Y)
    p12.YAxisLimits = NumberRange.new(v18:get().X, v18:get().Y)
    p12.ZAxisLimits = NumberRange.new(v19:get().X, v19:get().Y)
    if v13.closed() then
        u1[p12] = nil
    end
end
local function u28(p21, p22) --[[ Line: 98 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v23 = p21.Window({ (("Editing collider of type: %*"):format(p22.Type)) })
    v23.isOpened.value = true
    local v24 = p21.State(p22.Type)
    local v25 = p21.State(p22.Scale)
    local v26 = p21.State(p22.Offset)
    local v27 = p21.State(p22.Rotation)
    p21.Combo({ "Collider Type" }, {
        ["index"] = v24
    })
    p21.Selectable({ "Box", "Box" }, {
        ["index"] = v24
    })
    p21.Selectable({ "Sphere", "Sphere" }, {
        ["index"] = v24
    })
    p21.Selectable({ "Capsule", "Capsule" }, {
        ["index"] = v24
    })
    p21.End()
    p21.DragVector3({
        "Scale",
        0.1,
        0,
        nil
    }, {
        ["number"] = v25
    })
    p21.DragVector3({
        "Offset",
        0.1,
        nil,
        nil
    }, {
        ["number"] = v26
    })
    p21.DragVector3({
        "Rotation",
        0.5,
        -180,
        180
    }, {
        ["number"] = v27
    })
    p22.Type = v24:get()
    p22.Scale = v25:get()
    p22.Offset = v26:get()
    p22.Rotation = v27:get()
    p21.End()
    if v23.closed() then
        u2[p22] = nil
    end
end
return function(p29, p30, p31) --[[ Line: 129 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u20
        [3] = u2
        [4] = u28
        [5] = u3
        [6] = u10
        [7] = u6
    --]]
    local v32 = {}
    for _, v33 in p30.BoneTrees do
        local v34 = v33.RootPart
        local v35 = v32[v34]
        if not v35 then
            v32[v34] = {}
            v35 = v32[v34]
        end
        v35[#v35 + 1] = v33
    end
    for v36, _ in u1 do
        local v37 = ("%* - %*"):format(p30.ID, v36.ParentIndex + 1)
        p29.PushId(v37)
        u20(p29, v36)
        p29.PopId()
    end
    for v38, _ in u2 do
        local v39 = v38.GUID
        p29.PushId(v39)
        u28(p29, v38)
        p29.PopId()
    end
    local v40 = #p30.BoneTrees
    local v41 = #p30.ColliderObjects
    local v42 = ("%* BoneTree%*"):format(v40, v40 == 1 and "" or "s")
    local v43 = ("%* Collider%*"):format(v41, v41 == 1 and "" or "s")
    p29.Window({
        ("SmartBone Runtime Editor. %*, %*"):format(v42, v43),
        [p29.Args.Window.NoClose] = true
    })
    p29.Tree({ "Debug Gizmos", true }, {
        ["isUncollapsed"] = true
    })
    for _, v44 in u3 do
        p29.SameLine()
        p29.Checkbox({ v44[1] }, {
            ["isChecked"] = p31[v44[3]]
        })
        u10(p29, v44[2])
        p29.End()
    end
    p29.End()
    p29.Separator()
    u6(p29, "Simulated Objects")
    for v45, v46 in v32 do
        p29.Tree((("%* - Root Part"):format(v45.Name)))
        for v47, v48 in v46 do
            p29.Tree((("BoneTree #%*"):format(v47)))
            u6(p29, (("Throttled Update Rate: %* / %* fps"):format(string.format("%.1f", v48.UpdateRate), (string.format("%.1f", v48.Settings.UpdateRate)))))
            u6(p29, (("In View: %*"):format(v48.InView)))
            local v49 = p29.State(v48.Settings.Constraint)
            local v50 = p29.State(v48.Settings.WindType)
            local v51 = p29.State(v48.Settings.UpdateRate)
            local v52 = p29.State(v48.Settings.ActivationDistance)
            local v53 = p29.State(v48.Settings.ThrottleDistance)
            p29.SameLine()
            u10(p29, "The constraint used, distance is more flowy while spring is more rigid.")
            p29.Combo({ "Constraint Type" }, {
                ["index"] = v49
            })
            p29.Selectable({ "Distance", "Distance" }, {
                ["index"] = v49
            })
            p29.Selectable({ "Spring", "Spring" }, {
                ["index"] = v49
            })
            p29.End()
            p29.End()
            p29.SameLine()
            u10(p29, "The wind solver used, sine is a smoother wind, noise is more chaotic and hybrid is a mix of the two.")
            p29.Combo({ "Wind Type" }, {
                ["index"] = v50
            })
            p29.Selectable({ "Sine", "Sine" }, {
                ["index"] = v50
            })
            p29.Selectable({ "Noise", "Noise" }, {
                ["index"] = v50
            })
            p29.Selectable({ "Hybrid", "Hybrid" }, {
                ["index"] = v50
            })
            p29.End()
            p29.End()
            p29.SameLine()
            u10(p29, "The target update rate for the bone tree")
            p29.SliderNum({
                "Update Rate",
                5,
                0,
                120
            }, {
                ["number"] = v51
            })
            p29.End()
            p29.SameLine()
            u10(p29, "The distance at which the bone tree stops updating")
            p29.SliderNum({
                "Activation Distance",
                1,
                0,
                500
            }, {
                ["number"] = v52
            })
            p29.End()
            p29.SameLine()
            u10(p29, "The distance at which the bone tree starts throttling its update rate")
            p29.SliderNum({
                "Throttle Distance",
                1,
                0,
                500
            }, {
                ["number"] = v53
            })
            p29.End()
            v48.Settings.Constraint = v49:get()
            v48.Settings.WindType = v50:get()
            v48.Settings.UpdateRate = v51:get()
            v48.Settings.ActivationDistance = v52:get()
            v48.Settings.ThrottleDistance = v53:get()
            p29.Table({
                4,
                false,
                false,
                false
            })
            p29.NextColumn()
            p29.Text("Bone #")
            p29.NextColumn()
            p29.Text("Bone Name")
            p29.NextColumn()
            p29.Text("Parent #")
            p29.NextColumn()
            p29.Text("Edit")
            p29.End()
            p29.Table({ 4 })
            for v54, v55 in v48.Bones do
                p29.NextColumn()
                p29.Text((tostring(v54)))
                p29.NextColumn()
                p29.Text(v55.Bone.Name)
                p29.NextColumn()
                local v56 = p29.Text
                local v57 = v55.ParentIndex
                v56((tostring(v57)))
                p29.NextColumn()
                p29.SameLine()
                p29.Text("")
                if p29.SmallButton({ "Edit" }).clicked() then
                    u1[v55] = true
                end
                p29.End()
            end
            p29.End()
            p29.End()
        end
        p29.End()
    end
    u6(p29, "Active Colliders")
    for _, v58 in p30.ColliderObjects do
        p29.Tree({ v58.m_Object.Name })
        u6(p29, "Colliders adorned to this object")
        p29.Table({
            5,
            false,
            false,
            false
        })
        p29.NextColumn()
        p29.Text("Type")
        p29.NextColumn()
        p29.Text("Scale")
        p29.NextColumn()
        p29.Text("Offset")
        p29.NextColumn()
        p29.Text("Rotation")
        p29.NextColumn()
        p29.Text("Edit")
        p29.End()
        p29.Table({ 5 })
        for _, v59 in v58.Colliders do
            p29.NextColumn()
            local v60 = p29.Text
            local v61 = v59.Type
            v60((tostring(v61)))
            p29.NextColumn()
            local v62 = p29.Text
            local v63 = v59.Scale
            v62((tostring(v63)))
            p29.NextColumn()
            local v64 = p29.Text
            local v65 = v59.Offset
            v64((tostring(v65)))
            p29.NextColumn()
            local v66 = p29.Text
            local v67 = v59.Rotation
            v66((tostring(v67)))
            p29.NextColumn()
            p29.SameLine()
            p29.Text("")
            if p29.SmallButton({ "Edit" }).clicked() then
                u2[v59] = true
            end
            p29.End()
        end
        p29.End()
        p29.End()
    end
    p29.End()
end