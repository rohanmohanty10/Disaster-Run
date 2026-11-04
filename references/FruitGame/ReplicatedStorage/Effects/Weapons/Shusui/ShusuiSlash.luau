 

local u1 = game:GetService("TweenService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = {}
local u4 = workspace.Effects
require(v2.Modules.BoatTween)
function v3.start(_, p5, p6) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u1
    --]]
    if _G.checkRenderDistance(p5.PrimaryPart.Position) then
        local v7 = p5:WaitForChild("HumanoidRootPart")
        local v8 = p5:FindFirstChild("ShusuiSword")
        if v8 == nil then
            return
        else
            local v9 = v8:findFirstChild("Blade")
            if p6 then
                local v10 = Instance.new("Attachment")
                v10.Name = "Particles"
                v10.Parent = v9
                for _, v11 in script.SwordParticles:GetChildren() do
                    if v11:IsA("ParticleEmitter") then
                        v11:Clone().Parent = v10
                    end
                end
                require(script.Parent.BusoColor):applyColors(p5, v10)
                _G.customEmit(v10)
                _G.destroy(v10, 1)
            else
                local v12 = script.Burst:Clone()
                v12.CFrame = v7.CFrame * CFrame.new(0, -2.5, -5)
                require(script.Parent.BusoColor):applyColors(p5, v12)
                v12.Parent = u4
                _G.customEmit(v12)
                _G.destroy(v12, 1)
                local u13 = script.Slash:Clone()
                u13.CFrame = v7.CFrame * CFrame.new(0, 0, 3) * CFrame.Angles(1.5707963267948966, 0, 1.5707963267948966)
                require(script.Parent.BusoColor):applyColors(p5, u13)
                u13.Parent = u4
                local v14, _, _ = _G.getRayFloor(p5.PrimaryPart.CFrame, 10)
                if v14 == nil then
                    u13.Dust:Destroy()
                else
                    u13.Dust.Dust.Color = ColorSequence.new(v14.Color)
                    u13.Dust.Debris.Color = u13.Dust.Dust.Color
                end
                local v15 = TweenInfo.new(0.35, Enum.EasingStyle.Linear)
                u1:Create(u13, v15, {
                    ["CFrame"] = u13.CFrame * CFrame.new(-65, 0, 0)
                }):Play()
                u1:Create(u13.Texture, v15, {
                    ["Transparency"] = 1
                }):Play()
                local u16 = script.Slash2:Clone()
                u16.CFrame = u13.CFrame * CFrame.new(-3, 0, 0) * CFrame.Angles(1.5707963267948966, 1.5707963267948966, 1.5707963267948966)
                require(script.Parent.BusoColor):applyColors(p5, u16)
                u16.Parent = u4
                _G.destroy(u16, 0.2)
                local v17 = TweenInfo.new(0.2, Enum.EasingStyle.Exponential)
                local u18 = TweenInfo.new(0.15, Enum.EasingStyle.Exponential)
                u1:Create(u16, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
                    ["CFrame"] = u16.CFrame * CFrame.Angles(0, 3.12413936106985, 0)
                }):Play()
                u1:Create(u16.Texture, v17, {
                    ["Transparency"] = 1
                }):Play()
                task.delay(0.05, function() --[[ Line: 79 ]]
                    --[[
                    Upvalues:
                        [1] = u1
                        [2] = u16
                        [3] = u18
                        [4] = u13
                    --]]
                    u1:Create(u16, u18, {
                        ["CFrame"] = u16.CFrame * CFrame.Angles(0, 3.12413936106985, 0)
                    }):Play()
                    u1:Create(u13.PointLight, TweenInfo.new(0.5), {
                        ["Brightness"] = 0
                    }):Play()
                end)
                local v19 = Color3.fromRGB(85, 255, 255)
                if p5:FindFirstChild("BusoSword") then
                    v19 = require(script.Parent.BusoColor):getColor(p5)
                end
                _G.PlayEffect("FloorTrail", nil, u13, nil, v19, Color3.fromRGB(0, 0, 0), 0.25, 0.1, 20)
                _G.destroy(u13, 1.25)
                task.wait(0.3)
                for _, v20 in u13:GetDescendants() do
                    if v20:IsA("ParticleEmitter") then
                        v20.Enabled = false
                    end
                end
            end
        end
    else
        return
    end
end
return v3