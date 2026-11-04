 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
require(game.ReplicatedStorage.Modules.Skills)
local u2 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u3 = setmetatable({}, u2)
u3.__index = u3
function u3.new(_) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local v4 = u2.new(script.Name)
    local v5 = u3
    local v6 = setmetatable(v4, v5)
    v6.Cooldowns = {
        ["fear"] = false
    }
    return v6
end
function u3.ExitMount(p7, _) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local _ = p7.Cooldowns
    local v8 = u1.Character
    local v9 = v8.Humanoid.SeatPart
    if v9 == nil then
        return
    else
        local v10 = v9.Parent
        if v10.Info.inRace.Value ~= true then
            game:GetService("ContextActionService"):UnbindAction("LockSeat")
            v8.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
            v8.Humanoid.Jump = true
            v10.Seat.unsit:InvokeServer()
            v8.HumanoidRootPart.Velocity = Vector3.new()
            v8.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        end
    end
end
return u3