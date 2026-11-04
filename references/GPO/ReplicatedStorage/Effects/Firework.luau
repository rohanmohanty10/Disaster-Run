 

local u1 = {}
local function u5(p2) --[[ Line: 3 ]]
    local v3 = p2:GetDescendants()
    for v4 = 1, #v3 do
        if v3[v4]:IsA("BasePart") then
            v3[v4].Transparency = 1
        end
    end
end
local u6 = Random.new()
local function u16(p7, p8, p9, p10, p11) --[[ Line: 21 ]]
    local v12 = p7 + (p8 - p7) * p11
    local v13 = p8 + (p9 - p8) * p11
    local v14 = p9 + (p10 - p9) * p11
    local v15 = v12 + (v13 - v12) * p11
    return v15 + (v13 + (v14 - v13) * p11 - v15) * p11
end
function u1.start(_, u17, u18, u19, u20) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u16
        [3] = u5
        [4] = u1
    --]]
    if _G.fastmode and _G.fastmode == true then
        return
    elseif _G.checkRenderDistance(u17.Position) ~= false then
        task.spawn(function() --[[ Line: 39 ]]
            --[[
            Upvalues:
                [1] = u20
                [2] = u17
                [3] = u18
                [4] = u6
                [5] = u16
                [6] = u5
                [7] = u19
                [8] = u1
            --]]
            local v21 = script.FireworkModels["firework" .. math.random(1, 7)]:Clone()
            if v21.Name == "firework2" and math.random(1, 2) == 1 then
                v21:Destroy()
                v21 = script.FireworkModels.firework1:Clone()
            end
            if u20 then
                v21:Destroy()
                v21 = script.FireworkModels:FindFirstChild("firework" .. u20):Clone()
            end
            local v22 = u17 * CFrame.new(0, v21.PrimaryPart.Size.Y / 2, 0)
            local v23 = CFrame.Angles
            local v24 = math.random(0, 360)
            v21:PivotTo(v22 * v23(0, math.rad(v24), 0))
            local v25 = v21.PrimaryPart
            v25.Anchored = true
            v25.Firework.PointLight.Enabled = false
            v21.Parent = workspace.Effects
            if u18 == nil then
                u18 = {
                    ["min"] = 50,
                    ["max"] = 100
                }
            end
            local v26 = u18.customR
            local v27 = u18.hole
            local v28 = v26 or 25
            local v29 = math.random(u18.min, u18.max)
            local v30 = v25.Position
            local v31 = u17 * CFrame.new(math.random(-v28, v28), v29 * 0.25, math.random(-v28, v28))
            local v32 = u17 * CFrame.new(math.random(-v28, v28), v29 * 0.5, math.random(-v28, v28))
            local v33 = u17 * CFrame.new(math.random(-v28, v28), v29 * 0.7, math.random(-v28, v28))
            local v34 = 0
            local v35 = u17 * CFrame.new(math.random(-v34, v34), v29, math.random(-v34, v34))
            local _ = v25.Position
            local v36 = u18.customInterval == nil and 0.05 or u18.customInterval
            local v37 = Color3.new(u6:NextNumber(), u6:NextNumber(), u6:NextNumber())
            v21.PriColor.Color = v37
            local v38 = script.Trail:Clone()
            v38.Attachment0 = v25.Trail1
            v38.Attachment1 = v25.Trail2
            v38.Parent = v25
            local v39 = v25:GetDescendants()
            for v40 = 1, #v39 do
                if v39[v40]:IsA("ParticleEmitter") or v39[v40]:IsA("Trail") then
                    v39[v40].Color = ColorSequence.new(v37)
                elseif v39[v40]:IsA("PointLight") then
                    v39[v40].Color = v37
                end
            end
            local v41 = u18.instant ~= nil and 1 or v36
            local v42 = CFrame.Angles
            local v43 = math.random(-360, 360)
            local v44 = v42(0, math.rad(v43), 0)
            local v45 = {}
            for v46 = 0, v41 + 1, v41 do
                local v47 = v46 == v41 and 0 or v46
                v45[v47] = CFrame.new((u16(v30, v31.Position, v32.Position, v33.Position, v47)))
            end
            if u18.delayTime ~= nil then
                task.wait(u18.delayTime)
            end
            if v27 ~= nil then
                local v48 = script.Hole.Attachment:Clone()
                v48.Burst.Color = ColorSequence.new(v37)
                v48.Parent = v27
                v48.WorldCFrame = CFrame.new(v27.Position, v45[v41 * 2].Position) * CFrame.new(0, 0, -v27.Size.Y / 2) * CFrame.Angles(-1.5707963267948966, 0, 0)
                _G.customEmit(v48)
                _G.destroy(v48, 2)
            end
            _G.PlaySound(v25, script.Shoots:GetChildren()[math.random(1, #script.Shoots:GetDescendants())]).Parent = v25
            v25.Firework.PointLight.Enabled = true
            for v49 = 0, v41 + 1, v41 do
                local v50 = v49 == v41 and 0 or v49
                local v51 = v35.Position
                if v45[v50 + v41] ~= nil then
                    v51 = v45[v50 + v41].Position
                end
                v25.CFrame = CFrame.new(v45[v50].Position, v51) * CFrame.Angles(-1.5707963267948966, 0, 0) * v44
                task.wait()
            end
            local v52 = u20 == "BIG" and 300 or 125
            local v53 = _G.PlaySound(v25, script.Booms:GetChildren()[math.random(1, #script.Booms:GetDescendants())], {
                ["RollOffMinDistance"] = v52
            })
            local v54 = 30
            if u20 == "Big" then
                v53.Volume = 0.8
                v54 = 60
            else
                v53.Volume = 0.4
            end
            v21.PrimaryPart.Firework.PointLight.Brightness = 5
            _G.tween(v21.PrimaryPart.Firework.PointLight, {
                0.5,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Range"] = v54,
                ["Brightness"] = 0
            })
            _G.destroy(v21, 5)
            u5(v21)
            v21:PivotTo(CFrame.new(v25.Position, workspace.CurrentCamera.CFrame.Position) * CFrame.Angles(0, 1.5707963267948966, 0))
            _G.customEmit(v21)
            if u19 and u19 == "Blitz" then
                for _ = 1, math.random(3, 6) do
                    local v55 = u1
                    local v56 = v25.CFrame
                    local v57 = CFrame.Angles
                    local v58 = math.random(0, 360)
                    local v59 = math.rad(v58)
                    local v60 = math.random(0, 360)
                    local v61 = math.rad(v60)
                    local v62 = math.random(0, 360)
                    v55:start(v56 * v57(v59, v61, (math.rad(v62))), {
                        ["min"] = 100,
                        ["max"] = 175,
                        ["customInterval"] = 0.05
                    })
                end
            end
        end)
    end
end
return u1