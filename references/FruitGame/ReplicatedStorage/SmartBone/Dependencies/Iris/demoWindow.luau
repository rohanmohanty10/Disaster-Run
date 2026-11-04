 

require(script.Parent.Types)
return function(u1) --[[ Line: 3 ]]
    local u2 = u1.State(true)
    local u3 = u1.State(false)
    local u4 = u1.State(false)
    local u5 = u1.State(false)
    local u6 = u1.State(false)
    local u7 = u1.State(false)
    local function u10(p8) --[[ Line: 12 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        u1.PushConfig({
            ["TextColor"] = u1._config.TextDisabledColor
        })
        local v9 = u1.Text({ "(?)" })
        u1.PopConfig()
        u1.PushConfig({
            ["ContentWidth"] = UDim.new(0, 350)
        })
        if v9.hovered() then
            u1.Tooltip({ p8 })
        end
        u1.PopConfig()
    end
    local u45 = {
        ["Basic"] = function() --[[ Name: Basic, Line 26 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            u1.Tree({ "Basic" })
            u1.SeparatorText({ "Basic" })
            local v11 = u1.State(1)
            u1.Button({ "Button" })
            u1.SmallButton({ "SmallButton" })
            u1.Text({ "Text" })
            u1.TextWrapped({ string.rep("Text Wrapped ", 5) })
            u1.TextColored({ "Colored Text", Color3.fromRGB(255, 128, 0) })
            u1.Text({
                "Rich Text: <b>bold text</b> <i>italic text</i> <u>underline text</u> <s>strikethrough text</s> <font color= \"rgb(240, 40, 10)\">red text</font> <font size=\"32\">bigger text</font>",
                true,
                nil,
                true
            })
            u1.SameLine()
            u1.RadioButton({ "Index \'1\'", 1 }, {
                ["index"] = v11
            })
            u1.RadioButton({ "Index \'two\'", "two" }, {
                ["index"] = v11
            })
            if u1.RadioButton({ "Index \'false\'", false }, {
                ["index"] = v11
            }).active() == false and u1.SmallButton({ "Select last" }).clicked() then
                v11:set(false)
            end
            u1.End()
            local v12 = u1.Text
            local v13 = {}
            local v14 = v11.value
            __set_list(v13, 1, {"The Index is: " .. tostring(v14)})
            v12(v13)
            u1.SeparatorText({ "Inputs" })
            u1.InputNum({})
            u1.DragNum({})
            u1.SliderNum({})
            u1.End()
        end,
        ["Tree"] = function() --[[ Name: Tree, Line 57 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u10
            --]]
            u1.Tree({ "Trees" })
            u1.Tree({
                "Tree using SpanAvailWidth",
                [u1.Args.Tree.SpanAvailWidth] = true
            })
            u10("SpanAvailWidth determines if the Tree is selectable from its entire with, or only the text area")
            u1.End()
            local v15 = u1.Tree({ "Tree with Children" })
            u1.Text({ "Im inside the first tree!" })
            u1.Button({ "Im a button inside the first tree!" })
            u1.Tree({ "Im a tree inside the first tree!" })
            u1.Text({ "I am the innermost text!" })
            u1.End()
            u1.End()
            u1.Checkbox({ "Toggle above tree" }, {
                ["isChecked"] = v15.state.isUncollapsed
            })
            u1.End()
        end,
        ["CollapsingHeader"] = function() --[[ Name: CollapsingHeader, Line 76 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            u1.Tree({ "Collapsing Headers" })
            u1.CollapsingHeader({ "A header" })
            u1.Text({ "This is under the first header!" })
            u1.End()
            local v16 = u1.State(true)
            u1.CollapsingHeader({ "Another header" }, {
                ["isUncollapsed"] = v16
            })
            if u1.Button({ "Shhh... secret button!" }).clicked() then
                v16:set(true)
            end
            u1.End()
            u1.End()
        end,
        ["Group"] = function() --[[ Name: Group, Line 91 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            u1.Tree({ "Groups" })
            u1.SameLine()
            u1.Group()
            u1.Text({ "I am in group A" })
            u1.Button({ "Im also in A" })
            u1.End()
            u1.Separator()
            u1.Group()
            u1.Text({ "I am in group B" })
            u1.Button({ "Im also in B" })
            u1.Button({ "Also group B" })
            u1.End()
            u1.End()
            u1.End()
        end,
        ["Indent"] = function() --[[ Name: Indent, Line 110 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            u1.Tree({ "Indents" })
            u1.Text({ "Not Indented" })
            u1.Indent()
            u1.Text({ "Indented" })
            u1.Indent({ 7 })
            u1.Text({ "Indented by 7 more pixels" })
            u1.End()
            u1.Indent({ -7 })
            u1.Text({ "Indented by 7 less pixels" })
            u1.End()
            u1.End()
            u1.End()
        end,
        ["Input"] = function() --[[ Name: Input, Line 126 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u10
            --]]
            u1.Tree({ "Input" })
            local v17 = u1.State(false)
            local v18 = u1.State(false)
            local v19 = u1.State(0)
            local v20 = u1.State(100)
            local v21 = u1.State(1)
            local v22 = u1.State("%d")
            u1.PushConfig({
                ["ContentWidth"] = UDim.new(1, -120)
            })
            local v23 = u1.InputNum({
                "Input Number",
                [u1.Args.InputNum.NoButtons] = v18.value,
                [u1.Args.InputNum.Min] = v19.value,
                [u1.Args.InputNum.Max] = v20.value,
                [u1.Args.InputNum.Increment] = v21.value,
                [u1.Args.InputNum.Format] = { v22.value }
            })
            u1.PopConfig()
            u1.Text({ "The Value is: " .. v23.number.value })
            if u1.Button({ "Randomize Number" }).clicked() then
                v23.number:set(math.random(1, 99))
            end
            local v24 = u1.Checkbox({ "NoField" }, {
                ["isChecked"] = v17
            })
            local v25 = u1.Checkbox({ "NoButtons" }, {
                ["isChecked"] = v18
            })
            if v24.checked() and v25.isChecked.value == true then
                v25.isChecked:set(false)
            end
            if v25.checked() and v24.isChecked.value == true then
                v24.isChecked:set(false)
            end
            u1.PushConfig({
                ["ContentWidth"] = UDim.new(1, -120)
            })
            u1.InputVector2({ "InputVector2" })
            u1.InputVector3({ "InputVector3" })
            u1.InputUDim({ "InputUDim" })
            u1.InputUDim2({ "InputUDim2" })
            local v26 = u1.State(false)
            local v27 = u1.State(false)
            local v28 = u1.State(Color3.new())
            local v29 = u1.State(0)
            u1.SliderNum({
                "Transparency",
                0.01,
                0,
                1
            }, {
                ["number"] = v29
            })
            u1.InputColor3({ "InputColor3", v26:get(), v27:get() }, {
                ["color"] = v28
            })
            u1.InputColor4({ "InputColor4", v26:get(), v27:get() }, {
                ["color"] = v28,
                ["transparency"] = v29
            })
            u1.SameLine()
            u1.Text({ v28:get():ToHex() })
            u1.Checkbox({ "Use Floats" }, {
                ["isChecked"] = v26
            })
            u1.Checkbox({ "Use HSV" }, {
                ["isChecked"] = v27
            })
            u1.End()
            u1.PopConfig()
            u1.Separator()
            u1.SameLine()
            u1.Text({ "Slider Numbers" })
            u10("ctrl + click slider number widgets to input a number")
            u1.End()
            u1.PushConfig({
                ["ContentWidth"] = UDim.new(1, -120)
            })
            u1.SliderNum({
                "Slide Int",
                1,
                1,
                8
            })
            u1.SliderNum({
                "Slide Float",
                0.01,
                0,
                100
            })
            u1.SliderNum({
                "Small Numbers",
                0.001,
                -2,
                1,
                "%f radians"
            })
            u1.SliderNum({
                "Odd Ranges",
                0.001,
                -3.141592653589793,
                3.141592653589793,
                "%f radians"
            })
            u1.SliderNum({
                "Big Numbers",
                10000,
                100000,
                10000000
            })
            u1.SliderNum({
                "Few Numbers",
                1,
                0,
                3
            })
            u1.PopConfig()
            u1.Separator()
            u1.SameLine()
            u1.Text({ "Drag Numbers" })
            u10("ctrl + click or double click drag number widgets to input a number, hold shift/alt while dragging to increase/decrease speed")
            u1.End()
            u1.PushConfig({
                ["ContentWidth"] = UDim.new(1, -120)
            })
            u1.DragNum({ "Drag Int" })
            u1.DragNum({
                "Slide Float",
                0.001,
                -10,
                10
            })
            u1.DragNum({
                "Percentage",
                1,
                0,
                100,
                "%d %%"
            })
            u1.PopConfig()
            u1.End()
        end,
        ["InputText"] = function() --[[ Name: InputText, Line 203 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            u1.Tree({ "Input Text" })
            u1.PushConfig({
                ["ContentWidth"] = UDim.new(0, 250)
            })
            local v30 = u1.InputText({
                "Input Text Test",
                [u1.Args.InputText.TextHint] = "Input Text here"
            })
            u1.PopConfig()
            u1.Text({ "The text is: " .. v30.text.value })
            u1.End()
        end,
        ["MultiInput"] = function() --[[ Name: MultiInput, Line 212 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            u1.Tree({ "Multi-Component Input" })
            local v31 = u1.State(Vector2.new())
            local v32 = u1.State((Vector3.new()))
            local v33 = u1.State(UDim.new())
            local v34 = u1.State(UDim2.new())
            local v35 = u1.State(Color3.new())
            local v36 = u1.State(Rect.new(0, 0))
            u1.SeparatorText({ "Input" })
            u1.InputVector2({}, {
                ["number"] = v31
            })
            u1.InputVector3({}, {
                ["number"] = v32
            })
            u1.InputUDim({}, {
                ["number"] = v33
            })
            u1.InputUDim2({}, {
                ["number"] = v34
            })
            u1.InputRect({}, {
                ["number"] = v36
            })
            u1.SeparatorText({ "Drag" })
            u1.DragVector2({}, {
                ["number"] = v31
            })
            u1.DragVector3({}, {
                ["number"] = v32
            })
            u1.DragUDim({}, {
                ["number"] = v33
            })
            u1.DragUDim2({}, {
                ["number"] = v34
            })
            u1.DragRect({}, {
                ["number"] = v36
            })
            u1.SeparatorText({ "Slider" })
            u1.SliderVector2({}, {
                ["number"] = v31
            })
            u1.SliderVector3({}, {
                ["number"] = v32
            })
            u1.SliderUDim({}, {
                ["number"] = v33
            })
            u1.SliderUDim2({}, {
                ["number"] = v34
            })
            u1.SliderRect({}, {
                ["number"] = v36
            })
            u1.SeparatorText({ "Color" })
            u1.InputColor3({}, {
                ["color"] = v35
            })
            u1.InputColor4({}, {
                ["color"] = v35
            })
            u1.End()
        end,
        ["Tooltip"] = function() --[[ Name: Tooltip, Line 254 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            u1.PushConfig({
                ["ContentWidth"] = UDim.new(0, 250)
            })
            u1.Tree({ "Tooltip" })
            if u1.Text({ "Hover over me to reveal a tooltip" }).hovered() then
                u1.Tooltip({ "I am some helpful tooltip text" })
            end
            local v37 = u1.State("Hello ")
            local v38 = u1.State(1)
            if u1.InputNum({
                "# of repeat",
                1,
                1,
                50
            }, {
                ["number"] = v38
            }).numberChanged() then
                v37:set(string.rep("Hello ", v38:get()))
            end
            if u1.Checkbox({ "Show dynamic text tooltip" }).isChecked.value then
                u1.Tooltip({ v37:get() })
            end
            u1.End()
            u1.PopConfig()
        end,
        ["Selectable"] = function() --[[ Name: Selectable, Line 272 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            u1.Tree({ "Selectable" })
            local v39 = u1.State(2)
            u1.Selectable({ "Selectable #1", 1 }, {
                ["index"] = v39
            })
            u1.Selectable({ "Selectable #2", 2 }, {
                ["index"] = v39
            })
            if u1.Selectable({ "Double click Selectable", 3, true }, {
                ["index"] = v39
            }).doubleClicked() then
                v39:set(3)
            end
            u1.Selectable({ "Impossible to select", 4, true }, {
                ["index"] = v39
            })
            if u1.Button({ "Select last" }).clicked() then
                v39:set(4)
            end
            u1.Selectable({ "Independent Selectable" })
            u1.End()
        end,
        ["Combo"] = function() --[[ Name: Combo, Line 288 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            u1.Tree({ "Combo" })
            u1.PushConfig({
                ["ContentWidth"] = UDim.new(1, -120)
            })
            local v40 = u1.State("No Selection")
            u1.SameLine()
            local v41 = u1.Checkbox({ "No Preview" })
            local v42 = u1.Checkbox({ "No Button" })
            if v41.checked() and v42.isChecked.value == true then
                v42.isChecked:set(false)
            end
            if v42.checked() and v41.isChecked.value == true then
                v41.isChecked:set(false)
            end
            u1.End()
            u1.Combo({ "Basic Usage", v42.isChecked:get(), v41.isChecked:get() }, {
                ["index"] = v40
            })
            u1.Selectable({ "Select 1", "One" }, {
                ["index"] = v40
            })
            u1.Selectable({ "Select 2", "Two" }, {
                ["index"] = v40
            })
            u1.Selectable({ "Select 3", "Three" }, {
                ["index"] = v40
            })
            u1.End()
            u1.ComboArray({ "Using ComboArray" }, {
                ["index"] = "No Selection"
            }, { "Red", "Green", "Blue" })
            local v43 = u1.State("7 AM")
            u1.Combo({ "Combo with Inner widgets" }, {
                ["index"] = v43
            })
            u1.Tree({ "Morning Shifts" })
            u1.Selectable({ "Shift at 7 AM", "7 AM" }, {
                ["index"] = v43
            })
            u1.Selectable({ "Shift at 11 AM", "11 AM" }, {
                ["index"] = v43
            })
            u1.Selectable({ "Shist at 3 PM", "3 PM" }, {
                ["index"] = v43
            })
            u1.End()
            u1.Tree({ "Night Shifts" })
            u1.Selectable({ "Shift at 6 PM", "6 PM" }, {
                ["index"] = v43
            })
            u1.Selectable({ "Shift at 9 PM", "9 PM" }, {
                ["index"] = v43
            })
            u1.End()
            u1.End()
            local v44 = u1.ComboEnum({ "Using ComboEnum" }, {
                ["index"] = Enum.UserInputState.Begin
            }, Enum.UserInputState)
            u1.Text({ "Selected: " .. v44.index:get().Name })
            u1.PopConfig()
            u1.End()
        end
    }
    local u46 = {
        "Basic",
        "Tree",
        "CollapsingHeader",
        "Group",
        "Indent",
        "Input",
        "MultiInput",
        "InputText",
        "Tooltip",
        "Selectable",
        "Combo"
    }
    local function u47() --[[ Line: 331 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u47
        --]]
        if u1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
            u47()
        end
        u1.End()
    end
    local function u50(p48) --[[ Line: 339 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u50
        --]]
        u1.Window({ "Recursive Window" }, {
            ["size"] = u1.State(Vector2.new(175, 100)),
            ["isOpened"] = p48
        })
        local v49 = u1.Checkbox({ "Recurse Again" })
        u1.End()
        if v49.isChecked.value then
            u50(v49.isChecked)
        end
    end
    local function u86() --[[ Line: 349 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u4
            [3] = u10
        --]]
        local v51 = {
            ["isOpened"] = u4
        }
        local v52 = u1.Window({ "Runtime Info" }, v51)
        local v53 = u1.Internal._lastVDOM
        local v54 = u1.Internal._states
        local v55 = u1.State(3)
        local v56 = u1.State(0)
        local v57 = u1.State(os.clock())
        u1.SameLine()
        u1.InputNum({
            "",
            [u1.Args.InputNum.Format] = "%d Seconds",
            [u1.Args.InputNum.Max] = 10
        }, {
            ["number"] = v55
        })
        if u1.Button({ "Disable" }).clicked() then
            u1.Disabled = true
            task.delay(v55:get(), function() --[[ Line: 362 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                u1.Disabled = false
            end)
        end
        u1.End()
        local v58 = os.clock()
        local v59 = v58 - v57.value
        v56.value = v56.value + (v59 - v56.value) * 0.2
        v57.value = v58
        u1.Text({ string.format("Average %.3f ms/frame (%.1f FPS)", v56.value * 1000, 1 / v56.value) })
        u1.Text({ string.format("Window Position: (%d, %d), Window Size: (%d, %d)", v52.position.value.X, v52.position.value.Y, v52.size.value.X, v52.size.value.Y) })
        u1.SameLine()
        u1.Text({ "Enter an ID to learn more about it." })
        u10("every widget and state has an ID which Iris tracks to remember which widget is which. below lists all widgets and states, with their respective IDs")
        u1.End()
        u1.PushConfig({
            ["ItemWidth"] = UDim.new(1, -150)
        })
        local v60 = u1.InputText({ "ID field" }, {
            ["text"] = u1.State(v52.ID)
        }).text.value
        u1.PopConfig()
        u1.Indent()
        local v61 = v53[v60]
        local v62 = v54[v60]
        if v61 then
            u1.Table({
                1,
                [u1.Args.Table.RowBg] = false
            })
            u1.Text({ string.format("The ID, \"%s\", is a widget", v60) })
            u1.NextRow()
            u1.Text({ string.format("Widget is type: %s", v61.type) })
            u1.NextRow()
            u1.Tree({ "Widget has Args:" }, {
                ["isUncollapsed"] = u1.State(true)
            })
            for v63, v64 in v61.arguments do
                u1.Text({ v63 .. " - " .. tostring(v64) })
            end
            u1.End()
            u1.NextRow()
            if v61.state then
                u1.Tree({ "Widget has State:" }, {
                    ["isUncollapsed"] = u1.State(true)
                })
                for v65, v66 in v61.state do
                    local v67 = u1.Text
                    local v68 = {}
                    local v69 = v66.value
                    __set_list(v68, 1, {v65 .. " - " .. tostring(v69)})
                    v67(v68)
                end
                u1.End()
            end
            u1.End()
        elseif v62 then
            u1.Table({
                1,
                [u1.Args.Table.RowBg] = false
            })
            u1.Text({ string.format("The ID, \"%s\", is a state", v60) })
            u1.NextRow()
            local v70 = u1.Text
            local v71 = {}
            local v72 = string.format
            local v73 = v62.value
            local v74 = typeof(v73)
            local v75 = v62.value
            __set_list(v71, 1, {v72("Value is type: %s, Value = %s", v74, (tostring(v75)))})
            v70(v71)
            u1.NextRow()
            u1.Tree({ "state has connected widgets:" }, {
                ["isUncollapsed"] = u1.State(true)
            })
            for v76, v77 in v62.ConnectedWidgets do
                u1.Text({ v76 .. " - " .. v77.type })
            end
            u1.End()
            u1.NextRow()
            u1.Text({ string.format("state has: %d connected functions", #v62.ConnectedFunctions) })
            u1.End()
        else
            u1.Text({ string.format("The ID, \"%s\", is not a state or widget", v60) })
        end
        u1.End()
        if u1.Tree({ "Widgets" }).isUncollapsed.value then
            local v78 = 0
            local v79 = ""
            for _, v80 in v53 do
                v78 = v78 + 1
                v79 = v79 .. "\n" .. v80.ID .. " - " .. v80.type
            end
            u1.Text({ "Number of Widgets: " .. v78 })
            u1.Text({ v79 })
        end
        u1.End()
        if u1.Tree({ "States" }).isUncollapsed.value then
            local v81 = 0
            local v82 = ""
            for v83, v84 in v54 do
                v81 = v81 + 1
                local v85 = v84.value
                v82 = v82 .. "\n" .. v83 .. " - " .. tostring(v85)
            end
            u1.Text({ "Number of States: " .. v81 })
            u1.Text({ v82 })
        end
        u1.End()
        u1.End()
    end
    local function u87() --[[ Line: 464 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u87
        --]]
        if u1.Menu({ "Recursive" }).state.isOpened.value then
            u1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl })
            u1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl })
            u1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl })
            u1.Separator()
            u1.MenuToggle({ "Autosave" })
            u1.MenuToggle({ "Checked" })
            u1.Separator()
            u1.Menu({ "Options" })
            u1.MenuItem({ "Red" })
            u1.MenuItem({ "Yellow" })
            u1.MenuItem({ "Green" })
            u1.MenuItem({ "Blue" })
            u1.Separator()
            u87()
            u1.End()
        end
        u1.End()
    end
    local function u93() --[[ Line: 488 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u87
            [3] = u3
            [4] = u6
            [5] = u7
            [6] = u4
            [7] = u5
        --]]
        u1.MenuBar()
        u1.Menu({ "File" })
        u1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl })
        u1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl })
        u1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl })
        u87()
        u1.MenuItem({ "Quit", Enum.KeyCode.Q, Enum.ModifierKey.Alt })
        u1.End()
        u1.Menu({ "Examples" })
        local v88 = {
            ["isChecked"] = u3
        }
        u1.MenuToggle({ "Recursive Window" }, v88)
        local v89 = {
            ["isChecked"] = u6
        }
        u1.MenuToggle({ "Windowless" }, v89)
        local v90 = {
            ["isChecked"] = u7
        }
        u1.MenuToggle({ "Main Menu Bar" }, v90)
        u1.End()
        u1.Menu({ "Tools" })
        local v91 = {
            ["isChecked"] = u4
        }
        u1.MenuToggle({ "Runtime Info" }, v91)
        local v92 = {
            ["isChecked"] = u5
        }
        u1.MenuToggle({ "Style Editor" }, v92)
        u1.End()
        u1.End()
    end
    local function u113() --[[ Line: 526 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u5
        --]]
        local v94 = u1.State(1)
        local v109 = {
            { "Sizing", function() --[[ Line: 532 ]]
                    --[[
                    Upvalues:
                        [1] = u1
                    --]]
                    local v95 = u1.State({})
                    if u1.Button({ "Update Config" }).clicked() then
                        u1.UpdateGlobalConfig(v95:get())
                        v95:set({})
                    end
                    for _, v96 in {
                        {
                            "ItemWidth",
                            nil,
                            UDim.new(),
                            UDim.new(1, 200)
                        },
                        {
                            "ContentWidth",
                            nil,
                            UDim.new(),
                            UDim.new(1, 200)
                        }
                    } do
                        local v97 = u1.SliderUDim({ table.unpack(v96) }, {
                            ["number"] = u1.WeakState(u1._config[v96[1]])
                        })
                        if v97.numberChanged() then
                            v95:get()[v96[1]] = v97.number:get()
                        end
                    end
                    for _, v98 in {
                        {
                            "WindowPadding",
                            nil,
                            Vector2.zero,
                            Vector2.one * 20
                        },
                        {
                            "WindowResizePadding",
                            nil,
                            Vector2.zero,
                            Vector2.one * 20
                        },
                        {
                            "FramePadding",
                            nil,
                            Vector2.zero,
                            Vector2.one * 20
                        },
                        {
                            "ItemSpacing",
                            nil,
                            Vector2.zero,
                            Vector2.one * 20
                        },
                        {
                            "ItemInnerSpacing",
                            nil,
                            Vector2.zero,
                            Vector2.one * 20
                        },
                        {
                            "CellPadding",
                            nil,
                            Vector2.zero,
                            Vector2.one * 20
                        },
                        {
                            "DisplaySafeAreaPadding",
                            nil,
                            Vector2.zero,
                            Vector2.one * 20
                        }
                    } do
                        local v99 = u1.SliderVector2({ table.unpack(v98) }, {
                            ["number"] = u1.WeakState(u1._config[v98[1]])
                        })
                        if v99.numberChanged() then
                            v95:get()[v98[1]] = v99.number:get()
                        end
                    end
                    for _, v100 in {
                        {
                            "TextSize",
                            1,
                            4,
                            20
                        },
                        {
                            "FrameBorderSize",
                            0.1,
                            0,
                            1
                        },
                        {
                            "FrameRounding",
                            1,
                            0,
                            12
                        },
                        {
                            "GrabRounding",
                            1,
                            0,
                            12
                        },
                        {
                            "WindowBorderSize",
                            0.1,
                            0,
                            1
                        },
                        {
                            "PopupBorderSize",
                            0.1,
                            0,
                            1
                        },
                        {
                            "PopupRounding",
                            1,
                            0,
                            12
                        },
                        {
                            "ScrollbarSize",
                            1,
                            0,
                            20
                        },
                        {
                            "GrabMinSize",
                            1,
                            0,
                            20
                        }
                    } do
                        local v101 = u1.SliderNum({ table.unpack(v100) }, {
                            ["number"] = u1.WeakState(u1._config[v100[1]])
                        })
                        if v101.numberChanged() then
                            v95:get()[v100[1]] = v101.number:get()
                        end
                    end
                    for _, v102 in { "WindowTitleAlign" } do
                        local v103 = u1.ComboEnum({ v102 }, {
                            ["index"] = u1.WeakState(u1._config[v102])
                        }, u1._config[v102].EnumType)
                        if v103.closed() then
                            u1.UpdateGlobalConfig({
                                [v102] = v103.index:get()
                            })
                        end
                    end
                end },
            { "Colors", function() --[[ Line: 599 ]]
                    --[[
                    Upvalues:
                        [1] = u1
                    --]]
                    local v104 = u1.State({})
                    if u1.Button({ "Update Config" }).clicked() then
                        u1.UpdateGlobalConfig(v104:get())
                        v104:set({})
                    end
                    for _, v105 in { "BorderColor", "BorderActiveColor" } do
                        local v106 = u1.InputColor3({ v105 }, {
                            ["color"] = u1.WeakState(u1._config[v105])
                        })
                        if v106.numberChanged() then
                            u1.UpdateGlobalConfig({
                                [v105] = v106.color:get()
                            })
                        end
                    end
                    for _, v107 in {
                        "Text",
                        "TextDisabled",
                        "WindowBg",
                        "ScrollbarGrab",
                        "TitleBg",
                        "TitleBgActive",
                        "TitleBgCollapsed",
                        "MenubarBg",
                        "FrameBg",
                        "FrameBgHovered",
                        "FrameBgActive",
                        "Button",
                        "ButtonHovered",
                        "ButtonActive",
                        "SliderGrab",
                        "SliderGrabActive",
                        "Header",
                        "HeaderHovered",
                        "HeaderActive",
                        "SelectionImageObject",
                        "SelectionImageObjectBorder",
                        "TableBorderStrong",
                        "TableBorderLight",
                        "TableRowBg",
                        "TableRowBgAlt",
                        "NavWindowingHighlight",
                        "NavWindowingDimBg",
                        "Separator",
                        "CheckMark"
                    } do
                        local v108 = u1.InputColor4({ v107 }, {
                            ["color"] = u1.WeakState(u1._config[v107 .. "Color"]),
                            ["transparency"] = u1.WeakState(u1._config[v107 .. "Transparency"])
                        })
                        if v108.numberChanged() then
                            v104:get()[v107 .. "Color"] = v108.color:get()
                            v104:get()[v107 .. "Transparency"] = v108.transparency:get()
                        end
                    end
                end }
        }
        local v110 = {
            ["isOpened"] = u5
        }
        u1.Window({ "Style Editor" }, v110)
        u1.Text({ "Customize the look of Iris in realtime." })
        u1.SameLine()
        if u1.SmallButton({ "Light Theme" }).clicked() then
            u1.UpdateGlobalConfig(u1.TemplateConfig.colorLight)
        end
        if u1.SmallButton({ "Dark Theme" }).clicked() then
            u1.UpdateGlobalConfig(u1.TemplateConfig.colorDark)
        end
        u1.End()
        u1.SameLine()
        if u1.SmallButton({ "Classic Size" }).clicked() then
            u1.UpdateGlobalConfig(u1.TemplateConfig.sizeDefault)
        end
        if u1.SmallButton({ "Larger Size" }).clicked() then
            u1.UpdateGlobalConfig(u1.TemplateConfig.sizeClear)
        end
        u1.End()
        if u1.SmallButton({ "Reset Everything" }).clicked() then
            u1.UpdateGlobalConfig(u1.TemplateConfig.colorDark)
            u1.UpdateGlobalConfig(u1.TemplateConfig.sizeDefault)
        end
        u1.Separator()
        u1.SameLine()
        for v111, v112 in ipairs(v109) do
            u1.RadioButton({ v112[1], v111 }, {
                ["index"] = v94
            })
        end
        u1.End()
        v109[v94:get()][2]()
        u1.End()
    end
    local function u126() --[[ Line: 699 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        u1.CollapsingHeader({ "Widget Event Interactivity" })
        local v114 = u1.State(0)
        if u1.Button({ "Click to increase Number" }).clicked() then
            v114:set(v114:get() + 1)
        end
        u1.Text({ "The Number is: " .. v114:get() })
        u1.Separator()
        local v115 = u1.State(false)
        local v116 = u1.State("clicked")
        u1.SameLine()
        u1.RadioButton({ "clicked", "clicked" }, {
            ["index"] = v116
        })
        u1.RadioButton({ "rightClicked", "rightClicked" }, {
            ["index"] = v116
        })
        u1.RadioButton({ "doubleClicked", "doubleClicked" }, {
            ["index"] = v116
        })
        u1.RadioButton({ "ctrlClicked", "ctrlClicked" }, {
            ["index"] = v116
        })
        u1.End()
        u1.SameLine()
        if u1.Button({ v116:get() .. " to reveal text" })[v116:get()]() then
            v115:set(not v115:get())
        end
        if v115:get() then
            u1.Text({ "Here i am!" })
        end
        u1.End()
        u1.Separator()
        local v117 = u1.State(0)
        u1.SameLine()
        if u1.Button({ "Click to show text for 20 frames" }).clicked() then
            v117:set(20)
        end
        if v117:get() > 0 then
            u1.Text({ "Here i am!" })
        end
        u1.End()
        local v118 = v117:get() - 1
        v117:set((math.max(0, v118)))
        u1.Text({ "Text Timer: " .. v117:get() })
        local v119 = u1.Checkbox({ "Event-tracked checkbox" })
        u1.Indent()
        local v120 = u1.Text
        local v121 = {}
        local v122 = v119.unchecked
        __set_list(v121, 1, {"unchecked: " .. tostring(v122())})
        v120(v121)
        local v123 = u1.Text
        local v124 = {}
        local v125 = v119.checked
        __set_list(v124, 1, {"checked: " .. tostring(v125())})
        v123(v124)
        u1.End()
        u1.SameLine()
        if u1.Button({ "Hover over me" }).hovered() then
            u1.Text({ "The button is hovered" })
        end
        u1.End()
        u1.End()
    end
    local function u136() --[[ Line: 755 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        u1.CollapsingHeader({ "Widget State Interactivity" })
        local v127 = u1.Checkbox({ "Widget-Generated State" })
        u1.Text({ (("isChecked: %*\n"):format(v127.state.isChecked.value)) })
        local v128 = {
            ["isChecked"] = u1.State(false)
        }
        local v129 = u1.Checkbox({ "User-Generated State" }, v128)
        u1.Text({ (("isChecked: %*\n"):format(v129.state.isChecked.value)) })
        local v130 = u1.Checkbox({ "Widget Coupled State" })
        local v131 = u1.Checkbox({ "Coupled to above Checkbox" }, {
            ["isChecked"] = v130.state.isChecked
        })
        u1.Text({ (("isChecked: %*\n"):format(v131.state.isChecked.value)) })
        local v132 = u1.State(false)
        u1.Checkbox({ "Widget and Code Coupled State" }, {
            ["isChecked"] = v132
        })
        if u1.Button({ "Click to toggle above checkbox" }).clicked() then
            v132:set(not v132:get())
        end
        u1.Text({ (("isChecked: %*\n"):format(v132.value)) })
        local v133 = u1.State(true)
        local v135 = u1.ComputedState(v133, function(p134) --[[ Line: 777 ]]
            return not p134
        end)
        u1.Checkbox({ "ComputedState (dynamic coupling)" }, {
            ["isChecked"] = v133
        })
        u1.Checkbox({ "Inverted of above checkbox" }, {
            ["isChecked"] = v135
        })
        u1.Text({ (("isChecked: %*\n"):format(v135.value)) })
        u1.End()
    end
    local function u141() --[[ Line: 787 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u10
        --]]
        u1.CollapsingHeader({ "Dynamic Styles" })
        local v137 = u1.State(0)
        u1.SameLine()
        if u1.Button({ "Change Color" }).clicked() then
            v137:set(math.random())
        end
        local v138 = u1.Text
        local v139 = {}
        local v140 = v137:get() * 255
        __set_list(v139, 1, {"Hue: " .. math.floor(v140)})
        v138(v139)
        u10("Using PushConfig with a changing value, this can be done with any config field")
        u1.End()
        u1.PushConfig({
            ["TextColor"] = Color3.fromHSV(v137:get(), 1, 1)
        })
        u1.Text({ "Text with a unique and changable color" })
        u1.PopConfig()
        u1.End()
    end
    local function u154() --[[ Line: 803 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u10
        --]]
        local v142 = u1.State(false)
        u1.CollapsingHeader({ "Tables & Columns" }, {
            ["isUncollapsed"] = v142
        })
        if v142.value == false then
            u1.End()
        else
            u1.SameLine()
            u1.Text({ "Table using NextRow and NextColumn syntax:" })
            u10("calling Iris.NextRow() in the outer loop, and Iris.NextColumn()in the inner loop")
            u1.End()
            u1.Table({ 3 })
            for v143 = 1, 4 do
                u1.NextRow()
                for v144 = 1, 3 do
                    u1.NextColumn()
                    u1.Text({ (("Row: %*, Column: %*"):format(v143, v144)) })
                end
            end
            u1.End()
            u1.Text({ "" })
            u1.SameLine()
            u1.Text({ "Table using NextColumn only syntax:" })
            u10("only calling Iris.NextColumn() in the inner loop, the result is identical")
            u1.End()
            u1.Table({ 2 })
            for v145 = 1, 4 do
                for v146 = 1, 2 do
                    u1.NextColumn()
                    u1.Text({ (("Row: %*, Column: %*"):format(v145, v146)) })
                end
            end
            u1.End()
            u1.Separator()
            local v147 = u1.State(false)
            local v148 = u1.State(false)
            local v149 = u1.State(true)
            local v150 = u1.State(true)
            local v151 = u1.State(3)
            u1.Text({ "Table with Customizable Arguments" })
            u1.Table({
                4,
                [u1.Args.Table.RowBg] = v147.value,
                [u1.Args.Table.BordersOuter] = v148.value,
                [u1.Args.Table.BordersInner] = v149.value
            })
            for v152 = 1, v151:get() do
                for v153 = 1, 4 do
                    u1.NextColumn()
                    if v150.value then
                        u1.Button({ (("Month: %*, Week: %*"):format(v152, v153)) })
                    else
                        u1.Text({ (("Month: %*, Week: %*"):format(v152, v153)) })
                    end
                end
            end
            u1.End()
            u1.Checkbox({ "RowBg" }, {
                ["isChecked"] = v147
            })
            u1.Checkbox({ "BordersOuter" }, {
                ["isChecked"] = v148
            })
            u1.Checkbox({ "BordersInner" }, {
                ["isChecked"] = v149
            })
            u1.SameLine()
            u1.RadioButton({ "Buttons", true }, {
                ["index"] = v150
            })
            u1.RadioButton({ "Text", false }, {
                ["index"] = v150
            })
            u1.End()
            u1.InputNum({
                "Number of rows",
                [u1.Args.InputNum.Min] = 0,
                [u1.Args.InputNum.Max] = 100,
                [u1.Args.InputNum.Format] = "%d"
            }, {
                ["number"] = v151
            })
            u1.End()
        end
    end
    local function u157() --[[ Line: 888 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u10
        --]]
        u1.CollapsingHeader({ "Widget Layout" })
        u1.Tree({ "Content Width" })
        local v155 = u1.State(50)
        local v156 = u1.State(Enum.Axis.X)
        u1.Text({ "The Content Width is a size property which determines the width of input fields." })
        u1.SameLine()
        u1.Text({ "By default the value is UDim.new(0.65, 0)" })
        u10("This is the default value from Dear ImGui.\nIt is 65% of the window width.")
        u1.End()
        u1.Text({ "This works well, but sometimes we know how wide elements are going to be and want to maximise the space." })
        u1.Text({ "Therefore, we can use Iris.PushConfig() to change the width" })
        u1.Separator()
        u1.SameLine()
        u1.Text({ "Content Width = 150 pixels" })
        u10("UDim.new(0, 150)")
        u1.End()
        u1.PushConfig({
            ["ContentWidth"] = UDim.new(0, 150)
        })
        u1.DragNum({
            "number",
            1,
            0,
            100
        }, {
            ["number"] = v155
        })
        u1.ComboEnum({ "axis" }, {
            ["index"] = v156
        }, Enum.Axis)
        u1.PopConfig()
        u1.SameLine()
        u1.Text({ "Content Width = 50% window width" })
        u10("UDim.new(0.5, 0)")
        u1.End()
        u1.PushConfig({
            ["ContentWidth"] = UDim.new(0.5, 0)
        })
        u1.DragNum({
            "number",
            1,
            0,
            100
        }, {
            ["number"] = v155
        })
        u1.ComboEnum({ "axis" }, {
            ["index"] = v156
        }, Enum.Axis)
        u1.PopConfig()
        u1.SameLine()
        u1.Text({ "Content Width = -150 pixels from the right side" })
        u10("UDim.new(1, -150)")
        u1.End()
        u1.PushConfig({
            ["ContentWidth"] = UDim.new(1, -150)
        })
        u1.DragNum({
            "number",
            1,
            0,
            100
        }, {
            ["number"] = v155
        })
        u1.InputEnum({ "axis" }, {
            ["index"] = v156
        }, Enum.Axis)
        u1.PopConfig()
        u1.End()
        u1.End()
    end
    local function u158() --[[ Line: 935 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u10
        --]]
        u1.PushConfig({
            ["ItemWidth"] = UDim.new(0, 150)
        })
        u1.SameLine()
        u1.TextWrapped({ "Windowless widgets" })
        u10("Widgets which are placed outside of a window will appear on the top left side of the screen.")
        u1.End()
        u1.Button({})
        u1.Tree({})
        u1.InputText({})
        u1.End()
        u1.PopConfig()
    end
    return function() --[[ Line: 949 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
            [3] = u93
            [4] = u126
            [5] = u136
            [6] = u47
            [7] = u141
            [8] = u46
            [9] = u45
            [10] = u154
            [11] = u157
            [12] = u3
            [13] = u50
            [14] = u4
            [15] = u86
            [16] = u5
            [17] = u113
            [18] = u6
            [19] = u158
            [20] = u7
        --]]
        local v159 = u1.State(false)
        local v160 = u1.State(false)
        local v161 = u1.State(false)
        local v162 = u1.State(true)
        local v163 = u1.State(false)
        local v164 = u1.State(false)
        local v165 = u1.State(false)
        local v166 = u1.State(false)
        local v167 = u1.State(false)
        if u2.value == false then
            local v168 = {
                ["isChecked"] = u2
            }
            u1.Checkbox({ "Open main window" }, v168)
        else
            u1.Window({
                "Iris Demo Window",
                [u1.Args.Window.NoTitleBar] = v159.value,
                [u1.Args.Window.NoBackground] = v160.value,
                [u1.Args.Window.NoCollapse] = v161.value,
                [u1.Args.Window.NoClose] = v162.value,
                [u1.Args.Window.NoMove] = v163.value,
                [u1.Args.Window.NoScrollbar] = v164.value,
                [u1.Args.Window.NoResize] = v165.value,
                [u1.Args.Window.NoNav] = v166.value,
                [u1.Args.Window.NoMenu] = v167.value
            }, {
                ["size"] = u1.State(Vector2.new(600, 550)),
                ["position"] = u1.State(Vector2.new(100, 25)),
                ["isOpened"] = u2
            })
            u93()
            u1.Text({ "Iris says hello. (2.1.1)" })
            u1.CollapsingHeader({ "Window Options" })
            u1.Table({
                3,
                false,
                false,
                false
            })
            u1.NextColumn()
            u1.Checkbox({ "NoTitleBar" }, {
                ["isChecked"] = v159
            })
            u1.NextColumn()
            u1.Checkbox({ "NoBackground" }, {
                ["isChecked"] = v160
            })
            u1.NextColumn()
            u1.Checkbox({ "NoCollapse" }, {
                ["isChecked"] = v161
            })
            u1.NextColumn()
            u1.Checkbox({ "NoClose" }, {
                ["isChecked"] = v162
            })
            u1.NextColumn()
            u1.Checkbox({ "NoMove" }, {
                ["isChecked"] = v163
            })
            u1.NextColumn()
            u1.Checkbox({ "NoScrollbar" }, {
                ["isChecked"] = v164
            })
            u1.NextColumn()
            u1.Checkbox({ "NoResize" }, {
                ["isChecked"] = v165
            })
            u1.NextColumn()
            u1.Checkbox({ "NoNav" }, {
                ["isChecked"] = v166
            })
            u1.NextColumn()
            u1.Checkbox({ "NoMenu" }, {
                ["isChecked"] = v167
            })
            u1.End()
            u1.End()
            u126()
            u136()
            u1.CollapsingHeader({ "Recursive Tree" })
            if u1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
                u47()
            end
            u1.End()
            u1.End()
            u141()
            u1.Separator()
            u1.CollapsingHeader({ "Widgets" })
            for _, v169 in u46 do
                u45[v169]()
            end
            u1.End()
            u154()
            u157()
            u1.End()
            if u3.value then
                u50(u3)
            end
            if u4.value then
                u86()
            end
            if u5.value then
                u113()
            end
            if u6.value then
                u158()
            end
            if u7.value then
                local _ = u1.Internal._rootWidget.Instance.PseudoWindowScreenGui.AbsoluteSize
                u93()
            end
        end
    end
end