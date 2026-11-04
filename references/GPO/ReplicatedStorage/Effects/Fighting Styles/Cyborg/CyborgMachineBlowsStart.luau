 

game:GetService("RunService")
game:GetService("VRService")
local v1 = RaycastParams.new()
v1.FilterType = Enum.RaycastFilterType.Whitelist
v1.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local u2 = workspace.Effects
local v3 = {}
local u4 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local function u10(p5, p6) --[[ Line: 14 ]]
    local v7 = { p5 }
    for _, v8 in p5:GetDescendants() do
        table.insert(v7, v8)
    end
    for _, v9 in v7 do
        if (v9:IsA("ParticleEmitter") or (v9:IsA("BasePart") or (v9:IsA("PointLight") or (v9:IsA("Trail") or v9:IsA("Highlight"))))) and v9:GetAttribute("recolorable") then
            if v9:IsA("Trail") or v9:IsA("ParticleEmitter") then
                v9.Color = ColorSequence.new(p6)
            elseif v9:IsA("Highlight") then
                v9.FillColor = p6
                v9.OutlineColor = Color3.new(1, 1, 1)
            else
                v9.Color = p6
            end
        end
    end
    table.clear(v7)
end
function v3.start(_, u11, u12) --[[ Line: 35 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u4
        [3] = u2
    --]]
    if _G.checkRenderDistance(u11.PrimaryPart.Position) ~= false then
        local function v18(p13) --[[ Line: 39 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u12
                [3] = u4
                [4] = u11
            --]]
            local v14 = nil
            local v15 = nil
            for _, v16 in ipairs(script.trail:GetChildren()) do
                local v17 = v16:Clone()
                u10(v17, u12)
                u4.apply(v17, u11)
                if v17.Name == "A0" then
                    v14 = v17.Trail
                    v14.Attachment0 = v17
                else
                    v15 = v17
                end
                v17.Parent = p13
            end
            v14.Attachment1 = v15
            return { v14, v15, v14.Parent }
        end
        local u19 = _G.PlaySound(u11.PrimaryPart, script.CyMachineGunJumpStart)
        task.delay(2.5, function() --[[ Line: 60 ]]
            --[[
            Upvalues:
                [1] = u19
            --]]
            _G.tween(u19, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Volume"] = 0
            })
            _G.destroy(u19, 0.25)
        end)
        local v20 = u11:WaitForChild("HumanoidRootPart", 5) or u11.PrimaryPart
        local v21, _, _ = _G.getRayFloor(u11.PrimaryPart.CFrame, 15)
        local v22 = script.throw:Clone()
        v22.CFrame = CFrame.new(v20.CFrame * CFrame.new(0, -u11:GetExtentsSize().Y / 2, 0).Position, v20.CFrame * CFrame.new(0, 3, -9).Position)
        v22.Parent = u2
        if v21 then
            v22.rocks.Color = ColorSequence.new(v21.Color)
        else
            v22.rocks.Transparency = NumberSequence.new(1)
        end
        u4.apply(v22, u11)
        _G.customEmit(v22)
        _G.destroy(v22, 3)
        for v23 = 1, 2 do
            local v24 = script.booster.cyborgBoosterEffects:Clone()
            u10(v24, u12)
            u4.apply(v24, u11)
            v24.Parent = v23 == 1 and u11:FindFirstChild("RightFoot") or u11:FindFirstChild("LeftFoot")
        end
        local u25 = v18(u11:FindFirstChild("RightFoot"))
        local u26 = v18(u11:FindFirstChild("LeftFoot"))
        task.wait(0.52)
        for v27 = 1, 2 do
            local v28 = u11:FindFirstChild(v27 == 1 and "RightFoot" or "LeftFoot"):FindFirstChild("cyborgBoosterEffects")
            for _, v29 in ipairs(v28:GetChildren()) do
                if v29:IsA("ParticleEmitter") then
                    v29.Enabled = false
                end
            end
            v28.Name = "d"
            _G.destroy(v28, 4)
        end
        u25[1].Enabled = false
        u26[1].Enabled = false
        task.delay(2, function() --[[ Line: 108 ]]
            --[[
            Upvalues:
                [1] = u26
                [2] = u25
            --]]
            for v30, v31 in u26 do
                v31:Destroy()
                u26[v30] = nil
            end
            for v32, v33 in u25 do
                v33:Destroy()
                u26[v32] = nil
            end
        end)
    end
end
return v3