 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Soru]
local v3 = game.Players.LocalPlayer
local u4 = game.ReplicatedStorage:FindFirstChild("Stats" .. v3.Name)
require(game.ReplicatedStorage.Modules.FastWait)
game:GetService("UserInputService")
function v1.start(_, _) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    local v5 = game.Players.LocalPlayer.Character
    local v6 = u2.GetM("Spring Dash")
    if _G.instantDash == false then
        return
    elseif not v6.stamreq or u4.Stamina.Value >= v6.stamreq then
        if not v6.statreq or _G.MeetReq(u2.GetM("Spring Dash").statreq) ~= false then
            if v5.Humanoid.MoveDirection == Vector3.new(0, 0, 0) then
                local _ = v5.HumanoidRootPart.CFrame.LookVector * 1
            end
            if game.ReplicatedStorage.Events.Skill:InvokeServer("Spring Dash") == true then
                _G.PlayEffect("SpringDash", nil, v5)
            end
            task.wait(0.5)
            return true
        end
    end
end
return v1