 

local u1 = game:GetService("Players")
local u2 = game:GetService("TweenService")
return {
    ["emitParticles"] = function(p3) --[[ Line: 7 ]]
        for _, u4 in p3 do
            if u4:IsA("ParticleEmitter") then
                local v5 = u4:GetAttribute("EmitDelay") or 0
                local u6 = u4:GetAttribute("EmitCount")
                if not u6 then
                    local v7 = u4.Name
                    u6 = tonumber(v7) or 0
                end
                local u8 = u4:GetAttribute("EmitDuration") or 0
                task.delay(v5, function() --[[ Line: 17 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u6
                        [3] = u8
                    --]]
                    if u4:IsA("ParticleEmitter") then
                        u4:Emit(u6)
                    end
                    if u8 > 0 then
                        task.defer(function() --[[ Line: 27 ]]
                            --[[
                            Upvalues:
                                [1] = u4
                                [2] = u8
                            --]]
                            u4.Enabled = true
                            task.wait(u8)
                            u4.Enabled = false
                        end)
                    end
                end)
            end
        end
    end,
    ["getPlayerFromCharacter"] = function(p9) --[[ Line: 44 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        return u1:GetPlayerFromCharacter(p9)
    end,
    ["tweenModelScale"] = function(p10, p11, p12) --[[ Line: 50 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        if p10.PrimaryPart then
            local v13 = p11 / p10:GetExtentsSize()
            local v14 = p12 or 0.3
            for _, v15 in pairs(p10:GetDescendants()) do
                if v15:IsA("BasePart") then
                    u2:Create(v15, TweenInfo.new(v14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Size"] = v15.Size * v13
                    }):Play()
                end
            end
        else
            warn("Model does not have a PrimaryPart.")
        end
    end,
    ["getMouseDirection"] = function(p16, p17) --[[ Line: 78 ]]
        return (p17 - p16).Unit
    end,
    ["generateUUID"] = function() --[[ Line: 84 ]]
        return string.gsub("xxxxxxxx-xxxx", "[x]", function() --[[ Line: 88 ]]
            return string.format("%x", math.random(0, 15))
        end)
    end,
    ["isWall"] = function(p18) --[[ Line: 96 ]]
        local v19 = p18:Dot(Vector3.new(0, 1, 0))
        local v20 = math.clamp(v19, -1, 1)
        local v21 = math.acos(v20)
        local v22 = math.deg(v21)
        warn("isWall Check: UpAngle =", v22, "HitNormal =", p18)
        if p18.Y > 0.7 then
            warn("Surface too flat to be a wall.")
            return false
        elseif v22 >= 70 and v22 <= 110 then
            warn("Surface is steep enough to be a wall.")
            return true
        else
            warn("Surface does not meet wall criteria.")
            return false
        end
    end,
    ["isRamp"] = function(p23, p24) --[[ Line: 114 ]]
        local v25 = p23:Dot(p24)
        local v26 = math.clamp(v25, -1, 1)
        local v27 = math.acos(v26)
        local v28 = math.deg(v27)
        warn("isRamp Check: FacingAngle =", v28, "HitNormal =", p23)
        if p23.Y > 0 and (p23.Y < 0.7 and v28 < 60) then
            warn("Surface classified as a ramp.")
            return true
        else
            warn("Surface does not meet ramp criteria.")
            return false
        end
    end,
    ["setTransparency"] = function(p29, p30, p31) --[[ Line: 132 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        for _, v32 in p29:GetDescendants() do
            if (v32:IsA("Part") or (v32:IsA("MeshPart") or v32:IsA("Decal"))) and v32.Name ~= "HumanoidRootPart" then
                u2:Create(v32, TweenInfo.new(p31 or 0.15, Enum.EasingStyle.Quad), {
                    ["Transparency"] = p30
                }):Play()
            end
        end
    end,
    ["displayPart"] = function(p33, p34) --[[ Line: 144 ]]
        local u35 = Instance.new("Part")
        u35.Size = p34
        u35.CFrame = p33
        u35.Color = Color3.new(0.92929, 0.0780957, 0)
        u35.Parent = workspace.Effects
        u35.Transparency = 0.9
        u35.CanCollide = false
        u35.Anchored = true
        task.delay(1, function() --[[ Line: 155 ]]
            --[[
            Upvalues:
                [1] = u35
            --]]
            u35:Destroy()
        end)
    end
}