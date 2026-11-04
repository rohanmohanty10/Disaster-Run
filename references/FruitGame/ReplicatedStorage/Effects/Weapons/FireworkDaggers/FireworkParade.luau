 

local v1 = game:GetService("ReplicatedStorage")
local u2 = require(v1.Modules.Client.WeaponVFXRecolor)
local u3 = {
    "rbxassetid://14355301811",
    "rbxassetid://14355301672",
    "rbxassetid://14355293187",
    "rbxassetid://14355293046",
    "rbxassetid://14355292840",
    "rbxassetid://14355292651",
    "rbxassetid://14355292453",
    "rbxassetid://14355292216",
    "rbxassetid://14355301442",
    "rbxassetid://14355301181",
    "rbxassetid://14355284866",
    "rbxassetid://14355284744",
    "rbxassetid://14355284625",
    "rbxassetid://14355284490",
    "rbxassetid://14355284308",
    "rbxassetid://14355284128"
}
local u4 = game:GetService("TweenService")
local u5 = Random.new()
local u6 = {}
return {
    ["start"] = function(_, u7, p8, _, p9, p10) --[[ Name: start, Line 61 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u4
            [3] = u2
            [4] = u5
            [5] = u3
        --]]
        if not u6[u7] then
            u6[u7] = {}
        end
        if p8 == "StartSkill" then
            local u11, v12
            if p10 == false or p10 == nil then
                u11 = script.NormalFireworks
                v12 = Instance.new("Highlight")
                v12.OutlineTransparency = 1
                v12.DepthMode = Enum.HighlightDepthMode.Occluded
                v12.FillTransparency = 0.3
                v12.OutlineColor = Color3.fromRGB(0, 0, 0)
                v12.FillColor = Color3.fromRGB(52, 140, 255)
            else
                u11 = script.PrestigeFireworks
                v12 = Instance.new("Highlight")
                v12.OutlineTransparency = 1
                v12.DepthMode = Enum.HighlightDepthMode.Occluded
                v12.FillTransparency = 0.3
                v12.OutlineColor = Color3.fromRGB(0, 0, 0)
                v12.FillColor = Color3.fromRGB(158, 126, 255)
            end
            v12.FillTransparency = 1
            _G.destroy(v12, 0.4)
            v12.Parent = p9
            u4:Create(v12, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, true), {
                ["FillTransparency"] = 0.3
            }):Play()
            u4:Create(v12, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                ["FillColor"] = Color3.new(1, 0.933333, 0.6)
            }):Play()
            local u13 = Instance.new("Folder")
            u13.Name = "EffectsFolder"
            u13.Parent = workspace.Effects
            local v14 = u7.PrimaryPart.CFrame
            local v15 = u11.StartUpParticles:Clone()
            u2.apply(v15, u7)
            v15.CFrame = v14
            v15.Parent = u13
            _G.customEmit(v15)
            u6[u7].EffectsFolder = u13
            task.wait(0.15)
            local v16 = u11.SlashParticles:Clone()
            u2.apply(v16, u7)
            v16.CFrame = v14
            v16.Parent = u13
            local v17 = u11.FloorEffect:Clone()
            u2.apply(v17, u7)
            v17.CFrame = v14 * CFrame.new(0, -3, 0)
            v17.Parent = u13
            _G.customWeld(v17, u7.PrimaryPart, CFrame.new(0, -3, 0), v17)
            _G.customWeld(v16, u7.PrimaryPart, CFrame.new(0, -3, 0), v16)
            local v18 = tick()
            local u19 = { u11.Firework1:Clone(), u11.Firework2:Clone() }
            u2.apply(u19[1], u7)
            u2.apply(u19[2], u7)
            repeat
                local u20 = u7.PrimaryPart.CFrame
                task.spawn(function() --[[ Line: 156 ]]
                    --[[
                    Upvalues:
                        [1] = u11
                        [2] = u2
                        [3] = u7
                        [4] = u5
                        [5] = u20
                        [6] = u13
                        [7] = u4
                        [8] = u3
                    --]]
                    if math.random(1, 2) ~= 1 then
                        local v21 = u11.SlashPart:Clone()
                        u2.apply(v21, u7)
                        local v22 = u5:NextNumber(0.2, 0.4)
                        v21.Position = u20.Position
                        local v23 = u5:NextNumber(-80, 80)
                        local v24 = u5:NextNumber(0, 360)
                        local v25 = u5
                        v21.Orientation = Vector3.new(v23, v24, v25:NextNumber(-30, 30))
                        local v26 = v21.Mesh
                        local v27 = -v22
                        local v28 = -v22
                        v26.Scale = Vector3.new(v27, -0.4, v28)
                        v21.Decal.Transparency = 1
                        v21.Parent = u13
                        u4:Create(v21.Decal, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                            ["Transparency"] = 0
                        }):Play()
                        for v29 = 1, #u3 do
                            local v30 = #u3 / 2
                            if v29 == math.round(v30) then
                                u4:Create(v21.Decal, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                    ["Transparency"] = 1
                                }):Play()
                            end
                            v21.Decal.Texture = u3[v29]
                            task.wait(0.01)
                        end
                    end
                end)
                local v31 = u19[math.random(1, 2)]
                v31.CFrame = u20 * CFrame.new(u5:NextNumber(-6, 6), u5:NextNumber(-2, 7), u5:NextNumber(-6, 6))
                local v32 = v31.PointLight
                local v33 = v31.PointLight.Range
                v32.Brightness = 5
                v32.Range = 0
                v31.Parent = u13
                _G.customEmit(v31)
                u4:Create(v32, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false), {
                    ["Brightness"] = 0,
                    ["Range"] = v33
                }):Play()
                task.wait(u5:NextNumber(0.05, 0.075))
            until u6[u7] == nil or tick() - v18 >= 5
            task.delay(1, function() --[[ Line: 214 ]]
                --[[
                Upvalues:
                    [1] = u19
                --]]
                for _, v34 in u19 do
                    v34:Destroy()
                end
            end)
            _G.particleEnabled(v16, false)
            _G.particleEnabled(v17, false)
        elseif p8 == "EndSkill" then
            local v35 = u6[u7].EffectsFolder
            _G.destroy(v35, 1)
            u6[u7] = nil
        end
    end
}