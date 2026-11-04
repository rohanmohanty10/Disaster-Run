 

local v1 = {}
local _, _, u2, _, _ = require(game.ReplicatedStorage.Modules.ScriptSet).get()
local u3 = nil
local u4 = {
    ["Slash"] = false,
    ["Rapid"] = false,
    ["Jump"] = false
}
function v1.setup(_, u5, u6) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u4
    --]]
    if u3 then
        u3:Disconnect()
    end
    u3 = u2.InputBegan:Connect(function(p7, p8) --[[ Line: 12 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u5
            [3] = u4
            [4] = u2
        --]]
        if u6.Parent ~= u5 or (_G.canuse == false or p8 == true) then
            return
        end
        if p7.KeyCode == Enum.KeyCode.E and (u4.Slash == false and _G.check:inspect(u5) == true) then
            local v9 = u5.Humanoid.Animator:LoadAnimation(script.slash)
            v9:Play()
            v9:AdjustWeight(2)
            u4.Slash = true
            _G.canuse = false
            _G.PauseAnim(v9, 0.2, 1)
            while true do
                game["Run Service"].RenderStepped:Wait()
                if _G.check:inspect(u5) == false then
                    v9:Stop()
                    break
                end
                u5.Humanoid.WalkSpeed = 4
                if u2:IsKeyDown(Enum.KeyCode.E) == false then
                    break
                end
            end
            u5.HumanoidRootPart.Anchored = true
            v9:AdjustSpeed(1)
            u5.Humanoid.WalkSpeed = 0
            task.wait(0.75)
            game.ReplicatedStorage.Events.Skill:InvokeServer("Yoru Slash")
            task.wait(0.25)
            u5.HumanoidRootPart.Anchored = false
            u5.Humanoid.WalkSpeed = 16
            u4.Slash = false
            _G.canuse = true
            return
        elseif p7.KeyCode == Enum.KeyCode.R and (u4.Rapid == false and _G.check:inspect(u5) == true) then
            local v10 = u5.Humanoid.Animator:LoadAnimation(script.rapid)
            v10:Play()
            v10:AdjustSpeed(2)
            u4.Rapid = true
            _G.canuse = false
            local v11 = game.ReplicatedStorage.Events.Skill:InvokeServer("Thousand Slashes")
            while true do
                game["Run Service"].RenderStepped:Wait()
                if _G.check:inspect(u5) == false then
                    v10:Stop()
                    break
                end
                u5.Humanoid.WalkSpeed = 4
                if u2:IsKeyDown(Enum.KeyCode.R) == false then
                    break
                end
            end
            if v11 then
                v11:InvokeServer()
            end
            v10:Stop()
            u5.Humanoid.WalkSpeed = 16
            u4.Rapid = false
            _G.canuse = true
        elseif p7.KeyCode == Enum.KeyCode.Z and (u4.Jump == false and _G.check:inspect(u5) == true) then
            local v12 = u5.Humanoid.Animator:LoadAnimation(script.jump)
            v12:Play()
            v12:AdjustWeight(5)
            v12:AdjustSpeed(0)
            _G.PauseAnim(v12, 0.2, 1)
            u4.Jump = true
            _G.canuse = false
            while true do
                game["Run Service"].RenderStepped:Wait()
                if _G.check:inspect(u5) == false then
                    v12:Stop()
                    break
                end
                u5.Humanoid.WalkSpeed = 4
                if u2:IsKeyDown(Enum.KeyCode.Z) == false then
                    break
                end
            end
            v12:AdjustSpeed(1)
            task.wait(0.3)
            local v13 = Instance.new("BodyVelocity", u5.HumanoidRootPart)
            v13.Name = "geppo"
            v13.MaxForce = Vector3.new(1000000000, 10000000000000000, 1000000000)
            v13.Velocity = u5.HumanoidRootPart.CFrame.upVector * 100
            v13.P = 4324234234
            _G.destroy(v13, 0.25)
            task.wait(0.7)
            local v14 = u5.HumanoidRootPart.Position
            local v15 = Ray.new(v14, CFrame.new(v14).upVector * -500)
            local v16, v17 = _G.raycastIgnoreList(v15, {
                workspace.Effects,
                workspace.PlayerCharacters,
                workspace.Projectiles,
                workspace.CurrentCamera,
                workspace.Projectiles,
                workspace.NPCs
            })
            u5.HumanoidRootPart.Anchored = true
            if v16 then
                local v18 = (v14 - v17).magnitude
                local v19 = u5.HumanoidRootPart.CFrame * CFrame.new(0, -v18, 0) * CFrame.new(0, u5.Humanoid.HipHeight * 1.25, 0)
                u5.HumanoidRootPart.CFrame = v19
            else
                v12:Stop()
            end
            u5.Humanoid.WalkSpeed = 16
            u5.HumanoidRootPart.Anchored = false
            u4.Jump = false
            _G.canuse = true
        end
    end)
end
return v1