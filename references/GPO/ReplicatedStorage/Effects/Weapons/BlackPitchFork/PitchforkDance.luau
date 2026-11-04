 

local u1 = game:GetService("TweenService")
local u2 = script:WaitForChild("Base")
local u3 = script:WaitForChild("Frames")
local u4 = u3:GetChildren()
local function u9(p5) --[[ Line: 8 ]]
    local v6 = 0
    for _, v7 in ipairs(p5:GetDescendants()) do
        if v7:IsA("ParticleEmitter") then
            local v8 = v7.Lifetime.Max / v7.TimeScale
            v6 = math.max(v6, v8)
            _G.customEmit(v7)
        end
    end
    task.delay(v6, p5.Destroy, p5)
end
local function u24(p10) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
        [3] = u9
        [4] = u3
        [5] = u1
    --]]
    local u11 = p10.Origin
    local v12 = p10.Time
    local v13 = p10.EndCFrame
    local u14 = p10.Size
    local v15 = p10.SurfaceDirection
    local v16 = p10.Color
    local u17 = v12 / #u4
    local u18 = u11 * v13
    local u19 = u2:Clone()
    u19.CFrame = u11
    u19.Decal.Face = v15
    u19.Decal.Color3 = v16
    u19.Mesh.Scale = u14
    u19.Parent = workspace.Effects
    task.delay(0.075, function() --[[ Line: 40 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u14
            [3] = u9
        --]]
        local v20 = script:WaitForChild("SlashEnd"):Clone()
        v20.CFrame = u11 * CFrame.new(u14.X, 0, 0) * CFrame.Angles(0, 1.5707963267948966, 0)
        v20.Parent = workspace.Effects
        u9(v20)
    end)
    task.delay(v12, u19.Destroy, u19)
    for u21 = 1, #u4 do
        local v22 = u17 * u21
        task.delay(v22, function() --[[ Line: 53 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u3
                [3] = u21
                [4] = u1
                [5] = u17
                [6] = u11
                [7] = u18
                [8] = u4
            --]]
            if u19:IsDescendantOf(game) then
                local v23 = u21
                u19.Decal.Texture = u3[tostring(v23)].Texture
                u1:Create(u19, TweenInfo.new(u17, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                    ["CFrame"] = u11:Lerp(u18, u21 / #u4)
                }):Play()
            end
        end)
    end
end
return {
    ["start"] = function(_, p25, p26) --[[ Name: start, Line 69 ]]
        --[[
        Upvalues:
            [1] = u24
        --]]
        u24({
            ["Origin"] = p25.HumanoidRootPart.CFrame * CFrame.Angles(0, -1.5707963267948966, 3.141592653589793) * p26,
            ["Time"] = 0.2,
            ["EndCFrame"] = CFrame.Angles(0, -2.792526803190927, 0),
            ["Size"] = Vector3.new(7.5, 15, 7.5),
            ["SurfaceDirection"] = "Bottom",
            ["Color"] = Color3.fromRGB(400, 400, 400)
        })
    end
}