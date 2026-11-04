 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local u3 = game:GetService("UserInputService")
local v4 = v1.Modules
local u5 = v2.LocalPlayer
require(v4.ContextActionService)
local v6 = require(script.Parent.Shared)
local u7 = setmetatable({}, v6)
u7.__index = u7
_G.mobileJumpHeld = false
local u8 = require(u5.Backpack:WaitForChild("InputCallbacks"))
function u7.new(_) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u8
        [3] = u3
        [4] = u5
    --]]
    local v9 = u7
    local v10 = setmetatable({}, v9)
    local u11 = false
    local u12 = 0
    local function u13() --[[ Line: 27 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u12
            [3] = u8
        --]]
        if game.Players.LocalPlayer.Character == nil then
            return
        elseif u11 == true then
            return
        elseif tick() - u12 >= 0.05 then
            u11 = true
            u12 = tick()
            if u8 then
                pcall(function() --[[ Line: 45 ]]
                    --[[
                    Upvalues:
                        [1] = u8
                    --]]
                    u8.Callbacks.Geppo:Mobile_Activate()
                end)
            end
            u11 = false
        end
    end
    if u3.TouchEnabled then
        local v14 = u5.PlayerGui:WaitForChild("TouchGui"):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton")
        v14.MouseButton1Down:Connect(function() --[[ Line: 59 ]]
            --[[
            Upvalues:
                [1] = u13
            --]]
            _G.mobileJumpHeld = true
            u13()
        end)
        v14.MouseButton1Up:Connect(function() --[[ Line: 68 ]]
            _G.mobileJumpHeld = false
        end)
    end
    return v10
end
game.Players.LocalPlayer.CharacterRemoving:Connect(function() --[[ Line: 97 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    u8 = nil
end)
game.Players.LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 101 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u5
    --]]
    u8 = require(u5.Backpack:WaitForChild("InputCallbacks"))
end)
return u7