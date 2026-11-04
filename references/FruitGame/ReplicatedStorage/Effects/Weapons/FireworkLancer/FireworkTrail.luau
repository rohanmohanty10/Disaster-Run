 

local v1 = game:GetService("ReplicatedStorage")
local u2 = require(v1.Modules.Client.WeaponVFXRecolor)
local u3 = script.Firework
local u4 = script.FireworkPrestige
local u5 = script.Fireworks
local u6 = script.FireworksPrestige
return {
    ["start"] = function(_, p7) --[[ Name: start, Line 11 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
            [3] = u2
            [4] = u6
            [5] = u5
        --]]
        local v8 = p7.target
        local v9 = p7.type
        local v10 = p7.variant
        local v11 = p7.prestige
        local v12 = p7.char
        local v13 = v8.HumanoidRootPart
        if _G.checkRenderDistance(v13.Position) ~= false then
            if v10 == "Rush" then
                if v9 == "Start" then
                    local v14
                    if v11 then
                        v14 = u4:Clone()
                    else
                        v14 = u3:Clone()
                    end
                    u2.apply(v14, v12)
                    v14.Name = "Firework"
                    local v15 = Instance.new("Weld")
                    v15.Part0 = v13
                    v15.Part1 = v14.Core
                    v15.C0 = CFrame.Angles(1.5707963267948966, 0, 0)
                    v15.Parent = v14.Core
                    v14.Parent = v8
                    v14.PrimaryPart.trailSFX:Play()
                    _G.destroy(v14, 10)
                    for _, v16 in v14:GetDescendants() do
                        if v16:IsA("ParticleEmitter") then
                            v16.Enabled = true
                        end
                    end
                    return
                end
                if v9 == "End" then
                    local u17 = v8:WaitForChild("Firework", 3)
                    if u17 ~= nil then
                        u17.Name = "firedone"
                        for _, v18 in u17:GetDescendants() do
                            if v18:IsA("ParticleEmitter") then
                                v18.Enabled = false
                            elseif v18:IsA("BasePart") then
                                v18.Transparency = 1
                            end
                        end
                        task.delay(2, function() --[[ Line: 54 ]]
                            --[[
                            Upvalues:
                                [1] = u17
                            --]]
                            u17:Destroy()
                        end)
                    end
                end
            else
                if v9 == "Start" then
                    local v19
                    if v11 then
                        v19 = u6.Trails:Clone()
                    else
                        v19 = u5.Trails:Clone()
                    end
                    u2.apply(v19, v12)
                    v19.Parent = v13
                    _G.destroy(v19, 4)
                    for _, v20 in v19:GetDescendants() do
                        if v20:IsA("ParticleEmitter") then
                            v20.Enabled = true
                        end
                    end
                    return
                end
                local v21 = v9 == "End" and v13:FindFirstChild("Trails")
                if v21 then
                    for _, v22 in v21:GetDescendants() do
                        if v22:IsA("ParticleEmitter") then
                            v22.Enabled = false
                        end
                    end
                    task.wait(1)
                    v21:Destroy()
                end
            end
        end
    end
}