 

local v1 = game:GetService("CollectionService")
local u2 = game:GetService("Players")
local u3 = game:GetService("RunService")
local u4 = {
    [Enum.HumanoidStateType.Physics] = true
}
local u5 = {}
local u6 = {}
local function u15(p7, p8) --[[ Line: 16 ]]
    local v9 = p7:FindFirstChild("HumanoidRootPart")
    if v9 then
        local _ = v9.AssemblyLinearVelocity
        for _, v10 in ipairs(p8:GetChildren()) do
            if v10:IsA("BallSocketConstraint") or v10:IsA("HingeConstraint") then
                local v11 = v10.Attachment0
                local v12 = v10.Attachment1
                if v11 and (v12 and (v11.Parent and v12.Parent)) then
                    local v13 = v11.Parent
                    local v14 = v12.Parent
                    if ((v13.CFrame * v11.CFrame).Position - (v14.CFrame * v12.CFrame).Position).Magnitude > 1 + v14.Size.Y * 1.5 then
                        v14.CFrame = v13.CFrame * v11.CFrame * v12.CFrame:Inverse()
                    end
                end
            end
        end
    end
end
local function u26(u16, p17) --[[ Line: 62 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u6
        [4] = u15
    --]]
    local u18 = u16.Parent
    if not u18 then
        return
    end
    local u19 = u18:WaitForChild("RagdollConstraints", 0.5)
    if not u19 then
        return
    end
    local v20 = u3:IsServer() and true or u2:GetPlayerFromCharacter(u16.Parent) == u2.LocalPlayer
    if u3:IsServer() == true then
        v20 = u16:IsDescendantOf(workspace.NPCs) and true or false
    end
    if p17 then
        if not u6[u16] and v20 == true then
            u6[u16] = u3.Heartbeat:Connect(function() --[[ Line: 86 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u15
                    [3] = u18
                    [4] = u19
                    [5] = u6
                --]]
                if u16:IsDescendantOf(workspace) then
                    u15(u18, u19)
                elseif u6[u16] then
                    u6[u16]:Disconnect()
                    u6[u16] = nil
                end
            end)
        end
    elseif u6[u16] then
        u6[u16]:Disconnect()
        u6[u16] = nil
    end
    for _, v21 in ipairs(u19:GetChildren()) do
        if v21:IsA("Constraint") then
            local v22 = v21.Attachment1
            if v22 then
                ::l24::
                local v23 = v21.RigidJoint.Value
                local v24
                if p17 then
                    v24 = nil
                else
                    v24 = v22.Parent or nil
                end
                if v23 ~= nil and v23.Part1 ~= v24 then
                    v23.Part1 = v24
                end
            else
                for v25 = 1, 6 do
                    v22 = v21.Attachment1
                    if v22 then
                        break
                    end
                    task.wait(v25 * 0.1)
                end
                if v22 then
                    goto l24
                end
            end
        end
    end
    if p17 == true then
        u16:SetAttribute("isRagdolled", true)
    elseif u16:GetAttribute("forcedRagdoll") == nil then
        u16:SetAttribute("isRagdolled", nil)
    end
end
local function v32(u27) --[[ Line: 136 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u4
        [3] = u3
        [4] = u2
        [5] = u26
    --]]
    u5[u27] = u27.StateChanged:Connect(function(_, p28) --[[ Line: 137 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u27
            [3] = u3
            [4] = u2
            [5] = u26
        --]]
        local v29 = u4[p28]
        local v30 = u27
        if u3:IsServer() and true or u2:GetPlayerFromCharacter(v30.Parent) == u2.LocalPlayer then
            if v29 == true then
                u26(u27, true)
                return
            end
            u26(u27, false)
        end
    end)
    if _G.Ragdolls ~= nil then
        _G.Ragdolls[u27] = function(p31) --[[ Line: 149 ]]
            --[[
            Upvalues:
                [1] = u26
                [2] = u27
            --]]
            if p31 == true then
                u26(u27, true)
            else
                u26(u27, false)
            end
        end
    end
end
v1:GetInstanceAddedSignal("Ragdoll"):Connect(v32)
v1:GetInstanceRemovedSignal("Ragdoll"):Connect(function(p33) --[[ Name: ragdollRemoved, Line 159 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
    --]]
    if u5[p33] then
        u5[p33]:Disconnect()
        u5[p33] = nil
    end
    if u6[p33] then
        u6[p33]:Disconnect()
        u6[p33] = nil
    end
    if _G.Ragdolls then
        _G.Ragdolls[p33] = nil
    end
end)
for _, v34 in ipairs(v1:GetTagged("Ragdoll")) do
    v32(v34)
end
return nil