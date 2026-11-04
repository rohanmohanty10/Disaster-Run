 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = game:GetService("RunService").Heartbeat
local u4 = require(script:WaitForChild("purpleeye"))
local u5 = require(script:WaitForChild("darkeneye"))
local u6 = CFrame.Angles(0, 0.4, 0)
local u7 = Random.new()
function v1.start(_, u8, u9) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u4
        [3] = u2
        [4] = u3
        [5] = u7
        [6] = u6
    --]]
    if _G.checkRenderDistance(u8.HumanoidRootPart.Position) ~= false then
        _G.PlaySound(u8.HumanoidRootPart, script.Parent.sounds.stomp)
        _G.PlaySound(u8.HumanoidRootPart, script.Parent.sounds.stance)
        local u10 = script.Parent.effect.darkeneye:Clone()
        u10:PivotTo(u8.Head.CFrame)
        u10.PrimaryPart.WC.Part1 = u8.Head
        u10.Parent = workspace.Effects
        u5(u10, false)
        local v11 = script.Parent.effect.purpleeye:Clone()
        v11:PivotTo(u8.Head.CFrame)
        v11.Parent = workspace.Effects
        u4(v11)
        local u12 = script.Parent.effect.charge:Clone()
        u12:PivotTo(u8.HumanoidRootPart.CFrame)
        u12.Parent = workspace.Effects
        local v13 = Ray.new(u8.HumanoidRootPart.CFrame.Position, u8.HumanoidRootPart.CFrame.upVector * -10)
        local v14, _, _ = _G.raycastWhitelist(v13, { workspace.Islands, workspace.Env, workspace.Ships })
        if v14 then
            u12.Dust.ParticleEmitter.Color = ColorSequence.new(v14.Color)
            _G.customEmit(u12.Dust.ParticleEmitter)
        end
        _G.PlayEffect("GroundRocks2", nil, u8.HumanoidRootPart.CFrame, 10, 4, 1, 0, 5)
        require(script.Parent.BusoColor):applyColors(u8, u12)
        u2:Create(u12.swirl, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            ["Transparency"] = 1,
            ["CFrame"] = u12.swirl.CFrame * CFrame.Angles(0, 2.827433388230814, 0),
            ["Size"] = u12.swirl.Size * 5
        }):Play()
        u2:Create(u12.ring, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            ["Transparency"] = 1,
            ["CFrame"] = u12.ring.CFrame * CFrame.new(0, -3.5, 0),
            ["Size"] = u12.ring.Size * Vector3.new(4, 0.1, 4)
        }):Play()
        u2:Create(u12.swoosh.Mesh, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Scale"] = Vector3.new(16, 3, 16)
        }):Play()
        u2:Create(u12.swoosha.Mesh, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Scale"] = Vector3.new(24, 3, 24)
        }):Play()
        u2:Create(u12.swoosh.Decal, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            ["Transparency"] = 1
        }):Play()
        u2:Create(u12.swoosha.Decal, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            ["Transparency"] = 1
        }):Play()
        spawn(function() --[[ Line: 72 ]]
            --[[
            Upvalues:
                [1] = u12
                [2] = u9
                [3] = u3
                [4] = u8
                [5] = u7
                [6] = u2
                [7] = u10
            --]]
            local u15 = u12:WaitForChild("sphere"):Clone()
            u12.sphere:Destroy()
            local v16 = 0
            local u17 = false
            while u9:IsDescendantOf(game) do
                u3:Wait()
                if v16 == 0 then
                    pcall(function() --[[ Line: 79 ]]
                        --[[
                        Upvalues:
                            [1] = u15
                            [2] = u17
                            [3] = u8
                            [4] = u7
                            [5] = u2
                        --]]
                        local v18 = u15:Clone()
                        u17 = not u17
                        v18.CFrame = CFrame.new(u8.HumanoidRootPart.Position) * CFrame.new(u7:NextNumber(-3, 3), u7:NextNumber(-1, -3), u7:NextNumber(-3, 3))
                        if u17 then
                            v18.Color = require(script.Parent.BusoColor):getColor(u8)
                        end
                        v18.Parent = workspace.Effects
                        _G.destroy(v18, 0.156)
                        u2:Create(v18, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            ["Size"] = Vector3.new(0, 1.5, 0),
                            ["CFrame"] = v18.CFrame * CFrame.new(0, 4.5, 0),
                            ["Transparency"] = 1
                        }):Play()
                    end)
                end
                v16 = (v16 + 1) % 3
            end
            _G.destroy(u12, 2)
            _G.destroy(u10, 2)
        end)
        for _ = 1, 30 do
            u3:Wait()
            local v19 = u12.swoosh
            local v20 = u12.swoosha
            v19.CFrame = v19.CFrame * u6
            v20.CFrame = v20.CFrame * u6
        end
    end
end
return v1