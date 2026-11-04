 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local v3 = game.Players.LocalPlayer
local u4 = game.ReplicatedStorage:FindFirstChild("Stats" .. v3.Name)
require(game.ReplicatedStorage.Modules.FastWait)
local u5 = game:GetService("UserInputService")
require(game.ReplicatedStorage.Modules.CameraShaker)
function v1.start(_, _) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
        [3] = u5
    --]]
    local v6 = game.Players.LocalPlayer.Character
    local v7 = u2.GetM("BombDash")
    if v7.stamreq and u4.Stamina.Value < v7.stamreq then
        return
    end
    if v7.statreq and _G.MeetReq(u2.GetM("BombDash").statreq, nil, true) == false then
        return
    end
    if game.ReplicatedStorage.Events.Skill:InvokeServer("BombDash", v6) == true then
        _G.PlayEffect("BombDash", nil, v6.HumanoidRootPart.CFrame, v6, nil)
    end
    local v8 = Instance.new("BodyVelocity")
    v8.Name = "rolling"
    v8.MaxForce = Vector3.new(1000000, 1000000, 1000000)
    v8.Parent = v6.HumanoidRootPart
    local v9 = 85
    local v10 = true
    local v11 = v6.Humanoid.MoveDirection
    if v11 == Vector3.new(0, 0, 0) then
        v11 = v6.HumanoidRootPart.CFrame.LookVector * 1
    end
    local v12 = workspace.CurrentCamera.CFrame:vectorToObjectSpace(v6.Humanoid.MoveDirection).Unit
    if _G.blocking == false then
        local v13 = v6.Humanoid:LoadAnimation(script.front)
        if u5.MouseBehavior == Enum.MouseBehavior.LockCenter then
            local v14 = v12.X
            local v15 = math.abs(v14)
            local v16 = v12.Z
            if math.abs(v16) < v15 then
                v10 = false
                if v12.X < 0 then
                    v13 = v6.Humanoid:LoadAnimation(script.left)
                else
                    v13 = v6.Humanoid:LoadAnimation(script.right)
                end
            else
                local v17 = v12.X
                local v18 = math.abs(v17)
                local v19 = v12.Z
                if v18 < math.abs(v19) and v12.Z > 0 then
                    v13 = v6.Humanoid:LoadAnimation(script.back)
                    v10 = false
                end
            end
        end
        v13:Play()
        v13.Priority = Enum.AnimationPriority.Action2
        v13:AdjustSpeed(1)
    end
    local v20 = _G.running == true and 100 or v9
    local v21 = _G.blocking == true and 15 or v20
    v6.Humanoid.AutoRotate = false
    CFrame.new(v6.HumanoidRootPart.CFrame.p, v11 + v6.HumanoidRootPart.CFrame.p)
    local _ = v6.Humanoid.Health / v6.Humanoid.MaxHealth
    if _G.check:inspect(v6) and v10 == true then
        v6.HumanoidRootPart.CFrame = CFrame.new(v6.HumanoidRootPart.CFrame.p, v11 + v6.HumanoidRootPart.CFrame.p)
    end
    v8.Velocity = CFrame.new(v6.HumanoidRootPart.CFrame.p, v11 + v6.HumanoidRootPart.CFrame.p).LookVector * v21
    _G.destroy(v8, 0.2)
    local v22 = tick()
    while true do
        if _G.check:inspect(v6, true) == false then
            v8:Destroy()
            if v6:FindFirstChild("knockback", true) == nil then
                v6.PrimaryPart.AssemblyLinearVelocity = Vector3.new()
            end
        end
        task.wait()
        if tick() - v22 >= 0.4 then
            _G.midDash = nil
            v6.Humanoid.AutoRotate = true
            task.wait(0.75)
            return true
        end
    end
end
return v1