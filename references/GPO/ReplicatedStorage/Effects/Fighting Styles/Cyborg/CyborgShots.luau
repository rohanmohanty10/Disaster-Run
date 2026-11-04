 

game:GetService("RunService")
require(script.Bezier)
local u1 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v2 = {}
local function u6(p3, p4) --[[ Line: 8 ]]
    for _, v5 in p3:GetDescendants() do
        if (v5:IsA("ParticleEmitter") or (v5:IsA("BasePart") or (v5:IsA("PointLight") or v5:IsA("Trail")))) and v5:GetAttribute("recolorable") then
            if v5:IsA("Trail") or v5:IsA("ParticleEmitter") then
                v5.Color = ColorSequence.new(p4)
            else
                v5.Color = p4
            end
        end
    end
end
function v2.start(_, u7, _, u8) --[[ Line: 23 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u1
    --]]
    if _G.checkRenderDistance(u7.PrimaryPart.Position) ~= false then
        local function v14(p9) --[[ Line: 27 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u8
                [3] = u1
                [4] = u7
            --]]
            local v10 = nil
            local v11 = nil
            for _, v12 in ipairs(script.trail:GetChildren()) do
                local v13 = v12:Clone()
                u6(v13, u8)
                u1.apply(v13, u7)
                if v13.Name == "A0" then
                    v10 = v13.Trail
                    v10.Attachment0 = v13
                else
                    v11 = v13
                end
                v13.Parent = p9
            end
            v10.Attachment1 = v11
            return { v10, v11, v10.Parent }
        end
        if not u7.PrimaryPart then
            u7:WaitForChild("HumanoidRootPart")
        end
        for v15 = 1, 2 do
            local v16 = script.booster.cyborgBoosterEffects:Clone()
            u6(v16, u8)
            u1.apply(v16, u7)
            v16.Parent = v15 == 1 and u7:FindFirstChild("RightFoot") or u7:FindFirstChild("LeftFoot")
        end
        local u17 = v14(u7:FindFirstChild("RightFoot"))
        local u18 = v14(u7:FindFirstChild("LeftFoot"))
        while u7:FindFirstChild("CyborgUlting") do
            task.wait()
        end
        for v19 = 1, 2 do
            local v20 = u7:FindFirstChild(v19 == 1 and "RightFoot" or "LeftFoot"):FindFirstChild("cyborgBoosterEffects")
            for _, v21 in ipairs(v20:GetChildren()) do
                if v21:IsA("ParticleEmitter") then
                    v21.Enabled = false
                end
            end
            v20.Name = "d"
            _G.destroy(v20, 4)
        end
        u17[1].Enabled = false
        u18[1].Enabled = false
        task.delay(2, function() --[[ Line: 72 ]]
            --[[
            Upvalues:
                [1] = u18
                [2] = u17
            --]]
            for v22, v23 in u18 do
                v23:Destroy()
                u18[v22] = nil
            end
            for v24, v25 in u17 do
                v25:Destroy()
                u18[v24] = nil
            end
        end)
    end
end
return v2