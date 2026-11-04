 

local v1 = game:GetService("ReplicatedStorage"):WaitForChild("RagdollHandler")
require(v1)
_G.Ragdolls = {}
require(game.ReplicatedStorage:WaitForChild("buildRagdoll"))
local u2 = false
function _G.forceRagdoll(p3, p4) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v5 = p3:FindFirstChild("Humanoid")
    if v5 ~= nil then
        if p4 == false then
            v5:ChangeState(Enum.HumanoidStateType.GettingUp)
            v5.AutoRotate = true
            u2 = true
        end
    end
end
game.ReplicatedStorage.Events.Ragdoll.OnClientEvent:Connect(function(p6, p7) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p6 ~= nil and (not p6 or p6:findFirstChild("HumanoidRootPart") ~= nil) then
        local v8 = p6:FindFirstChild("Humanoid")
        if v8 then
            if p7 == true then
                u2 = false
                if p6.PrimaryPart.Anchored == true then
                    v8:ChangeState(Enum.HumanoidStateType.GettingUp)
                    v8.AutoRotate = true
                else
                    repeat
                        task.wait()
                        v8.AutoRotate = false
                        v8:ChangeState(Enum.HumanoidStateType.Physics)
                    until u2 == true or p6:GetAttribute("RagdollTrigger") == nil and p6.Parent ~= workspace.Ragdolls
                    v8:ChangeState(Enum.HumanoidStateType.GettingUp)
                    v8.AutoRotate = true
                    u2 = true
                end
            end
            v8:ChangeState(Enum.HumanoidStateType.GettingUp)
            v8.AutoRotate = true
            u2 = true
        end
    end
end)