 

local v1 = {}
local u2 = game:GetService("RunService")
local v3 = game:GetService("ReplicatedStorage"):WaitForChild("Refrences"):WaitForChild("Phoenix")
local u4 = require(game:GetService("ReplicatedStorage"):WaitForChild("Util").Misc)
require(game:GetService("ReplicatedStorage").Util.ShakeCamera)
local _ = workspace.CurrentCamera
require(v3.Modules.Trail)
require(v3.Modules.Slash)
local u5 = require(game.ReplicatedStorage.Util.Tween)
local u6 = false
local u7 = nil
local u8 = nil
local u9 = 0
local u10 = { workspace.Env, workspace.Islands, workspace.Ships }
game:GetService("HttpService")
local u11 = {}
function v1.start(_, p12, u13, p14, p15, u16, p17) --[[ Line: 23 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u2
        [3] = u6
        [4] = u5
        [5] = u10
        [6] = u7
        [7] = u8
        [8] = u9
        [9] = u4
    --]]
    local v18 = u11
    table.insert(v18, p17)
    table.sort(u11)
    repeat
        u2.RenderStepped:Wait()
    until u11[1] == p17 and u6 == false
    u6 = true
    local v19 = p12.Character
    local u20 = v19:FindFirstChild("HumanoidRootPart")
    local u21 = v19:FindFirstChildOfClass("Humanoid")
    local v22 = u20.CFrame
    Vector3.new()
    local _ = v22.Position
    local u23 = v22.Position
    local v24 = p15 or 100
    local v25 = (p14 - u23).Magnitude / v24
    local v26 = v25 / 1
    local v27 = Vector3.new()
    Vector3.new()
    Vector3.new()
    local u28 = v22
    local v29 = nil
    local v30 = 0
    local v31 = false
    local v32 = false
    local v33 = nil
    local v34 = nil
    local v35 = nil
    local v36 = nil
    local v37 = nil
    while true do
        local v38 = tick()
        v29 = v29 or v38
        local v39 = v33 or 0.016666666666666666
        local v40 = (v38 - v29) / v25
        local v41 = math.min(1, v40)
        v36 = v36 or 0
        local v42
        if v26 < v38 - v36 then
            if v30 >= 1 then
                break
            end
            v30 = v30 + 1
            v37 = u20.Position
            v34 = p14 - v37
            v35 = v34.Magnitude
            v36 = v38
            v42 = v27
        else
            local v43 = v38 - v36
            local v44 = v43 / v26
            local v45 = (v43 - v26 / 2) / (v26 / 2)
            local v46 = math.clamp(v45, 0, 1)
            local v47 = v43 / (v26 / 2)
            local v48 = math.clamp(v47, 0, 1)
            local v49 = u5.ease.out.sine(v44, 0, 1, 1)
            local v50 = u5.ease.out.sine(v46, 0, 1, 1)
            local v51 = u5.ease.out.cubic(v46, 0, 1, 1)
            u5.ease.out.sine(v48, 0, 1, 1)
            local v52 = v37.Y - p14.Y
            local v53 = Vector3.new()
            local v54 = v34.Unit
            if math.abs(v52) <= 5 then
                local v55 = (3.141592653589793 * v50 + 3.141592653589793) / 2
                v53 = Vector3.new(0, 25, 0) * (1 - math.sin(v55))
            elseif v52 > 5 then
                if u16 then
                    local v56 = 2.5132741228718345 * v49
                    local v57 = -math.sin(v56)
                    local v58 = 25 - v52
                    v53 = Vector3.new(0, v52, 0) * v57 + Vector3.new(0, v58) * v50
                    v54 = (v54 * Vector3.new(1, 0, 1)).Unit
                else
                    local v59 = 3.141592653589793 * v49
                    local v60 = -math.sin(v59)
                    local v61 = 25 - v52
                    v53 = Vector3.new(0, v52, 0) * v60 + Vector3.new(0, v61) * v50
                    v54 = (v54 * Vector3.new(1, 0, 1)).Unit
                end
            end
            v42 = v37 + v54 * ((u16 and 1 or 1.5) * v35) * v49 + v53
            local v62 = (v42 - v27).Unit
            if v62 ~= v62 then
                v62 = v22.LookVector
            end
            local v63 = CFrame.new(Vector3.new(), v62)
            local v64 = CFrame.new
            local v65 = 6.283185307179586 * v50
            local v66 = math.sin(v65)
            local v67 = 6.283185307179586 * v50
            local v68 = math.cos(v67)
            local v69 = v63 * v64(Vector3.new(v66, v68) * 15 * v51 * (u16 and 0 or 1))
            local v70 = CFrame.Angles(0, u16 and 0 or 3.141592653589793 * v50, 0)
            u28 = v69 * v70 + v42
            if v44 > 0.5 and not v31 then
                local v71 = u16 and Vector3.new(0, -1, 0) or (v62 + Vector3.new(0, 1, 0)).Unit
                local v72 = Ray.new(u20.Position - v71 * 5, v71 * 10 * (1 + 2 * v39))
                local v73, v74, v75 = _G.raycastWhitelist(v72, u10)
                if v73 then
                    v32 = v75
                    v31 = v74
                end
            end
            if v31 then
                local v76 = v42.Y - v31.Y
                if u16 then
                    local v77 = u20.Position.X
                    local v78 = v31.Y
                    local v79 = u20.Position.Z
                    local v80 = Vector3.new(v77, v78, v79) + v32 * 4 + v54 * v24 * v39
                    local v81 = Ray.new(u20.Position - v54 * 5, v54 * 10)
                    local _, _, _ = _G.raycastWhitelist(v81, u10)
                    u28 = CFrame.new(v80) * CFrame.new(Vector3.new(), v54)
                else
                    u28 = CFrame.new(v31 + v32 * 4) * v70 + Vector3.new(0, v76)
                end
            end
            for _ = 1, 10 do
                u20.Velocity = Vector3.new()
                u20.RotVelocity = Vector3.new()
            end
            u20.CFrame = u28
            for _ = 1, 10 do
                u20.Velocity = Vector3.new()
                u20.RotVelocity = Vector3.new()
            end
            u21.Sit = true
            u21.AutoRotate = false
            u21:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
            u21:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
            u9 = v38
        end
        if v41 == 1 then
            break
        end
        u2.Heartbeat:Wait()
        v33 = tick() - v38
        v27 = v42
    end
    table.remove(u11, 1)
    table.sort(u11)
    coroutine.resume(coroutine.create(function() --[[ Line: 240 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u16
            [3] = u13
            [4] = u23
            [5] = u20
            [6] = u28
            [7] = u21
            [8] = u2
            [9] = u9
            [10] = u4
            [11] = u7
            [12] = u8
        --]]
        task.wait(0.25)
        if not u6 then
            task.wait()
            local v82 = u16 or not u13.Parent
            if not v82 then
                local v83 = nil
                while true do
                    local v84 = tick()
                    v83 = v83 or v84
                    local v85 = (v84 - v83) / 1
                    local v86 = math.min(1, v85)
                    for _ = 1, 10 do
                        u20.Velocity = Vector3.new()
                        u20.RotVelocity = Vector3.new()
                    end
                    u20.CFrame = u28
                    for _ = 1, 10 do
                        u20.Velocity = Vector3.new()
                        u20.RotVelocity = Vector3.new()
                    end
                    u20.CFrame = u20.CFrame
                    u21.Sit = true
                    u21.AutoRotate = false
                    u21:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
                    u21:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
                    u21:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                    if v86 == 1 or u6 then
                        break
                    end
                    u2.Heartbeat:Wait()
                end
            end
            if tick() - u9 > 1 or (v82 or u16) then
                u20.CFrame = u4.AlignCFrame(u20.CFrame, Vector3.new(0, 1, 0))
                if u7 then
                    u7.CFrame = u4.AlignCFrame(u20.CFrame, Vector3.new(0, 1, 0))
                end
                if u8 then
                    u8.Position = u20.CFrame.Position
                end
                u21.Sit = false
                u21.AutoRotate = true
                u21:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, false)
                u21:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
                u21:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
                u2.RenderStepped:Wait()
                u2.RenderStepped:Wait()
                if u8 and u7 then
                    u8:Destroy()
                    u7:Destroy()
                end
                u7 = nil
                u8 = nil
            end
        end
    end))
    u6 = false
end
return v1