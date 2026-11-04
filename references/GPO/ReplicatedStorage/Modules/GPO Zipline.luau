 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local u3 = game:GetService("UserInputService")
local u4 = game:GetService("RunService")
local u5 = v2.LocalPlayer
local v6 = workspace:WaitForChild("ZipLines")
local u7 = v1.Events.ZiplineRemote
local u8 = game.ReplicatedStorage:WaitForChild("Stats" .. u5.Name)
local u9 = OverlapParams.new()
u9.FilterDescendantsInstances = { v6 }
u9.FilterType = Enum.RaycastFilterType.Include
local u10 = require(script.Zipline)
local u17 = {
    ["_currentZipline"] = nil,
    ["_updateThread"] = nil,
    ["_isOnCooldown"] = false,
    ["_cooldown"] = 0.5,
    ["_radius"] = 5,
    ["_applyCooldown"] = function() --[[ Name: _applyCooldown, Line 29 ]]
        --[[
        Upvalues:
            [1] = u17
        --]]
        if u17._isOnCooldown and coroutine.status(u17._isOnCooldown) ~= "dead" then
            task.defer(task.cancel, u17._isOnCooldown)
        end
        u17._isOnCooldown = task.delay(u17._cooldown, function() --[[ Line: 34 ]]
            --[[
            Upvalues:
                [1] = u17
            --]]
            u17._isOnCooldown = false
        end)
    end,
    ["_exit"] = function() --[[ Name: _exit, Line 39 ]]
        --[[
        Upvalues:
            [1] = u17
        --]]
        if u17._currentZipline then
            u17._currentZipline:Exit()
        end
    end,
    ["_validate"] = function() --[[ Name: _validate, Line 44 ]]
        --[[
        Upvalues:
            [1] = u17
        --]]
        return not u17._isOnCooldown
    end,
    ["_detectZiplinePart"] = function(_, p11) --[[ Name: _detectZiplinePart, Line 48 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u9
        --]]
        local v12 = workspace:GetPartBoundsInRadius(p11.Position, u17._radius, u9)
        local v13 = u17._radius
        local v14 = nil
        for _, v15 in v12 do
            local v16 = (v15.Position - p11.Position).Magnitude
            if v16 > v13 then
                v14 = v15
                v13 = v16
            end
        end
        return v14
    end
}
local u18 = 0
function u17._update(p19) --[[ Line: 67 ]]
    --[[
    Upvalues:
        [1] = u17
        [2] = u5
        [3] = u8
        [4] = u18
        [5] = u10
        [6] = u7
    --]]
    if u17._validate() then
        local v20 = u5.Character
        if v20.PrimaryPart ~= nil then
            local v21 = v20.PrimaryPart
            if u17._currentZipline then
                u17._currentZipline:Update(p19)
            else
                local v22 = u17._detectZiplinePart(v20, v21)
                local v23
                if v22 then
                    v23 = v22.Position.Y
                else
                    v23 = v22
                end
                local v24 = v21.Position.Y
                if v22 and (_G.canuse == true and (_G.check:inspect(v20) == true and (v20:FindFirstChild("Blocking") == nil and v20:GetAttribute("flyMode") == nil))) then
                    local v25 = u8.Stamina.MaxValue * 0.08
                    if u8.Stamina.Value < v25 then
                        if tick() - u18 >= 1 then
                            _G.StamRed(v25)
                            u18 = tick()
                        end
                        return
                    end
                    local v26 = v24 < v23 and -1 or 1
                    local v27 = u10.new(v20, v22, v26)
                    v27:Enter()
                    v27.Destroyed:Connect(function() --[[ Line: 105 ]]
                        --[[
                        Upvalues:
                            [1] = u17
                            [2] = u7
                        --]]
                        u17._currentZipline = nil
                        u17._applyCooldown()
                        u7:InvokeServer("Exit")
                    end)
                    u17._currentZipline = v27
                    u7:InvokeServer("Enter", v26, v21.Position)
                    if v20:GetAttribute("ZiplineBypass") == nil then
                        u17._currentZipline:Exit(true)
                        return
                    end
                end
            end
        end
    else
        return
    end
end
function u17._toggleDetection(p28) --[[ Line: 123 ]]
    --[[
    Upvalues:
        [1] = u17
        [2] = u4
    --]]
    if u17._updateThread or not p28 then
        if u17._updateThread and not p28 then
            u17._updateThread:Disconnect()
            u17._updateThread = nil
            if u17._currentZipline then
                u17._currentZipline:Exit()
            end
        end
    else
        local u29 = 0
        u17._updateThread = u4.Heartbeat:Connect(function(p30) --[[ Line: 127 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u29
            --]]
            if not u17._currentZipline then
                if tick() - u29 <= 0.06666666666666667 then
                    return
                end
                u29 = tick()
            end
            u17._update(p30)
        end)
    end
end
function u17._handleCharacter() --[[ Line: 148 ]]
    --[[
    Upvalues:
        [1] = u17
        [2] = u5
    --]]
    local function v33(p31) --[[ Line: 150 ]]
        --[[
        Upvalues:
            [1] = u17
        --]]
        u17._toggleDetection(false)
        p31:WaitForChild("Humanoid").StateChanged:Connect(function(_, p32) --[[ Line: 154 ]]
            --[[
            Upvalues:
                [1] = u17
            --]]
            if u17._currentZipline then
                return
            elseif p32 == Enum.HumanoidStateType.Landed then
                u17._toggleDetection(false)
            elseif p32 == Enum.HumanoidStateType.Jumping or p32 == Enum.HumanoidStateType.Freefall then
                u17._toggleDetection(true)
            end
        end)
    end
    local v34 = u5.Character or u5.CharacterAdded:Wait()
    u17._toggleDetection(false)
    v34:WaitForChild("Humanoid").StateChanged:Connect(function(_, p35) --[[ Line: 154 ]]
        --[[
        Upvalues:
            [1] = u17
        --]]
        if u17._currentZipline then
            return
        elseif p35 == Enum.HumanoidStateType.Landed then
            u17._toggleDetection(false)
        elseif p35 == Enum.HumanoidStateType.Jumping or p35 == Enum.HumanoidStateType.Freefall then
            u17._toggleDetection(true)
        end
    end)
    u5.CharacterAdded:Connect(v33)
end
function u17._handleInputs() --[[ Line: 168 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u17
    --]]
    u3.InputBegan:Connect(function(p36, p37) --[[ Line: 169 ]]
        --[[
        Upvalues:
            [1] = u17
        --]]
        if p37 then
            return
        elseif p36.KeyCode == Enum.KeyCode.Space then
            if u17._currentZipline then
                u17._currentZipline:Exit(true)
            end
        else
            return
        end
    end)
    u3.JumpRequest:Connect(function() --[[ Line: 179 ]]
        --[[
        Upvalues:
            [1] = u17
        --]]
        if _G.mobile == false then
            return
        elseif u17._currentZipline then
            u17._currentZipline:Exit(true)
        end
    end)
end
function u17.Initialize() --[[ Line: 190 ]]
    --[[
    Upvalues:
        [1] = u17
    --]]
    print("client init")
    u17._handleCharacter()
    u17._handleInputs()
end
return u17