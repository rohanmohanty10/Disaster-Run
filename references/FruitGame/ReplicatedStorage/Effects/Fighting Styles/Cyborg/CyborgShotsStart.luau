 

local u1 = game:GetService("RunService")
game:GetService("VRService")
local u2 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local u3 = RaycastParams.new()
u3.FilterType = Enum.RaycastFilterType.Whitelist
u3.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local _ = workspace.Effects
local v4 = {}
local function u10(p5, p6) --[[ Line: 13 ]]
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
function v4.start(_, u11, u12) --[[ Line: 35 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u2
        [3] = u3
        [4] = u1
    --]]
    if _G.checkRenderDistance(u11.PrimaryPart.Position) ~= false then
        local function v18(p13) --[[ Line: 39 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u12
                [3] = u2
                [4] = u11
            --]]
            local v14 = nil
            local v15 = nil
            for _, v16 in ipairs(script.trail:GetChildren()) do
                local v17 = v16:Clone()
                u10(v17, u12)
                u2.apply(v17, u11)
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
        local u19 = _G.PlaySound(u11.PrimaryPart, script.CyBarrageStart)
        task.delay(2.5, function() --[[ Line: 58 ]]
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
        local u20, _, _ = _G.getRayFloor(u11.PrimaryPart.CFrame, 15)
        local u21 = u11:WaitForChild("HumanoidRootPart", 5) or u11.PrimaryPart
        local function v41(p22, _) --[[ Line: 70 ]]
            --[[
            Upvalues:
                [1] = u21
                [2] = u20
                [3] = u10
                [4] = u12
                [5] = u2
                [6] = u11
            --]]
            local v23 = p22 or u21.CFrame
            if u20 then
                local v24 = script.Rocks:GetChildren()
                local v25 = v24[math.random(1, #v24)]:Clone()
                v25:PivotTo(v23)
                v25.Floor.Color = u20.Color
                v25.Parent = workspace.Effects
                local v26 = math.random(-1, 1)
                local v27 = v26 == 0 and -1 or v26
                local v28 = v25.Rock
                local v29 = v23.LookVector * math.random(-60, -25)
                local v30 = v27 * math.random(30, 70)
                local v31 = math.random(25, 60)
                v28.Velocity = v29 + Vector3.new(v30, v31, 0) / 1.25
                local v32 = v25.Rock
                local v33 = math.random(-5, 5)
                local v34 = math.random(-5, 5)
                local v35 = math.random
                v32.RotVelocity = Vector3.new(v33, v34, v35(-5, 5)) * 1.6
                local v36 = nil
                local v37 = nil
                for _, v38 in ipairs(script.rocktrail:GetChildren()) do
                    local v39 = v38:Clone()
                    if v39.Name == "A0" then
                        v36 = v39.Trail
                        v36.Attachment0 = v39
                    else
                        v37 = v39
                    end
                    v39.Parent = v25.Rock
                end
                for _, v40 in ipairs(script.rockfire:GetChildren()) do
                    v40:Clone().Parent = v25.Rock
                end
                v36.Attachment1 = v37
                u10(v25, u12)
                u2.apply(v25, u11)
                _G.destroy(v25, 5)
            end
        end
        local v42 = CFrame.new(u21.Position, u21.CFrame.UpVector)
        v41(v42)
        v41(v42)
        v41(v42)
        local v43 = script["Meshes/Rasengan Shockwave_Cylinder.002"]:Clone()
        local v44 = v42 * CFrame.new(0, 0, -1)
        local v45 = CFrame.Angles
        local v46 = math.random(0, 180)
        v43.CFrame = v44 * v45(0, math.rad(v46), 0)
        v43.Size = Vector3.new(14, 23, 14)
        u10(v43, u12)
        u2.apply(v43, u11)
        v43.Parent = workspace.Effects
        local v47 = _G.tween
        local v48 = {
            0.5,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }
        local v49 = {}
        local v50 = v43.Size.Y
        v49.Size = Vector3.new(0, v50, 0)
        local v51 = v42 * CFrame.new(0, v43.Size.Y / 2, 0)
        local v52 = CFrame.Angles
        local v53 = math.random(0, 180)
        v49.CFrame = v51 * v52(0, math.rad(v53), 0)
        v47(v43, v48, v49)
        _G.destroy(v43, 0.5)
        local v54 = script.stars:Clone()
        v54.CFrame = v42
        u10(v54, u12)
        u2.apply(v54, u11)
        v54.Parent = workspace.Effects
        if u20 then
            v54.Attachment.rocks.Color = ColorSequence.new(u20.Color)
            v54.Attachment.Smoke.Color = ColorSequence.new(u20.Color)
        else
            v54.Attachment.rocks:Destroy()
            v54.Attachment.Smoke:Destroy()
        end
        _G.tween(v54.PointLight, {
            0.4,
            "Quad",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["Brightness"] = 0
        })
        local v55 = workspace:Raycast(u21.Position, u21.CFrame.UpVector * Vector3.new(0, -10, 0), u3)
        if v55 then
            local u56 = script.bigfloorFire:Clone()
            local v57 = CFrame.new(v55.Position, v55.Position + v55.Normal)
            local v58 = CFrame.Angles
            local v59 = math.random(0, 360)
            u56.CFrame = v57 * v58(-1.5707963267948966, math.rad(v59), 0)
            u10(u56, u12)
            u2.apply(u56, u11)
            u56.Parent = workspace.Effects
            task.delay(1 + math.random(100, 140) / 100, function() --[[ Line: 146 ]]
                --[[
                Upvalues:
                    [1] = u56
                --]]
                for _, v60 in ipairs(u56:GetChildren()) do
                    v60.Enabled = false
                end
                _G.destroy(u56, 4)
            end)
        end
        _G.customEmit(v54)
        _G.destroy(v54, 4)
        for v61 = 1, 2 do
            local v62 = script.booster.cyborgBoosterEffects:Clone()
            u10(v62, u12)
            u2.apply(v62, u11)
            v62.Parent = v61 == 1 and u11:FindFirstChild("RightFoot") or u11:FindFirstChild("LeftFoot")
        end
        local u63 = v18(u11:FindFirstChild("RightFoot"))
        local u64 = v18(u11:FindFirstChild("LeftFoot"))
        local v65 = Instance.new("Highlight")
        v65.OutlineTransparency = 1
        v65.DepthMode = Enum.HighlightDepthMode.Occluded
        v65.FillTransparency = 1
        v65.OutlineColor = u12
        v65.FillColor = u12
        u10(v65, u12)
        v65:SetAttribute("UniqueID", "a3c4d5e6-f7a8-4b90-1234-000000000003")
        u2.apply(v65, u11)
        v65.Parent = u11
        _G.tween(v65, {
            0.35,
            "EntranceExpressive",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["OutlineTransparency"] = 0,
            ["FillTransparency"] = 0.5
        })
        _G.destroy(v65, 1)
        local u66 = script.tings:Clone()
        u10(u66, u12)
        u2.apply(u66, u11)
        u66.Parent = workspace.Effects
        local v67 = u1.Heartbeat:Connect(function(_) --[[ Line: 185 ]]
            --[[
            Upvalues:
                [1] = u66
                [2] = u21
            --]]
            u66.CFrame = u21.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
        end)
        task.wait(0.35)
        v67:Disconnect()
        for _, v68 in ipairs(u66:GetDescendants()) do
            if v68:IsA("ParticleEmitter") or (v68:IsA("Trail") or v68:IsA("PointLight")) then
                v68.Enabled = false
            end
        end
        _G.destroy(u66, 4)
        _G.tween(v65, {
            0.4,
            "EntranceExpressive",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["OutlineTransparency"] = 1,
            ["FillTransparency"] = 1
        })
        for v69 = 1, 2 do
            local v70 = u11:FindFirstChild(v69 == 1 and "RightFoot" or "LeftFoot"):FindFirstChild("cyborgBoosterEffects")
            for _, v71 in ipairs(v70:GetChildren()) do
                if v71:IsA("ParticleEmitter") then
                    v71.Enabled = false
                end
            end
            v70.Name = "d"
            _G.destroy(v70, 4)
        end
        u63[1].Enabled = false
        u64[1].Enabled = false
        task.delay(2, function() --[[ Line: 214 ]]
            --[[
            Upvalues:
                [1] = u64
                [2] = u63
            --]]
            for v72, v73 in u64 do
                v73:Destroy()
                u64[v72] = nil
            end
            for v74, v75 in u63 do
                v75:Destroy()
                u64[v74] = nil
            end
        end)
    end
end
return v4