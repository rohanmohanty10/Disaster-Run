 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Soru]
local v3 = game.Players.LocalPlayer
local u4 = game.ReplicatedStorage:FindFirstChild("Stats" .. v3.Name)
require(game.ReplicatedStorage.Modules.FastWait)
game:GetService("UserInputService")
require(game.ReplicatedStorage.Modules.LightningBolt)
require(game.ReplicatedStorage.Modules.LightningBolt.LightningSparks)
function v1.start(_, _) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    local v5 = game.Players.LocalPlayer.Character
    local v6 = u2.GetM("GoroDash")
    if _G.instantDash == false then
        return
    elseif not v6.stamreq or u4.Stamina.Value >= v6.stamreq then
        if not v6.statreq or _G.MeetReq(u2.GetM("GoroDash").statreq) ~= false then
            local v7 = v5.Humanoid.MoveDirection
            if v7 == Vector3.new(0, 0, 0) then
                v7 = v5.HumanoidRootPart.CFrame.LookVector * 1
            end
            local v8 = CFrame.new(v5.HumanoidRootPart.CFrame.p, v7 + v5.HumanoidRootPart.CFrame.p).lookVector * 15
            local v9 = Ray.new(v5.HumanoidRootPart.Position, v8)
            local v10, v11 = _G.raycastWhitelist(v9, { workspace.Islands, workspace.Ships, workspace.Env })
            local v12 = (v5.HumanoidRootPart.Position - v11).magnitude
            local v13 = v12 < 2 and 0 or v12
            local v14 = v5.HumanoidRootPart.CFrame
            local v15, _, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25 = (CFrame.new(v14.p, v11) * CFrame.new(0, 0, -v13)):components()
            local v26 = CFrame.new(v15, v14.Y, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25)
            if v10 then
                v26 = v26 * CFrame.new(0, 1, 0)
            end
            if v26 ~= v26 then
                return true
            end
            if game.ReplicatedStorage.Events.Skill:InvokeServer("GoroDash", {
                ["old"] = v14,
                ["new"] = v26
            }) == true then
                v5:PivotTo(v26)
                _G.PlayEffect("GoroDash", nil, v14, v5.HumanoidRootPart.CFrame)
            end
            task.wait(0.75)
            return true
        end
    end
end
return v1