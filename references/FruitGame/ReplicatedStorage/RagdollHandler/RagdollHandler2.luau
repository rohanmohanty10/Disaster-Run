 

local v1 = game:GetService("CollectionService")
local u2 = game:GetService("Players")
local u3 = game:GetService("RunService")
local u4 = {
    [Enum.HumanoidStateType.Physics] = true
}
local u5 = {}
local function u15(p6, p7) --[[ Line: 15 ]]
    local v8 = p6.Parent
    if not v8 then
        return
    end
    local v9 = v8:WaitForChild("RagdollConstraints", 0.5)
    if not v9 then
        return
    end
    for _, v10 in ipairs(v9:GetChildren()) do
        if v10:IsA("Constraint") then
            local v11 = v10.Attachment1
            if v11 then
                ::l9::
                local v12 = v10.RigidJoint.Value
                local v13
                if p7 then
                    v13 = nil
                else
                    v13 = v11.Parent or nil
                end
                if v12 ~= nil and v12.Part1 ~= v13 then
                    v12.Part1 = v13
                end
            else
                for v14 = 1, 6 do
                    v11 = v10.Attachment1
                    if v11 then
                        break
                    end
                    task.wait(v14 * 0.1)
                end
                if v11 then
                    goto l9
                end
            end
        end
    end
    if p7 == true then
        p6:SetAttribute("isRagdolled", true)
    elseif p6:GetAttribute("forcedRagdoll") == nil then
        p6:SetAttribute("isRagdolled", nil)
    end
end
local function v21(u16) --[[ Line: 81 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u4
        [3] = u3
        [4] = u2
        [5] = u15
    --]]
    u5[u16] = u16.StateChanged:Connect(function(_, p17) --[[ Line: 82 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u16
            [3] = u3
            [4] = u2
            [5] = u15
        --]]
        local v18 = u4[p17]
        local v19 = u16
        if u3:IsServer() and true or u2:GetPlayerFromCharacter(v19.Parent) == u2.LocalPlayer then
            if v18 == true then
                u15(u16, true)
                return
            end
            u15(u16, false)
        end
    end)
    if _G.Ragdolls ~= nil then
        _G.Ragdolls[u16] = function(p20) --[[ Line: 94 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u16
            --]]
            if p20 == true then
                u15(u16, true)
            else
                u15(u16, false)
            end
        end
    end
end
v1:GetInstanceAddedSignal("Ragdoll"):Connect(v21)
v1:GetInstanceRemovedSignal("Ragdoll"):Connect(function(p22) --[[ Name: ragdollRemoved, Line 104 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    u5[p22]:Disconnect()
    u5[p22] = nil
    if _G.Ragdolls then
        _G.Ragdolls[p22] = nil
    end
end)
for _, v23 in ipairs(v1:GetTagged("Ragdoll")) do
    v21(v23)
end
return nil