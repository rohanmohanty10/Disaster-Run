 

game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v1 = game:GetService("Players")
local u2 = game:GetService("TweenService")
local _ = v1.LocalPlayer
local u3 = workspace.Effects
local function u14(p4, p5, p6) --[[ Line: 14 ]]
    local function v12(u7, p8, p9) --[[ Line: 15 ]]
        for _, v10 in ipairs(u7:GetDescendants()) do
            if v10:IsA("ParticleEmitter") or v10:IsA("Trail") then
                v10.Enabled = p8
            end
        end
        if p9 then
            task.delay(p9, function() --[[ Line: 23 ]]
                --[[
                Upvalues:
                    [1] = u7
                --]]
                for _, v11 in ipairs(u7:GetDescendants()) do
                    if v11:IsA("ParticleEmitter") or v11:IsA("Trail") then
                        v11.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p4) == "table" then
        for _, v13 in p4 do
            v12(v13, p5, p6)
        end
    else
        v12(p4, p5, p6)
    end
end
return {
    ["start"] = function(_, p15, p16, p17) --[[ Name: start, Line 46 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u14
        --]]
        if _G.checkRenderDistance(p16.Position) ~= false then
            if p15 == "Aroma" then
                local u18 = script.AromaSpawn:Clone()
                u18.CFrame = p16
                u18.Parent = u3
                _G.customEmit(u18.Attachment)
                _G.destroy(u18, 2)
                for _, v19 in u18:GetChildren() do
                    if v19:IsA("ParticleEmitter") then
                        v19.Enabled = true
                    end
                end
                u2:Create(u18, TweenInfo.new(0.5), {
                    ["CFrame"] = u18.CFrame * CFrame.new(0, 15, 0)
                }):Play()
                task.delay(0.5, function() --[[ Line: 67 ]]
                    --[[
                    Upvalues:
                        [1] = u14
                        [2] = u18
                    --]]
                    u14(u18, false)
                end)
                local u20 = script.Aroma:Clone()
                u20.CFrame = p16
                u20.Parent = u3
                u14(u20, true)
                _G.PlaySound(u20, script.StartCircle)
                u20.FlowerBuffCircleLoop:Play()
                task.delay(p17, function() --[[ Line: 79 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u20
                        [3] = u3
                    --]]
                    u2:Create(u20.FlowerBuffCircleLoop, TweenInfo.new(0.25), {
                        ["Volume"] = 0
                    }):Play()
                    _G.PlaySound(u20, script.FlowerBuffCircleEnd)
                    local v21 = script.AromaEnd:Clone()
                    v21.CFrame = u20.CFrame
                    v21.Parent = u3
                    _G.customEmit(v21)
                    _G.destroy(v21, 3)
                    u20:Destroy()
                end)
            end
        end
    end
}