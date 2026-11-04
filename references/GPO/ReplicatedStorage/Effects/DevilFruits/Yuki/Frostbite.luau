 

local v1 = game:GetService("Players")
game:GetService("RunService")
local u2 = game:GetService("TweenService")
local v3 = game:GetService("ReplicatedStorage")
local _ = v1.LocalPlayer
local u4 = workspace.Effects
require(v3.Modules.Essentials)
local u5 = require(v3.Modules.Utility)
require(v3.Modules.CameraShaker)
local v6 = {}
local _ = workspace.CurrentCamera
function v6.start(_, p7, p8) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
        [3] = u2
    --]]
    if _G.checkRenderDistance(p7.PrimaryPart.Position) == false then
        return
    elseif p8 == nil then
        local v9 = script.CharSpiral:Clone()
        v9.CFrame = p7.HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0)
        v9.Parent = u4
        u5:AddItem(v9, 1)
        local v10 = TweenInfo.new(0.75, Enum.EasingStyle.Exponential)
        u2:Create(v9.Texture, v10, {
            ["Transparency"] = 1
        }):Play()
        u2:Create(v9.Mesh, v10, {
            ["Scale"] = Vector3.new(5, 0.75, 5)
        }):Play()
        local v11 = u2
        local v12 = {}
        local v13 = v9.Orientation
        local v14 = v9.Orientation.Y - 1000
        v12.Orientation = v13 + Vector3.new(0, v14, 0)
        v11:Create(v9, v10, v12):Play()
        task.wait(0.6)
    else
        task.wait(0.3)
        task.wait(1.1)
        task.wait(1)
        local v15 = RaycastParams.new()
        v15.FilterType = Enum.RaycastFilterType.Whitelist
        v15.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
        local v16 = workspace:Raycast(p7.HumanoidRootPart.CFrame.Position, CFrame.new(0, -20, 0).Position, v15)
        local v17 = script.GroundSmash:Clone()
        v17.CFrame = p7.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
        v17.Parent = u4
        u5:Emit(v17.Main)
        u5:AddItem(v17, 2.5)
        if v16 then
            local v18 = CFrame.lookAt(v16.Position, v16.Position + p7.HumanoidRootPart.CFrame.LookVector, v16.Normal)
            local u19 = script.GroundCrack:Clone()
            u19.CFrame = v18 * CFrame.new(0, 0, -6)
            u19.Size = Vector3.new(0, 0, 0)
            u19.Parent = u4
            u2:Create(u19, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                ["Size"] = Vector3.new(20, 0, 20)
            }):Play()
            u2:Create(u19.Texture, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0.1), {
                ["Transparency"] = 0,
                ["Color3"] = Color3.fromRGB(300, 425, 700)
            }):Play()
            task.delay(2, function() --[[ Line: 68 ]]
                --[[
                Upvalues:
                    [1] = u19
                    [2] = u5
                    [3] = u2
                --]]
                u19.Smoke.Enabled = false
                task.wait(1)
                u5:AddItem(u19, 1.5)
                u2:Create(u19.Texture, TweenInfo.new(1.5), {
                    ["Transparency"] = 1
                }):Play()
            end)
        end
        local v20 = script.Shock1:Clone()
        v20.CFrame = p7.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
        v20.Parent = u4
        u5:AddItem(v20, 0.35)
        u2:Create(v20.Texture, TweenInfo.new(0.35, Enum.EasingStyle.Exponential), {
            ["Transparency"] = 1
        }):Play()
        u2:Create(v20.Mesh, TweenInfo.new(0.35, Enum.EasingStyle.Exponential), {
            ["Scale"] = Vector3.new(0, 20, 0)
        }):Play()
    end
end
return v6