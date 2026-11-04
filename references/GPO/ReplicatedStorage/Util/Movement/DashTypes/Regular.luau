 

local v1 = {}
require(game.ReplicatedStorage.Modules.Skills)
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Soru]
local v2 = game.Players.LocalPlayer
local u3 = game.ReplicatedStorage:FindFirstChild("Stats" .. v2.Name)
require(game.ReplicatedStorage.Modules.FastWait)
local u4 = game:GetService("UserInputService")
require(game.ReplicatedStorage.Modules.CameraShaker)
local u5 = require(game.ReplicatedStorage.Modules.SwordHandle.SwordInfo)
local u6 = workspace.CurrentCamera
function v1.start(_, _) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u5
        [4] = u6
    --]]
    local u7 = game.Players.LocalPlayer.Character
    if _G.StamCheck(10 + u3.Stamina.MaxValue * _G.dashPercentAmmount, true) == false then
        return
    end
    if u7.HumanoidRootPart:FindFirstChild("RollDirt") == nil then
        script.Dirt.RollDirt:Clone().Parent = u7.HumanoidRootPart
    end
    game.ReplicatedStorage.Events.takestam:FireServer(u3.Stamina.MaxValue * _G.dashPercentAmmount, "dash", u7.PrimaryPart.CFrame)
    u7.PrimaryPart:GetMass()
    local v8 = Instance.new("BodyVelocity")
    v8.Name = "rolling"
    v8.MaxForce = Vector3.new(70000, 100, 70000)
    v8.Parent = u7.HumanoidRootPart
    local v9 = false
    local v10 = 60
    local v11 = true
    local v12 = u7:FindFirstChildWhichIsA("Tool")
    if _G.blocking == false then
        local v13 = u7.Humanoid:LoadAnimation(script.roll)
        local v14 = 2
        if u4:IsKeyDown(Enum.KeyCode.A) then
            v13 = u7.Humanoid:LoadAnimation(script.left)
            v14 = 1.5
            v11 = false
        elseif u4:IsKeyDown(Enum.KeyCode.D) then
            v13 = u7.Humanoid:LoadAnimation(script.right)
            v14 = 1.5
            v11 = false
        elseif u4:IsKeyDown(Enum.KeyCode.W) then
            v9 = true
        end
        if v12 ~= nil and (u5[v12.Name] and game.ReplicatedStorage.Modules.SwordHandle.Swords[v12.Name]:FindFirstChild("Dashes") ~= nil) then
            local v15 = game.ReplicatedStorage.Modules.SwordHandle.Swords[v12.Name]:FindFirstChild("Dashes")
            if u4:IsKeyDown(Enum.KeyCode.A) then
                v13 = u7.Humanoid:LoadAnimation(v15.Left)
                v14 = 1.5
                v11 = false
            elseif u4:IsKeyDown(Enum.KeyCode.D) then
                v13 = u7.Humanoid:LoadAnimation(v15.Right)
                v14 = 1.5
                v11 = false
            elseif u4:IsKeyDown(Enum.KeyCode.W) then
                v13 = u7.Humanoid:LoadAnimation(v15.Front)
                v14 = 1.5
            elseif u4:IsKeyDown(Enum.KeyCode.S) then
                v13 = u7.Humanoid:LoadAnimation(v15.Back)
                v14 = 1.5
                v11 = false
            else
                v13 = u7.Humanoid:LoadAnimation(v15.Front)
            end
        end
        v13:Play()
        v13.Priority = Enum.AnimationPriority.Action2
        v13:AdjustSpeed(v14)
    end
    local v16 = Ray.new(u7.HumanoidRootPart.Position, CFrame.new(u7.HumanoidRootPart.CFrame.p).upVector * -(u7.Humanoid.HipHeight * 2))
    local v17 = _G.raycastWhitelist(v16, { workspace.Islands, workspace.Env, workspace.Ships })
    if v17 then
        u7.HumanoidRootPart.RollDirt.ParticleEmitter.Color = ColorSequence.new(v17.Color)
        u7.HumanoidRootPart.RollDirt.ParticleEmitter.Enabled = true
    end
    task.delay(0.15, function() --[[ Line: 94 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        u7.HumanoidRootPart.RollDirt.ParticleEmitter.Enabled = false
    end)
    local v18 = _G.running == true and 85 or v10
    local v19 = _G.blocking == true and 50 or v18
    u7.Humanoid.AutoRotate = false
    local v20 = u7.Humanoid.MoveDirection
    if v20 == Vector3.new(0, 0, 0) then
        v20 = u7.HumanoidRootPart.CFrame.LookVector * 1
    end
    CFrame.new(u7.HumanoidRootPart.CFrame.p, v20 + u7.HumanoidRootPart.CFrame.p)
    _G.PlaySound(u7.PrimaryPart, script["J" .. math.random(1, 3)]).Parent = u7.PrimaryPart
    if _G.blocking == false and v11 == true then
        u7.HumanoidRootPart.CFrame = CFrame.new(u7.HumanoidRootPart.CFrame.p, v20 + u7.HumanoidRootPart.CFrame.p)
    end
    v8.Velocity = _G.ScaleWithHP(CFrame.new(u7.HumanoidRootPart.CFrame.p, v20 + u7.HumanoidRootPart.CFrame.p).LookVector * v19)
    _G.destroy(v8, _G.ScaleWithHP(0.25))
    local v21 = tick()
    local _ = u7.Humanoid.Health
    while true do
        if _G.check:inspect(u7, true) == false then
            v8.MaxForce = Vector3.new()
            v8:Destroy()
            if u7:FindFirstChild("knockback", true) == nil then
                u7.PrimaryPart.AssemblyLinearVelocity = Vector3.new()
            else
                warn("found regular knockback")
            end
            break
        end
        if v9 then
            local v22 = (Vector3.new(0, 1, 0)):Cross(u6.CFrame.RightVector)
            v8.Velocity = _G.ScaleWithHP(v22 * v19)
            local v23 = u7.HumanoidRootPart
            v23.CFrame = CFrame.new(Vector3.new(0, 0, 0), v22) + v23.Position
        else
            v8.Velocity = _G.ScaleWithHP(CFrame.new(u7.HumanoidRootPart.CFrame.p, v20 + u7.HumanoidRootPart.CFrame.p).LookVector * v19)
        end
        game["Run Service"].Stepped:Wait()
        if tick() - v21 >= 0.2 then
            break
        end
    end
    _G.midDash = nil
    u7.HumanoidRootPart.RollDirt.ParticleEmitter.Enabled = false
    u7.Humanoid.AutoRotate = true
    task.wait(1)
    return true
end
return v1