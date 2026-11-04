 

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
    local v6 = u2.GetM("PikaDashV2")
    if _G.instantDash == false then
        return
    elseif not v6.stamreq or u4.Stamina.Value >= v6.stamreq then
        if not v6.statreq or _G.MeetReq(u2.GetM("PikaDashV2").statreq) ~= false then
            local v7 = v5.Humanoid.Health / v5.Humanoid.MaxHealth <= 0.75 and 15 or 25
            local v8 = v5.Humanoid.MoveDirection
            if v8 == Vector3.new(0, 0, 0) then
                v8 = v5.HumanoidRootPart.CFrame.LookVector * 1
            end
            local v9 = CFrame.new(v5.HumanoidRootPart.CFrame.p, v8 + v5.HumanoidRootPart.CFrame.p).lookVector * v7
            local v10 = Ray.new(v5.HumanoidRootPart.Position, v9)
            local v11, v12 = _G.raycastWhitelist(v10, { workspace.Islands, workspace.Ships, workspace.Env })
            local v13 = (v5.HumanoidRootPart.Position - v12).magnitude
            local v14 = v13 < 2 and 0 or v13
            local v15 = v5.HumanoidRootPart.CFrame
            local v16, _, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26 = (CFrame.new(v15.p, v12) * CFrame.new(0, 0, -v14)):components()
            local v27 = CFrame.new(v16, v15.Y, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26)
            if v11 then
                v27 = v27 * CFrame.new(0, 1, 0)
            end
            if v27 ~= v27 then
                return true
            end
            if game.ReplicatedStorage.Events.Skill:InvokeServer("PikaDashV2", {
                ["old"] = v15,
                ["new"] = v27
            }) == true then
                v5:PivotTo(v27)
                _G.PlayEffect("PikaDashV2", nil, v15, v5.HumanoidRootPart.CFrame)
            end
            task.wait(0.75)
            return true
        end
    end
end
return v1