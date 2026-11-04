 

local u1 = game:GetService("UserInputService")
local u2 = Enum.UserInputType.Touch
local u3 = Enum.UserInputType.Keyboard
local u4 = nil
local u5 = {}
local function u9(p6) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    local v7 = game:GetService("GuiService"):IsTenFootInterface()
    if v7 == true then
        game.ReplicatedStorage.Events.updateDeviceInput:FireServer("Controller")
    end
    if p6 ~= u4.Current then
        u4.Current = p6
        for _, v8 in ipairs(u5) do
            task.spawn(v8, p6)
        end
        if v7 == false then
            game.ReplicatedStorage.Events.updateDeviceInput:FireServer(p6)
        end
    end
end
local function u11(p10) --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u9
        [3] = u2
    --]]
    if p10 == u3 or p10.Name:sub(1, 5) == "Mouse" then
        u9("KeyboardMouse")
        _G.mobile = false
        return
    elseif p10 == u2 then
        u9("Mobile")
        _G.mobile = true
    elseif p10.Name:sub(1, 7) == "Gamepad" then
        u9("Controller")
        _G.mobile = false
    end
end
u4 = {
    ["Current"] = "KeyboardMouse",
    ["Observe"] = function(u12) --[[ Name: Observe, Line 54 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u4
        --]]
        if table.find(u5, u12) then
            error("function already subscribed", 2)
        end
        local v13 = u5
        table.insert(v13, u12)
        task.spawn(u12, u4.Current)
        return function() --[[ Line: 62 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u12
            --]]
            local v14 = table.find(u5, u12)
            if v14 then
                local v15 = #u5
                local v16 = u5
                u5[v14] = u5[v15]
                v16[v15] = nil
            end
        end
    end,
    ["Update"] = function() --[[ Name: Update, Line 71 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u1
        --]]
        u11(u1:GetLastInputType())
    end
}
game.ReplicatedStorage.Events.updateDeviceInput:FireServer("KeyboardMouse")
u11(u1:GetLastInputType())
u1.LastInputTypeChanged:Connect(u11)
return u4