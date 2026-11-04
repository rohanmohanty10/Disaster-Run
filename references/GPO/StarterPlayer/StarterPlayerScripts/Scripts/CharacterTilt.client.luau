 

local v1 = game:GetService("RunService")
local v2 = game:GetService("Players").LocalPlayer
local u3 = v2.Character or v2.CharacterAdded:Wait()
local u4 = u3:WaitForChild("Humanoid")
local u5 = u3:WaitForChild("HumanoidRootPart")
local v6 = u3:WaitForChild("LowerTorso")
local u7 = math.abs
local u8 = math.clamp
local u9 = math.max
local u10 = false
local u11
if u4.RigType == Enum.HumanoidRigType.R15 then
    u11 = v6.Root
else
    u11 = u5.RootJoint
end
local u12 = u11.C0
v1.Heartbeat:Connect(function(p13) --[[ Line: 35 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u3
        [3] = u4
        [4] = u10
        [5] = u5
        [6] = u7
        [7] = u8
        [8] = u9
        [9] = u12
    --]]
    if u11 == nil or (u3 == nil or u4 == nil) then
        return
    elseif u3 and u3.Parent == workspace.Ragdolls or u4:GetState() == Enum.HumanoidStateType.Physics then
        return
    else
        local v14 = u4.MoveDirection
        local v15 = u4 and (u4.SeatPart ~= nil or _G.canuse == false) and Vector3.new(0, 0, 0) or v14
        if v15 == Vector3.new(0, 0, 0) and u10 then
            return
        else
            local v16 = u5.CFrame
            local v17 = v16:VectorToObjectSpace(v15)
            local v18 = v16:VectorToObjectSpace(u5.Velocity) * 0.008
            local v19 = u8(u7(v18.X), 0, 1)
            local v20 = u8(u7(v18.Z), 0, 1)
            local v21 = Vector3.new(v19, 0, v20)
            local v22 = u3:GetScale()
            local v23 = v17.X * v21.X / v22
            local v24 = { u9(0, v17.Z * v21.Z / v22), 0, -v23 }
            local v25 = u11.C0
            local v26 = v25.Y
            local v27 = v25:Lerp(u12 * CFrame.Angles(table.unpack(v24)), p13 * 15)
            local v28 = v27 - v27.Y * Vector3.new(0, 1, 0) + Vector3.new(0, 1, 0) * v26
            u11.C0 = v28
            if v15 == Vector3.new(0, 0, 0) then
                local _, v29 = v28:ToAxisAngle()
                local _, v30 = u12:ToAxisAngle()
                u10 = u7(v29 - v30) < 0.001
            else
                u10 = false
            end
        end
    end
end)
v2.CharacterAdded:Connect(function(p31) --[[ Line: 90 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u5
        [4] = u11
        [5] = u12
    --]]
    u3 = p31
    u4 = u3:WaitForChild("Humanoid")
    u5 = u3:WaitForChild("HumanoidRootPart")
    u11 = nil
    u12 = nil
    if u4.RigType == Enum.HumanoidRigType.R15 then
        u11 = u3:WaitForChild("LowerTorso").Root
    else
        u11 = u5.RootJoint
    end
    u12 = u11.C0 - u11.C0.Y * Vector3.new(0, 1, 0)
end)