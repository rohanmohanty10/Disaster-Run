 

local v1 = {}
local u2 = 0
function v1.start(_, p3, p4, p5, p6) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p4 and p4.Parent == nil then
        return
    elseif u2 >= 100 then
        warn("too many hits on screen returning", u2)
    else
        if p3 == "Clash" or p3 == "Blocked" then
            if p3 == "Blocked" then
                if p4 == nil then
                    return
                end
                if p4.PrimaryPart == nil then
                    return
                end
                if not _G.checkRenderDistance(p4.PrimaryPart.Position, 150) then
                    return
                end
                u2 = u2 + 1
                local v7 = script.BlockParticle:Clone()
                v7.CFrame = p4.HumanoidRootPart.CFrame
                v7.Size = Vector3.new(1.5, 2.5, 1)
                local v8 = v7.Attachment
                local v9 = math.random(-v7.Size.X, v7.Size.X) / 2
                local v10 = math.random(-v7.Size.Y, v7.Size.Y) / 2
                local v11 = math.random(-v7.Size.Z, v7.Size.Z) / 2
                v8.Position = Vector3.new(v9, v10, v11)
                v7.Parent = workspace.Effects
                _G.customEmit(v7)
                _G.destroy(v7, 1)
            else
                if not _G.checkRenderDistance(p6.Position, 150) then
                    return
                end
                u2 = u2 + 1
                local v12 = script.Types.Clash:Clone()
                v12.CFrame = p6 * CFrame.new(0, 0, -1)
                v12.Parent = workspace.Effects
                _G.customEmit(v12)
                _G.tween(v12.PointLight, {
                    0.15,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Range"] = 15,
                    ["Brightness"] = 0
                })
                _G.destroy(v12, 2)
                _G.PlaySound(p6, script.blocksfx["B" .. math.random(1, 9)])
                _G.shakenear(v12.Position, 25, 35, 15, -1.5)
                local v13 = Random.new()
                for _ = 1, math.random(4) do
                    local v14 = _G.PlayEffect
                    local v15 = {}
                    local v16 = CFrame.Angles
                    local v17 = v13:NextInteger(-90, 90)
                    local v18 = math.rad(v17)
                    local v19 = v13:NextInteger(-45, 45)
                    v15.Direction = (p6 * v16(v18, math.rad(v19), 0)).LookVector * v13:NextNumber(15, 35)
                    v15.Position = p6.Position
                    v14("Sparks", nil, v15)
                end
            end
        else
            if p4 == nil then
                return
            end
            if p4.PrimaryPart == nil then
                return
            end
            if not _G.checkRenderDistance(p4.PrimaryPart.Position, 150) then
                return
            end
            u2 = u2 + 1
            local v20 = script.Types:FindFirstChild(p3):Clone()
            if p3 == "Sword" then
                local v21 = v20.Attachment
                local v22 = math.random
                v21.Orientation = Vector3.new(0, 0, v22(-90, 90))
            end
            v20.CFrame = (p5 or p4.PrimaryPart).CFrame
            v20.Parent = workspace.Effects
            _G.customEmit(v20)
            _G.destroy(v20, 1)
        end
        task.delay(1, function() --[[ Line: 89 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            u2 = u2 - 1
        end)
    end
end
return v1