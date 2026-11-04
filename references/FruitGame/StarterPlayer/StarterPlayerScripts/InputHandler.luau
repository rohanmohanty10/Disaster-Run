 

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("UserInputService")
local u4 = v1.LocalPlayer
u4:WaitForChild("PlayerGui")
u4:WaitForChild("Backpack")
local u5 = require(script:WaitForChild("GetPreferredInput"))
local u17 = {
    ["InputsRegistered"] = {},
    ["Inputs"] = {},
    ["DeviceDetected"] = require(v2.Modules.Shared.Signals.Signal).new(),
    ["GetCurrentInput"] = function(_) --[[ Name: GetCurrentInput, Line 18 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        return u5.Current
    end,
    ["_addInput"] = function(_, p6) --[[ Name: _addInput, Line 22 ]]
        --[[
        Upvalues:
            [1] = u17
        --]]
        warn("Adding INPUT FOR", p6)
        local v7 = require(script.DeviceInputs[p6])
        v7:Initialize()
        u17.Inputs[p6] = v7
        u17.InputsRegistered[p6] = true
        warn("ADDED INPUT FOR", p6)
    end,
    ["Initialize"] = function(u8) --[[ Name: Initialize, Line 32 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
            [3] = u5
            [4] = u17
        --]]
        warn("initalziing input handler")
        if u4.Character == nil then
            repeat
                task.wait()
            until u4.Character
            u4.Character:WaitForChild("HumanoidRootPart")
        end
        if _G.displayMessage == nil then
            repeat
                task.wait()
            until _G.displayMessage ~= nil
        end
        local u9 = false
        local u10 = game:GetService("GuiService"):IsTenFootInterface()
        if u5.Current then
            if u10 == true then
                print("its controller, check for kbm")
                print(u3.MouseEnabled, u3.KeyboardEnabled)
                if u9 ~= true then
                    u9 = true
                    _G.displayMessage("You are playing on CONSOLE, some features such as the <Color=Red>CHAT have been disabled<Color=/> due to ROBLOX guidelines. <Color=Orange>A MOUSE AND KEYBOARD IS REQUIRED TO PLAY!")
                end
            end
            u8:_addInput(u5.Current)
        else
            warn("NO CURRENT FOR INPUT HANDLER NOT DOING ADDINPIT")
        end
        u5.Observe(function(p11) --[[ Line: 74 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u10
                [3] = u3
                [4] = u9
                [5] = u8
            --]]
            if not u17.InputsRegistered[p11] then
                task.wait()
                if u10 == true then
                    print("its controller, check for kbm")
                    print(u3.MouseEnabled, u3.KeyboardEnabled)
                    if u9 ~= true then
                        u9 = true
                        _G.displayMessage("You are playing on CONSOLE, some features such as the <Color=Red>CHAT have been disabled<Color=/> due to ROBLOX guidelines. <Color=Orange>A MOUSE AND KEYBOARD IS REQUIRED TO PLAY!")
                    end
                end
                u8:_addInput(p11)
            end
        end)
        u5.Update()
        local u12 = u3.KeyboardEnabled
        local u13 = u3.MouseEnabled
        if u10 == true then
            u3.InputBegan:Connect(function(p14, p15) --[[ Line: 92 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u13
                --]]
                if p15 then
                    return
                elseif p14.UserInputType == Enum.UserInputType.Keyboard then
                    if u12 == false then
                        _G.displayMessage("<Color=Green>Keyboard Detected!")
                    end
                    u12 = true
                elseif p14.UserInputType.Name:match("Mouse") ~= nil then
                    if u13 == false then
                        _G.displayMessage("<Color=Green>Mouse Detected!")
                    end
                    u13 = true
                end
            end)
        end
        task.spawn(function() --[[ Line: 111 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u12
                [3] = u13
            --]]
            if u10 == true then
                while task.wait(3) do
                    local v16 = {}
                    if u12 == false then
                        table.insert(v16, "Keyboard")
                    end
                    if u13 == false then
                        table.insert(v16, "Mouse")
                    end
                    if #v16 > 0 then
                        _G.displayMessage("<Color=Red>A " .. table.concat(v16, ",") .. " is required to play the game.")
                    end
                end
            end
        end)
        warn("FINISHED initalziing input handler")
    end
}
return u17